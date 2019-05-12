Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFE5C04A6B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AAE20C01
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 11:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRNU8ttk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfELLcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 07:32:52 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42439 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbfELLcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 07:32:52 -0400
Received: by mail-pg1-f195.google.com with SMTP id 145so5264841pgg.9
        for <linux-kernel@vger.kernel.org>; Sun, 12 May 2019 04:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=9f00UOD9NYVcNSwcRACXhgj+F1rjTUSAOxdcAQilGeM=;
        b=JRNU8ttkWu7WYhoYidiWjaf7gI8eubmh7Jdu0XhMfjo9ZJOXo7weoUF5vf5sHZHjSC
         +xY05/2mnT0IRHTMvwwIVeeD/7LLfrIGnoyQYmRnx3L+N5itN2vk5K6LjvbShE0UkYuw
         sZUWrmSizlJG+JD/HkOfAKinUMpTyfWH+aCmuVZScL3CubDfIxbqlDpoWl+XXCIP49Mp
         NNr2Bz8nsV8LEUcGFhsFQe7YChx71iySn5pxFd79GklhnbqUrT3MGedQBBSdqSvqegqS
         9HMIjmEXN7zy6ZHNAj7pZma3wElB0je+khcTsdjgd541Me0H0XyCTffHqwtcn9+wzewO
         qYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=9f00UOD9NYVcNSwcRACXhgj+F1rjTUSAOxdcAQilGeM=;
        b=BXu2g6oaQWY4mbAdxo5RKLUIEVAykkxBq9jpBZH7wNclAfUWYbnm5TdfSLOdVPxUWZ
         Vzvc6CiXrfohi+1A6jgLwbyVck28X5zVA1fyRRfcWo0B5ivY1/1jSfCLh9dIeueHxgk3
         BVg9mfxbFoDHF1Vpn2E9wF/Cy1baKSkNXEYkXFuBOksPpkR9ZWdP/HdRY5ueRSQ/988E
         TbCoyvP9sXTpvX7uqNHvZEEMXZGV4UxIu+WPhmyiBPNYBTfFgfM2jK9+qMSrbJLqsP36
         Iz+NDrMt4N6rR1H+p4gcY3wXPsMN1rHbJ+7K/RyVEMfVajpJqcas2nHcqoru/VJ7MxNO
         IIeA==
X-Gm-Message-State: APjAAAW5pFYnUiiJgAe0rj7ZKpef53P8VzGdIE1h2ugMrioKY9U/o4h1
        Ki6ZqJOIwKQ+O3szv7Fo+xc=
X-Google-Smtp-Source: APXvYqyGJVBBZgQTr9jm/+R79kKhJgnd51p0UtxYhjrxIAptXX2ztH88Uv5uVfzeY9KfD9VFeIAxuA==
X-Received: by 2002:a62:579b:: with SMTP id i27mr27587948pfj.205.1557660771833;
        Sun, 12 May 2019 04:32:51 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.92.73])
        by smtp.gmail.com with ESMTPSA id s137sm12577493pfc.119.2019.05.12.04.32.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 May 2019 04:32:51 -0700 (PDT)
Date:   Sun, 12 May 2019 17:02:45 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Wen Yang <wen.yang99@zte.com.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        viswanath.barenkala@gmail.com
Subject: [PATCH] drivers: staging :rtl8723bs :os_dep Remove Unneeded variable
 ret
Message-ID: <20190512113245.GA2221@hari-Inspiron-1545>
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

