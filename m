Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DACB9C3A5A6
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AEF23407
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 14:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="BjTJ1X09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfH1ODa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 10:03:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42671 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfH1OD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 10:03:29 -0400
Received: by mail-ed1-f68.google.com with SMTP id m44so139607edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pUd3m4DsM7BTeNbPVwQgbVgdSNN5DvcolcmC2Ql3+nU=;
        b=BjTJ1X09BzCUN38w6rpH9CpwQMRT+Bh48KuewQie9HhUYXT6DSkm+W03BRraBSh7zW
         X9P6xjW3VPZ/HWlF/3qwoZSExSf7KIwYSnoIek+9XVVLncPj+SFnMzg1AkFjJn0dhjMZ
         1w7m4B2khXFKewQQ//IrHe/Le8avKB8tqxDUXSmuQQTYe2dArXOKfv6wVxHtDnCcHfHs
         gyH0CDUfNMGIl08bAGg2GXXS0B/ypqKq/ltifqzEg9pBO+Jd/YBBEJ8Gt/RgpsOyDa60
         zCOsyJvPBmicpA10K5gSiobiNivqqtESKm/OSfL0Brt5qCzczegNQMhKp8X+a1E+dlCr
         Ml0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pUd3m4DsM7BTeNbPVwQgbVgdSNN5DvcolcmC2Ql3+nU=;
        b=UByiI0KkKfN90GVXlB2n+x7hDsk361VJ/d6bHii4pT9MK8+DdF+K3NqeDmkeBGnnfs
         H1Dwmiqe4aDHu1LxVRgn8JBgev2zkPaXj6UYcZgCgRn6w4Iwra8Nbm7sx1DvRKf+bLgt
         fKxK1KWftM/zzrW4rAzjqhS5AkUt6KnQnC9b5l0RvRnnCtcPRXxfwVO68+QC7xDDoJUH
         X665CUncnqh9ku8r32XWUu/+pn9XyOwtYsjtHObSI47NO0GJTZ/ayR2mCWaTD/gzvi3t
         TvSG4+PLlp339A14hWlHonWbyUj7dUs5Z6qN0kQu0OO63OGs8noINnBtHXuIheSAeeDq
         6M0Q==
X-Gm-Message-State: APjAAAUrSKv+LQRbN5AdBdwkhBnadlLPw8LnGapq0HabZdo5rBaY7T31
        mx1mdDO9CWCJCqqqsmsEDfVMJA==
X-Google-Smtp-Source: APXvYqx4F0/oYwYwiSZeMVH8GZbGtmYDTML+qzGZXbX4+VAd0dmbAwrZ4tBT6Q9UELleMKFYpiMQ6Q==
X-Received: by 2002:a17:906:80da:: with SMTP id a26mr3394346ejx.222.1567001007528;
        Wed, 28 Aug 2019 07:03:27 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id y37sm483972edb.42.2019.08.28.07.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 07:03:26 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id CD1651009F2; Wed, 28 Aug 2019 17:03:29 +0300 (+03)
Date:   Wed, 28 Aug 2019 17:03:29 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, hannes@cmpxchg.org,
        rientjes@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH -mm] mm: account deferred split THPs into MemAvailable
Message-ID: <20190828140329.qpcrfzg2hmkccnoq@box>
References: <20190826074035.GD7538@dhcp22.suse.cz>
 <20190826131538.64twqx3yexmhp6nf@box>
 <20190827060139.GM7538@dhcp22.suse.cz>
 <20190827110210.lpe36umisqvvesoa@box>
 <aaaf9742-56f7-44b7-c3db-ad078b7b2220@suse.cz>
 <20190827120923.GB7538@dhcp22.suse.cz>
 <20190827121739.bzbxjloq7bhmroeq@box>
 <20190827125911.boya23eowxhqmopa@box>
 <d76ec546-7ae8-23a3-4631-5c531c1b1f40@linux.alibaba.com>
 <20190828075708.GF7386@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828075708.GF7386@dhcp22.suse.cz>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 09:57:08AM +0200, Michal Hocko wrote:
> On Tue 27-08-19 10:06:20, Yang Shi wrote:
> > 
> > 
> > On 8/27/19 5:59 AM, Kirill A. Shutemov wrote:
> > > On Tue, Aug 27, 2019 at 03:17:39PM +0300, Kirill A. Shutemov wrote:
> > > > On Tue, Aug 27, 2019 at 02:09:23PM +0200, Michal Hocko wrote:
> > > > > On Tue 27-08-19 14:01:56, Vlastimil Babka wrote:
> > > > > > On 8/27/19 1:02 PM, Kirill A. Shutemov wrote:
> > > > > > > On Tue, Aug 27, 2019 at 08:01:39AM +0200, Michal Hocko wrote:
> > > > > > > > On Mon 26-08-19 16:15:38, Kirill A. Shutemov wrote:
> > > > > > > > > Unmapped completely pages will be freed with current code. Deferred split
> > > > > > > > > only applies to partly mapped THPs: at least on 4k of the THP is still
> > > > > > > > > mapped somewhere.
> > > > > > > > Hmm, I am probably misreading the code but at least current Linus' tree
> > > > > > > > reads page_remove_rmap -> [page_remove_anon_compound_rmap ->\ deferred_split_huge_page even
> > > > > > > > for fully mapped THP.
> > > > > > > Well, you read correctly, but it was not intended. I screwed it up at some
> > > > > > > point.
> > > > > > > 
> > > > > > > See the patch below. It should make it work as intened.
> > > > > > > 
> > > > > > > It's not bug as such, but inefficientcy. We add page to the queue where
> > > > > > > it's not needed.
> > > > > > But that adding to queue doesn't affect whether the page will be freed
> > > > > > immediately if there are no more partial mappings, right? I don't see
> > > > > > deferred_split_huge_page() pinning the page.
> > > > > > So your patch wouldn't make THPs freed immediately in cases where they
> > > > > > haven't been freed before immediately, it just fixes a minor
> > > > > > inefficiency with queue manipulation?
> > > > > Ohh, right. I can see that in free_transhuge_page now. So fully mapped
> > > > > THPs really do not matter and what I have considered an odd case is
> > > > > really happening more often.
> > > > > 
> > > > > That being said this will not help at all for what Yang Shi is seeing
> > > > > and we need a more proactive deferred splitting as I've mentioned
> > > > > earlier.
> > > > It was not intended to fix the issue. It's fix for current logic. I'm
> > > > playing with the work approach now.
> > > Below is what I've come up with. It appears to be functional.
> > > 
> > > Any comments?
> > 
> > Thanks, Kirill and Michal. Doing split more proactive is definitely a choice
> > to eliminate huge accumulated deferred split THPs, I did think about this
> > approach before I came up with memcg aware approach. But, I thought this
> > approach has some problems:
> > 
> > First of all, we can't prove if this is a universal win for the most
> > workloads or not. For some workloads (as I mentioned about our usecase), we
> > do see a lot THPs accumulated for a while, but they are very short-lived for
> > other workloads, i.e. kernel build.
> > 
> > Secondly, it may be not fair for some workloads which don't generate too
> > many deferred split THPs or those THPs are short-lived. Actually, the cpu
> > time is abused by the excessive deferred split THPs generators, isn't it?
> 
> Yes this is indeed true. Do we have any idea on how much time that
> actually is?

For uncontented case, splitting 1G worth of pages (2MiB x 512) takes a bit
more than 50 ms in my setup. But it's best-case scenario: pages not shared
across multiple processes, no contention on ptl, page lock, etc.

> > With memcg awareness, the deferred split THPs actually are isolated and
> > capped by memcg. The long-lived deferred split THPs can't be accumulated too
> > many due to the limit of memcg. And, cpu time spent in splitting them would
> > just account to the memcgs who generate that many deferred split THPs, who
> > generate them who pay for it. This sounds more fair and we could achieve
> > much better isolation.
> 
> On the other hand, deferring the split and free up a non trivial amount
> of memory is a problem I consider quite serious because it affects not
> only the memcg workload which has to do the reclaim but also other
> consumers of memory beucase large memory blocks could be used for higher
> order allocations.

Maybe instead of drive the split from number of pages on queue we can take
a hint from compaction that is struggles to get high order pages?

We can also try to use schedule_delayed_work() instead of plain
schedule_work() to give short-lived page chance to get freed before
splitting attempt.

> > And, I think the discussion is diverted and mislead by the number of
> > excessive deferred split THPs. To be clear, I didn't mean the excessive
> > deferred split THPs are problem for us (I agree it may waste memory to have
> > that many deferred split THPs not usable), the problem is the oom since they
> > couldn't be split by memcg limit reclaim since the shrinker was not memcg
> > aware.
> 
> Well, I would like to see how much of a problem the memcg OOM really is
> after deferred splitting is more time constrained. Maybe we will find
> that there is no special memcg aware solution really needed.
> -- 
> Michal Hocko
> SUSE Labs

-- 
 Kirill A. Shutemov
