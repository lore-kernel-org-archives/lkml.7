Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DA8C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5392082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 18:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="npLyOjeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390692AbfC0STQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:19:16 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36420 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390676AbfC0STM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 14:19:12 -0400
Received: by mail-pf1-f193.google.com with SMTP id p10so10096525pff.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 11:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=elq3lPVXVJpFQIKCv7kEN+Z8SrDMJCw2P5QlEAUjYmE=;
        b=npLyOjeODYZMYwa3GB4kCwcHF6OLdI+lR12TIk26fb1bYAGCqz3RaUIjCqgaPxuC1W
         5HIPLwR/4XJ726v/vcrYrZkss9WrJFip0B1NpB7gABFCw2aZdhyvO/wPOLO+7NXDMK/5
         2sDAo6LqmgnrePHzB5lmW0V3jMXcEX99C0ttIsMu2kKm1T4mdu4iyeuiF6LfbNuptyGF
         njLsfMnZhN/dDHOHCujVlPUnNMO2SRJgr2MaQSgvpCCTc5mk6rgn4efUbZLhoLd+YGPo
         1PdtTGd3WOyFYDliVYCA17hUwpo+qrJFzAiaSlnXGR8JI7L2BvsJinGxdP7NvfyeAfQ1
         blhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=elq3lPVXVJpFQIKCv7kEN+Z8SrDMJCw2P5QlEAUjYmE=;
        b=e15NFyrNWiipULEDJANLGxq69NFJBoGxRkjelYjjLtCLy2ngLU/ziFECE9hT3zTSCx
         WOIACZ4pLHxNhLUxiAShGOvE6+dd+5S8T2anuKQjLkn8C29FpCSaWu4lxuT/4rTb5U7X
         ZZbYs/6NKkreyfIStHnfq1la4cAAFhuTuU0Lj1nkISju8XbpHxgyznCdtzmSFM4ll3zL
         375Cr1DLs5dwtvYlN6Vg0+EUE5pb5rdBga4/oE8ZXt3mC7SUNYIIFRZccdMAGY05LZxf
         2RLmWB/4rcH6nbgsy0fMaZa2n/x3ZCOT++fahjGK9KGgSweRgbprqTf8iehlFp0m09T1
         HN2g==
X-Gm-Message-State: APjAAAVvZxAIvf7snK+GEezV4GJAGAQYRPimmA84xqs8JZdHwu8HcVTF
        WhjlgvMfS3XxTEoijtc7wB7aZCnlksc=
X-Google-Smtp-Source: APXvYqx2UTp2ffxcXn9AJ9K4uNKWCJiJQd3mHU3bC7jGzj3AB9Kx7RLLJQ0D0MUjQONLdCsVHNTuLg==
X-Received: by 2002:a63:481:: with SMTP id 123mr36300079pge.167.1553710751373;
        Wed, 27 Mar 2019 11:19:11 -0700 (PDT)
Received: from auvm ([106.51.27.254])
        by smtp.gmail.com with ESMTPSA id l74sm25755366pfi.174.2019.03.27.11.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 11:19:10 -0700 (PDT)
Date:   Wed, 27 Mar 2019 23:49:07 +0530
From:   Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
To:     gregkh@linuxfoundation.org, hadess@hadess.net, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: rtl8723bs: core: fix line over 80 characters
 warning
Message-ID: <20190327181836.GA37876@auvm>
References: <20190326182309.GA33380@auvm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326182309.GA33380@auvm>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch.pl complains that these lines are over 80 characters. Use the
"psecuritypriv" pointer for consistency, remove unnecessary parantheses
and fix the alignment.

This patch just cleans up a condition, it doesn't affect runtime.

Signed-off-by: Anirudh Rayabharam <anirudh.rayabharam@gmail.com>
---
v2: Made the commit message clearer, removed unnecessary parantheses and fixed
    the alignment as suggested by Dan Carpenter <dan.carpenter@oracle.com>

 drivers/staging/rtl8723bs/core/rtw_ap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 18fabf5ff44b..8062b7f36de2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -2336,8 +2336,8 @@ void rtw_ap_restore_network(struct adapter *padapter)
 			Update_RA_Entry(padapter, psta);
 			/* pairwise key */
 			/* per sta pairwise key and settings */
-			if ((padapter->securitypriv.dot11PrivacyAlgrthm == _TKIP_) ||
-				(padapter->securitypriv.dot11PrivacyAlgrthm == _AES_)) {
+			if (psecuritypriv->dot11PrivacyAlgrthm == _TKIP_ ||
+			    psecuritypriv->dot11PrivacyAlgrthm == _AES_) {
 				rtw_setstakey_cmd(padapter, psta, true, false);
 			}
 		}
-- 
2.17.1

