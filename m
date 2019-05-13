Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0331C46470
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1282133F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 15:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D0OIEpdn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfEMPUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 11:20:50 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:41127 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfEMPUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 11:20:50 -0400
Received: by mail-qt1-f170.google.com with SMTP id y22so11733145qtn.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 08:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GfucGi6E8CEofLJ0x44J7XInrISOaZYfjQZg3ZcUxv4=;
        b=D0OIEpdn+YwCQTnRAHTG8T8EZftzb3SJgXdK6HoKO14Hl7lohlc9qu8Qx9GIxfzmjd
         +OQRyofjp2c2yjwr3YA5BRJRsMoPHxbGztnpjPONaocSLiNKVocK7lviF1MDmNlZbbdr
         E8e9lAWNNMmtujKHBXRuNVF2XJh2YMqDQqSZKWVH6QfqEyGhwXmd0WC3yxCrPFBymB3L
         W+3f8jFiO3tdnNigELzQFmpvjr/O3S/1Uer8kJBKfamBZHZa06V0eVhYkApnGS1WRRcW
         VJCXjMstRY0GehlTY0TOyyUqDwIM6j3vimhmnr44uEBIYr0H8jFUzAQblZZVXIffxf0B
         bsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GfucGi6E8CEofLJ0x44J7XInrISOaZYfjQZg3ZcUxv4=;
        b=sLiBDpwz6DOcNaX3ObkGqxBi8X1ZBfX5xLk6enTI7Pot1ZaB7uMXzkPH7eIuujXjZx
         cuzrtvF0dozNvA57EhHGuHZ2A5isOkrF1vAB2mWd0vXkai7AtUlWnuR0nLICna5ls2Pe
         Mnf3h3ffwb/IkzyiXbO22Fve/YSAfJlBXxJQAyls5uOj+Ja2YTq5U02GjsEtq9kh8UGO
         tRvlAhKsuWh7EZZJI6k+yrwzvdLVOJY/o8CiH0hAoRxWUVVcEFeBQk9zSUqatw4fVbJ1
         lvn5uUrqjM7CXfiuMu1XP/aydLXOwFYGPIN7AM/IhzLgqW8hmyCwI3xhzyI5JzsvuHUb
         2tdA==
X-Gm-Message-State: APjAAAXG2zL3bf+RquR0cYmzxETkPQ4mZxVmqBufxPXffpJ+/SsKakmF
        jcEuZQdWrrKMKErkL8qhmwChrQ==
X-Google-Smtp-Source: APXvYqzNCg/Lbhg5+o+INUC/kV+a1p/OwOuOK9EYoWevkihzXrAQ0dYEeibOxkl3lJrup7k5j+U7mw==
X-Received: by 2002:ac8:392c:: with SMTP id s41mr24553433qtb.34.1557760848842;
        Mon, 13 May 2019 08:20:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 17sm6813770qkg.30.2019.05.13.08.20.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 08:20:47 -0700 (PDT)
Message-ID: <1557760846.6132.25.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 11:20:46 -0400
In-Reply-To: <20190513140448.GJ24036@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
         <20190513124112.GH24036@dhcp22.suse.cz> <1557755039.6132.23.camel@lca.pw>
         <20190513140448.GJ24036@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 16:04 +0200, Michal Hocko wrote:
> On Mon 13-05-19 09:43:59, Qian Cai wrote:
> > On Mon, 2019-05-13 at 14:41 +0200, Michal Hocko wrote:
> > > On Sun 12-05-19 01:48:29, Qian Cai wrote:
> > > > The linux-next commit ("x86, numa: always initialize all possible
> > > > nodes") introduced a crash below during boot for systems with a
> > > > memory-less node. This is due to CPUs that get onlined during SMP boot,
> > > > but that onlining triggers a page fault in bus_add_device() during
> > > > device registration:
> > > > 
> > > > 	error = sysfs_create_link(&bus->p->devices_kset->kobj,
> > > > 
> > > > bus->p is NULL. That "p" is the subsys_private struct, and it should
> > > > have been set in,
> > > > 
> > > > 	postcore_initcall(register_node_type);
> > > > 
> > > > but that happens in do_basic_setup() after smp_init().
> > > > 
> > > > The old code had set this node online via alloc_node_data(), so when it
> > > > came time to do_cpu_up() -> try_online_node(), the node was already up
> > > > and nothing happened.
> > > > 
> > > > Now, it attempts to online the node, which registers the node with
> > > > sysfs, but that can't happen before the 'node' subsystem is registered.
> > > > 
> > > > Since kernel_init() is running by a kernel thread that is in
> > > > SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> > > > during the early boot in __try_online_node().
> > > 
> > > Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
> > > drop try_online_node from do_cpu_up? Your v2 remark below suggests that
> > > we need to call node_set_online because something later on depends on
> > > that. Btw. why do we even allocate a pgdat from this path? This looks
> > > really messy.
> > 
> > See the commit cf23422b9d76 ("cpu/mem hotplug: enable CPUs online before
> > local
> > memory online")
> > 
> > It looks like try_online_node() in do_cpu_up() is needed for memory hotplug
> > which is to put its node online if offlined and then hotadd_new_pgdat()
> > calls
> > build_all_zonelists() to initialize the zone list.
> 
> Well, do we still have to followthe logic that the above (unreviewed)
> commit has established? The hotplug code in general made a lot of ad-hoc
> design decisions which had to be revisited over time. If we are not
> allocating pgdats for newly added memory then we should really make sure
> to do so at a proper time and hook. I am not sure about CPU vs. memory
> init ordering but even then I would really prefer if we could make the
> init less obscure and _documented_.

I don't know, but I think it is a good idea to keep the existing logic rather
than do a big surgery unless someone is able to confirm it is not breaking NUMA
node physical hotplug.
