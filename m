Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA45C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E185020644
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 08:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xQbnXKF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbfG2IS6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 04:18:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52248 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG2IS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 04:18:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id s3so52930545wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vHj9NXahSs6iR8Pg+ItC8iS4CBlK8AvLVaxPXNIpuUE=;
        b=xQbnXKF8Y7E+t8j+NkUBwqn2H5QphW/cVaobSbrgpsuHm+4EWO6RX6IzN8M9D2M0RQ
         vYwnuc6bMkTf84yGvMP1JgFPoid5mCkowMdZ0MyW+RKWpJK+zwB5LDHuqYVYyanjhzeG
         3I6WqlRd/fPf8gz1MbhF0/UTB8oYe5Sl/8a2HSb7zJCPnHHzaQD9dQ6Z4oTAh5T6dO9+
         TlIom4yR5AXhYb0+X3LgWDYmbq6JXjeHA7Wh4WugIU+K4wQA2ZnvlBHKa9Eb1K/d1Xn6
         eOl5U8Bia8RTUj8iYkhItoD7RiAgYAJF8pT45eS4sWxouG63GTqtIRrWxJswCz0h91o0
         R5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vHj9NXahSs6iR8Pg+ItC8iS4CBlK8AvLVaxPXNIpuUE=;
        b=BiT8wFhovQHMjwzIgMeerM6h/jn9HRMN766wlQY2IesmZsht4Q8Heun0L6EONJf3Gu
         8Ynu4liz7FTq1XOP2vZuus8DuNT/0KfQLkZOIidoIu8AepVA4cJKz36J1JW660ygvf1Q
         UQmrXtW9rqaCngeHh4DY78uAwl1lgqsDG3w/0YYsPNF1TtgaiZge3ans4gxSxnS4l3qN
         yFT6J0MRrzqNWcWmlU6cyfmhuDmY3/b91AGj5fEw4cW4GzEG4/0sdZF1bFilA2AlSaOg
         1faLLDqTK8VhoCFH5miGL2NNPurz12nveKuCuD8S8pjlCAe1sy71omRf3B1Qt7px/6oE
         yNaA==
X-Gm-Message-State: APjAAAWhDUDsnc2OAdy43qfDnXSMez69ogMcYJk/KKRvYAGa44Pt8rgp
        1IdcBiY5dHZX1MavqUGpBac=
X-Google-Smtp-Source: APXvYqwmY7Gie5+Musllq20iA/vpGOeb+HpfY7d6X5o963I1/ONCZZ3wYid5aigxUN7L3tNQhUWdSA==
X-Received: by 2002:a1c:1bd7:: with SMTP id b206mr95120334wmb.85.1564388336079;
        Mon, 29 Jul 2019 01:18:56 -0700 (PDT)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id f12sm66058989wrg.5.2019.07.29.01.18.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 29 Jul 2019 01:18:55 -0700 (PDT)
Date:   Mon, 29 Jul 2019 10:18:54 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: sched: Fix a possible null-pointer dereference
 in dequeue_func()
Message-ID: <20190729081854.GC2211@nanopsycho>
References: <20190729080018.28678-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729080018.28678-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Jul 29, 2019 at 10:00:18AM CEST, baijiaju1990@gmail.com wrote:
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
>Fixes: 79bdc4c862af ("codel: generalize the implementation")

Looks like this is something being there since the beginning:
commit 76e3cc126bb223013a6b9a0e2a51238d1ef2e409
Author: Eric Dumazet <edumazet@google.com>
Date:   Thu May 10 07:51:25 2012 +0000

    codel: Controlled Delay AQM


Please adjust "Fixes:".

The fix itself looks fine to me.
Reviewed-by: Jiri Pirko <jiri@mellanox.com>



>Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
>---
>v2:
>* Add a fix tag.
>  Thank Jiri Pirko for helpful advice.
>
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
