Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A756C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB0120675
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUmcvlNJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfCGSMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:12:49 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37342 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCGSMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:12:49 -0500
Received: by mail-ed1-f66.google.com with SMTP id m12so14272320edv.4;
        Thu, 07 Mar 2019 10:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/35u3o/m0zzpVadJNISLoIXZ2wioO5fHRn9O05VsrU0=;
        b=iUmcvlNJHfBNvWBVLvUQRTIu3D3LynOGPNM6BAj69YgCVpNRFmzWakyejecPTqyOJ1
         XWZQmMaRHFQDnmHfkmSyrwmqDTx5m5doBc4Brj/PxwT0DWeXWvaqL2BZvuLi5fxHJrGx
         /lCW78aFXelLFtqieif65rUpOhRkpY3H7XJTpgQoIuare/V3PSzzPCNyrWEA2qStm1ag
         D0o7+HHiRFklMwYqqxBUlmoFkmymlDl+pQx1iKurnvd64dhxz9dPOTVcrfq5VvVXxaPY
         SgGHbaTQBiFj5OMkwOORBMCJgIV83m4GkwOLyRuGV0aNj05FGlj3eCn62mRywka5+BKw
         CaHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/35u3o/m0zzpVadJNISLoIXZ2wioO5fHRn9O05VsrU0=;
        b=n4yTVtjVa7PlEGERWJg0edvo/5OFlxo364J5VyaIzX04ROA2r/gJt8IULb9uHZZqv3
         vdVwVoL/Yix08k6dEvAL5zOnHsJMMvnAQR6Mw9Xjtcw2JkEcfEkbKBi1VZRWxBENYveg
         37YUTgl//a1haWbXHHXWzxwucKz7GkdoKzRI+d9loBPTZiA9vmXGvZD7c+x9KMh0A9ND
         irOvMB/W4Ba+x3J6YylcZS6Wi22gVXI6LRcFezHvSK/WNhksdOnUl35m8AsVHPPgMNrh
         9j16Hf0VWOIBXUOBx6Mme229FHE/z/No5/3P4fNf/VLDkoNq/qCz+eTUF1XoKrjO/JUc
         RXzw==
X-Gm-Message-State: APjAAAXck1ZaaHuASYU+dSjS/sVGuNHXfwCiBCbRMrZS/4Yf4/cYE4Q0
        3yWGii2p8sdK/M6kd2uC1xg=
X-Google-Smtp-Source: APXvYqwtZWQ6FhZgPTmJ+tCeKTuFPqJgoYPW7r3I5pgm+som9lg0yeb7gCjz2uruRO5y+SWI9e1xyw==
X-Received: by 2002:aa7:c419:: with SMTP id j25mr29114576edq.195.1551982366885;
        Thu, 07 Mar 2019 10:12:46 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id q46sm1508337edd.0.2019.03.07.10.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 10:12:46 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] net: atm: Add another IS_ENABLED(CONFIG_COMPAT) in atm_dev_ioctl
Date:   Thu,  7 Mar 2019 11:11:26 -0700
Message-Id: <20190307181125.7705-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190307165741.19870-1-natechancellor@gmail.com>
References: <20190307165741.19870-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I removed compat's universal assignment to 0, which allows this if
statement to fall through when compat is passed with a value other
than 0.

Fixes: f9d19a7494e5 ("net: atm: Use IS_ENABLED in atm_dev_ioctl")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Sorry for not paying more attention :(

 net/atm/resources.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/atm/resources.c b/net/atm/resources.c
index 3e9f6391319e..889349c6d90d 100644
--- a/net/atm/resources.c
+++ b/net/atm/resources.c
@@ -413,7 +413,7 @@ int atm_dev_ioctl(unsigned int cmd, void __user *arg, int compat)
 		}
 		/* fall through */
 	default:
-		if (compat) {
+		if (IS_ENABLED(CONFIG_COMPAT) && compat) {
 #ifdef CONFIG_COMPAT
 			if (!dev->ops->compat_ioctl) {
 				error = -EINVAL;
-- 
2.21.0

