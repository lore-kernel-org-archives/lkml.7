Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45FEC282E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F91217FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 06:47:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXLEhMQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbfDYGrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 02:47:47 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40386 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYGrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 02:47:47 -0400
Received: by mail-pf1-f193.google.com with SMTP id c207so10615026pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 23:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MfadBOZHDy5Mf1IJGguZmr8zMU+dJK1bFg7For3vejM=;
        b=AXLEhMQ7uiX4H0M+XtuJYv1xI2SrCZJLvxNWJAUzUP+O9UrZsYL0pmP3oBoE2EjrXZ
         mWJBtXuBYuvt06U7yffRxpen2uFQcNA+PE+HMbDPiCSkdERQJnxgI6yqYqPQlpSK72dA
         BpgXnseOqIdsLcSIdOSdb2wdw9Low1q9pQRTEpoh4QOpDjN/MmNc3JG6t9D/HMqTrZJ7
         pZNEUrdhgjbl/AE6iQojykq3OlDyLSU0F4ejF11/pLYqu+6B3KG2KeweO+v9bypfUtYA
         8SGJmgRiwEhaeyXtTAPmQNNx2seRpkPZqNDTGg7+pR3pHDa1eYDhoD9/Ksk8ztUSV+VN
         73jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MfadBOZHDy5Mf1IJGguZmr8zMU+dJK1bFg7For3vejM=;
        b=HlsiMcM5Vq+Il6+hyjtUUKrphC3deeMKlzkoaNSo+nAaTTTaqlVukhq8VUYNQ3Lw35
         zLlcWuxsT5FifM/eRUR+cTWUOmqfTP1NkxeCMK6T27wGsvaVb2m23r0Bk306zjgZfjnU
         //spkI9Mck9YlykFZjcyD5mx+AM02Hd6otisXhk6sCxTCoxb3jVEFalxNIQo6b4+BZSR
         SSHTxP71QEpBba50Uop+romCs2oLE4yg+ScD9CmodnkzGFYLTDCA+urKPIR0JJOZGJvO
         rEidjnBacsLPahRpNq4RDMCIg2qbCD1Tp0jVMXqQS5WWwTERpzXYjPRwPSarf+tnRydx
         /lyw==
X-Gm-Message-State: APjAAAWNdVvyhikcT0JkNNZayH4r9mCiTT3/X0mE5ca1P6+s28yuxgPq
        EC5Z6uwSB1u5G+OAF+t+n0/TL4IF
X-Google-Smtp-Source: APXvYqxFTvjUKxKCvGpuvRW3xmb2/2Nqsz6wydnA3g6aMc4eaVAyiY7G2EXdWBGKCd3X56wQF0AGFQ==
X-Received: by 2002:a63:f315:: with SMTP id l21mr22479949pgh.417.1556174866619;
        Wed, 24 Apr 2019 23:47:46 -0700 (PDT)
Received: from localhost ([175.223.37.83])
        by smtp.gmail.com with ESMTPSA id b19sm27747588pgb.51.2019.04.24.23.47.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 23:47:45 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:47:41 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [RFC][PATCH 2/2] printk: take console_sem when accessing console
 drivers list
Message-ID: <20190425064741.GB27270@jagdpanzerIV>
References: <20190423062511.1118-1-sergey.senozhatsky@gmail.com>
 <20190423062511.1118-3-sergey.senozhatsky@gmail.com>
 <20190424151306.jcmygibltizcorgk@pathway.suse.cz>
 <20190425051944.GB8532@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425051944.GB8532@jagdpanzerIV>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/25/19 14:19), Sergey Senozhatsky wrote:
> 
> So may be we can move the whole thing under console_sem.
> 

Something like below. I'll re-spin the series in a day or two,
we have time.

---
 kernel/printk/printk.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 52d1123d9fdc..0c2eb161e793 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2666,7 +2666,7 @@ static int __unregister_console(struct console *console)
  *  - Once a "real" console is registered, any attempt to register a
  *    bootconsoles will be rejected
  */
-void register_console(struct console *newcon)
+static void __register_console(struct console *newcon)
 {
 	int i;
 	unsigned long flags;
@@ -2771,7 +2771,6 @@ void register_console(struct console *newcon)
 	 *	Put this console in the list - keep the
 	 *	preferred driver at the head of the list.
 	 */
-	console_lock();
 	if ((newcon->flags & CON_CONSDEV) || console_drivers == NULL) {
 		newcon->next = console_drivers;
 		console_drivers = newcon;
@@ -2820,19 +2819,25 @@ void register_console(struct console *newcon)
 
 	console_unlock();
 	console_sysfs_notify();
+	console_lock();
 
 	if (keep_bootcon)
 		return;
 
 	if (bcon && (newcon->flags & (CON_CONSDEV|CON_BOOT)) == CON_CONSDEV) {
-		console_lock();
 		for_each_console(bcon)
 			if (bcon->flags & CON_BOOT)
 				__unregister_console(bcon);
-		console_unlock();
-		console_sysfs_notify();
 	}
 }
+
+void register_console(struct console *newcon)
+{
+	console_lock();
+	__register_console(newcon);
+	console_unlock();
+	console_sysfs_notify();
+}
 EXPORT_SYMBOL(register_console);
 
 int unregister_console(struct console *console)
-- 
2.21.0
