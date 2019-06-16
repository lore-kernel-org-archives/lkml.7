Return-Path: <SRS0=7o0M=UP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE132C31E51
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D7920652
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Jun 2019 03:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etPgZwUY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfFPD1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Jun 2019 23:27:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39209 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726870AbfFPD1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jun 2019 23:27:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id 196so3838844pgc.6
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2019 20:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=468/RLQKpIqiti2//KMB81NPRyvxXX0VssP8ZgLdNtw=;
        b=etPgZwUYVMabvNDiHfuYDthpUixrKax2+vMU4U4qKFIZgDXih3zHnvdcziRLeDFBwE
         3r02ZYAJ6PPrd/9EyK519Q4MaJM0LyY7ELMOhfmOpvHXiDDEZG5zMIpFeZUp91y1c1dZ
         KNdLhUSb0Be7TIcKPX05hh9pOUQWPrq12TN94NvoBEZIOMtF+R8sO6GrHJLzW64b5yWj
         YUljYcSIlSmYHDxt6TWxpl0O52wg2FBQJJ/TR34tO7HFL2YaNS+QBdPn/UINxqsAIYCb
         bFDkHnLd9QhcPS4og/ivqLTsmP+BGVwrln/7p90gQWRdlVttNjoNjEeRCp9T233Uwgfv
         GugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=468/RLQKpIqiti2//KMB81NPRyvxXX0VssP8ZgLdNtw=;
        b=MYGTcC58R4pb5shwygPGgvp76tmtNpB3IChgpHHBE4JFdRlYQ7FTaKpU1iJX/dw/zo
         /FoVw0J/q7aT4yqsNE1mqpkhLWKoV7qbcLSh9Sq6rv4EyPK84Amkr40owPvjn7m2rvGy
         H0Bwb+YloAU3jzJM5iQsC8S1eyFHEWkxuhQp+8rP+8ta1CIc/IaXxZiKUtRvxJsDMqFn
         U+65x75CMNoFqbkJdbtAMbS1Jwdr/Z64qF9DqCRe5inQRRM5neCnggTL7LFSEJoxJbGE
         QaDWfRumNy3lu9ax6SwAaBvURjiDu9Gh5VFoj/UDLhQnt8RXCsy5zE5Oy+h0JWLcebMc
         q46A==
X-Gm-Message-State: APjAAAWTumpyf3+bmHsCXVvRViznFna7djAKorD6YEZWXgryUO8MOFqr
        l67pyDMDHa50ugo1/RqRWdE=
X-Google-Smtp-Source: APXvYqxLn4cvOpVNTUHm+i4dJj/N+ModuzP1/ExShNgEha1mvVOgElUNUZ0r/rFUVe5Ixd5nwKllJA==
X-Received: by 2002:a17:90b:8d2:: with SMTP id ds18mr19685197pjb.132.1560655630682;
        Sat, 15 Jun 2019 20:27:10 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.89.153])
        by smtp.gmail.com with ESMTPSA id 125sm4615801pfg.99.2019.06.15.20.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Jun 2019 20:27:10 -0700 (PDT)
Date:   Sun, 16 Jun 2019 08:57:05 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishka Dasgupta <nishka.dasgupta@yahoo.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Jeeeun Evans <jeeeunevans@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hardik Singh Rathore <hardiksingh.k@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging/rtl8723bs/core: Remove redundant call to memset
Message-ID: <20190616032705.GA13790@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rtw_zmalloc is doing memset . So there is no need to call memset again.

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index d26d8cf..a8dab1a 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2229,7 +2229,6 @@ sint rtw_set_auth(struct adapter *adapter, struct security_priv *psecuritypriv)
 		goto exit;
 	}
 
-	memset(psetauthparm, 0, sizeof(struct setauth_parm));
 	psetauthparm->mode = (unsigned char)psecuritypriv->dot11AuthAlgrthm;
 
 	pcmd->cmdcode = _SetAuth_CMD_;
@@ -2262,7 +2261,6 @@ sint rtw_set_key(struct adapter *adapter, struct security_priv *psecuritypriv, s
 		res = _FAIL;
 		goto exit;
 	}
-	memset(psetkeyparm, 0, sizeof(struct setkey_parm));
 
 	if (psecuritypriv->dot11AuthAlgrthm == dot11AuthAlgrthm_8021X) {
 		psetkeyparm->algorithm = (unsigned char)psecuritypriv->dot118021XGrpPrivacy;
-- 
2.7.4

