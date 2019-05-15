Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B73DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5DFF2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918881;
	bh=lk1Uf4zzSURzti2jY3EY/WMJP1XeQtaGBpeS83/XbuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mJMzIxL2/F4wPZEH8tmcJtmhWuTaPaamsVvzzddLHNlCFy+Dn5i15aJQrnX+I3KIB
	 KNl1uimV6h9uyxQq/aoPlV8E5UpsmuW5acAVKA+WBodIVjvU0YcAvcLfX7cHSgcGAG
	 ECbljNV5e7QHV98WK1hQHSQZqLEYQEUDPeRyNCVk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbfEOLOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:14:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:50714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730154AbfEOLOe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:14:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E63B320644;
        Wed, 15 May 2019 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918874;
        bh=lk1Uf4zzSURzti2jY3EY/WMJP1XeQtaGBpeS83/XbuA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sYJ0eLEu8tjZDbdhjpHx1Ac3pZuuxmqG7Lum54rOV0kqFEFArC+OB4dxwfOW6ETrM
         t533KHufjkNbgTUKcscTiPobr5QlT50FxMTgdFtIt6s+aKwPGWqtIILC+QSMVG2y30
         vsdCxCYfLlMa1EH2zKNmnEChaBQMW2xMM/MPOMX4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 09/51] HID: input: add mapping for keyboard Brightness Up/Down/Toggle keys
Date:   Wed, 15 May 2019 12:55:44 +0200
Message-Id: <20190515090620.180254085@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515090616.669619870@linuxfoundation.org>
References: <20190515090616.669619870@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 7975a1d6a7afeb3eb61c971a153d24dd8fa032f3 ]

According to HUTRR73 usages 0x79, 0x7a and 0x7c from the consumer page
correspond to Brightness Up/Down/Toggle keys, so let's add the mappings.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d31725c4e7b1e..302a24931147b 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -802,6 +802,10 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x074: map_key_clear(KEY_BRIGHTNESS_MAX);		break;
 		case 0x075: map_key_clear(KEY_BRIGHTNESS_AUTO);		break;
 
+		case 0x079: map_key_clear(KEY_KBDILLUMUP);	break;
+		case 0x07a: map_key_clear(KEY_KBDILLUMDOWN);	break;
+		case 0x07c: map_key_clear(KEY_KBDILLUMTOGGLE);	break;
+
 		case 0x082: map_key_clear(KEY_VIDEO_NEXT);	break;
 		case 0x083: map_key_clear(KEY_LAST);		break;
 		case 0x084: map_key_clear(KEY_ENTER);		break;
-- 
2.20.1



