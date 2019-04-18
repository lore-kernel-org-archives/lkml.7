Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E83C10F0B
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9328D2083D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 07:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="PMN9oRU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388144AbfDRH2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 03:28:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54440 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730258AbfDRH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 03:28:52 -0400
Received: from zn.tnic (p200300EC2F112E00DC490119D3A149FB.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:2e00:dc49:119:d3a1:49fb])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 59E731EC0104;
        Thu, 18 Apr 2019 09:28:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555572531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mDXcmB2dg3VfgT/wN632ae9RcHNXHqZMTaZd4Y5RGjc=;
        b=PMN9oRU0eLY15i7KvvZB20GQGIYzACtH0qXyHtwcN5dycDTftuUW5AuZsD2laIzPtKSWlE
        cIcK3Wp5V3cMuq9EnGABXMSIZopvrFEGtwv1/YeXcCkvR/jjBM5XOhmzNmdt/dFePAiMEC
        ZVhoQGeELsLSiDUiqF7Fs5+p3lH12i4=
Date:   Thu, 18 Apr 2019 09:28:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaochen Shen <xiaochen.shen@intel.com>
Cc:     tony.luck@intel.com, x86@kernel.org, mingo@redhat.com, bp@suse.de,
        reinette.chatre@intel.com, hpa@zytor.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        fenghua.yu@intel.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/cache] x86/resctrl: Initialize a new resource group
 with default MBA values
Message-ID: <20190418072845.GA27160@zn.tnic>
References: <1555499329-1170-3-git-send-email-xiaochen.shen@intel.com>
 <tip-47820e73f5b3a1fdb8ebd1219191edc96e0c85c1@git.kernel.org>
 <0ab6a79f-d1ae-1c99-1447-722f18405309@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ab6a79f-d1ae-1c99-1447-722f18405309@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:03:35PM +0800, Xiaochen Shen wrote:
> In my opinion, this newline is unnecessary. Thank you.

See commit message:

>   [ bp: Add newlines between code blocks for better readability. ]

And I didn't add enough. That code is too crammed.

For example, the new __init_one_rdt_domain() could use some newlines
too, to separate code blocks for better readability. At least before
each comment so that one can visually distinguish code groups
better/faster.

Here the whole function pasted with newlines added where I think they
make sense. This way you have visual separation between the code blocks
and not one big fat clump of code which one has to painstakingly pick
apart.

static int __init_one_rdt_domain(struct rdt_domain *d, struct rdt_resource *r,
                                 u32 closid)
{
        struct rdt_resource *r_cdp = NULL;
        struct rdt_domain *d_cdp = NULL;
        u32 used_b = 0, unused_b = 0;
        unsigned long tmp_cbm;
        enum rdtgrp_mode mode;
        u32 peer_ctl, *ctrl;
        int i;

        rdt_cdp_peer_get(r, d, &r_cdp, &d_cdp);
        d->have_new_ctrl = false;
        d->new_ctrl = r->cache.shareable_bits;
        used_b = r->cache.shareable_bits;
        ctrl = d->ctrl_val;

        for (i = 0; i < closids_supported(); i++, ctrl++) {
                if (closid_allocated(i) && i != closid) {
                        mode = rdtgroup_mode_by_closid(i);
                        if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
                                break;

                        /*
                         * If CDP is active include peer domain's
                         * usage to ensure there is no overlap
                         * with an exclusive group.
                         */
                        if (d_cdp)
                                peer_ctl = d_cdp->ctrl_val[i];
                        else
                                peer_ctl = 0;

                        used_b |= *ctrl | peer_ctl;
                        if (mode == RDT_MODE_SHAREABLE)
                                d->new_ctrl |= *ctrl | peer_ctl;
                }
        }

        if (d->plr && d->plr->cbm > 0)
                used_b |= d->plr->cbm;

        unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
        unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
        d->new_ctrl |= unused_b;

        /*
         * Force the initial CBM to be valid, user can
         * modify the CBM based on system availability.
         */
        cbm_ensure_valid(&d->new_ctrl, r);

        /*
         * Assign the u32 CBM to an unsigned long to ensure that
         * bitmap_weight() does not access out-of-bound memory.
         */
        tmp_cbm = d->new_ctrl;

        if (bitmap_weight(&tmp_cbm, r->cache.cbm_len) < r->cache.min_cbm_bits) {
                rdt_last_cmd_printf("No space on %s:%d\n", r->name, d->id);
                return -ENOSPC;
        }
        d->have_new_ctrl = true;

        return 0;
}

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
