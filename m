Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC6CC43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E776C206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 15:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfD0Pcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 11:32:32 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60716 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726758AbfD0PPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 11:15:12 -0400
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2j-0000zA-TZ; Sat, 27 Apr 2019 16:15:09 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hKP2h-0004PO-Kn; Sat, 27 Apr 2019 16:15:07 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Dexuan Cui" <decui@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Stephen Hemminger" <sthemmin@microsoft.com>,
        "Sasha Levin" <sashal@kernel.org>,
        "Haiyang Zhang" <haiyangz@microsoft.com>
Date:   Sat, 27 Apr 2019 16:13:09 +0100
Message-ID: <lsq.1556377989.901924242@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 023/202] Drivers: hv: vmbus: Check for ring when
 getting debug info
In-Reply-To: <lsq.1556377988.384060557@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.66-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

commit ba50bf1ce9a51fc97db58b96d01306aa70bc3979 upstream.

fc96df16a1ce is good and can already fix the "return stack garbage" issue,
but let's also improve hv_ringbuffer_get_debuginfo(), which would silently
return stack garbage, if people forget to check channel->state or
ring_info->ring_buffer, when using the function in the future.

Having an error check in the function would eliminate the potential risk.

Add a Fixes tag to indicate the patch depdendency.

Fixes: fc96df16a1ce ("Drivers: hv: vmbus: Return -EINVAL for the sys files for unopened channels")
Cc: K. Y. Srinivasan <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/hv/ring_buffer.c | 31 +++++++-------
 drivers/hv/vmbus_drv.c   | 91 +++++++++++++++++++++++++++-------------
 include/linux/hyperv.h   |  5 ++-
 3 files changed, 79 insertions(+), 48 deletions(-)

--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -329,26 +329,25 @@ static u32 hv_copyto_ringbuffer(
  * Get various debug metrics for the specified ring buffer
  *
  */
-void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
-			    struct hv_ring_buffer_debug_info *debug_info)
+int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
+				struct hv_ring_buffer_debug_info *debug_info)
 {
 	u32 bytes_avail_towrite;
 	u32 bytes_avail_toread;
 
-	if (ring_info->ring_buffer) {
-		hv_get_ringbuffer_availbytes(ring_info,
-					&bytes_avail_toread,
-					&bytes_avail_towrite);
+	if (!ring_info->ring_buffer)
+		return -EINVAL;
 
-		debug_info->bytes_avail_toread = bytes_avail_toread;
-		debug_info->bytes_avail_towrite = bytes_avail_towrite;
-		debug_info->current_read_index =
-			ring_info->ring_buffer->read_index;
-		debug_info->current_write_index =
-			ring_info->ring_buffer->write_index;
-		debug_info->current_interrupt_mask =
-			ring_info->ring_buffer->interrupt_mask;
-	}
+	hv_get_ringbuffer_availbytes(ring_info,
+				     &bytes_avail_toread,
+				     &bytes_avail_towrite);
+	debug_info->bytes_avail_toread = bytes_avail_toread;
+	debug_info->bytes_avail_towrite = bytes_avail_towrite;
+	debug_info->current_read_index = ring_info->ring_buffer->read_index;
+	debug_info->current_write_index = ring_info->ring_buffer->write_index;
+	debug_info->current_interrupt_mask
+		= ring_info->ring_buffer->interrupt_mask;
+	return 0;
 }
 
 /*
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -257,12 +257,16 @@ static ssize_t out_intr_mask_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", outbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(out_intr_mask);
@@ -272,12 +276,15 @@ static ssize_t out_read_index_show(struc
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_read_index);
 }
 static DEVICE_ATTR_RO(out_read_index);
@@ -288,12 +295,15 @@ static ssize_t out_write_index_show(stru
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.current_write_index);
 }
 static DEVICE_ATTR_RO(out_write_index);
@@ -304,12 +314,15 @@ static ssize_t out_read_bytes_avail_show
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(out_read_bytes_avail);
@@ -320,12 +333,15 @@ static ssize_t out_write_bytes_avail_sho
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info outbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound, &outbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->outbound,
+					  &outbound);
+	if (ret < 0)
+		return ret;
 	return sprintf(buf, "%d\n", outbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(out_write_bytes_avail);
@@ -335,12 +351,15 @@ static ssize_t in_intr_mask_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_interrupt_mask);
 }
 static DEVICE_ATTR_RO(in_intr_mask);
@@ -350,12 +369,15 @@ static ssize_t in_read_index_show(struct
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_read_index);
 }
 static DEVICE_ATTR_RO(in_read_index);
@@ -365,12 +387,15 @@ static ssize_t in_write_index_show(struc
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.current_write_index);
 }
 static DEVICE_ATTR_RO(in_write_index);
@@ -381,12 +406,15 @@ static ssize_t in_read_bytes_avail_show(
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_toread);
 }
 static DEVICE_ATTR_RO(in_read_bytes_avail);
@@ -397,12 +425,15 @@ static ssize_t in_write_bytes_avail_show
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
 	struct hv_ring_buffer_debug_info inbound;
+	int ret;
 
 	if (!hv_dev->channel)
 		return -ENODEV;
-	if (hv_dev->channel->state != CHANNEL_OPENED_STATE)
-		return -EINVAL;
-	hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+
+	ret = hv_ringbuffer_get_debuginfo(&hv_dev->channel->inbound, &inbound);
+	if (ret < 0)
+		return ret;
+
 	return sprintf(buf, "%d\n", inbound.bytes_avail_towrite);
 }
 static DEVICE_ATTR_RO(in_write_bytes_avail);
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -580,8 +580,9 @@ int hv_ringbuffer_read(struct hv_ring_bu
 		   u32 offset, bool *signal);
 
 
-void hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
-			    struct hv_ring_buffer_debug_info *debug_info);
+
+int hv_ringbuffer_get_debuginfo(struct hv_ring_buffer_info *ring_info,
+				struct hv_ring_buffer_debug_info *debug_info);
 
 void hv_begin_read(struct hv_ring_buffer_info *rbi);
 

