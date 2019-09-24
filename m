Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129E6C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4BC5214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HjEtlvgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436853AbfIXSyK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:54:10 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35984 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfIXSyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:54:09 -0400
Received: by mail-qt1-f193.google.com with SMTP id o12so3445348qtf.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MiKqbwAmBQwaqsCthyRHLRDPP3OlLqhMZfYy8oltFLU=;
        b=HjEtlvgNgKCPbWWrJWjCX1t4Zg96frB5QVa695LGa3ORvGL/s+3Tdy9wIhdtrkBTAa
         KAAYG3Hu29lM7UFbyKQlqFfr6WepmmM9L/OF5BmJiPKQZYZ6H3WQdR9AHdm+Z/smsUaD
         hyIMqDLaHyVslCM4/lL+v+AVFwzb1qymMrEc1jT1LW2NVDERuGND1N7Yup+mLsYfHWyg
         2ejFOrVFQj3+vXk+OFXOsDl0+2GVbeYGAWXphiAStbncWNtcqVqC4L7BRVIFFdsD1AgW
         ygt1GarYud5cFFl/NKFKyJh2nE8IrfxuwVGKtFaaGMSbHwL0Od05fN/gFlPUvIID4oYu
         PfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MiKqbwAmBQwaqsCthyRHLRDPP3OlLqhMZfYy8oltFLU=;
        b=UlDdekgvwK0KZv9ucVa1XrIsHVJH5k+IzsLRiDycnNv1BocQfOlagNnxlKeevGVCrH
         4sKy2sbZLL3EY9Fczk9q1e5VPv7N0z/oq0rzfp+3CdGZvsCIqJ9ksCWGfMS6iXEm2Pl2
         Uzv/qk3WhKAyc+oMVOOajz8og6f54gdLLsnajeK9FSpzG8DZSlC+lxmG9Zp2tqjclyLK
         q2VQG1dVUYx4CJRP5m5aOFxK+lhLaO0G18bslvW+3uq5SQ87e+7nBHbLC0sM9eHlNRGF
         aG92IFSalGGfRaaepeSQ2terfjOhRwPYEiBMyO3ANAnyK0ysvZNMgBH9rHcYQbd6pP3u
         t6ig==
X-Gm-Message-State: APjAAAXaHLbxAZ7VxZSg6QFrX4y6AkvK/dhjLSk2NNoRgvJEkkkrry5B
        xK+tHFrIT9hAvOmTa7jsF118fQ==
X-Google-Smtp-Source: APXvYqxh7GtANWCqEgywe7I/WDaQ+q/YbqyG5jNks7urqX5NR/xpoUtC5VBlMgz8P+gFHv3xF9QBmQ==
X-Received: by 2002:aed:2448:: with SMTP id s8mr4529400qtc.173.1569351247227;
        Tue, 24 Sep 2019 11:54:07 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id w6sm1371556qkj.136.2019.09.24.11.54.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Sep 2019 11:54:06 -0700 (PDT)
Message-ID: <1569351244.5576.219.camel@lca.pw>
Subject: Re: [PATCH v1] mm/memory_hotplug: Don't take the cpu_hotplug_lock
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 24 Sep 2019 14:54:04 -0400
In-Reply-To: <20190924151147.GB23050@dhcp22.suse.cz>
References: <20190924143615.19628-1-david@redhat.com>
         <1569337401.5576.217.camel@lca.pw> <20190924151147.GB23050@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-09-24 at 17:11 +0200, Michal Hocko wrote:
> On Tue 24-09-19 11:03:21, Qian Cai wrote:
> [...]
> > While at it, it might be a good time to rethink the whole locking over there, as
> > it right now read files under /sys/kernel/slab/ could trigger a possible
> > deadlock anyway.
> > 
> 
> [...]
> > [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> > [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> > [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> > [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> > [  442.474803][ T5224]        get_online_mems+0x54/0x150
> > [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> > [  442.485072][ T5224]        total_objects_show+0x28/0x34
> > [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> > [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> > [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> > [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> > [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> > [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> > [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> > [  442.524060][ T5224]        ksys_read+0xb0/0x120
> > [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> > [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> > [  442.538768][ T5224]        el0_svc+0x8/0xc
> 
> I believe the lock is not really needed here. We do not deallocated
> pgdat of a hotremoved node nor destroy the slab state because an
> existing slabs would prevent hotremove to continue in the first place.
> 
> There are likely details to be checked of course but the lock just seems
> bogus.

Check 03afc0e25f7f ("slab: get_online_mems for
kmem_cache_{create,destroy,shrink}"). It actually talk about the races during
memory as well cpu hotplug, so it might even that cpu_hotplug_lock removal is
problematic?
