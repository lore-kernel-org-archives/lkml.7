Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C9AC2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9B920828
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da18x/ct"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbfLWQgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 11:36:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40506 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbfLWQgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 11:36:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id s21so4643543plr.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Dec 2019 08:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DMCgPncuWHJTD5/ks/DMMUA1VLzNBNuj3082cj/3jJ0=;
        b=da18x/ctAjwsEUbMO0otQqgpJkCE/Gh0u74KFUbz3wbU075YHtnUrn3rCxSSgeHa1g
         Hs4gFA8AiPsK0IYN65u6SsuiTmGL5mzklIcZcmhQA5dJuVmkIHylF2tXtvE9mmyZ7j2I
         0dGsXwEcOSxD+KhvWPQlakT5NQfaqSgLWTuz8OSob9Ac1LBbhj8JPZ4/joqbxLh/yDlQ
         BH5s9P6bWFsZcExGutsbyoknm6wgvQwRASZ60TF2wJ4LcrREEVX5geSkCnuUibFwaMMj
         QKAFainxLQymSMjYlbkRLzZs9h/ZYX3l+AsHxRSy9SQ+lqrOkK8+oj21fSA9HJwU1nSN
         07DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DMCgPncuWHJTD5/ks/DMMUA1VLzNBNuj3082cj/3jJ0=;
        b=T5WjfYh4qOTmkl1pABx396bOfhxrRCswSMI+L7degSEbONqlFPK9eWv9ef8bdNLaH/
         atxilGyMeq5A2JAVWgXJbtmL0ZWLCdrECOQUSmboSSig3QaGM3wKlYtQv74NUZ8xoUd4
         2+S4KA1+RmDx2NScl5zYkNUAV5xsrhCPwHyxMiqDpOGYgc9Q4iw0rIJ7dbRJu8TXb5ck
         Lffw75KP1swF1xjPcOMiCSBjK68JjXY+E5I1alQVlx6UEcnRgxV+1hud3rSiYLtlbkVn
         GZpBBxLyTpsM9vyAfqjQMpxdtyWs0hsz2HzRJjgX77BJsKJe31O1gkkZgRQDwrf7cy0p
         9MEQ==
X-Gm-Message-State: APjAAAWpRz8VE3uPdySrKsqfDzYLru9Yqcg8LfSeQwGVpTstCtU1qt8V
        Su1Wq+scpINRSHzkRnKq1gEaXTve
X-Google-Smtp-Source: APXvYqzj6c/TPIylZuCIOkvXOQu+TvPkWsXmilQn+pQg/+bPOmZWGRn4bUpr7C8XUoT5c/40sUtgfg==
X-Received: by 2002:a17:902:421:: with SMTP id 30mr32012017ple.324.1577118972115;
        Mon, 23 Dec 2019 08:36:12 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13sm21636768pjz.15.2019.12.23.08.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Dec 2019 08:36:11 -0800 (PST)
Date:   Mon, 23 Dec 2019 08:36:10 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Axtens <dja@axtens.net>
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        akash.goel@intel.com, ajd@linux.ibm.com,
        syzbot+1e925b4b836afe85a1c6@syzkaller-ppc64.appspotmail.com,
        syzbot+587b2421926808309d21@syzkaller-ppc64.appspotmail.com,
        syzbot+58320b7171734bf79d26@syzkaller.appspotmail.com,
        syzbot+d6074fb08bdb2e010520@syzkaller.appspotmail.com
Subject: Re: [PATCH] relay: handle alloc_percpu returning NULL in relay_open
Message-ID: <20191223163610.GA32267@roeck-us.net>
References: <20191129013745.7168-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191129013745.7168-1-dja@axtens.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 12:37:45PM +1100, Daniel Axtens wrote:
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
> 

So there is a CVE now, but it appears that the patch went nowhere.
Are there any plans to actually apply it ?

Thanks,
Guenter

> --
> 
> There's a syz reproducer on the powerpc syzbot that eventually hits
> the bug, but it can take up to an hour or so before it keels over on a
> kernel with all the syzkaller debugging on, and even longer on a
> production kernel. I have been able to reproduce it once on a stock
> Ubuntu 5.0 ppc64le kernel.
> 
> I will ask MITRE for a CVE - while only the process doing the syscall
> gets killed, it gets killed while holding the relay_channels_mutex,
> so it blocks all future relay activity.
> ---
>  kernel/relay.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
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
> -- 
> 2.20.1
> 
