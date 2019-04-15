Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8251DC10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A0F52075B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355831;
	bh=/tTIezOw4NUNRZW97BRmzUuVRCBgj4mMLEcgBhBOjkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UzRCyJWOs5JhYsBrcISk75JcIk3k+Pjxb9ya9g9SeTr1zoPJYL7Vs44PAD9IpFQ2P
	 7Nl1dBmfeL/EIVBHUWWfQgm7jD9TCYDrohSRJseeIqfT0jxIGX+jPxgOjevAuy+rKR
	 cM23ngc93Jm8IHSON8/jOJ8uOTnYwHLPMHgH2LMw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731674AbfDOTRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:17:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730168AbfDOTMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:12:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D87020880;
        Mon, 15 Apr 2019 19:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355557;
        bh=/tTIezOw4NUNRZW97BRmzUuVRCBgj4mMLEcgBhBOjkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HpH+VtL6ysezJp2kHrTi1woGjPjT9V8obRDE+7wdHcT+X8APtCgx+9RtGJZORcqOn
         WgkJa6R3v6JpTqHTP9qnBS5mNhimvApqTsEzQ5nWG82PX1D4OickZ/rRuuDxlaoUOd
         zCQy1Xz4eoLc8ibSWNSPdH/07FskZql42j8kFjGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 5.0 065/117] alarmtimer: Return correct remaining time
Date:   Mon, 15 Apr 2019 21:00:35 +0200
Message-Id: <20190415183748.251904926@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
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
@@ -594,7 +594,7 @@ static ktime_t alarm_timer_remaining(str
 {
 	struct alarm *alarm = &timr->it.alarm.alarmtimer;
 
-	return ktime_sub(now, alarm->node.expires);
+	return ktime_sub(alarm->node.expires, now);
 }
 
 /**


