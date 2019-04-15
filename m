Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA62C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F25921902
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355060;
	bh=8rRQHwobng+aZa9UIy3jd+ANvm5R4fXjvQ7dzLT+bWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tDDQvDu1db1ia6BfD70SF0MnWf1BafYD+IGxXq+EQdT8pMDw8jFK57HWlHJ6uhq80
	 31GxBexr7ivcAg2Rf87EQBKfE4RGw+Ih2y/K+FI8la5Qt++X3wb+S0Y4ASscYRaZqz
	 bM8HG/B+JqE+ealiTj3ailIEmckO7iobABbyA9Ig=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbfDOTET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbfDOTEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:04:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A25212087C;
        Mon, 15 Apr 2019 19:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355056;
        bh=8rRQHwobng+aZa9UIy3jd+ANvm5R4fXjvQ7dzLT+bWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDnvDFnBxiIfcA3lh2bvTga41TIaL8hma+bCZsKhuMMleg22pZR+pCuAxRtOUe4Ir
         l/VmyX+gVYwH892PGcegvERGcUgFUP4wz7wapGD5L1GdtNEXjhRI+osAO9F6d8HBFR
         oALjT176rQ2ft5Icu85YNCpzcGFHNew/QVLHnnFI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4.14 42/69] alarmtimer: Return correct remaining time
Date:   Mon, 15 Apr 2019 20:59:00 +0200
Message-Id: <20190415183733.048867920@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183726.036654568@linuxfoundation.org>
References: <20190415183726.036654568@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrei Vagin <avagin@gmail.com>

commit 07d7e12091f4ab869cc6a4bb276399057e73b0b3 upstream.

To calculate a remaining time, it's required to subtract the current time
from the expiration time. In alarm_timer_remaining() the arguments of
ktime_sub are swapped.

Fixes: d653d8457c76 ("alarmtimer: Implement remaining callback")
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: John Stultz <john.stultz@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lkml.kernel.org/r/20190408041542.26338-1-avagin@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/time/alarmtimer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -597,7 +597,7 @@ static ktime_t alarm_timer_remaining(str
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return ktime_sub(now, alarm->node.expires);
+	return ktime_sub(alarm->node.expires, now);
 }
 
 /**


