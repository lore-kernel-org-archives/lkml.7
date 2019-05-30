Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5E8C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D1B4243B0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559177116;
	bh=Q/jZBlUt+/OQ2kjUr3oKQoJFOrN5c234c4Y06NnRpmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qlmKS3aSre3egWEAI/CMTLVfhca0tT9nYjdvUbjLMWobMTw0bUVwRYd5iZLtkr+kr
	 /ETIZEwpcgHr6lP9qfaaaJrlSQutIKEXmJ8Isaj8YeLtpFp6ynwj7BpHZeEBlOStbJ
	 JYxWeh6ZRK8Mwdym6lYvQd+tp5kB3WCqgKHcvzH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbfE3ApP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:45:15 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44384 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3ApP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:45:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2so886093pgp.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3pQf3oE9pe7ut38GOYF86CTbPhCE2HZHC16fikq5yN4=;
        b=b0rhC0GnaksDvk0NWeuH1qv7fPieZq9dXKXYRobup/o0JNscbNlpDJOYzfHN03PATj
         OHKJ0xZuwZZH2F+3URlVPUKBZOH+aTinvwRWog8zP7uTflJ6QdFQVbpKZHqJfi1IFeu8
         khW1oqaMCyj+NK+HU/0/smU4pi1IZ9amJI+fxmBOHfWKxlazKHZ5PHpryv2cISCV2/V+
         zyO0l1aRDazryxC70o7JgzWp7qZksuVAyeUdewD0qiRIoEziuBzQVolw7TXKpLD6KXOs
         ORsa6C3gaQ3krpOaXj9O7Hra3MD77Z6IQCs/0/7PLPI6MquEgy5BPIGmI658rVdhHTv1
         Pplw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3pQf3oE9pe7ut38GOYF86CTbPhCE2HZHC16fikq5yN4=;
        b=o+vlRQFxfKep5aAVP5i613TbCfDJWrtcnALvpzGymCVoLryLZYlRUIYrX2KQY5iZ7S
         6ci+AhIzBSBw2WV3S29vGDkPF1P25IU9j63CSiMT7XWJw33WeX6DE5a4lkJxqZuuSXfJ
         BDDMNKMrrm2GBtM4+wJDgPxRYn/XuYx8m5c7/+Ue9cIcE6JOn8lcdEla8BxwI9SnaZf7
         vX4syM+Rl1Un84v/N9FdrEFZzHpymaeR4Wi/4ffMccKlcgh8E5ROYZQvEFa1kv83rHSN
         INtG3ocK9YQbHGu7idmnOtdn085yzeyjgRfOVO2E8+Gv698OifIhercloLSmQOlORxO7
         xrxQ==
X-Gm-Message-State: APjAAAWAYBnodi7WgMZN5tX4eeM/t9/4kLV0jEbNpZyF/IWq7Ibv/ZZG
        0f9Tp0WT+acmrkQubmHJQ54=
X-Google-Smtp-Source: APXvYqwt7gk7vehNu9cqSQXx8VB/7JE6vGRiMLtFRxLfQ3oXlqzDjKH+/HuhFg127Ccfn86BHVjTDw==
X-Received: by 2002:a63:f509:: with SMTP id w9mr978848pgh.134.1559177114886;
        Wed, 29 May 2019 17:45:14 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id t5sm476354pgh.46.2019.05.29.17.45.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 17:45:13 -0700 (PDT)
Date:   Thu, 30 May 2019 09:45:07 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 3/7] mm: introduce MADV_COLD
Message-ID: <20190530004507.GC229459@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-4-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 10:54:32PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 May 2019 12:52:50 +0900 Minchan Kim wrote:
> > +unsigned long reclaim_pages(struct list_head *page_list)
> > +{
> > +	int nid = -1;
> > +	unsigned long nr_isolated[2] = {0, };
> > +	unsigned long nr_reclaimed = 0;
> > +	LIST_HEAD(node_page_list);
> > +	struct reclaim_stat dummy_stat;
> > +	struct scan_control sc = {
> > +		.gfp_mask = GFP_KERNEL,
> > +		.priority = DEF_PRIORITY,
> > +		.may_writepage = 1,
> > +		.may_unmap = 1,
> > +		.may_swap = 1,
> > +	};
> > +
> > +	while (!list_empty(page_list)) {
> > +		struct page *page;
> > +
> > +		page = lru_to_page(page_list);
> > +		list_del(&page->lru);
> > +
> > +		if (nid == -1) {
> > +			nid = page_to_nid(page);
> > +			INIT_LIST_HEAD(&node_page_list);
> > +			nr_isolated[0] = nr_isolated[1] = 0;
> > +		}
> > +
> > +		if (nid == page_to_nid(page)) {
> > +			list_add(&page->lru, &node_page_list);
> > +			nr_isolated[!!page_is_file_cache(page)] +=
> > +						hpage_nr_pages(page);
> > +			continue;
> > +		}
> > +
> Now, page's node != nid and any page on the node_page_list has
> node == nid. 
> > +		nid = page_to_nid(page);
> 
> After updating nid, we get the node id of the isolated pages lost.
> 
> > +
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_ANON,
> > +					nr_isolated[0]);
> > +		mod_node_page_state(NODE_DATA(nid), NR_ISOLATED_FILE,
> > +					nr_isolated[1]);
> > +		nr_reclaimed += shrink_page_list(&node_page_list,
> > +				NODE_DATA(nid), &sc, TTU_IGNORE_ACCESS,
> 
> And nid no longer matches the node of the pages to be shrunk.
> 
> > +				&dummy_stat, true);
> > +		while (!list_empty(&node_page_list)) {
> > +			struct page *page = lru_to_page(page_list);
> 
> Non-empty node_page_list will never become empty if pages are deleted
> only from the page_list.

Sure.
They were last minute change. I will fix it.

Thanks for the review!
