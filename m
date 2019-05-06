Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E7FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4EDE20C01
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 14:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557153666;
	bh=PTzDf0Og633U/AmIb2Xsav2KKdCIJsvNOeaTc+NXz+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f1DDDKSrnDxZuPt3OmQTnDfLZQBpSA2lZMIEYOCCbXqBaCPbWzyEUgK/vQajSz1EN
	 jaSq+QWeMzudavo35LBheaG7Nfa4xqToI3oTgRUCYjLBwkUy0g7yKYjl/1DDBBTff3
	 qMig2DkFVBPXXU9xebwUCayAHJcrU3+iq9o9x8eQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbfEFOlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 10:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbfEFOlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 10:41:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30FAA21019;
        Mon,  6 May 2019 14:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557153661;
        bh=PTzDf0Og633U/AmIb2Xsav2KKdCIJsvNOeaTc+NXz+E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ep1/uSk8LBII85U6Wb1DM87GSrY8YVa0G22dOzQKM6JDHMZkmCZtMIECzXqJDscCT
         RY1PTi8as4gLwiLnI2piuYLVZ5Wi57F1pH5pNM1KUvIwpTM08lceKr66MxjsJF/tUf
         Dh1SZk13uNJICUFDrTtwxE+yKKmKqyw7C5v9Vr2s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 49/99] HID: input: add mapping for Assistant key
Date:   Mon,  6 May 2019 16:32:22 +0200
Message-Id: <20190506143058.514065653@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190506143053.899356316@linuxfoundation.org>
References: <20190506143053.899356316@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit ce856634af8cda3490947df8ac1ef5843e6356af ]

According to HUTRR89 usage 0x1cb from the consumer page was assigned to
allow launching desktop-aware assistant application, so let's add the
mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a3916e58dbf5..e649940e065d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -982,6 +982,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x1b8: map_key_clear(KEY_VIDEO);		break;
 		case 0x1bc: map_key_clear(KEY_MESSENGER);	break;
 		case 0x1bd: map_key_clear(KEY_INFO);		break;
+		case 0x1cb: map_key_clear(KEY_ASSISTANT);	break;
 		case 0x201: map_key_clear(KEY_NEW);		break;
 		case 0x202: map_key_clear(KEY_OPEN);		break;
 		case 0x203: map_key_clear(KEY_CLOSE);		break;
-- 
2.20.1



