Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4207AC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A9221D7C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 16:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SkqMrQKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439699AbfIYQBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 12:01:06 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34812 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439511AbfIYQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 12:01:05 -0400
Received: by mail-qt1-f195.google.com with SMTP id 3so7192238qta.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 09:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wE7o18rA9f1oaiSrLT04Q82HAXBxKMsgWbvymZifnKw=;
        b=SkqMrQKbTN+NXMJ2fzwQ2PUgrpPvP6OQkXVj50wFBR3F5FBhYZpARNLhaxLZH6kmLi
         jiDcHfsXu83EX5Q55QCWht3wu/s06SOEQuklc8sNbT5HgRp5hX37KRjPTO1mNl3vYyxv
         AxDl4WMOwW1U+6mmETKpbNYL6YgFEzEmp+NqGlI14AtFPDO7CPNxvTpDpYoUNdHfznFx
         J3eujsmn0K4lSAeXb/KANtZyMCaahf7L3ORbNdKTWR/YPomnp/cGwqYWJCnqh29n47Aq
         RQ7pZBLbQoty6BjCukHTVNSXNxcxClD/SIWrH5ehuJBeQGICooMI7MmKlRWjw41ZVft6
         4HWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wE7o18rA9f1oaiSrLT04Q82HAXBxKMsgWbvymZifnKw=;
        b=atMItB+qg/hEMTwP7xSzz8OlqKQDTeBpPhCB/ip/3Z0tJAwsYnmbR/3b793LrkKeR4
         KKYlRTiIK0humXEmW4/p3CWSYlNs/HsriwVHgEPUcCcMdG81faIrcP0v5Zx/s4BqpZzW
         l5aJRguzh2FrI0NiNwJ1lUAW2X8a4RvYLqs6GVGlHQQnPSq0+lsrqPN+RYal2XW3gC/P
         f8tSJ9CE0aIuDNZjYKxUYDmWvamo2T79wLvvDFGI25ufn1XEjTT/KPGN2jTsOD9z+HT6
         0U7VveqULEvmXTaeKu2kzmp9rLW/i+uyA9NAtlKL/Erlpx9eWGngZbE63uda+G1bU8Bw
         GJsQ==
X-Gm-Message-State: APjAAAWnqG0WFo63c77pL95qv4C6+1xQSdbleR9zh+VuN/wl0WhoGoWU
        bWHRAcRBe06a3LEv+VkCaF9k2g==
X-Google-Smtp-Source: APXvYqzP1UPwIUGNslKSU1q+gwg/MeyuFYBDOZpmYJumxVb0J/cxQW7zvtSioCviXWbdxxVaKUUJwg==
X-Received: by 2002:ac8:2c8f:: with SMTP id 15mr9585039qtw.3.1569427264317;
        Wed, 25 Sep 2019 09:01:04 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id t63sm3225912qkf.48.2019.09.25.09.01.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 09:01:03 -0700 (PDT)
Message-ID: <1569427262.5576.225.camel@lca.pw>
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
Date:   Wed, 25 Sep 2019 12:01:02 -0400
In-Reply-To: <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
References: <20190924143615.19628-1-david@redhat.com>
         <1569337401.5576.217.camel@lca.pw> <20190924151147.GB23050@dhcp22.suse.cz>
         <1569351244.5576.219.camel@lca.pw>
         <2f8c8099-8de0-eccc-2056-a79d2f97fbf7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-09-25 at 09:02 +0200, David Hildenbrand wrote:
> On 24.09.19 20:54, Qian Cai wrote:
> > On Tue, 2019-09-24 at 17:11 +0200, Michal Hocko wrote:
> > > On Tue 24-09-19 11:03:21, Qian Cai wrote:
> > > [...]
> > > > While at it, it might be a good time to rethink the whole locking over there, as
> > > > it right now read files under /sys/kernel/slab/ could trigger a possible
> > > > deadlock anyway.
> > > > 
> > > 
> > > [...]
> > > > [  442.452090][ T5224] -> #0 (mem_hotplug_lock.rw_sem){++++}:
> > > > [  442.459748][ T5224]        validate_chain+0xd10/0x2bcc
> > > > [  442.464883][ T5224]        __lock_acquire+0x7f4/0xb8c
> > > > [  442.469930][ T5224]        lock_acquire+0x31c/0x360
> > > > [  442.474803][ T5224]        get_online_mems+0x54/0x150
> > > > [  442.479850][ T5224]        show_slab_objects+0x94/0x3a8
> > > > [  442.485072][ T5224]        total_objects_show+0x28/0x34
> > > > [  442.490292][ T5224]        slab_attr_show+0x38/0x54
> > > > [  442.495166][ T5224]        sysfs_kf_seq_show+0x198/0x2d4
> > > > [  442.500473][ T5224]        kernfs_seq_show+0xa4/0xcc
> > > > [  442.505433][ T5224]        seq_read+0x30c/0x8a8
> > > > [  442.509958][ T5224]        kernfs_fop_read+0xa8/0x314
> > > > [  442.515007][ T5224]        __vfs_read+0x88/0x20c
> > > > [  442.519620][ T5224]        vfs_read+0xd8/0x10c
> > > > [  442.524060][ T5224]        ksys_read+0xb0/0x120
> > > > [  442.528586][ T5224]        __arm64_sys_read+0x54/0x88
> > > > [  442.533634][ T5224]        el0_svc_handler+0x170/0x240
> > > > [  442.538768][ T5224]        el0_svc+0x8/0xc
> > > 
> > > I believe the lock is not really needed here. We do not deallocated
> > > pgdat of a hotremoved node nor destroy the slab state because an
> > > existing slabs would prevent hotremove to continue in the first place.
> > > 
> > > There are likely details to be checked of course but the lock just seems
> > > bogus.
> > 
> > Check 03afc0e25f7f ("slab: get_online_mems for
> > kmem_cache_{create,destroy,shrink}"). It actually talk about the races during
> > memory as well cpu hotplug, so it might even that cpu_hotplug_lock removal is
> > problematic?
> > 
> 
> Which removal are you referring to? get_online_mems() does not mess with
> the cpu hotplug lock (and therefore this patch).

The one in your patch. I suspect there might be races among the whole NUMA node
hotplug, kmem_cache_create, and show_slab_objects(). See bfc8c90139eb ("mem-
hotplug: implement get/put_online_mems")

"kmem_cache_{create,destroy,shrink} need to get a stable value of cpu/node
online mask, because they init/destroy/access per-cpu/node kmem_cache parts,
which can be allocated or destroyed on cpu/mem hotplug."

Both online_pages() and show_slab_objects() need to get a stable value of
cpu/node online mask.
