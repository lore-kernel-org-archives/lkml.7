Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8570FC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 613F722CD8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 13:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388633AbfGZNt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 09:49:58 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41373 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388813AbfGZNtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 09:49:49 -0400
Received: by mail-qt1-f196.google.com with SMTP id d17so52532561qtj.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 06:49:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Arc7jiA/gNfqVVW7QNfgaMfkpV6mHYMiv3nUsNQh21Q=;
        b=C1TOqzmGmMDDx5+78B9o2F0tV4pBewaMghEvZOibsG9uBC0iJjkWS10rScwGb8MQXu
         E8bEdIgx7GxELdWy39CftqcUVHWOHAJBWh8FWM+gAd6lE9NUWhuKbjU+ZwO2L/+tr0l0
         CsDOeGuvxwMReKnskimxKVhc7XdbQ6CEiU085ZNuD2nTpGtlJR0J0f0bmrNUKj6GarUc
         JnHNRBh8b1FGthdRayHxiUkTozJRSQVRVKM2sdpj9qXR7min1Vew+27oUKVbjoPjPtVu
         R8OXeNZ8WfF893RbAGWvvoOakIfjii4ya7icgVJp7UKgmLPdaRtXl9QCB5Ix6woCkJOo
         mmeA==
X-Gm-Message-State: APjAAAWyA48PT8RjQuWfni+DeYhMXEk15FBnGxRY2AtwnVrawZIh3pza
        VGnWqJVTdAwAE3VEgB4xu2TkcQ==
X-Google-Smtp-Source: APXvYqwJQHLCc1j1lFY5aAZTn5kwYloU8xFZNwjN11XBjJ1dY1OXNTBegRGc33x5aUh2wiZJ7uMG3w==
X-Received: by 2002:a0c:9233:: with SMTP id a48mr67054287qva.66.1564148988892;
        Fri, 26 Jul 2019 06:49:48 -0700 (PDT)
Received: from redhat.com ([212.92.104.165])
        by smtp.gmail.com with ESMTPSA id w19sm20959381qkj.66.2019.07.26.06.49.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 06:49:48 -0700 (PDT)
Date:   Fri, 26 Jul 2019 09:49:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     syzbot <syzbot+e58112d71f77113ddb7b@syzkaller.appspotmail.com>,
        aarcange@redhat.com, akpm@linux-foundation.org,
        christian@brauner.io, davem@davemloft.net, ebiederm@xmission.com,
        elena.reshetova@intel.com, guro@fb.com, hch@infradead.org,
        james.bottomley@hansenpartnership.com, jglisse@redhat.com,
        keescook@chromium.org, ldv@altlinux.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        luto@amacapital.net, mhocko@suse.com, mingo@kernel.org,
        namit@vmware.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk,
        wad@chromium.org
Subject: Re: WARNING in __mmdrop
Message-ID: <20190726094756-mutt-send-email-mst@kernel.org>
References: <55e8930c-2695-365f-a07b-3ad169654d28@redhat.com>
 <20190725042651-mutt-send-email-mst@kernel.org>
 <84bb2e31-0606-adff-cf2a-e1878225a847@redhat.com>
 <20190725092332-mutt-send-email-mst@kernel.org>
 <11802a8a-ce41-f427-63d5-b6a4cf96bb3f@redhat.com>
 <20190726074644-mutt-send-email-mst@kernel.org>
 <5cc94f15-b229-a290-55f3-8295266edb2b@redhat.com>
 <20190726082837-mutt-send-email-mst@kernel.org>
 <ada10dc9-6cab-e189-5289-6f9d3ff8fed2@redhat.com>
 <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aaefa93e-a0de-1c55-feb0-509c87aae1f3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 09:36:18PM +0800, Jason Wang wrote:
> 
> On 2019/7/26 下午8:53, Jason Wang wrote:
> > 
> > On 2019/7/26 下午8:38, Michael S. Tsirkin wrote:
> > > On Fri, Jul 26, 2019 at 08:00:58PM +0800, Jason Wang wrote:
> > > > On 2019/7/26 下午7:49, Michael S. Tsirkin wrote:
> > > > > On Thu, Jul 25, 2019 at 10:25:25PM +0800, Jason Wang wrote:
> > > > > > On 2019/7/25 下午9:26, Michael S. Tsirkin wrote:
> > > > > > > > Exactly, and that's the reason actually I use
> > > > > > > > synchronize_rcu() there.
> > > > > > > > 
> > > > > > > > So the concern is still the possible synchronize_expedited()?
> > > > > > > I think synchronize_srcu_expedited.
> > > > > > > 
> > > > > > > synchronize_expedited sends lots of IPI and is bad for realtime VMs.
> > > > > > > 
> > > > > > > > Can I do this
> > > > > > > > on through another series on top of the incoming V2?
> > > > > > > > 
> > > > > > > > Thanks
> > > > > > > > 
> > > > > > > The question is this: is this still a gain if we switch to the
> > > > > > > more expensive srcu? If yes then we can keep the feature on,
> > > > > > I think we only care about the cost on srcu_read_lock()
> > > > > > which looks pretty
> > > > > > tiny form my point of view. Which is basically a
> > > > > > READ_ONCE() + WRITE_ONCE().
> > > > > > 
> > > > > > Of course I can benchmark to see the difference.
> > > > > > 
> > > > > > 
> > > > > > > if not we'll put it off until next release and think
> > > > > > > of better solutions. rcu->srcu is just a find and replace,
> > > > > > > don't see why we need to defer that. can be a separate patch
> > > > > > > for sure, but we need to know how well it works.
> > > > > > I think I get here, let me try to do that in V2 and
> > > > > > let's see the numbers.
> > > > > > 
> > > > > > Thanks
> > > > 
> > > > It looks to me for tree rcu, its srcu_read_lock() have a mb()
> > > > which is too
> > > > expensive for us.
> > > I will try to ponder using vq lock in some way.
> > > Maybe with trylock somehow ...
> > 
> > 
> > Ok, let me retry if necessary (but I do remember I end up with deadlocks
> > last try).
> 
> 
> Ok, I play a little with this. And it works so far. Will do more testing
> tomorrow.
> 
> One reason could be I switch to use get_user_pages_fast() to
> __get_user_pages_fast() which doesn't need mmap_sem.
> 
> Thanks

OK that sounds good. If we also set a flag to make
vhost_exceeds_weight exit, then I think it will be all good.

-- 
MST
