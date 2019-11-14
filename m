Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD296C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FCAF20715
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 06:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfKNGmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 01:42:12 -0500
Received: from mga12.intel.com ([192.55.52.136]:58046 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfKNGmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:42:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Nov 2019 22:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,302,1569308400"; 
   d="scan'208";a="216645416"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 13 Nov 2019 22:42:08 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 2/2] intel_th: Document software sinks
Date:   Thu, 14 Nov 2019 08:42:01 +0200
Message-Id: <20191114064201.43089-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
References: <20191114064201.43089-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the software sinks API of the MSU driver and the
msu-sink module in particular.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
---
 Documentation/trace/intel_th.rst | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/trace/intel_th.rst b/Documentation/trace/intel_th.rst
index baa12eb09ef4..70b7126eaeeb 100644
--- a/Documentation/trace/intel_th.rst
+++ b/Documentation/trace/intel_th.rst
@@ -44,7 +44,8 @@ Documentation/trace/stm.rst for more information on that.
 
 MSU can be configured to collect trace data into a system memory
 buffer, which can later on be read from its device nodes via read() or
-mmap() interface.
+mmap() interface and directed to a "software sink" driver that will
+consume the data and/or relay it further.
 
 On the whole, Intel(R) Trace Hub does not require any special
 userspace software to function; everything can be configured, started
@@ -122,3 +123,28 @@ In order to enable the host mode, set the 'host_mode' parameter of the
 will show up on the intel_th bus. Also, trace configuration and
 capture controlling attribute groups of the 'gth' device will not be
 exposed. The 'sth' device will operate as usual.
+
+Software Sinks
+--------------
+
+The Memory Storage Unit (MSU) driver provides an in-kernel API for
+drivers to register themselves as software sinks for the trace data.
+Such drivers can further export the data via other devices, such as
+USB device controllers or network cards.
+
+The API has two main parts::
+ - notifying the software sink that a particular window is full, and
+   "locking" that window, that is, making it unavailable for the trace
+   collection; when this happens, the MSU driver will automatically
+   switch to the next window in the buffer if it is unlocked, or stop
+   the trace capture if it's not;
+ - tracking the "locked" state of windows and providing a way for the
+   software sink driver to notify the MSU driver when a window is
+   unlocked and can be used again to collect trace data.
+
+An example sink driver, msu-sink illustrates the implementation of a
+software sink. Functionally, it simply unlocks windows as soon as they
+are full, keeping the MSU running in a circular buffer mode. Unlike the
+"multi" mode, it will fill out all the windows in the buffer as opposed
+to just the first one. It can be enabled by writing "sink" to the "mode"
+file (assuming msu-sink.ko is loaded).
-- 
2.24.0

