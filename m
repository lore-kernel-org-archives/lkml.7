Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C44C4CED1
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 951532084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 17:20:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="DLw0gUoD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbfJDRUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 13:20:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40184 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDRUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 13:20:41 -0400
Received: by mail-pf1-f194.google.com with SMTP id x127so4274425pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CFABRMz1edgqMZrdkcJ5grQHuov7IQWx4KDvNWdkveo=;
        b=DLw0gUoDjdWvEBBUV5C8SsFx2SjR7VbPltgBwhUofYZDeym6mWGlcy4pzCTH99BHOv
         kKM6IrnZhzr87BifF8O22/Xjqa10WR/Uyac9x7SQG4iz4uVReP6nlGz+d6b0T+xjQvPL
         Z11qFIqBDxRwx+WWICguoP64fiLb15pZr6PQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CFABRMz1edgqMZrdkcJ5grQHuov7IQWx4KDvNWdkveo=;
        b=Lrr22iXboE/UoWUeKs+awtJbnmuTStUK+Lgu8vUFqag83PRelYB1KfanL5az4zewSM
         tfJsUOYbVQ0ubfYq94txvvbaTelcrz19sNXWi+5aegIHB3xKbkWVNM/sgcIfnS6XUo04
         8ANKOO93uYZG5ueZWaTemeCw2rHVaAU0gF52C3Tkagy8xD60d94+gNfCW9qqUarh1OAq
         29kBaOYeMjepi8Dk6tmkC9+nBp2ocFdiyYUE4qfsrDvyLOLvYWcdhhb2B7c+IkawJ2GM
         UUVlRRxx0MHJXbsgwfhamQzn6KPhkWgBv5azz2czSTWBu7PqiE08ASzaqOQuykxu0/k9
         lDzg==
X-Gm-Message-State: APjAAAWyxROUrW7mAkWJte+HsdoYanPvCye76ZTrjciiPVOYvS5wEN3k
        bbP9WKsq7DjV5qcY1QgfO9G/8A==
X-Google-Smtp-Source: APXvYqwFCmRx7gnHvoTWyC7aMhsw0IcKe/Dj+u7BUgTEzw2ALpPH5rZ3jH7F7dZ7Yuhc2QYnthap5Q==
X-Received: by 2002:a62:a509:: with SMTP id v9mr17803603pfm.180.1570209640112;
        Fri, 04 Oct 2019 10:20:40 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id j22sm8832861pgg.16.2019.10.04.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 10:20:39 -0700 (PDT)
Date:   Fri, 4 Oct 2019 13:20:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        kernel-team@lge.com, Byungchul Park <byungchul.park@lge.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        max.byungchul.park@gmail.com,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Rao Shoaib <rao.shoaib@oracle.com>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v4 1/2] rcu/tree: Add basic support for kfree_rcu()
 batching
Message-ID: <20191004172038.GG253167@google.com>
References: <20190814160411.58591-1-joel@joelfernandes.org>
 <20190918095811.GA25821@pc636>
 <20190930201623.GA134859@google.com>
 <20191001112702.GA22112@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001112702.GA22112@pc636>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 01, 2019 at 01:27:02PM +0200, Uladzislau Rezki wrote:
[snip] 
> > > I have just a small question related to workloads and performance evaluation.
> > > Are you aware of any specific workloads which benefit from it for example
> > > mobile area, etc? I am asking because i think about backporting of it and
> > > reuse it on our kernel. 
> > 
> > I am not aware of a mobile usecase that benefits but there are server
> > workloads that make system more stable in the face of a kfree_rcu() flood.
> > 
> OK, i got it. I wanted to test it finding out how it could effect mobile
> workloads.
> 
> >
> > For the KVA allocator work, I see it is quite similar to the way binder
> > allocates blocks. See function: binder_alloc_new_buf_locked(). Is there are
> > any chance to reuse any code? For one thing, binder also has an rbtree for
> > allocated blocks for fast lookup of allocated blocks. Does the KVA allocator
> > not have the need for that?
> >
> Well, there is a difference. Actually the free blocks are not sorted by
> the its size like in binder layer, if understand the code correctly.
> 
> Instead, i keep them(free blocks) sorted(by start address) in ascending
> order + maintain the augment value(biggest free size in left or right sub-tree)
> for each node, that allows to navigate toward the lowest address and the block
> that definitely suits. So as a result our allocations become sequential
> what is important.

Right, I realized this after sending the email that binder and kva sort
differently though they both try to use free sizes during the allocation.

Would you have any papers, which survey various rb-tree based allocator
algorithms and their tradeoffs? I am interested in studying these more
especially in relation to the binder driver. Would also be nice to make
contributions to papers surveying both these allocators to describe the state
of the art.

thanks,

 - Joel


> >
> > And, nice LPC presentation! I was there ;)
> > 
> Thanks :)
> 
> --
> Vlad Rezki
