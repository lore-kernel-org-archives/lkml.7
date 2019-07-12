Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171F6C742B9
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E046921670
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562934177;
	bh=EMojlX+IUcL8fA+GgsbxYKBtbRtuE78Fhm8+7MCCKS8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=u9HFN4jL2QgzBLe1pOqOH88fFv1WGqTfaIOG96MHzGLmNPpmnN0nqSCjDdwmIRG+Y
	 vQX8nugo7ogCDshs7KIcmXeMwuy2LKZtDzD+oFs9cwetHzd4PqoeokivhqsSYZujD8
	 9vujj3xan0Ff9SF4xDrsvyAJ7VN2ED5Ov6P1Cq9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbfGLMWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:22:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727797AbfGLMWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:22:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A37F2084B;
        Fri, 12 Jul 2019 12:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562934172;
        bh=EMojlX+IUcL8fA+GgsbxYKBtbRtuE78Fhm8+7MCCKS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WLJ5H8k9eUIO8aDAuIaJ8flNwdn0Agy4GGHpwdQvOssD9QFJOiypZTvHm0lDxkn98
         vw9HsISzy4JBfPtlU7ej/mDf9in5haGlftqNvuDfy3eF++u2LRs8zL1V/N4R8V/sfb
         9FlbbFSBkMBo/dNp+A5al9/OhEeXeT98Bsw4+vk8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kailang Yang <kailang@realtek.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4.19 60/91] ALSA: hda/realtek - Headphone Mic cant record after S3
Date:   Fri, 12 Jul 2019 14:19:03 +0200
Message-Id: <20190712121625.058296244@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190712121621.422224300@linuxfoundation.org>
References: <20190712121621.422224300@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kailang Yang <kailang@realtek.com>

commit d07a9a4f66e944fcc900812cbc2f6817bde6a43d upstream.

Dell headset mode platform with ALC236.
It doesn't recording after system resume from S3.
S3 mode was deep. s2idle was not has this issue.
S3 deep will cut of codec power. So, the register will back to default
after resume back.
This patch will solve this issue.

Signed-off-by: Kailang Yang <kailang@realtek.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/pci/hda/patch_realtek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -3236,6 +3236,7 @@ static void alc256_init(struct hda_codec
 	alc_update_coefex_idx(codec, 0x57, 0x04, 0x0007, 0x4); /* Hight power */
 	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 1 << 15); /* Clear bit */
 	alc_update_coefex_idx(codec, 0x53, 0x02, 0x8000, 0 << 15);
+	alc_update_coef_idx(codec, 0x36, 1 << 13, 1 << 5); /* Switch pcbeep path to Line in path*/
 }
 
 static void alc256_shutup(struct hda_codec *codec)
@@ -7686,7 +7687,6 @@ static int patch_alc269(struct hda_codec
 		spec->shutup = alc256_shutup;
 		spec->init_hook = alc256_init;
 		spec->gen.mixer_nid = 0; /* ALC256 does not have any loopback mixer path */
-		alc_update_coef_idx(codec, 0x36, 1 << 13, 1 << 5); /* Switch pcbeep path to Line in path*/
 		break;
 	case 0x10ec0257:
 		spec->codec_variant = ALC269_TYPE_ALC257;


