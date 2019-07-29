Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DADC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA732073F
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 06:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="pPD/sBPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfG2G46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 02:56:58 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38603 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfG2G44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 02:56:56 -0400
Received: by mail-wr1-f65.google.com with SMTP id g17so60496983wrr.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2019 23:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=77kBMlKTAenEQAkiXPo05Wm16zYsJQ8LVBsU59Q9oVA=;
        b=pPD/sBPWrxLVysfk2Ps6tNucGWwJlCOr6XR//BG7RR8oyJv9v2k0wFNw+aXtAtsXYm
         luzVZfhEqo8WA7WT/fSQnZtLwComZEEyj8mBmG+fymQinBJIgbaFF7evSjaTfz2+9Jol
         2kUHUh75XX13bm33it4tEGzQXVUJxh83BJ/xYgTjF4zu0Ddf23BiggfphU3EaRAJctJM
         Bh+an0KVkI7Z0NnC+O2OUljKfZ26Iq8iDoRE6D8JEdsKtNDEeVU2Mh0cLcsxyhaZW5SH
         2HmMkqHzIIN65y/5FRFy5MVWQsGTiAc5O+XD9DHQPA+sFP7xWlzl0Jkw0UevTMw/Mxm0
         fX9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=77kBMlKTAenEQAkiXPo05Wm16zYsJQ8LVBsU59Q9oVA=;
        b=QLsQDSj2nKaVBs+6BkA5Aj9HsgaDNcJVvGHN29G0azM6UHrDrk1f88OK2ClYvpXTyT
         f1HFfo/n4WqoGOgSL7b0f+LtJVFvz0OZhCeV8yl+8OgmND0jbQqEzyMQrAOCRQHEiaEm
         SuQjcSQ0rTrayubPi+buHkP/5MJRiZ56duKs0CGXyc+k6VYntcfzUywqd0PGKt9Xza/A
         phmwbqLLBaZ8aam4Ri6gCGCMpsGBvMAbBJYd4YrXx//gMPb7+OIniJ7MVJGJcYkAdfQW
         pJlwW74Q4UssFoMLCKuwTeELyifgySumrRu7ed7kKdnkb0/h6iXoj+j1TQTxcx54RVvl
         ygVg==
X-Gm-Message-State: APjAAAXPmBYKRbuOmoCmA+t9Wfqk038Huq+sEq9pm9MqiPzD+6jUNCJ2
        /E6lE0AO60yrZu+2FHd7OfE=
X-Google-Smtp-Source: APXvYqwltHE9iEWxKnbbh87k8UY3j+nd3lsQOuNtcbriLQ+0SNoXQVr2iH8MQnAoJMCtZAHoz6/ZDg==
X-Received: by 2002:adf:fd08:: with SMTP id e8mr122286409wrr.147.1564383414116;
        Sun, 28 Jul 2019 23:56:54 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id e7sm54869909wmd.0.2019.07.28.23.56.53
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 28 Jul 2019 23:56:53 -0700 (PDT)
Date:   Mon, 29 Jul 2019 08:56:53 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: Fix a possible null-pointer dereference in
 dequeue_func()
Message-ID: <20190729065653.GA2211@nanopsycho>
References: <20190729022157.18090-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729022157.18090-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 29, 2019 at 04:21:57AM CEST, baijiaju1990@gmail.com wrote:
>In dequeue_func(), there is an if statement on line 74 to check whether
>skb is NULL:
>    if (skb)
>
>When skb is NULL, it is used on line 77:
>    prefetch(&skb->end);
>
>Thus, a possible null-pointer dereference may occur.
>
>To fix this bug, skb->end is used when skb is not NULL.
>
>This bug is found by a static analysis tool STCheck written by us.
>
>Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Fixes tag, please?


>---
> net/sched/sch_codel.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
>index 25ef172c23df..30169b3adbbb 100644
>--- a/net/sched/sch_codel.c
>+++ b/net/sched/sch_codel.c
>@@ -71,10 +71,10 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
> 	struct Qdisc *sch = ctx;
> 	struct sk_buff *skb = __qdisc_dequeue_head(&sch->q);
> 
>-	if (skb)
>+	if (skb) {
> 		sch->qstats.backlog -= qdisc_pkt_len(skb);
>-
>-	prefetch(&skb->end); /* we'll need skb_shinfo() */
>+		prefetch(&skb->end); /* we'll need skb_shinfo() */
>+	}
> 	return skb;
> }
> 
>-- 
>2.17.0
>
