Return-Path: <SRS0=HtuS=UO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A5DC31E50
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB36D21773
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Jun 2019 17:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dN+7R7CB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfFORW1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 13:22:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39145 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725270AbfFORW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 13:22:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id j2so3301398pfe.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 10:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=sOyp4+sq+KgwllM2CeYmEU/9LNYkDyFFb5HcnRUf3P4=;
        b=dN+7R7CB9Ahi7rYreE+yvwbashFY8WWYDtDrv7uNs7mlANGL4JTH6BZBBX03Ihyv9a
         lwfbDzcmisqCUblu6lje2jpnRkOr78P8uqueVnjSRrv/ZF+rHd/aKkVA6/DBUOpvxIK5
         CWfdLGqPbJruH5lIxpPjYzFgT5Y2b88h4ehuRJCy4eFFtFpQN9urruibdjD+nWvDF1JK
         /jX/0frSk2STRZ34aLERabEBsEBvLRsXfN15PhMfvLPgpgGKd55Qg49BR/gj1fKbzOAI
         A4H4TqTh7bsvgZ5T3RoR7kL+jaPUiigBo66oXF5SFc2EXw8S8xIOnmbHjOuWvMY/5J2n
         6B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sOyp4+sq+KgwllM2CeYmEU/9LNYkDyFFb5HcnRUf3P4=;
        b=PW1s17KFr0+kM9L+nw+fIfm9h7tlz9SErA76iNOsEoY3Wd58G3hCi4XZAdPmHMeXPI
         sbdbbFKAy+Fn+ZXcT9Xzw9VcfgKltJhfvOz+Z787PXgngxAbM3JiZYY8o/X1XXrViLy5
         HEwLPH8cD/yiCOBhs6wSem4m34cf8mIupf6Bs9j6GuRxFAWXmf6LPkm6/Bbq8HMcatbw
         3tcijQH/RFsYazlt71m8F2Dn1+lhxR2SYgDE/LOesCTxAQ5IF+Q1F4MB4Eu8oF51AKfw
         TYM+gree0EOxChM+n4cI7aPGBHyspAI1pkNiltPe1xxSflrNdez3PJo1AS/5dGoYbpWZ
         0niw==
X-Gm-Message-State: APjAAAVRWH85XzpYx3GPau6SMTG4hvVcDa32w3U+qRu/hxKZ/ZKl8XrF
        T+k3Z8/qdU8Li0+1zsc9lNZr+9LW
X-Google-Smtp-Source: APXvYqxWwgzupgHTg0PdzvxfYOChOOwYzZe2kJWzBpKINwfQ9Fyq03VYi83ClAPm4UfEwGBUH6GLKQ==
X-Received: by 2002:a65:64d5:: with SMTP id t21mr42337756pgv.310.1560619346176;
        Sat, 15 Jun 2019 10:22:26 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id h6sm2985058pjs.2.2019.06.15.10.22.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 10:22:25 -0700 (PDT)
Date:   Sat, 15 Jun 2019 22:52:20 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Josenivaldo Benito Jr <jrbenito@benito.qsl.br>,
        Himadri Pandya <himadri18.07@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Remove return type of initrecvbuf
Message-ID: <20190615172220.GA6344@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

change return of initrecvbuf from s32 to void. As this function always
returns SUCCESS .

fix checkpatch warning "Comparison to false is error prone"

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
index b269de5..e23b39a 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_recv.c
@@ -10,14 +10,12 @@
 #include <rtw_debug.h>
 #include <rtl8723b_hal.h>
 
-static s32 initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
+static void initrecvbuf(struct recv_buf *precvbuf, struct adapter *padapter)
 {
 	INIT_LIST_HEAD(&precvbuf->list);
 	spin_lock_init(&precvbuf->recvbuf_lock);
 
 	precvbuf->adapter = padapter;
-
-	return _SUCCESS;
 }
 
 static void update_recvframe_attrib(struct adapter *padapter,
@@ -177,7 +175,7 @@ static void rtl8723bs_c2h_packet_handler(struct adapter *padapter,
 
 	res = rtw_c2h_packet_wk_cmd(padapter, tmp, length);
 
-	if (res == false)
+	if (!res)
 		kfree(tmp);
 
 	/* DBG_871X("-%s res(%d)\n", __func__, res); */
@@ -435,9 +433,7 @@ s32 rtl8723bs_init_recv_priv(struct adapter *padapter)
 	/*  init each recv buffer */
 	precvbuf = (struct recv_buf *)precvpriv->precv_buf;
 	for (i = 0; i < NR_RECVBUFF; i++) {
-		res = initrecvbuf(precvbuf, padapter);
-		if (res == _FAIL)
-			break;
+		initrecvbuf(precvbuf, padapter);
 
 		if (!precvbuf->pskb) {
 			SIZE_PTR tmpaddr = 0;
-- 
2.7.4

