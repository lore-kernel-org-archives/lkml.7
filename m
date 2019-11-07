Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2F4C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED58218AE
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 20:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Db4tHNgn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfKGUsM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 15:48:12 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46035 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfKGUsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 15:48:11 -0500
Received: by mail-pl1-f196.google.com with SMTP id y24so2392094plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2019 12:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=JwhsjFXL+RY1sUbjvE8fwB+ZL/JKNehRxoaYrePu9kQ=;
        b=Db4tHNgnwbiKUQQBjTMR0BNEUAL8a5ipvo2TbmNtUEJbzAu8RlKa6uhhd5aFftsQ0T
         F4kd7FDyZGOMI1Jn2Ady7sMtkff3mQU5vj21YIKxUIDWe3mzZA+e2X3wS6qaGGdo2h6j
         CROaJhOezoBE5fyBtHxs0z4+m6jtUiaouXO/grqPU5yi+nh4h0QkiXgnwZyOQo7Wu/NY
         PtN954C/mOUI18lQP053JcZVOAXNb6cMnHnnYCvkt/1qKusp5e3xS3DJ7Z3zaUHYNncM
         JA0jxdur16ge7pCLtb7FNHEzIT9TyQAV4U/oSnXGprSYOEtFh4UYNhj/re2T87B6uuwZ
         CFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=JwhsjFXL+RY1sUbjvE8fwB+ZL/JKNehRxoaYrePu9kQ=;
        b=T4tsNYyx7ItlNL9l9kAKeCzodVnMROMYqhrmllyMWTxP/k4am6I/IeIujCeoVAtv/Z
         2ayQTL55h7ETZbt048Mhcxg/+b72udOOSbsCwyB8AfMQNGvRRBMLjS/R9Rm3qzCXJ3Y7
         S6nXw+TlculHBF1t0WJkDn/jMJkuJfbIxXIrPzpPCuwUSYUBqcxRX7psVODHZuKdSSTl
         gUD9TiTwedAslHmKsErt16ErnGk/CCHLZmAeqpTaPw45Boq3cBZxJm11YU+EJlhnZCkB
         YHBKFTaO5LyAq7h+UrDqn4FvoZaBqDhVZYPHQTNqPrFLFXx4aQH2/3Fy+RP11N4RANAE
         GPBg==
X-Gm-Message-State: APjAAAUceZ+tYHildblFvt9K5oE8OOXEuexRtFKBAQ6ShgH+ErpbbVkA
        hftdGZSSTRqquieuY1EAkstyjQ==
X-Google-Smtp-Source: APXvYqykdvTfDCqsSkkatuk30iFz3oWiBFqclYZEG2RhpWyX/ON1ggWyaHVSkpa526VjHZaUu3CQ4w==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr5955147plq.26.1573159690626;
        Thu, 07 Nov 2019 12:48:10 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h9sm4965652pjh.8.2019.11.07.12.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 12:48:09 -0800 (PST)
Date:   Thu, 7 Nov 2019 12:48:09 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Yunfeng Ye <yeyunfeng@huawei.com>
cc:     akpm@linux-foundation.org, jgg@ziepe.ca, mhocko@suse.com,
        jglisse@redhat.com, minchan@kernel.org, peterz@infradead.org,
        jack@suse.cz, rppt@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "hushiyuan@huawei.com" <hushiyuan@huawei.com>,
        "linfeilong@huawei.com" <linfeilong@huawei.com>
Subject: Re: [PATCH] mm/madvise: replace with page_size() in
 madvise_inject_error()
In-Reply-To: <7296c9ca-f8a7-f31b-d090-cc6bf5ee1df4@huawei.com>
Message-ID: <alpine.DEB.2.21.1911071247480.88963@chino.kir.corp.google.com>
References: <29dce60c-38d6-0220-f292-e298f0c78c4d@huawei.com> <alpine.DEB.2.21.1911061327550.155572@chino.kir.corp.google.com> <7296c9ca-f8a7-f31b-d090-cc6bf5ee1df4@huawei.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2019, Yunfeng Ye wrote:

> >> The function page_size() is supported after the commit a50b854e073c
> >> ("mm: introduce page_size()").
> >>
> >> Replace with page_size() in madvise_inject_error() for readability.
> >>
> >> Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
> >> ---
> >>  mm/madvise.c | 8 ++++----
> >>  1 file changed, 4 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/mm/madvise.c b/mm/madvise.c
> >> index 2be9f3fdb05e..38c4e7fcf850 100644
> >> --- a/mm/madvise.c
> >> +++ b/mm/madvise.c
> >> @@ -856,13 +856,13 @@ static int madvise_inject_error(int behavior,
> >>  {
> >>  	struct page *page;
> >>  	struct zone *zone;
> >> -	unsigned int order;
> >> +	unsigned int size;
> > 
> > Should be unsinged long.
> > 
> ok, thanks. Andrew has already help me modify the patch and add to -mm tree.
> 

Good deal, in that case:

Acked-by: David Rientjes <rientjes@google.com>
