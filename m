Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CE4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F63C20896
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 18:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqHCezEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbfCQSbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 14:31:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54479 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727438AbfCQSbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 14:31:31 -0400
Received: by mail-wm1-f66.google.com with SMTP id f3so10998207wmj.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2019 11:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=umGZEQbuKMgrNvhGvByniZ7Anp1p5oZ9xYk2M/7LMIg=;
        b=lqHCezEUZ6jSPedRU9rTqJW5yiGweoe+Yn19uVLdegmn2kO6zhk03iwzcmiH3gYajM
         7O8bKgdhISJhKDBjb1xBbzNE3ip/byTm5Fv7xRy2QoI5HtjfxjfMBBvrx9JCjQxzmhrq
         DoaaoPrOMh22treLvonQYn66zlBdW2XUb/XubULFnalE1kXGn+0Ilg4whf94V2++RDg0
         5Yl5LkP77aTObFrxPOJMyXo9vuMiCAxHm1lShKmCIaMm49u1Viq4lLpmqugbNsD4KQi5
         cr+5Dt0guQd3Z3PUDXUICz6CXgJD4PwAcOOElHl4GKV1dStbtxt3pASsgNnHue1hhzdW
         ef6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=umGZEQbuKMgrNvhGvByniZ7Anp1p5oZ9xYk2M/7LMIg=;
        b=QarGHadEaTjJf+8DPNmjVzsQib7kcTxQNUk9utHodlnH7XbhcrGdCPxQpPOGlpCsjV
         +1q7eyMy/QFrfnQtX6jYSw6HvTf1M+bvdJDKxTDjkE/05jRJQem+WqC+peLL4+8ut3ff
         76y3CS6/rHNo0C+elT0Gfz2NuAanO07I9eT7gHv6nx+B2g8yZYF5PFd8ex6YXS+04DPk
         4qx6DfBnXzn8H2whVz1eaGAXZfToN2xVIZEvWXX8lGPD4gTrrkjma2ZUjm5hvIdoendk
         HLZK7HYcMmIE68GvohMSoWTNU0+DCgvjE906gXrPlYj5kewB1IgtRuNd0bS9g9YdtNg8
         fAFA==
X-Gm-Message-State: APjAAAWaxIqdafyN9F/6JH5BoAQencS438zd3Pwnc6OGYFfXmbK8+fSb
        dmjrOcZjJGndGM7jAojWH8EUjmnaOgg=
X-Google-Smtp-Source: APXvYqyfu1vaXnaBt/a4cn1Izhsu2KPPPssPZHqKOM0rU1mS0BC+Q2h87tf9PrHhZidxUsAj/sLU6A==
X-Received: by 2002:a1c:6c16:: with SMTP id h22mr9120865wmc.87.1552847489783;
        Sun, 17 Mar 2019 11:31:29 -0700 (PDT)
Received: from p200300EEEE2F.fritz.box (p200300C9871AF900B43796A8F69485B6.dip0.t-ipconnect.de. [2003:c9:871a:f900:b437:96a8:f694:85b6])
        by smtp.gmail.com with ESMTPSA id q5sm8415358wrn.43.2019.03.17.11.31.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:31:29 -0700 (PDT)
From:   Emanuel Bennici <benniciemanuel78@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Henriette Hofmeier <passt@h-hofmeier.de>,
        Thomas Avery <tavery321@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Aymen Qader <qader.aymen@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Young Xiao <YangX92@hotmail.com>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 04/10] staging: rtl8723bs: Remove old unreachable Code
Date:   Sun, 17 Mar 2019 19:31:07 +0100
Message-Id: <20190317183115.32393-4-benniciemanuel78@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190317183115.32393-1-benniciemanuel78@gmail.com>
References: <20190317183115.32393-1-benniciemanuel78@gmail.com>
Reply-To: benniciemanuel78@gmail.com
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commented code in core/rtw_mlme_ext.c obsolete because the macro
CONFIG_INTEL_WIDI no longer exists.

Signed-off-by: Emanuel Bennici <benniciemanuel78@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 1f7c87e48c1e..b2813eb3d9d2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -5707,11 +5707,6 @@ void linked_status_chk(struct adapter *padapter)
 		/*  Marked by Kurt 20130715 */
 		/*  For WiDi 3.5 and latered on, they don't ask WiDi sink to do roaming, so we could not check rx limit that strictly. */
 		/*  todo: To check why we under miracast session, rx_chk would be false */
-		/* ifdef CONFIG_INTEL_WIDI */
-		/* if (padapter->mlmepriv.widi_state != INTEL_WIDI_STATE_NONE) */
-		/* 	rx_chk_limit = 1; */
-		/* endif */
-
 		psta = rtw_get_stainfo(pstapriv, pmlmeinfo->network.MacAddress);
 		if (psta != NULL) {
 			if (chk_ap_is_alive(padapter, psta) == false)
-- 
2.19.1

