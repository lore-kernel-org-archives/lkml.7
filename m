Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4E7C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42193206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521709;
	bh=8NCXrLCwzmdazBmKh3MPc3z/jq4Rubpa4X2/ZG55fGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=o1crYbvSjaxRotAgLMZdp1UPOCokLfNQ5kgg5r9NpDN888j4Fco1tiwQlOCFUCdI4
	 q9h+hqWj/TSBfUDClKqxA5zwldbH5akxqPmZ+prRQb0RNhEEOhIxImxhai7eUxMjU+
	 2Q5xhewa1329aLn6703Czj8jBz22OfFcvN75nOOU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbfLPSA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:00:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729032AbfLPSAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:00:54 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C635C205C9;
        Mon, 16 Dec 2019 18:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576519253;
        bh=8NCXrLCwzmdazBmKh3MPc3z/jq4Rubpa4X2/ZG55fGY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vORe0nVBEk9TdcSi8/4emXYgFFrNNV90+k1ibiA3geDi2fgZqj11ZpNlscpMONCzq
         VMKpsVLptR73TRLjtLzp6DJlyi4FEsqSgcXVkeiL4HSw9/kgzbjm2bHMCQf83Ht1Ew
         qo9B3FLJFnzH33E9yYWDpl+Y+3AskNJyDV01o9H4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-media@vger.kernel.org,
        Martin Bugge <marbugge@cisco.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Thierry Reding <treding@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>
Subject: [PATCH 4.14 231/267] video/hdmi: Fix AVI bar unpack
Date:   Mon, 16 Dec 2019 18:49:17 +0100
Message-Id: <20191216174915.211691381@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191216174848.701533383@linuxfoundation.org>
References: <20191216174848.701533383@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 6039f37dd6b76641198e290f26b31c475248f567 upstream.

The bar values are little endian, not big endian. The pack
function did it right but the unpack got it wrong. Fix it.

Cc: stable@vger.kernel.org
Cc: linux-media@vger.kernel.org
Cc: Martin Bugge <marbugge@cisco.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Fixes: 2c676f378edb ("[media] hdmi: added unpack and logging functions for InfoFrames")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20190919132853.30954-1-ville.syrjala@linux.intel.com
Reviewed-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/video/hdmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/video/hdmi.c
+++ b/drivers/video/hdmi.c
@@ -1036,12 +1036,12 @@ static int hdmi_avi_infoframe_unpack(str
 	if (ptr[0] & 0x10)
 		frame->active_aspect = ptr[1] & 0xf;
 	if (ptr[0] & 0x8) {
-		frame->top_bar = (ptr[5] << 8) + ptr[6];
-		frame->bottom_bar = (ptr[7] << 8) + ptr[8];
+		frame->top_bar = (ptr[6] << 8) | ptr[5];
+		frame->bottom_bar = (ptr[8] << 8) | ptr[7];
 	}
 	if (ptr[0] & 0x4) {
-		frame->left_bar = (ptr[9] << 8) + ptr[10];
-		frame->right_bar = (ptr[11] << 8) + ptr[12];
+		frame->left_bar = (ptr[10] << 8) | ptr[9];
+		frame->right_bar = (ptr[12] << 8) | ptr[11];
 	}
 	frame->scan_mode = ptr[0] & 0x3;
 


