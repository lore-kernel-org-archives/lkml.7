Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85A8C48BE8
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FD42070B
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 16:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfB7oRUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfFVQlO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 12:41:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35195 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbfFVQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 12:41:13 -0400
Received: by mail-pg1-f195.google.com with SMTP id s27so4843782pgl.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2019 09:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=N2gUTBH2OR+uI9TRPkHXeFtmpRrFd2HrYT6sxFxzjjQ=;
        b=bfB7oRUFXtZsHa5PVNf3HNIRwgW8jty71EWcLeS4wmGBsIloCzimZQWFxSVP7XpWbG
         8fGLftWFbl5uLX4FmfAysjw4TDPnLN7PYR0IeAaou29nmXXDKeXd6iC4kIktuiOjTfL9
         iWjDMZsc3h0npHOHyvAdgsd+q3uLLLSDgtWbLa5nj1Zwfzo8BYfi0iqTozfB/KR/uqqH
         GH+fcbDgtl3McGk17FSSBNlbCoJcJjs4yLKLb5cQGIZaduZ0LGGwGjfZoC4M+H4rVfQa
         oSsY8vMNB88HyieTPGlyvvun/WjOJGfuzzZ7pi0xaiFLAsjqQvZTXP/17WTb1Dqm+6yy
         n/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N2gUTBH2OR+uI9TRPkHXeFtmpRrFd2HrYT6sxFxzjjQ=;
        b=cBg4zyN51RIpGUHk+AhHUR+ZpsowoGCR6vawZnV2zCUU6NU5dM7NZbzGqsDvUvKL4W
         NwxSNOlDZ8ApCN961iZBly7V9kskx/8bEomnItWcUUaZE6S3iIJiizCyr4VUHBp2Btvl
         MOGOBIb1dzTYXtIILDFUvgZs3R+uOIr0+CkRKnpwPnkChs+SKCs3SOWzKZi4R5nSJfKj
         N0lqwdGgxmYBNIwFpz05++IHCFTjYG39KCDxobw0/WR+1vQ0D08+qCFW/CxSHFGUC2co
         hoO1VFMvIb9Dqwb9uJU9Az2J3/6T0eYwkrvf1ehjikRRQDhXuRLjecTEJ2xrfU482jCt
         cwKg==
X-Gm-Message-State: APjAAAV0b81K4nGNAa+CQm7OhMpByKHQhb3TUE4sAqr4nBAQngSFbSyU
        MCXMd6UDkW3gKgTp37L5Y9E=
X-Google-Smtp-Source: APXvYqwVOhx+YvbiAK8mJ4RJDN1YY63VDT6GCjyE4W2X2ICbbF9g70cPpKWyfOQdMw7w4OEjQv1FNg==
X-Received: by 2002:a17:90a:ac13:: with SMTP id o19mr13914783pjq.143.1561221672736;
        Sat, 22 Jun 2019 09:41:12 -0700 (PDT)
Received: from localhost.localdomain (c-98-210-58-162.hsd1.ca.comcast.net. [98.210.58.162])
        by smtp.gmail.com with ESMTPSA id u5sm5809161pgp.19.2019.06.22.09.41.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Jun 2019 09:41:12 -0700 (PDT)
From:   Shobhit Kukreti <shobhitkukreti@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Shobhit Kukreti <shobhitkukreti@gmail.com>
Subject: [PATCH 1/3] staging: rtl8723bs: os_dep: Change return type of function rtw_suspend_normal() to void
Date:   Sat, 22 Jun 2019 09:40:40 -0700
Message-Id: <f7486ee2092699ffb20a7cee298050e41bb7b5f6.1561220637.git.shobhitkukreti@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
In-Reply-To: <cover.1561220637.git.shobhitkukreti@gmail.com>
References: <cover.1561220637.git.shobhitkukreti@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coccicheck issues Unneeded variable "ret" warning.
The return value of function rtw_suspend_normal() is set to _SUCCESS.
The return value is never never checked by the calling function.
Modified return type to void to remove the coccicheck warning..

Signed-off-by: Shobhit Kukreti <shobhitkukreti@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/os_intfs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 8a9d838..e1e871e 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -1422,10 +1422,9 @@ int rtw_suspend_ap_wow(struct adapter *padapter)
 #endif /* ifdef CONFIG_AP_WOWLAN */
 
 
-static int rtw_suspend_normal(struct adapter *padapter)
+static void rtw_suspend_normal(struct adapter *padapter)
 {
 	struct net_device *pnetdev = padapter->pnetdev;
-	int ret = _SUCCESS;
 
 	DBG_871X("==> " FUNC_ADPT_FMT " entry....\n", FUNC_ADPT_ARG(padapter));
 	if (pnetdev) {
@@ -1447,7 +1446,6 @@ static int rtw_suspend_normal(struct adapter *padapter)
 		padapter->intf_deinit(adapter_to_dvobj(padapter));
 
 	DBG_871X("<== " FUNC_ADPT_FMT " exit....\n", FUNC_ADPT_ARG(padapter));
-	return ret;
 }
 
 int rtw_suspend_common(struct adapter *padapter)
-- 
2.7.4

