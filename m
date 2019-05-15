Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D3A7C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D75B2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 11:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557918877;
	bh=EvvY5jbYxvFkgQwwoLGjP9+ygaI0eFVXbhCB7QWtUfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F33mb22fqgPEkehmJqx82lgBvH6lFGSRc3k+djGDvlR1EpCaWVLdUxuVkwvSAAbi1
	 sSjKrLP8Ht2aQoq3eDkK3WEGLgesQj9kU8VpFLBxpuaapUsbIcixZFoyJKLN/aQaR4
	 a+m+HfsJpKkui6CZHckAPbvm8zJJ/bJNtZojmEBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbfEOLOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 07:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730139AbfEOLOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 07:14:32 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4416020644;
        Wed, 15 May 2019 11:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557918871;
        bh=EvvY5jbYxvFkgQwwoLGjP9+ygaI0eFVXbhCB7QWtUfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MYyNm4D3UpGajKnE83BiD3Oj+BC8o2cHDx93qK88n+N/Ze0yR/hRPnI8/OmKZT2Pl
         bFCtjpjOa0BrlcHAQsvxhDk6Shdf5lBfCarQRNcIqpadYZRehdApRGw1zDtRxe+XMx
         rbEtRSjfQSvziVEQlbZcGNzorQTKkJTzOyZzeSsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 08/51] HID: input: add mapping for Expose/Overview key
Date:   Wed, 15 May 2019 12:55:43 +0200
Message-Id: <20190515090620.099124532@linuxfoundation.org>
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

[ Upstream commit 96dd86871e1fffbc39e4fa61c9c75ec54ee9af0f ]

According to HUTRR77 usage 0x29f from the consumer page is reserved for
the Desktop application to present all running user’s application windows.
Linux defines KEY_SCALE to request Compiz Scale (Expose) mode, so let's
add the mapping.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index fc7ada26457e8..d31725c4e7b1e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -932,6 +932,8 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x2cb: map_key_clear(KEY_KBDINPUTASSIST_ACCEPT);	break;
 		case 0x2cc: map_key_clear(KEY_KBDINPUTASSIST_CANCEL);	break;
 
+		case 0x29f: map_key_clear(KEY_SCALE);		break;
+
 		default: map_key_clear(KEY_UNKNOWN);
 		}
 		break;
-- 
2.20.1



