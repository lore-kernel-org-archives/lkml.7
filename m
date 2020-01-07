Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD28DC32771
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D520207FF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 02:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTFeI61t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgAGCHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 21:07:31 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42033 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGCHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 21:07:31 -0500
Received: by mail-pl1-f196.google.com with SMTP id p9so22558459plk.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 18:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=FcqVbuH4BEZl+ciRs0e0B8iPKj0+hshWElohx4nDlP8=;
        b=sTFeI61tYPfuAIi6zuNSHzccw82y+IFJQZN/FOERtaSSqtpiXv2rOpO1dyPm4suK9d
         ftLYzVvf4icX0o3N0u/z5HFcxiat1L2XRuge1iX7lbBY2Md2XAs+Vxt04yEGQu7uv2l8
         B9lrwHI36DRK0JUm1QxdEBLBDZl4WkM/Ai4x6+Hqh019u9drIfYC7rQPYih72eXUlL7V
         KOFBxa2toSREPK7LfZYoSs+/8fgvnWy7jTYEu1twlyKcjKroHFNdQjabRMii/TID8Eev
         FBntvssn6jwCDIMA8zHiVazWzc611aei+IvMD9PvhSF9GrFnfsLNykTivOxhqLapB3+P
         +P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=FcqVbuH4BEZl+ciRs0e0B8iPKj0+hshWElohx4nDlP8=;
        b=o1ynMgGqiK8MG8cSCqLZeIt/Hb3PjSPvInkClEQ+TpumYpK7BdO8flPC8LZpvvb6pT
         zgkfZaRQig2AtGfRCRrg2b0D1+sMUWqkudTHc6MywsrrzAjMUr977GkCowcZ0ue9q4LP
         UaZ5cMJjvF7W2Bt9A0jher1iPs6DXIv0Fxpw42llJFA4kMjsryU3pzuLr1Qe4KWQvl/x
         fw/SpBUQCRfuT/4gJHKjZeIP8qFFRprRNTfp4xi9TcOZ/TrVcT7iVclqovRUPjUyMWts
         HE4LsGZ54K+oW7XsNEIFQ6TV5cLV6eqa7SKRdD/gq2Elpn789aUsO1/1SwTcShNA+Ovu
         hjKw==
X-Gm-Message-State: APjAAAVio9Y40a8HGGq7KWTEMYUzYiceY3GPhepYaqeeS8p6jGOzb49s
        QU97aOl+zly5nE6sjORDR6hQDQ==
X-Google-Smtp-Source: APXvYqxSmH3jtb3yGf6lQzuN/p1hBfhYZSwhFc2W7ST0vDRyyIEI7Z+ED8qhCWhzRta6FDHArc60zA==
X-Received: by 2002:a17:90a:660b:: with SMTP id l11mr45934270pjj.47.1578362850725;
        Mon, 06 Jan 2020 18:07:30 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i3sm78670353pfg.94.2020.01.06.18.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 18:07:29 -0800 (PST)
Date:   Mon, 6 Jan 2020 18:07:29 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, vdavydov.dev@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        cgroups@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [RFC PATCH] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <20200107012624.GB15341@richard>
Message-ID: <alpine.DEB.2.21.2001061803200.55132@chino.kir.corp.google.com>
References: <20200103143407.1089-1-richardw.yang@linux.intel.com> <CAKgT0Uf+EP8yGf93=R3XK0Y=0To0KQDys0O1BkG-Odej3Rwj5A@mail.gmail.com> <20200107012624.GB15341@richard>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jan 2020, Wei Yang wrote:

> >One thing you might want to do is pull the "if (compound)" check out
> >and place it outside of the spinlock check. It would then simplify
> >this signficantly so it is something like
> >if (compound) {
> >  spin_lock();
> >  list = page_deferred_list(page);
> >  if (!list_empty(list)) {
> >    list_del_init(list);
> >    from->..split_queue_len--;
> >  }
> >  spin_unlock();
> >}
> >
> >Same for the block below. I would pull the check for compound outside
> >of the spinlock call since it is a value that shouldn't change and
> >would eliminate an unnecessary lock in the non-compound case.
> 
> This is reasonable, if no objection from others, I would change this in v2.

Looks fine to me; I don't see it as a necessary improvement but there's 
also no reason to object to it.  It's definitely a patch that is needed, 
however, for the simple reason that with the existing code we can 
manipulate the deferred split queue incorrectly so either way works for 
me.  Feel free to keep my acked-by.
