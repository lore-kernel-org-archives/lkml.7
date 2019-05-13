Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1791BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C569420879
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PI4evEZq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729710AbfEMNoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:44:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36468 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfEMNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:44:03 -0400
Received: by mail-qk1-f196.google.com with SMTP id c14so8015469qke.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2QDl6grKdXugMhxYUcRUEzKdYNWZg6vAUEjXwfnBzkw=;
        b=PI4evEZqraBE8yNXPNwxp4xmE2NyijJHNSsC7SfViFNImDgZ1AAwHTvYYvHWNnR3wJ
         aSKxM7KkC3kgtnIk0XhwIa9Wy74Fs+F3fSPL/0kxJVZtEeFWXdQ2wz8bmI8EanvPLJIa
         JZGmIVsQxCvb995ZVHcttoajnCWTYDD8EDPma13jIZ3VsfeY/35hW1u0naTipeY/FbdC
         WD/A6+vJpnsoMUu3I1UkxnfMD41foxCLv86sD7T25x/23bK7M4ZaXje2B4sZ10cAYNd2
         7E4pUHmtjmKvXmNVSU5Yrc2FZTuQHuetU8uxVlWRieV8DcYBY8Bxom/M7BCLiGUdmUSk
         68vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2QDl6grKdXugMhxYUcRUEzKdYNWZg6vAUEjXwfnBzkw=;
        b=Q7o1ARwkxqiH5kjDyO1AYuvXLwiWJeenubqLCIXTL0WsJt4v+jG7BV19FyjtTGpDx3
         1qw4fUjR+5eQqo0nAZF6SIcWLCXaaqfuncDytk3O3K7Gf1LPf7rTsaPJR9Dxb6IEdATf
         MlL3zn+KmhjUYBmaD9agBh1hOA+MslXIlWPd8Q5VwRce1pyFVafaRsH+MuSobhUIyrcA
         XIeE2Er5maNTsuH79bE5+i5ezwkWLhImIE+p/YHzKPeShtSkY5ySnu1wioYptCXIKMC9
         4tIaDp19JJA77yhlDUi7E9QxZt7z3ze4k8kqeSvvpKStm3XgE1gLmz5VMzIX3TtMW0QO
         7Mzg==
X-Gm-Message-State: APjAAAVJXXh2hv7PTXwR4m5u+tGPpl83x3nILsR4VnGH5Kcm9k6K9huL
        vl2Xxub/ik13yncSFkb+TgKrTg==
X-Google-Smtp-Source: APXvYqxjHoiLVV5dDlLcG6KTaJ0fU0NM6dQoETxAspMtmKMogQvEfztN5TXLDgEyCZ8FB74Xzl9biA==
X-Received: by 2002:a05:620a:13fc:: with SMTP id h28mr21824042qkl.164.1557755042373;
        Mon, 13 May 2019 06:44:02 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d16sm4138827qtd.73.2019.05.13.06.44.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 06:44:01 -0700 (PDT)
Message-ID: <1557755039.6132.23.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm/hotplug: fix a null-ptr-deref during NUMA
 boot
From:   Qian Cai <cai@lca.pw>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     akpm@linux-foundation.org, brho@google.com, kernelfans@gmail.com,
        dave.hansen@intel.com, rppt@linux.ibm.com, peterz@infradead.org,
        mpe@ellerman.id.au, mingo@elte.hu, osalvador@suse.de,
        luto@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 13 May 2019 09:43:59 -0400
In-Reply-To: <20190513124112.GH24036@dhcp22.suse.cz>
References: <20190512054829.11899-1-cai@lca.pw>
         <20190513124112.GH24036@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-05-13 at 14:41 +0200, Michal Hocko wrote:
> On Sun 12-05-19 01:48:29, Qian Cai wrote:
> > The linux-next commit ("x86, numa: always initialize all possible
> > nodes") introduced a crash below during boot for systems with a
> > memory-less node. This is due to CPUs that get onlined during SMP boot,
> > but that onlining triggers a page fault in bus_add_device() during
> > device registration:
> > 
> > 	error = sysfs_create_link(&bus->p->devices_kset->kobj,
> > 
> > bus->p is NULL. That "p" is the subsys_private struct, and it should
> > have been set in,
> > 
> > 	postcore_initcall(register_node_type);
> > 
> > but that happens in do_basic_setup() after smp_init().
> > 
> > The old code had set this node online via alloc_node_data(), so when it
> > came time to do_cpu_up() -> try_online_node(), the node was already up
> > and nothing happened.
> > 
> > Now, it attempts to online the node, which registers the node with
> > sysfs, but that can't happen before the 'node' subsystem is registered.
> > 
> > Since kernel_init() is running by a kernel thread that is in
> > SYSTEM_SCHEDULING state, fixed this by skipping registering with sysfs
> > during the early boot in __try_online_node().
> 
> Relying on SYSTEM_SCHEDULING looks really hackish. Why cannot we simply
> drop try_online_node from do_cpu_up? Your v2 remark below suggests that
> we need to call node_set_online because something later on depends on
> that. Btw. why do we even allocate a pgdat from this path? This looks
> really messy.

See the commit cf23422b9d76 ("cpu/mem hotplug: enable CPUs online before local
memory online")

It looks like try_online_node() in do_cpu_up() is needed for memory hotplug
which is to put its node online if offlined and then hotadd_new_pgdat() calls
build_all_zonelists() to initialize the zone list.

> 
> > Call Trace:
> >  device_add+0x43e/0x690
> >  device_register+0x107/0x110
> >  __register_one_node+0x72/0x150
> >  __try_online_node+0x8f/0xd0
> >  try_online_node+0x2b/0x50
> >  do_cpu_up+0x46/0xf0
> >  cpu_up+0x13/0x20
> >  smp_init+0x6e/0xd0
> >  kernel_init_freeable+0xe5/0x21f
> >  kernel_init+0xf/0x180
> >  ret_from_fork+0x1f/0x30
> > 
> > Reported-by: Barret Rhoden <brho@google.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: Set the node online as it have CPUs. Otherwise, those memory-less nodes
> > will
> >     end up being not in sysfs i.e., /sys/devices/system/node/.
> > 
> >  mm/memory_hotplug.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index b236069ff0d8..6eb2331fa826 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1037,6 +1037,18 @@ static int __try_online_node(int nid, u64 start, bool
> > set_node_online)
> >  	if (node_online(nid))
> >  		return 0;
> >  
> > +	/*
> > +	 * Here is called by cpu_up() to online a node without memory from
> > +	 * kernel_init() which guarantees that "set_node_online" is true
> > which
> > +	 * will set the node online as it have CPUs but not ready to call
> > +	 * register_one_node() as "node_subsys" has not been initialized
> > +	 * properly yet.
> > +	 */
> > +	if (system_state == SYSTEM_SCHEDULING) {
> > +		node_set_online(nid);
> > +		return 0;
> > +	}
> > +
> >  	pgdat = hotadd_new_pgdat(nid, start);
> >  	if (!pgdat) {
> >  		pr_err("Cannot online node %d due to NULL pgdat\n", nid);
> > -- 
> > 2.20.1 (Apple Git-117)
> 
> 
