Return-Path: <SRS0=tJqY=VY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A91C7618B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424852075E
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jul 2019 12:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sochV/fV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387559AbfG0MxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jul 2019 08:53:07 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45811 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728824AbfG0MxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jul 2019 08:53:06 -0400
Received: by mail-pl1-f195.google.com with SMTP id y8so25776527plr.12
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2019 05:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ld7+Uj630f5ZM6LOdOr+O6vUN4++4Q00HLFfndySjNc=;
        b=sochV/fVlWbh9AkilsVBjLDAbUAqRX1oVoo0Z9KD2mypUzJDaRgfrNf5QHF2eGaq6k
         V3FeXj/mV3cUk4cZ6HTyZ4e/TIcTBT09I4WzIKSnG852F/TtALSbD5yk/M8tRrn+Wfbd
         qjeMzuanWNerEUu3X9/fpUu/FCkhOwZg9yA+p06PrrFQc983pyTTOWsCX2hqZ0jtTDxV
         Cmjn5qa6zhTrbIfIAxKnPnUWccJqAqehokVk+vksdXe3L4dRP9BntmjjJAI5AsGeLfZE
         ANA4hKv58PgY72K+X9Fkzw19omCC+FtXYYLKAfDEOH7xe2n7vGNWQff9dU7piTsUru5h
         Q+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ld7+Uj630f5ZM6LOdOr+O6vUN4++4Q00HLFfndySjNc=;
        b=I9ekzT9evEmm5qKpH/Fo+v7JfsktlxTNRqlpXLKY7Y3uCpZBZDypMk+mV+5Dqdg2mf
         KqC5XlEYR5OYaO6f9R5F/fNuWIhmT8b6Hg2cS+ae1x5NY/2lxnawakH3MOECxsv59fF3
         usN401xbFeNl7zc12RkF7ksY7xVGczUJ+U19BR7pt6NBfdgtinzYEQGFjTCPLV9AOAAO
         FQUuVrC2UCfcbZUbi1kVef2aWqByY/19CtLjvVI58ZFPf/eVsweFwzlynVaOpDDf26ID
         yJY3vEHdHuUGpdfHAHPY21nT2NMHAQjujQS/EcY9pAQ3JS9YcMRuRi7pneKNaTDuKgW2
         6Ymg==
X-Gm-Message-State: APjAAAUqttRWs5LAP8ATbXI0OI8obI56UAzZBY2SGKxYiD6eTNwc5KuG
        KaQf6hA7YYsh1g+HSbDaQbE=
X-Google-Smtp-Source: APXvYqyeW/wa8fc9UwVhHiUkdKfJrle/DifqN6rBC96OG59gwBM4VPYRkXRHxoWoq3/fCqI4FTNx7Q==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr6731069plj.141.1564231986201;
        Sat, 27 Jul 2019 05:53:06 -0700 (PDT)
Received: from hari-Inspiron-1545 ([183.83.86.126])
        by smtp.gmail.com with ESMTPSA id y23sm58091408pfo.106.2019.07.27.05.53.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Jul 2019 05:53:05 -0700 (PDT)
Date:   Sat, 27 Jul 2019 18:23:00 +0530
From:   Hariprasad Kelam <hariprasad.kelam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hariprasad Kelam <hariprasad.kelam@gmail.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Emanuel Bennici <benniciemanuel78@gmail.com>,
        Shobhit Kukreti <shobhitkukreti@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        hdegoede@redhat.com, Larry.Finger@lwfinger.net
Subject: [PATCH] staging: rtl8723bs: os_dep: Remove unused defines related to
 combo scan
Message-ID: <20190727125300.GA8629@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove below defines WEXT_CSCAN_AMOUNT WEXT_CSCAN_BUF_LEN
WEXT_CSCAN_NPROBE_SECTION

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 99e6b10..73b412e 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -21,13 +21,10 @@
 #define RATE_COUNT 4
 
 /*  combo scan */
-#define WEXT_CSCAN_AMOUNT 9
-#define WEXT_CSCAN_BUF_LEN		360
 #define WEXT_CSCAN_HEADER		"CSCAN S\x01\x00\x00S\x00"
 #define WEXT_CSCAN_HEADER_SIZE		12
 #define WEXT_CSCAN_SSID_SECTION		'S'
 #define WEXT_CSCAN_CHANNEL_SECTION	'C'
-#define WEXT_CSCAN_NPROBE_SECTION	'N'
 #define WEXT_CSCAN_ACTV_DWELL_SECTION	'A'
 #define WEXT_CSCAN_PASV_DWELL_SECTION	'P'
 #define WEXT_CSCAN_HOME_DWELL_SECTION	'H'
-- 
2.7.4

