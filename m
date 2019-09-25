Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F674C432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FD321D79
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 20:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="p2CU4vi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393260AbfIYUcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 16:32:53 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36151 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393204AbfIYUcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 16:32:53 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so63679qtf.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 13:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J57wOkNytV0R3QXZeQjJRBC086OiS7uIcVQyHpK+i0g=;
        b=p2CU4vi2sWx+7UfJkiFNoo8vpM7H8Gf/T/0I97xj/7zbDLPQlSn9GV3RFA0Fj5cdQp
         4uTlcQvd2MbdxdwH3RpzeDp/6IUcCxFZD62HYfxIqlXJmReN4Xuloi18elQuOwGPmnFu
         uCAhwdz3tjTJ5VUy4hxxkEq8f+dk5kHg8MuHYL4RCmn1eCuNw4BTaKaKrK8Tncu440ZI
         vG0nX5MyEYNFq1FFDrDi0OX7Mds39gJPHxH1U2eQjF1nxn4xVoIs6h9PY9oEiY7JUrmC
         iBEG4Uc9jUHgoFcmgTB8tqBTSwe5HTUsOjQz5ub2SgMpSVSKAs1WYVtVv0g8jbZW3TKC
         PzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J57wOkNytV0R3QXZeQjJRBC086OiS7uIcVQyHpK+i0g=;
        b=OcHHRmq+D9F+REIqVlfT8wuNc0UunEgBu1u5/CvBsjZhzklHrBdMRTl9inw4CeXL4F
         csNMWdA6Cn4eItZDG2BMsv1FQEaPVrmQU+8Q09UWlDax3FSIXdD8Sq/XNUHTAo7L1NHX
         Q3DP9Nnq503cPNmQVNNR5fVWQkHLecRFtYGTEQOb+nVOt3zkpUgtz1t9cz8JyXWeI5z3
         IfJnYMgINkU0fpgr3Vci4uS5q3IgmDq82jqM7kKJeL7yhFwbFGUkIxF2/7tYQZGXrN2B
         1y0ywZaT5xU4obP7evgmK+d1e9oDxKXjsLrmlpLAE2OccbRkj4q9hB4o7xtSeT48zXih
         Y3qQ==
X-Gm-Message-State: APjAAAXDBhJjha2WTcZqfyPLgCZcnY70mbJ/KFlPDLzT4K4JKl3Y0BgQ
        fFKJR3Gjk8DOdkC4NEPpUYwapA==
X-Google-Smtp-Source: APXvYqx3EbclPFEDN8LDEQbR3sOz9fbH21aVNcvda7KZXbguZB+0NrEGz7nKgjTNZY2vgLlU0vnVaw==
X-Received: by 2002:ac8:5147:: with SMTP id h7mr298272qtn.117.1569443571714;
        Wed, 25 Sep 2019 13:32:51 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 199sm3507177qkk.112.2019.09.25.13.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:32:50 -0700 (PDT)
Message-ID: <1569443568.5576.231.camel@lca.pw>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
From:   Qian Cai <cai@lca.pw>
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Wed, 25 Sep 2019 16:32:48 -0400
In-Reply-To: <92bce3d4-0a3e-e157-529d-35aafbc30f3b@redhat.com>
References: <20190924143615.19628-1-david@redhat.com>
         <1569337401.5576.217.camel@lca.pw> <20190924151147.GB23050@dhcp22.suse.cz>
         <1569351244.5576.219.camel@lca.pw>
         <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
         <1569427262.5576.225.camel@lca.pw> <20190925174809.GM23050@dhcp22.suse.cz>
         <1569435659.5576.227.camel@lca.pw>
         <92bce3d4-0a3e-e157-529d-35aafbc30f3b@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 21:48 +0200, David Hildenbrand wrote:
> On 25.09.19 20:20, Qian Cai wrote:
> > On Wed, 2019-09-25 at 19:48 +0200, Michal Hocko wrote:
> > > On Wed 25-09-19 12:01:02, Qian Cai wrote:
> > > > On Wed, 2019-09-25 at 09:02 +0200, David Hildenbrand wrote:
> > > > > On 24.09.19 20:54, Qian Cai wrote:
> > > > > > On Tue, 2019-09-24 at 17:11 +0200, Michal Hocko wrote:
> > > > > > > On Tue 24-09-19 11:03:21, Qian Cai wrote:
> > > > > > > [...]
> > > > > > > > While at it, it might be a good time to rethink the whole locking over there, as
> > > > > > > > it right now read files under /sys/kernel/slab/ could trigger a possible
> > > > > > > > deadlock anyway.
> > > > > > > > 
> > > > > > > 
> > > > > > > [...]
> > > > > > > > [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> > > > > > > > [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> > > > > > > > [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> > > > > > > > [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> > > > > > > > [  442.474803][ T5224]        get_online_mems+0x54/0x150
> > > > > > > > [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> > > > > > > > [  442.485072][ T5224]        total_objects_show+0x28/0x34
> > > > > > > > [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> > > > > > > > [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> > > > > > > > [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> > > > > > > > [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> > > > > > > > [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> > > > > > > > [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> > > > > > > > [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> > > > > > > > [  442.524060][ T5224]        ksys_read+0xb0/0x120
> > > > > > > > [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> > > > > > > > [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> > > > > > > > [  442.538768][ T5224]        el0_svc+0x8/0xc
> > > > > > > 
> > > > > > > I believe the lock is not really needed here. We do not deallocated
> > > > > > > pgdat of a hotremoved node nor destroy the slab state because an
> > > > > > > existing slabs would prevent hotremove to continue in the first place.
> > > > > > > 
> > > > > > > There are likely details to be checked of course but the lock just seems
> > > > > > > bogus.
> > > > > > 
> > > > > > Check 03afc0e25f7f ("slab: get_online_mems for
> > > > > > kmem_cache_{create,destroy,shrink}"). It actually talk about the races during
> > > > > > memory as well cpu hotplug, so it might even that cpu_hotplug_lock removal is
> > > > > > problematic?
> > > > > > 
> > > > > 
> > > > > Which removal are you referring to? get_online_mems() does not mess with
> > > > > the cpu hotplug lock (and therefore this patch).
> > > > 
> > > > The one in your patch. I suspect there might be races among the whole NUMA node
> > > > hotplug, kmem_cache_create, and show_slab_objects(). See bfc8c90139eb ("mem-
> > > > hotplug: implement get/put_online_mems")
> > > > 
> > > > "kmem_cache_{create,destroy,shrink} need to get a stable value of cpu/node
> > > > online mask, because they init/destroy/access per-cpu/node kmem_cache parts,
> > > > which can be allocated or destroyed on cpu/mem hotplug."
> > > 
> > > I still have to grasp that code but if the slub allocator really needs
> > > a stable cpu mask then it should be using the explicit cpu hotplug
> > > locking rather than rely on side effect of memory hotplug locking.
> > > 
> > > > Both online_pages() and show_slab_objects() need to get a stable value of
> > > > cpu/node online mask.
> > > 
> > > Could tou be more specific why online_pages need a stable cpu online
> > > mask? I do not think that show_slab_objects is a real problem because a
> > > potential race shouldn't be critical.
> > 
> > build_all_zonelists()
> >   __build_all_zonelists()
> >     for_each_online_cpu(cpu)
> > 
> 
> Two things:
> 
> a) We currently always hold the device hotplug lock when onlining memory
> and when onlining cpus (for CPUs at least via user space - we would have
> to double check other call paths). So theoretically, that should guard
> us from something like that already.
> 
> b)
> 
> commit 11cd8638c37f6c400cc472cc52b6eccb505aba6e
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Wed Sep 6 16:20:34 2017 -0700
> 
>     mm, page_alloc: remove stop_machine from build_all_zonelists
> 
> Tells me:
> 
> "Updates of the zonelists happen very seldom, basically only when a zone
>  becomes populated during memory online or when it loses all the memory
>  during offline.  A racing iteration over zonelists could either miss a
>  zone or try to work on one zone twice.  Both of these are something we
>  can live with occasionally because there will always be at least one
>  zone visible so we are not likely to fail allocation too easily for
>  example."
> 
> Sounds like if there would be a race, we could live with it if I am not
> getting that totally wrong.
> 

What's the problem you are trying to solve? Why it is more important to live
with races than to keep the correct code?
