Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA7FCA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5023E21906
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 21:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407793AbfJWVqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 17:46:47 -0400
Received: from mga06.intel.com ([134.134.136.31]:39636 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407759AbfJWVqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 17:46:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Oct 2019 14:46:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,222,1569308400"; 
   d="scan'208";a="196908273"
Received: from ayamada-mobl1.gar.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.254.95.208])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2019 14:46:42 -0700
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Subject: [PATCH 15/18] soundwire: stream: update state machine and add state checks
Date:   Wed, 23 Oct 2019 16:45:58 -0500
Message-Id: <20191023214601.883-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
References: <20191023214601.883-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The state machine and notes don't accurately explain or allow
transitions from STREAM_DEPREPARED and STREAM_DISABLED.

Add more explanations and allow for more transitions as a result of a
trigger_stop(), trigger_suspend() and prepare(), depending on the
ALSA/ASoC layer behavior defined by the INFO_RESUME and INFO_PAUSE
flags.

Also add basic checks to help debug inconsistent states and illegal
state machine transitions.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 Documentation/driver-api/soundwire/stream.rst | 63 +++++++++++++------
 drivers/soundwire/stream.c                    | 38 +++++++++++
 2 files changed, 83 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/soundwire/stream.rst b/Documentation/driver-api/soundwire/stream.rst
index 5351bd2f34a8..9b7418ff8d59 100644
--- a/Documentation/driver-api/soundwire/stream.rst
+++ b/Documentation/driver-api/soundwire/stream.rst
@@ -156,22 +156,27 @@ Below shows the SoundWire stream states and state transition diagram. ::
 	+-----------+     +------------+     +----------+     +----------+
 	| ALLOCATED +---->| CONFIGURED +---->| PREPARED +---->| ENABLED  |
 	|   STATE   |     |    STATE   |     |  STATE   |     |  STATE   |
-	+-----------+     +------------+     +----------+     +----+-----+
-	                                                           ^
-	                                                           |
-	                                                           |
-	                                                           v
-	         +----------+           +------------+        +----+-----+
+	+-----------+     +------------+     +---+--+---+     +----+-----+
+	                                         ^  ^              ^
+				                 |  |              |
+				               __|  |___________   |
+				              |                 |  |
+	                                      v                 |  v
+	         +----------+           +-----+------+        +-+--+-----+
 	         | RELEASED |<----------+ DEPREPARED |<-------+ DISABLED |
 	         |  STATE   |           |   STATE    |        |  STATE   |
 	         +----------+           +------------+        +----------+
 
-NOTE: State transition between prepare and deprepare is supported in Spec
-but not in the software (subsystem)
+NOTE: State transitions between ``SDW_STREAM_ENABLED`` and
+``SDW_STREAM_DISABLED`` are only relevant when then INFO_PAUSE flag is
+supported at the ALSA/ASoC level. Likewise the transition between
+``SDW_DISABLED_STATE`` and ``SDW_PREPARED_STATE`` depends on the
+INFO_RESUME flag.
 
-NOTE2: Stream state transition checks need to be handled by caller
-framework, for example ALSA/ASoC. No checks for stream transition exist in
-SoundWire subsystem.
+NOTE2: The framework implements basic state transition checks, but
+does not e.g. check if a transition from DISABLED to ENABLED is valid
+on a specific platform. Such tests need to be added at the ALSA/ASoC
+level.
 
 Stream State Operations
 -----------------------
@@ -246,6 +251,9 @@ SDW_STREAM_PREPARED
 
 Prepare state of stream. Operations performed before entering in this state:
 
+  (0) Steps 1 and 2 are omitted in the case of a resume operation,
+      where the bus bandwidth is known.
+
   (1) Bus parameters such as bandwidth, frame shape, clock frequency,
       are computed based on current stream as well as already active
       stream(s) on Bus. Re-computation is required to accommodate current
@@ -270,13 +278,15 @@ Prepare state of stream. Operations performed before entering in this state:
 After all above operations are successful, stream state is set to
 ``SDW_STREAM_PREPARED``.
 
-Bus implements below API for PREPARE state which needs to be called once per
-stream. From ASoC DPCM framework, this stream state is linked to
-.prepare() operation.
+Bus implements below API for PREPARE state which needs to be called
+once per stream. From ASoC DPCM framework, this stream state is linked
+to .prepare() operation. Since the .trigger() operations may not
+follow the .prepare(), a direct transitions from
+``SDW_STREAM_PREPARED`` to ``SDW_STREAM_DEPREPARED`` is allowed.
 
 .. code-block:: c
 
-  int sdw_prepare_stream(struct sdw_stream_runtime * stream);
+  int sdw_prepare_stream(struct sdw_stream_runtime * stream, bool resume);
 
 
 SDW_STREAM_ENABLED
@@ -332,6 +342,14 @@ Bus implements below API for DISABLED state which needs to be called once
 per stream. From ASoC DPCM framework, this stream state is linked to
 .trigger() stop operation.
 
+When the INFO_PAUSE flag is supported, a direct transition to
+``SDW_STREAM_ENABLED`` is allowed.
+
+For resume operations where ASoC will use the .prepare() callback, the
+stream can transition from ``SDW_STREAM_DISABLED`` to
+``SDW_STREAM_PREPARED``, with all required settings restored but
+without updating the bandwidth and bit allocation.
+
 .. code-block:: c
 
   int sdw_disable_stream(struct sdw_stream_runtime * stream);
@@ -353,9 +371,18 @@ state:
 After all above operations are successful, stream state is set to
 ``SDW_STREAM_DEPREPARED``.
 
-Bus implements below API for DEPREPARED state which needs to be called once
-per stream. From ASoC DPCM framework, this stream state is linked to
-.trigger() stop operation.
+Bus implements below API for DEPREPARED state which needs to be called
+once per stream. ALSA/ASoC do not have a concept of 'deprepare', and
+the mapping from this stream state to ALSA/ASoC operation may be
+implementation specific.
+
+When the INFO_PAUSE flag is supported, the stream state is linked to
+the .hw_free() operation - the stream is not deprepared on a
+TRIGGER_STOP.
+
+Other implementations may transition to the ``SDW_STREAM_DEPREPARED``
+state on TRIGGER_STOP, should they require a transition through the
+``SDW_STREAM_PREPARED`` state.
 
 .. code-block:: c
 
diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index e69f94a8c3a8..0a074d445b8d 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -1553,10 +1553,21 @@ int sdw_prepare_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_CONFIGURED &&
+	    stream->state != SDW_STREAM_DEPREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_prepare_stream(stream);
+
 	if (ret < 0)
 		pr_err("Prepare for stream:%s failed: %d\n", stream->name, ret);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1621,10 +1632,19 @@ int sdw_enable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_PREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_enable_stream(stream);
 	if (ret < 0)
 		pr_err("Enable for stream:%s failed: %d\n", stream->name, ret);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1697,10 +1717,18 @@ int sdw_disable_stream(struct sdw_stream_runtime *stream)
 
 	sdw_acquire_bus_lock(stream);
 
+	if (stream->state != SDW_STREAM_ENABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_disable_stream(stream);
 	if (ret < 0)
 		pr_err("Disable for stream:%s failed: %d\n", stream->name, ret);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
@@ -1755,10 +1783,20 @@ int sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 	}
 
 	sdw_acquire_bus_lock(stream);
+
+	if (stream->state != SDW_STREAM_PREPARED &&
+	    stream->state != SDW_STREAM_DISABLED) {
+		pr_err("%s: %s: inconsistent state state %d\n",
+		       __func__, stream->name, stream->state);
+		ret = -EINVAL;
+		goto state_err;
+	}
+
 	ret = _sdw_deprepare_stream(stream);
 	if (ret < 0)
 		pr_err("De-prepare for stream:%d failed: %d\n", ret, ret);
 
+state_err:
 	sdw_release_bus_lock(stream);
 	return ret;
 }
-- 
2.20.1

