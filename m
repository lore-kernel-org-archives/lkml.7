Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D695C04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07B121019
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaU3eFcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbfEMLP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:15:29 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44403 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbfEMLP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:15:27 -0400
Received: by mail-pg1-f194.google.com with SMTP id z16so6603669pgv.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=3iAATnbSEiy6b6i71ojDZbziQxQ7RiHCHlvJLO1/RJk=;
        b=WaU3eFcL3Wh+Ko+6wV7nZ9QbQpdYDw3FHhgJH2CoMDkRdTN4kpBLlTMYyWwbXTJDqX
         U9E+0q1QJgK5kc3L59EOugKXRbUZFaqi3Yf7C4Y/0BHVUDwqeUrzMIHINyvsZkduoh4q
         Lq8YoHjh+d2mrV3VfxBCUehOe8dOIJgXJmJH+N9FTQ0X73g6RMqE4cvOSMv58z/FPfHy
         xHUgWCmBS3qg3k6X3gh5qb0kGI9yPjfqW8vrx6qI017gaUhnacaQPu3kM8ciq9wRMQnu
         01s5imbG9hpBai4GFZUZkvjXd4eTbkEJOylLvSmSmXmuHFkf4JOtZ7riE6PUQUuWQjDm
         Xojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=3iAATnbSEiy6b6i71ojDZbziQxQ7RiHCHlvJLO1/RJk=;
        b=lYGWLsxKoykEEgjMXNOQwuq6nVMzDCSs0KejZQEKJF6NR/4bnq4yek9cTzy9V+INcm
         vV4AiMQ0AcC1/McoL15u5l2P2Q9qmxULsG5MEp+ZWhvO/TWBEs4zSo42zxLhk9O0HsYt
         H4pls7KaJMFSGWkZoAhXoAb9MRlzhCB0KAR7XwLXUJUZdBn8tC61xet4twFIJba/ed/V
         EjGhHXQvxgs+iqWka5C74xKdgfKKoPEGRVgeBK4XFCvfAVs/0N9RGimsLe8HvfpClQKM
         1xrLzkJ5vYQxcYxJiA1REc9sxLFcClzKRt14KRbYhV32kr30xy5UnvoAg/4dF5JbCkFc
         baBg==
X-Gm-Message-State: APjAAAV4g93Nez3/8aJJWHfZB5CH/LE14A/38lRIN9L4UNb+jqVdsyJe
        o5kKJiQwdZ85CHpIr8h+GRE=
X-Google-Smtp-Source: APXvYqxMNZIcn/HilH5dCIoNUPQR+fjxs+ZB3BXNTS1fC7qLDqU0TSK+X38T8hD4TUmNpvvnuf6FCg==
X-Received: by 2002:a62:83c8:: with SMTP id h191mr12306755pfe.251.1557746126297;
        Mon, 13 May 2019 04:15:26 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id a7sm4675526pgj.42.2019.05.13.04.15.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 04:15:25 -0700 (PDT)
Date:   Mon, 13 May 2019 16:45:18 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [Patch v2] staging: rtl8723bs: os_dep: Remove Unneeded variable ret
Message-ID: <20190513111518.GA3766@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix below issue reported by coccicheck

drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2685:5-8: Unneeded
variable: "ret". Return "0" on line 3266

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>

----
Changes in v2:
  - make subject line more clean
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e3d3569..3f1ab6e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2682,7 +2682,6 @@ static int rtw_dbg_port(struct net_device *dev,
                                struct iw_request_info *info,
                                union iwreq_data *wrqu, char *extra)
 {
-	int ret = 0;
 	u8 major_cmd, minor_cmd;
 	u16 arg;
 	u32 extra_arg, *pdata, val32;
@@ -3263,7 +3262,7 @@ static int rtw_dbg_port(struct net_device *dev,
 	}
 
 
-	return ret;
+	return 0;
 
 }
 
-- 
2.7.4

