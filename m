Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59FFFC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62D2067D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 17:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgAHRzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 12:55:12 -0500
Received: from mga09.intel.com ([134.134.136.24]:41182 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729994AbgAHRzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 12:55:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 09:55:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,410,1571727600"; 
   d="scan'208";a="211617417"
Received: from cozturk-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.amr.corp.intel.com) ([10.251.17.77])
  by orsmga007.jf.intel.com with ESMTP; 08 Jan 2020 09:55:06 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
Subject: [PATCH 6/6] soundwire: stream: don't program ports for a stream that has not been prepared
Date:   Wed,  8 Jan 2020 11:54:38 -0600
Message-Id: <20200108175438.13121-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rander Wang <rander.wang@intel.com>

In the Intel QA multi-pipelines test case, there are two pipelines for
playback and capture on the same bus. The test fails with an error
when setting port params:

[  599.224812] rt711 sdw:0:25d:711:0: invalid dpn_prop direction 1 port_num 0
[  599.224815] sdw_program_slave_port_params failed -22
[  599.224819] intel-sdw sdw-master-0: Program transport params failed: -22
[  599.224822] intel-sdw sdw-master-0: Program params failed: -22
[  599.224828] sdw_enable_stream: SDW0 Pin2-Playback: done

This problem is root-caused to the programming of the capture stream
ports while it is not yet prepared, the calling sequence is:

(1) hw_params for playback. The playback stream provide the port
    information to Bus.
(2) stream_prepare for playback, Transport and port parameters
    are computed for playback.
(3) hw_params for capture. The capture stream provide the port
    information to Bus, but it has not been prepared so is not
    accounted for in the bandwidth allocation.
(4) stream_enable for playback. Program transport and port parameters
    for all masters and slaves. Since the transport and port parameters
    are not computed for capture stream, sdw_program_slave_port_params
    will generate a error when setting port params for capture.

in step (4), we should only program the ports for the stream that have
been prepared. A stream that is only in CONFIGURED state should be
ignored, its ports will be programmed when it becomes PREPARED.

Tested on Comet Lake.

GitHub issue: https://github.com/thesofproject/linux/issues/1637
Signed-off-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/stream.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index da10f38298c0..198372977187 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -604,12 +604,23 @@ static int sdw_notify_config(struct sdw_master_runtime *m_rt)
  *
  * @bus: SDW bus instance
  */
-static int sdw_program_params(struct sdw_bus *bus)
+static int sdw_program_params(struct sdw_bus *bus, bool prepare)
 {
 	struct sdw_master_runtime *m_rt;
 	int ret = 0;
 
 	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
+
+		/*
+		 * this loop walks through all master runtimes for a
+		 * bus, but the ports can only be configured while
+		 * explicitly preparing a stream or handling an
+		 * already-prepared stream otherwise.
+		 */
+		if (!prepare &&
+		    m_rt->stream->state == SDW_STREAM_CONFIGURED)
+			continue;
+
 		ret = sdw_program_port_params(m_rt);
 		if (ret < 0) {
 			dev_err(bus->dev,
@@ -1502,7 +1513,7 @@ static int _sdw_prepare_stream(struct sdw_stream_runtime *stream,
 
 program_params:
 		/* Program params */
-		ret = sdw_program_params(bus);
+		ret = sdw_program_params(bus, true);
 		if (ret < 0) {
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			goto restore_params;
@@ -1602,7 +1613,7 @@ static int _sdw_enable_stream(struct sdw_stream_runtime *stream)
 		bus = m_rt->bus;
 
 		/* Program params */
-		ret = sdw_program_params(bus);
+		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			return ret;
@@ -1687,7 +1698,7 @@ static int _sdw_disable_stream(struct sdw_stream_runtime *stream)
 		struct sdw_bus *bus = m_rt->bus;
 
 		/* Program params */
-		ret = sdw_program_params(bus);
+		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			return ret;
@@ -1769,7 +1780,7 @@ static int _sdw_deprepare_stream(struct sdw_stream_runtime *stream)
 			m_rt->ch_count * m_rt->stream->params.bps;
 
 		/* Program params */
-		ret = sdw_program_params(bus);
+		ret = sdw_program_params(bus, false);
 		if (ret < 0) {
 			dev_err(bus->dev, "Program params failed: %d\n", ret);
 			return ret;
-- 
2.20.1

