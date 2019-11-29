Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92B6C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCB42176D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 04:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfK2E7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 23:59:37 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:36087 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726800AbfK2E7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 23:59:37 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47PMk93X45z9sPj;
        Fri, 29 Nov 2019 15:59:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1575003574;
        bh=19pJP6vUr4t2D8dTKyATaMi+48+ZIdMKG/tYr/jD0V4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XUCEc+EWpMdNAtEBbV6Q+/egdrVh/W32IvexKmcHnYsjLD0xi16QwSbsLC4qYb7b4
         A1VJXiTd99K0L0/6tJzeKQVUY6D9EillQpyWjbLFOzBx0zaM5esGAtny4tJeLzHllH
         iTcEWCOA0BV8wDCCYwZbfXYy4+lQFR5nCPv82NbrwoVCx7BRZAJJbZFEvEPoB0W+c9
         jk2hIV6o4DHGjqVs4DqFm5cb4sgoKKehvLdMGOnEmgzwCElzoV+epn1wEqm8+fYWdy
         RvtmHbSPilqsK9i+E83E2TLZehSShpi/OVLrshGEkBfoPJ+QTte4t7H1pqgY/Ac/A7
         qbwrGIau+nrjg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Cc:     akash.goel@intel.com, ajd@linux.ibm.com,
        Daniel Axtens <dja@axtens.net>,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: Re: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
In-Reply-To: <20191129013745.7168-1-dja@axtens.net>
References: <20191129013745.7168-1-dja@axtens.net>
Date:   Fri, 29 Nov 2019 15:59:27 +1100
Message-ID: <87d0dbffbk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Axtens <dja@axtens.net> writes:
> alloc_percpu() may return NULL, which means chan->buf may be set to
> NULL. In that case, when we do *per_cpu_ptr(chan->buf, ...), we
> dereference an invalid pointer:
>
> BUG: Unable to handle kernel data access at 0x7dae0000
> Faulting instruction address: 0xc0000000003f3fec
> ...
> NIP [c0000000003f3fec] relay_open+0x29c/0x600
> LR [c0000000003f3fc0] relay_open+0x270/0x600
> Call Trace:
> [c000000054353a70] [c0000000003f3fb4] relay_open+0x264/0x600 (unreliable)
> [c000000054353b00] [c000000000451764] __blk_trace_setup+0x254/0x600
> [c000000054353bb0] [c000000000451b78] blk_trace_setup+0x68/0xa0
> [c000000054353c10] [c0000000010da77c] sg_ioctl+0x7bc/0x2e80
> [c000000054353cd0] [c000000000758cbc] do_vfs_ioctl+0x13c/0x1300
> [c000000054353d90] [c000000000759f14] ksys_ioctl+0x94/0x130
> [c000000054353de0] [c000000000759ff8] sys_ioctl+0x48/0xb0
> [c000000054353e20] [c00000000000bcd0] system_call+0x5c/0x68
>
> Check if alloc_percpu returns NULL. Because we can readily catch and
> handle this situation, switch to alloc_cpu_gfp and pass in __GFP_NOWARN.
>
> This was found by syzkaller both on x86 and powerpc, and the reproducer
> it found on powerpc is capable of hitting the issue as an unprivileged
> user.
>
> Fixes: 017c59c042d0 ("relay: Use per CPU constructs for the relay channel buffer pointers")
> Reported-by: syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com
> Reported-by: syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com
> Reported-by: syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com
> Reported-by: syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
> Cc: Akash Goel <akash.goel@intel.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com> # syzkaller-ppc64
> Cc: stable@vger.kernel.org # v4.10+
> Signed-off-by: Daniel Axtens <dja@axtens.net>
...
> diff --git a/kernel/relay.c b/kernel/relay.c
> index ade14fb7ce2e..a376cc6b54ec 100644
> --- a/kernel/relay.c
> +++ b/kernel/relay.c
> @@ -580,7 +580,13 @@ struct rchan *relay_open(const char *base_filename,
>  	if (!chan)
>  		return NULL;
>  
> -	chan->buf = alloc_percpu(struct rchan_buf *);
> +	chan->buf = alloc_percpu_gfp(struct rchan_buf *,
> +				     GFP_KERNEL | __GFP_NOWARN);
> +	if (!chan->buf) {
> +		kfree(chan);
> +		return NULL;
> +	}
> +
>  	chan->version = RELAYFS_CHANNEL_VERSION;
>  	chan->n_subbufs = n_subbufs;
>  	chan->subbuf_size = subbuf_size;

This looks right to me. The kfree + direct return is correct, there's
nothing else that needs tear down in this function.

I think I'm 50/50 on the __GFP_NOWARN. We're only asking for 8 bytes per
cpu, and if that fails the system is pretty sick, so a warning could be
helpful. There's also logic in the percpu allocator to limit the number
of warnings printed. But see what others think.

Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
