Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37235C49ED7
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D06820692
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 00:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbAiEctD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390758AbfINAD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 20:03:29 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46520 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbfINAD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 20:03:28 -0400
Received: by mail-ed1-f68.google.com with SMTP id i8so28368521edn.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 17:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t8cGpHubjB6DkvBW1Qn9d5gYfqgedzw/xNrPjvFY/Nw=;
        b=gbAiEctD/TNFuOmjaeF2iGU//aIQDkU6BSjDfxc02v/fm2ehA5B8CbS4asenQun9RX
         /ozWunb+vjjtTL1srFBAGUp+m5abZ0wT/iuSAXN9NnQIcw0TqNChAepSHoTF7wkF1Aae
         YiaB37IvY9Js8F2ISO9pT052SCwmIQKuoOR7gma3wtCuLjNHgLv9D7YMF/7WwkE7L5lb
         8qtJGbdBQ4vTzmZkkri9qvHZsIJgUBzv1GWZtQ2VuM5Z29S3XBSI1loZysTzjxxoQoT0
         dQw72nFnOFggxX0BGaQHtk9LnFtcTGh0nup+eaDMWiac4rks5dZ6M3CXExkgKMYyaJq9
         ZRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t8cGpHubjB6DkvBW1Qn9d5gYfqgedzw/xNrPjvFY/Nw=;
        b=mMURMEUMxZsXopOUkH9afhduNVr6Qt7hnce4CrzMm5+pQy9TLdEkl0x2/Ci9e+AVZ1
         wEhRiX0FAtJmRYLi0VlJcI7XOw0RNAtRxIi7STYPz+y25BZDw88MCkzQacYGoqCMC2wv
         JOhgX9JkpktDTlsnHR1Cgd7Vb2ptO9KcvDaro0KGkaQE8TrK1X3XLexvUS6buAyR4gB1
         wzTfBsIAbDlgFO5BsnqJQMLbDABglz4kmLhlt7vg3zWT1qB5708vH+fwJHTHEcqakh0x
         96dBPHzuHoG6j9fRbBHYiWixodtHN1xzlb28bEX8Q1mvmJc8oKDipN/G1FCCta9NNi7J
         hfxg==
X-Gm-Message-State: APjAAAXCywq/EeLpVjYgNpWZYK1oKu2T+oqdey4XTXE6++sjuzsGfjd0
        LM7dUFvA5pyyuMrzvZtokoc=
X-Google-Smtp-Source: APXvYqzNgIBraeg58W85oixzqOodw+0h+nOJqf7BvwSamF7jVThsLD9U0Rhc2kikkmamuckBAdl6hQ==
X-Received: by 2002:a17:906:235a:: with SMTP id m26mr42419198eja.297.1568419407776;
        Fri, 13 Sep 2019 17:03:27 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id q10sm5563765edw.26.2019.09.13.17.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Sep 2019 17:03:27 -0700 (PDT)
Date:   Sat, 14 Sep 2019 00:03:26 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, will@kernel.org, peterz@infradead.org
Subject: Re: [PATCH] mm: remove redundant assignment of entry
Message-ID: <20190914000326.h4ruqmyvo3yisf52@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20190708082740.21111-1-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708082740.21111-1-richardw.yang@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 08, 2019 at 04:27:40PM +0800, Wei Yang wrote:
>Since ptent will not be changed after previous assignment of entry, it
>is not necessary to do the assignment again.
>

Sounds this one is lost in the time line :-)

>Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>---
> mm/memory.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/mm/memory.c b/mm/memory.c
>index ddf20bd0c317..d108bb979a08 100644
>--- a/mm/memory.c
>+++ b/mm/memory.c
>@@ -1127,7 +1127,6 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> 		if (unlikely(details))
> 			continue;
> 
>-		entry = pte_to_swp_entry(ptent);
> 		if (!non_swap_entry(entry))
> 			rss[MM_SWAPENTS]--;
> 		else if (is_migration_entry(entry)) {
>-- 
>2.17.1

-- 
Wei Yang
Help you, Help me
