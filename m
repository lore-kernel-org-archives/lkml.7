Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFD6ECE58C
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B312083B
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 19:32:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDsSL+4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbfJOTcW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 15:32:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36147 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbfJOTcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 15:32:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id y19so25274230wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 12:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pka8MZciE1uXdvlPGsnSN2mfafkuH+B/p1WIBzC4Ucw=;
        b=SDsSL+4LynUfiX5Q5WLqJPRY1/eneAjTyWB1ipJUsrsIK4l91EPqjXHbjx2B/ENSjD
         9wCDPP6Am/vxS6lYevbV/gtVGHtu+Rz1uUe3YXQHeCyMaxI9hk1BKRhpFaJiGuxSGlL+
         OI59nmWpVZkgXPfzAhbOCV5azSJsusC9RKgZovVcZ89zKJ1cexnAoVlPHyd7SK02PwZI
         6cvdgbaDok61/i/PtWZSvzJrxRvnovpQ0apZ5an98thbte78QBEtmF56NBYuRo9V/Sif
         XLu/LU0IM80C2awIndFBtHL37BwoLCpcGbgDfCQ6A2bn3DInE9/Vz77rMHRhlgiOAj4S
         kDTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pka8MZciE1uXdvlPGsnSN2mfafkuH+B/p1WIBzC4Ucw=;
        b=HtyzP/K1aI+pcHy1uUfaJS5DGNIzu9Jf2gc96I2bxv+P3skJVIAwPk5dhSu1f0zhTI
         Utp9OqlHL0LdM9x8YpaS5ZuvgqlwBILTXzkwyGjb+6XJW/8UT4nImOAs/WBkcoFIQ2wh
         9bpA7XeZPHmiqyeMwVAXRXQKSAgOKOjNsEKMeJAVsj1ZQlfR5AGZOBOR7r+ztV915WI8
         UDhnRKv0/pLAGCs8zp+o+kAx+s4giCNerhKMf7qgIK/ix3coGbwG/K99oQhsxz1PJE5h
         bdA6er4ONQRLT26hCgr+8zUPgT1eg12z8X3GPy5ts82tCvIS3tU/0S4MLYTMB65xL8rz
         ymTg==
X-Gm-Message-State: APjAAAV1xx5nMi3mIu8LKhV5ABPx7cIetH3Jj3L783Xs7kMMWOAfigw6
        8eT/hyH/KFEMPgtlcnzsO/m2ZLLW4GvwGQ==
X-Google-Smtp-Source: APXvYqwOG2BhIWkKve+GHAXVaPzespIOcqR4qXJxUaHrSxi1VC6m5L50gkmrJIoSrpBe4J6LAXgx9A==
X-Received: by 2002:a5d:4302:: with SMTP id h2mr22881854wrq.35.1571167939204;
        Tue, 15 Oct 2019 12:32:19 -0700 (PDT)
Received: from debian (212-127-136-25.cable.dynamic.v4.ziggo.nl. [212.127.136.25])
        by smtp.gmail.com with ESMTPSA id l18sm24290823wrn.48.2019.10.15.12.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 12:32:18 -0700 (PDT)
From:   Michiel Schuurmans <michielschuurmans@gmail.com>
Cc:     michielschuurmans@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zach Turner <turnerzdp@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Christina Quast <contact@christina-quast.de>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [PATCH] staging: rtl8192e: Fix checkpatch errors
Date:   Tue, 15 Oct 2019 21:32:08 +0200
Message-Id: <20191015193210.20146-1-michielschuurmans@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace formatting as suggested by checkpatch.

Signed-off-by: Michiel Schuurmans <michielschuurmans@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 0cbf4a1a326b..e7478a1c204e 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -218,7 +218,6 @@ static int rtllib_ccmp_encrypt(struct sk_buff *skb, int hdr_len, void *priv)
 	return 0;
 }
 
-
 static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 {
 	struct rtllib_ccmp_data *key = priv;
@@ -233,7 +232,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		return -1;
 	}
 
-	hdr = (struct rtllib_hdr_4addr *) skb->data;
+	hdr = (struct rtllib_hdr_4addr *)skb->data;
 	pos = skb->data + hdr_len;
 	keyidx = pos[3];
 	if (!(keyidx & (1 << 5))) {
@@ -278,7 +277,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		int aad_len, ret;
 
 		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
-		if(!req)
+		if (!req)
 			return -ENOMEM;
 
 		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
-- 
2.23.0

