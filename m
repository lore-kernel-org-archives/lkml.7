Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A339C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1142075E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 14:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtRExl5r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731770AbfCZOwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 10:52:03 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38573 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZOwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 10:52:03 -0400
Received: by mail-lj1-f195.google.com with SMTP id p14so10412577ljg.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 07:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XI8nG9Dzmt5ShimcJLgUrFfOlr1UjZ/4vfezN58z7mI=;
        b=mtRExl5rQvp5nbXGCI/zHz/hSZxZNfiZyNqO8FojEpmtvcCqNgzb3mRjnpamZQpWW1
         K+OA4pLUbXctnOw0xvAiKD02hDCUZfrUw71JcmXKz/mqRJCXsvCpSj/+3/KGT3+5+8eh
         r2sLoGsjsor9eNEnoOIzMKNlos+7JfVp57yi62KnmvFjoB/uNd9J/1yl7Q3y1rjPHEgO
         TuK1VMYuXbA09G7aFW3F0IZPrMpQru4ZFRCakwwB6slytwAsXVG9WwFVEVp8Y9F2Gb0k
         Yzf0P9fLan8AXDY5nSAb11qnf+GkkzITTpGXt+nGctYowVFX3P3Bkeq9oD3wYv3qymgD
         7Uow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XI8nG9Dzmt5ShimcJLgUrFfOlr1UjZ/4vfezN58z7mI=;
        b=grDH+DgAJSrmMNu7JcLarcrykbcsqh5AKoXy+D2KDn267QRpvjApQSBRoxi3Yupqmj
         hcRrP8jd0aEohRoZVHoIhaYE4FXWasVjup97xhqybTsz90yxZGmyESJhaLL+0Ev+Zh7S
         3WTk0PdvnPNesNsXZ7i8l4ORBc/SEMGS5jrfXlL1K7Z8jKHZyKxnrL8VS/6anP+C2rnI
         2zFy5KhYu9m/K8WtdEyS7MsJrlaktFQBhNX/5qP0FkFPM2V4EnXaNZqCQr+gdAunmOHK
         endqlcSWuZJF00qQZY4045XHjbwAHgqARTJ6ZKu17jvRG/F2Ynz65EQ9UkXwdE9HaP+Y
         xamA==
X-Gm-Message-State: APjAAAUzLpldAqbfV6kWkbvSvt50m5c/n2rVPcBi+xW4zng7Lj7V6GXN
        mwHhL2n/YLD3TYiVsvCqh5Y=
X-Google-Smtp-Source: APXvYqzTtQP+oFFD8jGFvpEJTrQjS1fwAFTra0tU4Xfa6gY3j2lgi5Z8Wwn4YaJfUT5HfAbn7DrrrQ==
X-Received: by 2002:a2e:9655:: with SMTP id z21mr16910027ljh.60.1553611921190;
        Tue, 26 Mar 2019 07:52:01 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id y1sm4118474ljj.13.2019.03.26.07.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 07:52:00 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 26 Mar 2019 15:51:53 +0100
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [RFC PATCH v2 1/1] mm/vmap: keep track of free blocks for vmap
 allocation
Message-ID: <20190326145153.r7y3llwtvqsg4r2s@pc636>
References: <20190321190327.11813-1-urezki@gmail.com>
 <20190321190327.11813-2-urezki@gmail.com>
 <20190322215413.GA15943@tower.DHCP.thefacebook.com>
 <20190325172010.q343626klaozjtg4@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325172010.q343626klaozjtg4@pc636>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Roman.

> > 
> > So, does it mean that this function always returns two following elements?
> > Can't it return a single element using the return statement instead?
> > The second one can be calculated as ->next?
> > 
> Yes, they follow each other and if you return "prev" for example you can easily
> refer to next. But you will need to access "next" anyway. I would rather keep
> implementation, because it strictly clear what it return when you look at this
> function.
> 
> But if there are some objections and we can simplify, let's discuss :)
> 
> > > +		}
> > > +	} else {
> > > +		/*
> > > +		 * The red-black tree where we try to find VA neighbors
> > > +		 * before merging or inserting is empty, i.e. it means
> > > +		 * there is no free vmap space. Normally it does not
> > > +		 * happen but we handle this case anyway.
> > > +		 */
> > > +		*prev = *next = &free_vmap_area_list;
> > 
> > And for example, return NULL in this case.
> > 
> Then we will need to check in the __merge_or_add_vmap_area() that
> next/prev are not NULL and not head. But i do not like current implementation
> as well, since it is hardcoded to specific list head.
> 
Like you said, it is more clever to return only one element, for example next.
After that just simply access to the previous one. If nothing is found return
NULL.

static inline struct list_head *
__get_va_next_sibling(struct rb_node *parent, struct rb_node **link)
{
	struct list_head *list;

	if (likely(parent)) {
		list = &rb_entry(parent, struct vmap_area, rb_node)->list;
		return (&parent->rb_right == link ? list->next:list);
	}

	/*
	 * The red-black tree where we try to find VA neighbors
	 * before merging or inserting is empty, i.e. it means
	 * there is no free vmap space. Normally it does not
	 * happen but we handle this case anyway.
	 */
	return NULL;
}
...
static inline void
__merge_or_add_vmap_area(struct vmap_area *va,
	struct rb_root *root, struct list_head *head)
{
...
	/*
	 * Get next node of VA to check if merging can be done.
	 */
	next = __get_va_next_sibling(parent, link);
	if (unlikely(next == NULL))
		goto insert;
...
}

Agree with your point and comment.

Thanks!

--
Vlad Rezki
