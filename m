Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30441C3A59F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E394821874
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 00:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="d+jv1H0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfH3A3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 20:29:19 -0400
Received: from mx1.ucr.edu ([138.23.248.2]:1322 "EHLO mx1.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbfH3A3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 20:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567124985; x=1598660985;
  h=from:to:cc:subject:date:message-id;
  bh=q+D0SryHYPNUN1CJ5QZseBsJ9Xc6ghplBypiNCp7NwQ=;
  b=d+jv1H0MPQyO9vF/wMph5nhrBx7TwZ+y4Q7u9mJlwn3uVIHxI3aUUbrq
   kJXZanm0DkmvzKH7Kisfkg1KT/zHb08bdUJ7O3EG8lS2ipt6aCQL17npq
   sYHIV9+s3v5XXXDB+AjfBdyBNNeGROZdXqMewYcjByMeG8YPYwoYDHPVV
   97z9woracg6ktWizYQn5rozovXq6vRBDLSLBl0+ZIHl5zGrX7YMgJVqAi
   aJEVZlaARffh567X4MbysZv9wIDv2wpICYs0x1sZE/iWcC95CnYddj42e
   HNSa+kwrQEDYKE6mhymCM1ouhToyeB9+B1Zj58w+XVD4dzvU3lexBmNrK
   g==;
IronPort-SDR: PD9N1aSsqXVm71ljO7JCEI3+PvSq8JWLd48KFtlEE+Un9tuXX6agTe44tLHrE1Rcq1a0wmUvv/
 GVPqL4HbqxqRGABt6g8lmx4M5dKj/mLzLcrVMj3ASpz42SAii5KsV6nfYdIUB7sXYs4kx+Kp8n
 ucReEMg7ZbDwY31xkgeR/vZjUk3gFVgDEgLzJrHZ1j8zmNHga3WidUupGspGso9zCSiBoMdOz0
 GIsP3x9yKjEdIZeP6RB6IO5QU0RmCFTsLV22umN0QDiMLrt+GplWRyCwEJGYlT9ilYcED+ExFr
 h7M=
IronPort-PHdr: =?us-ascii?q?9a23=3Aoq3w+BCcSRjV3vzbY8iLUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPv+pMbcNUDSrc9gkEXOFd2Cra4d0ayP7furAjVIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfK1+IA+roQjQuMQajoVvJrsswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwHMj858HrMisxxiqJbrw+qqQJmzYXJboGVNeRxfqfActgHQW?=
 =?us-ascii?q?ZMUNpdWylHD4ihbYUAEvABMP5YoYfjulUAoxiwCw63Ce/z1jNFnGP60Lcm3+?=
 =?us-ascii?q?g9FwzNwQwuH8gJsHTRtNj6NqYSUOG1zKnVyjXIcvRb2Df86YjIaB8hoO2AUa?=
 =?us-ascii?q?5+fMfK1EkgCxnFgk+OpoP4IjOYz+IAuHWY4ep4Te+jlXIrpgVrrjWsxsogkJ?=
 =?us-ascii?q?fFip8Jxlze6Cl0xII4KcWlREN6ZdOoCoVcui+aOodsXM8vQntktSQ1x7AApJ?=
 =?us-ascii?q?W1ZjIFyI49yB7ac/GHdo+I7Q/9W+uJOjd4gW5leKq4hxav7Uis0u38Wdew0F?=
 =?us-ascii?q?ZNtidFl8PDtnEJ1xDK8siHROZx8l6v2TqS0w3e7vtIIU8zlarcJJ4hxqA/mo?=
 =?us-ascii?q?APvkTEGy/6gET2jKmIeUU44uWk9fjrb7H8qpKfN4J4kB/yPrkylsClHOg1Ng?=
 =?us-ascii?q?wDU3Ce+eum1b3j+UP5QK9Njv0ziqTYsJHbJcQBqa64HwNZzogu5g2iDzi6yt?=
 =?us-ascii?q?QUh2cII09YeB6flYjmJ0nOIOzkDfe4m1mslDZrx/bbPrzuG5nNLWbMkK3nfb?=
 =?us-ascii?q?lj705R0xQzzd9B6JJOEL0BI+z8WlX3tNPGCh81KQu0w/zoCIY1+JkZXDe+A7?=
 =?us-ascii?q?2ZLaSa5U6a5usue7HXTJIeonDwJ+VztK2mtmMwhVJIJfrh5pAQcn3tRaxr?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EwAQCqgmddgMfSVdFlHgEGBwaBVgY?=
 =?us-ascii?q?LAYNXTBCNHYZcAQEBBosfGHGFeYooAQgBAQEMAQEtAgEBhD+CWyM3Bg4CAwg?=
 =?us-ascii?q?BAQUBAQEBAQYEAQECEAEBCQ0JCCeFQ4I6DBmCZAsWZ4EVAQUBNSI5gkcBgXY?=
 =?us-ascii?q?UnTyBAzyMVoVKgx8BCAyBSQkBCIEihx6EWYEQgQeDbnOEDRGDRYJEBIEuAQE?=
 =?us-ascii?q?BlE6WBQEGAgGCDBSBcpJTJ4QwiRmLEwEtpXcCCgcGDyGBRYF7TSWBbAqBRJE?=
 =?us-ascii?q?nHzOBCIwBASWCLgE?=
X-IPAS-Result: =?us-ascii?q?A2EwAQCqgmddgMfSVdFlHgEGBwaBVgYLAYNXTBCNHYZcA?=
 =?us-ascii?q?QEBBosfGHGFeYooAQgBAQEMAQEtAgEBhD+CWyM3Bg4CAwgBAQUBAQEBAQYEA?=
 =?us-ascii?q?QECEAEBCQ0JCCeFQ4I6DBmCZAsWZ4EVAQUBNSI5gkcBgXYUnTyBAzyMVoVKg?=
 =?us-ascii?q?x8BCAyBSQkBCIEihx6EWYEQgQeDbnOEDRGDRYJEBIEuAQEBlE6WBQEGAgGCD?=
 =?us-ascii?q?BSBcpJTJ4QwiRmLEwEtpXcCCgcGDyGBRYF7TSWBbAqBRJEnHzOBCIwBASWCL?=
 =?us-ascii?q?gE?=
X-IronPort-AV: E=Sophos;i="5.64,443,1559545200"; 
   d="scan'208";a="4934158"
Received: from mail-pf1-f199.google.com ([209.85.210.199])
  by smtp1.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2019 17:29:44 -0700
Received: by mail-pf1-f199.google.com with SMTP id 191so3855155pfy.20
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 17:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7nToAqjv4OEYbMmpARgQ1FCOKtHR4Z4q4zwJrXuyKdU=;
        b=YykqIFNtCpZZXuLzWajpwYDd9pajHzTgb5oPT0iLtLTK0i0lillkQSrr4wBrFp6WJa
         Ol+y75TgE6PZVH9d2wO6rJSSoS8RAF7oa+Fc9+lp0OxXaub0Uz7eChS43EWjtEm1ep7i
         8XjFmaBTEvSpQF/8RRw0aRooUJqgEcH1FH0oGdruD1aZJxieBnnD6v0D9R8KZKyLWQpN
         M4APRUGjuAPI7XFJvFIF/NMuOFn8OJjpPSM9Fu1fZ0qIW7r7ErSl1VqLWNQHEdQKE0o2
         6BqteeXH7Ahu6R1kDv+dZsaj9QZQNOdFWGsHut7Xv4tideVJb2FXuvxAcku2CtnfAJ3z
         Cb1g==
X-Gm-Message-State: APjAAAVSjangrJwIZ4+bGZyMWmy/dsxw1JbKgpjF8HBSFujYHLKh7Wdn
        pklfK+va9mosN13IiO6a3IXk886ZvjGBqbanU5prffr3y+UQwjwH3XojeRo1zzynuT/O/YjJOse
        CesJ6PMUjZMG6XgEEOf6248fMlw==
X-Received: by 2002:a65:5348:: with SMTP id w8mr10679733pgr.176.1567124956189;
        Thu, 29 Aug 2019 17:29:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwajsnQB5LSVw3bqtjQWdgVGe2PtIJ/iVC/Riptn+9pLXUos1Ww553JZXmJ7hEKGpBj+zPcnw==
X-Received: by 2002:a65:5348:: with SMTP id w8mr10679715pgr.176.1567124955849;
        Thu, 29 Aug 2019 17:29:15 -0700 (PDT)
Received: from Yizhuo.cs.ucr.edu (yizhuo.cs.ucr.edu. [169.235.26.74])
        by smtp.googlemail.com with ESMTPSA id l31sm3613812pgm.63.2019.08.29.17.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:29:15 -0700 (PDT)
From:   Yizhuo <yzhai003@ucr.edu>
Cc:     csong@cs.ucr.edu, zhiyunq@cs.ucr.edu, Yizhuo <yzhai003@ucr.edu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/smp: Variable nr_cpus is uninitialized if get_option() returns 0
Date:   Thu, 29 Aug 2019 17:29:50 -0700
Message-Id: <20190830002950.22458-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inside function nrcpus(), variable nr_cpus is uninitialized if
get_option() returns 0. However, the value will be used in the
if statement, which is potentially unsafe.

Signed-off-by: Yizhuo <yzhai003@ucr.edu>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index c94dd85c8d41..4bf24d4dc041 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -527,7 +527,7 @@ early_param("nosmp", nosmp);
 /* this is hard limit */
 static int __init nrcpus(char *str)
 {
-	int nr_cpus;
+	int nr_cpus = 0;
 
 	get_option(&str, &nr_cpus);
 	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
-- 
2.17.1

