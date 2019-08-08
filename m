Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706B3C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4168B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 08:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="jED+jZHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbfHHInd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 04:43:33 -0400
Received: from mail.skyhub.de ([5.9.137.197]:59656 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731313AbfHHInc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 04:43:32 -0400
Received: from zn.tnic (p200300EC2F0FD700B5ECB790597D1186.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:d700:b5ec:b790:597d:1186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2A65F1EC0B07;
        Thu,  8 Aug 2019 10:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1565253811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Ie3mp4NVKQiRqVScYtsW/1o05H8/mSyOmqXkJBiR/+0=;
        b=jED+jZHzuEwHYoLGE4PKlPOGzHKZqTeQp4YIYdmL+g2BskOLofMJGXt1hLoZLb/5nULRPl
        mAW2QdoL/h1ohXSeXXBiuM6murDvrtI0Ytr61q+aic9yu+2mRChMqYPs7zkSe2x8fqnJpH
        WntMnSuNu3OSGZXsy9U6C8ARpEJL8z0=
Date:   Thu, 8 Aug 2019 10:44:16 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com,
        kuo-lang.tseng@intel.com, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 09/10] x86/resctrl: Pseudo-lock portions of multiple
 resources
Message-ID: <20190808084416.GC20745@zn.tnic>
References: <cover.1564504901.git.reinette.chatre@intel.com>
 <c0095fd15488d87be06deddf43abb4a2834dc7e6.1564504902.git.reinette.chatre@intel.com>
 <20190807152511.GB24328@zn.tnic>
 <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e9145623-bf5a-b96c-d802-7b61caa406e0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 12:23:29PM -0700, Reinette Chatre wrote:
> I do not fully understand this proposal. All those goto labels take care
> of the the different failures that can be encountered during the
> initialization of the pseudo-lock region. Each initialization failure is
> associated with a goto where it jumps to the cleanup path. The
> initialization starts with the constraining of the c-states
> (initializing plr->pm_reqs), but if I move that I think it will not
> reduce the goto labels, just change the order because of the other
> initialization done (plr->size, plr->line_size, plr->cpu).

Here's one possible way to do it, pasting the whole function here as it
is easier to read it this way than an incremental diff ontop.

You basically cache all attributes in local variables and assign them to
the plr struct only on success, at the end. This way, no goto labels and
the C-states constraining, i.e., the most expensive operation, happens
last, only after all the other simpler checks have succeeded. And you
don't have to call pseudo_lock_cstates_relax() prematurely, when one of
those easier checks fail.

Makes sense?

Btw, I've marked the cpu_online() check with "CPU hotplug
lock?!?" question because I don't see you holding that lock with
get_online_cpus()/put_online_cpus().

static int pseudo_lock_l2_l3_portions_valid(struct pseudo_lock_region *plr,
					    struct pseudo_lock_portion *l2_p,
					    struct pseudo_lock_portion *l3_p)
{
	unsigned int l2_size, l3_size, size, line_size, cpu;
	struct rdt_domain *l2_d, *l3_d;

	l2_d = rdt_find_domain(l2_p->r, l2_p->d_id, NULL);
	if (IS_ERR_OR_NULL(l2_d)) {
		rdt_last_cmd_puts("Cannot locate L2 cache domain\n");
		return -1;
	}

	l3_d = rdt_find_domain(l3_p->r, l3_p->d_id, NULL);
	if (IS_ERR_OR_NULL(l3_d)) {
		rdt_last_cmd_puts("Cannot locate L3 cache domain\n");
		return -1;
	}

	if (!cpumask_subset(&l2_d->cpu_mask, &l3_d->cpu_mask)) {
		rdt_last_cmd_puts("L2 and L3 caches need to be in same hierarchy\n");
		return -1;
	}

	l2_size = rdtgroup_cbm_to_size(l2_p->r, l2_d, l2_p->cbm);
	l3_size = rdtgroup_cbm_to_size(l3_p->r, l3_d, l3_p->cbm);

	if (l2_size > l3_size) {
		rdt_last_cmd_puts("L3 cache portion has to be same size or larger than L2 cache portion\n");
		return -1;
	}

	size = l2_size;

	l2_size = get_cache_line_size(cpumask_first(&l2_d->cpu_mask), l2_p->r->cache_level);
	l3_size = get_cache_line_size(cpumask_first(&l3_d->cpu_mask), l3_p->r->cache_level);
	if (l2_size != l3_size) {
		rdt_last_cmd_puts("L2 and L3 caches have different coherency cache line sizes\n");
		return -1;
	}

	line_size = l2_size;

	cpu = cpumask_first(&l2_d->cpu_mask);

	/*
	 * CPU hotplug lock?!?
	 */
	if (!cpu_online(cpu)) {
		rdt_last_cmd_printf("CPU %u associated with cache not online\n", cpu);
		return -1;
	}

	if (!get_cache_inclusive(cpu, l3_p->r->cache_level)) {
		rdt_last_cmd_puts("L3 cache not inclusive\n");
		return -1;
	}

	/*
	 * All checks passed, constrain C-states:
	 */
	if (pseudo_lock_cstates_constrain(plr, &l2_d->cpu_mask)) {
		rdt_last_cmd_puts("Cannot limit C-states\n");
		pseudo_lock_cstates_relax(plr);
		return -1;
	}

	plr->line_size	= line_size;
	plr->size	= size;
	plr->cpu	= cpu;

	return 0;
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
