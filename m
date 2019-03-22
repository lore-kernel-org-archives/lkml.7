Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6131AC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3128B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257271;
	bh=QQs+iqtc6eV5NeTS+njbP8xZTsulqcfm5sClMZ2n9Kk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Abw7zZqr9o6Ta4B8NBAqPxspeS8NHwf3/Aat6Jsff6vfCH5Om9HaBAXK0AlDDYW5p
	 Xbe75C7o3pBfvrQ+KnT+SpqFOhBlkhKSM6VBcEun2IjJ35KuM0uQD4TT3qAa7bm76r
	 yCoESKlZ1faLtJy0XgpxykexYTOTcsJq/cvCkI9c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390526AbfCVMVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:21:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:60116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390815AbfCVMVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:21:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89F422054F;
        Fri, 22 Mar 2019 12:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257266;
        bh=QQs+iqtc6eV5NeTS+njbP8xZTsulqcfm5sClMZ2n9Kk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IBwFPtjR4YU0fPY5O1CUq2n3rfJJxBcnEanLILs5WmHcX0cP7HknRMnWQUFk5cCYq
         tbNgvaE2ZGUd4Tm7emLxRuiKTiUX9CknKBe1Zt+m5Z3uIlpC5bHXMfkdsrTYWxz5Rb
         7mOiAe+pQp/oKoMJq2uifMpwYNOyYy9D6v7KISk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cody P Schafer <dev@codyps.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 5.0 180/238] media: cx25840: mark pad sig_types to fix cx231xx init
Date:   Fri, 22 Mar 2019 12:16:39 +0100
Message-Id: <20190322111308.887255457@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cody P Schafer <dev@codyps.com>

commit 46c039d06b6ecabb94bd16c3a999b28dc83b79ce upstream.

Without this, we get failures like this when the kernel attempts to
initialize a cx231xx device:

	[16046.153653] cx231xx 3-1.2:1.1: New device Hauppauge Hauppauge Device @ 480 Mbps (2040:c200) with 6 interfaces
	[16046.153900] cx231xx 3-1.2:1.1: can't change interface 3 alt no. to 3: Max. Pkt size = 0
	[16046.153907] cx231xx 3-1.2:1.1: Identified as Hauppauge USB Live 2 (card=9)
	[16046.154350] i2c i2c-11: Added multiplexed i2c bus 13
	[16046.154379] i2c i2c-11: Added multiplexed i2c bus 14
	[16046.267194] cx25840 10-0044: cx23102 A/V decoder found @ 0x88 (cx231xx #0-0)
	[16048.424551] cx25840 10-0044: loaded v4l-cx231xx-avcore-01.fw firmware (16382 bytes)
	[16048.463224] cx231xx 3-1.2:1.1: v4l2 driver version 0.0.3
	[16048.567878] cx231xx 3-1.2:1.1: Registered video device video2 [v4l2]
	[16048.568001] cx231xx 3-1.2:1.1: Registered VBI device vbi0
	[16048.568419] cx231xx 3-1.2:1.1: audio EndPoint Addr 0x83, Alternate settings: 3
	[16048.568425] cx231xx 3-1.2:1.1: video EndPoint Addr 0x84, Alternate settings: 5
	[16048.568431] cx231xx 3-1.2:1.1: VBI EndPoint Addr 0x85, Alternate settings: 2
	[16048.568436] cx231xx 3-1.2:1.1: sliced CC EndPoint Addr 0x86, Alternate settings: 2
	[16048.568448] usb 3-1.2: couldn't get decoder output pad for V4L I/O
	[16048.568453] cx231xx 3-1.2:1.1: V4L2 device vbi0 deregistered
	[16048.568579] cx231xx 3-1.2:1.1: V4L2 device video2 deregistered
	[16048.569001] cx231xx: probe of 3-1.2:1.1 failed with error -22

Likely a regession since Commit 9d6d20e652c0
("media: v4l2-mc: switch it to use the new approach to setup pipelines")
(v4.19-rc1-100-g9d6d20e652c0), which introduced the use of
PAD_SIGNAL_DV within v4l2_mc_create_media_graph().

This also modifies cx25840 to remove the VBI pad, matching the action
taken in Commit 092a37875a22 ("media: v4l2: remove VBI output pad").

Fixes: 9d6d20e652c0 ("media: v4l2-mc: switch it to use the new approach to setup pipelines")

Cc: stable@vger.kernel.org
Signed-off-by: Cody P Schafer <dev@codyps.com>
Tested-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/media/i2c/cx25840/cx25840-core.c |    3 ++-
 drivers/media/i2c/cx25840/cx25840-core.h |    1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/media/i2c/cx25840/cx25840-core.c
+++ b/drivers/media/i2c/cx25840/cx25840-core.c
@@ -5216,8 +5216,9 @@ static int cx25840_probe(struct i2c_clie
 	 * those extra inputs. So, let's add it only when needed.
 	 */
 	state->pads[CX25840_PAD_INPUT].flags = MEDIA_PAD_FL_SINK;
+	state->pads[CX25840_PAD_INPUT].sig_type = PAD_SIGNAL_ANALOG;
 	state->pads[CX25840_PAD_VID_OUT].flags = MEDIA_PAD_FL_SOURCE;
-	state->pads[CX25840_PAD_VBI_OUT].flags = MEDIA_PAD_FL_SOURCE;
+	state->pads[CX25840_PAD_VID_OUT].sig_type = PAD_SIGNAL_DV;
 	sd->entity.function = MEDIA_ENT_F_ATV_DECODER;
 
 	ret = media_entity_pads_init(&sd->entity, ARRAY_SIZE(state->pads),
--- a/drivers/media/i2c/cx25840/cx25840-core.h
+++ b/drivers/media/i2c/cx25840/cx25840-core.h
@@ -40,7 +40,6 @@ enum cx25840_model {
 enum cx25840_media_pads {
 	CX25840_PAD_INPUT,
 	CX25840_PAD_VID_OUT,
-	CX25840_PAD_VBI_OUT,
 
 	CX25840_NUM_PADS
 };


