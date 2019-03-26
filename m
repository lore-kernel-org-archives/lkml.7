Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D3DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CABF206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 18:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkyoM4bp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732526AbfCZSZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 14:25:12 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45100 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732061AbfCZSZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 14:25:11 -0400
Received: by mail-pl1-f195.google.com with SMTP id bf11so2023845plb.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7V6nGtsUhJyXuUPYKYJHr3yF1+LeM2UVaq85yKnTwRU=;
        b=rkyoM4bpRd/c0ALmB7cFk/gZANsvlvCE28WS6wo2FR35OHQK8msrTKthxa0QqAfr0W
         d7fsz9txtH0ACFt6VGcYob4ybAbvmB+OvUH7MJp4t9fIrKoSZFQViEoS0BbHH0K4zaGX
         DLCU7alFyv39sxZSFMAB40r2Lgylcj829A7IG6A6WxXx/mINGfE+j5b6SKWbpd6/EbLc
         oMOfRmvywrbOKfphrkOjfeXxglfbFI/YD//O12Jdo8uZEiJ7N/6+ITpKSBlPulSOLYS9
         WmcAjN+/TAK2CbD9HnGJw2tH3fYn2bXGmOUY6bZnJBKB4RVLyyEcx+pBiYIAZHDZ/SEL
         u1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7V6nGtsUhJyXuUPYKYJHr3yF1+LeM2UVaq85yKnTwRU=;
        b=KK635Uy6T4cwTKmtAwQNsaTf4ExFdSv6bypKvs52Tt3HAH59jq+oGW2PNTbxNyX6hE
         tgRWTf4jRA6A/cnyWs80XmPWS/dcdLoBgINf/BQjuLyf1j4xqDY8P9I4IuJnKJlHsD1G
         bjwXtxHBthXeLN3emXAEK6SSCi4D19GyJb7TofRMsZ94QBc/iGv4oU9Ox7+X9Zh3a9Gy
         tYYUwbuTfio6P489u54UN1A4vtqvrqRQKIdiGljdmUNl4DYpDgX9w0eQdrdSsKMkLGbL
         ed96qoHW22Wo7Ze8+skpXGLZGk6GAk5PoP5h95uGl4CzNxwmPL2gHpAgkZrPOdlL8sZA
         0cog==
X-Gm-Message-State: APjAAAWsZrOKA5u00The57gNA4gMz9vCiaeXeugyfOid33dP4SvmhRb3
        uT4OqvdxfL5yVPgix8J43o7DlAhwsbU=
X-Google-Smtp-Source: APXvYqxZxz/2aL0XdP4vMb9e8f3T5O+TA7jk4A3rWjO6+kend91xZa85BcY2NNlrouKnpDTeTpEagg==
X-Received: by 2002:a17:902:8690:: with SMTP id g16mr32421918plo.284.1553624710741;
        Tue, 26 Mar 2019 11:25:10 -0700 (PDT)
Received: from auvm ([106.51.27.254])
        by smtp.gmail.com with ESMTPSA id k12sm24838534pfk.109.2019.03.26.11.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 11:25:10 -0700 (PDT)
Date:   Tue, 26 Mar 2019 23:55:07 +0530
From:   Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
To:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        hadess@hadess.net, hdegoede@redhat.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: core: fix line over 80 characters warning
Message-ID: <20190326182309.GA33380@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the expression by re-using the part that was already computed to
fix the line over 80 characters warning reported by checkpatch.pl.

Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 18fabf5ff44b..bc0230672457 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
 			Update_RA_Entry(padapter, psta);
 			/* pairwise key */
 			/* per sta pairwise key and settings */
-			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
-				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
+			if ((psecuritypriv->dot11PrivacyAlgrthm == _TKIP_) ||
+				(psecuritypriv->dot11PrivacyAlgrthm == _AES_)) {
 				rtw_setstakey_cmd(padapter, psta, true, false);
 			}
 		}
-- 
2.17.1

