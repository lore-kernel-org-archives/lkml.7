Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14685C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D87B72053B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 15:18:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+uLGpmf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbfK0PS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 10:18:57 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:41910 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfK0PS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 10:18:56 -0500
Received: by mail-qv1-f65.google.com with SMTP id g18so9017812qvp.8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 07:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Zys7zsjkt1m0RnQUfslYJUalywAfCs8j/JmRSdhUUts=;
        b=F+uLGpmf5nAR/f+UaS87JHCuVg7uI2Go/nnhOr8k/n1HkFI7eYjKsFDPkoIjPlEJ9b
         ZP9s5kNkz+HgVIPEeMZXfXt6+9eoW6YsyZcQo5UwEE7xS+NxSoyf2izxMZJSXA6V6IgS
         HEVonGKeazGdHY+mTi+cd6LUvso5kDne1Z2T4FO25MHZqfS35v5f3TbJANJe8ROSVPSU
         p93sB1beUU/x+ikiBM+n8ZknIgD/7zLdUShyznvXEEyIttTJwCwbtyVf2l1VBA00i/Tx
         1D3bCQ0tg3ZQ+2PJSQtnt4xBk3LJV/e1V1QLUo1gNW2LVUJF8gZL+XPHROqrpZxrqXqE
         FtEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Zys7zsjkt1m0RnQUfslYJUalywAfCs8j/JmRSdhUUts=;
        b=FO71JvyR1zjNr2rPGsHb+rrAzOfogPEH0xm5mQPRUIDMJRwVZX8Zb46YAEL6DGU75p
         rzhRQlRvDhz3ERn7N/VHk4eCHwM2T3cEsWFS0v3LqxsLsm9QTqrLnQUR8PFqah6e8AbW
         15mO8KAoBN8OM1g/8Wlr50KJeD93s4cHZCPw9GYFyjFiH2s4L2IGyoAGW/7sbEWzsKml
         sxsgNkEmw5Rd3jeO2ZebE53/TM/3o12Hm4+N4QjyNXkZ3AaNxHbgznP5nSYAdjd4ihp0
         YSaZ72W16NYd3hutjf+oHM9nyN4NXghCUkqcrN5xXTQXgS9gyg9Zzo8s3H1N7C19hJfo
         cmPg==
X-Gm-Message-State: APjAAAVEyD1zjV4ERaNRsBnS2fd3s0hRPjp3Xw/JdTCq2KGdSicgMASK
        RYKUHK2BYBciptB2T/xPDhLjRRGLBm8=
X-Google-Smtp-Source: APXvYqxjMWstOXxnYtQbaq7zg14WId27aS+0GcKiP3VguPC8qQ7u1OVcUgaDWhO5t1JgL71YqfNT4Q==
X-Received: by 2002:ad4:496f:: with SMTP id p15mr1182216qvy.191.1574867935472;
        Wed, 27 Nov 2019 07:18:55 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.50])
        by smtp.gmail.com with ESMTPSA id i4sm2380813qki.45.2019.11.27.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 07:18:54 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D386C40D3E; Wed, 27 Nov 2019 12:18:52 -0300 (-03)
Date:   Wed, 27 Nov 2019 12:18:52 -0300
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 2/2] perf script: Fix invalid LBR/binary mismatch error
Message-ID: <20191127151852.GH22719@kernel.org>
References: <20191127095631.15663-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127095631.15663-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 27, 2019 at 11:56:31AM +0200, Adrian Hunter escreveu:
> The 'len' returned by grab_bb() includes an extra MAXINSN bytes to allow
> for the last instruction, so the the final 'offs' will not be 'len'.
> Fix the error condition logic accordingly.
> 
> Before:
> 
>   $ perf record -e '{intel_pt//,cpu/mem_inst_retired.all_loads,aux-sample-size=8192/pp}:u' grep -rqs jhgjhg /boot
>   [ perf record: Woken up 19 times to write data ]
>   [ perf record: Captured and wrote 2.274 MB perf.data ]
>   $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
>             grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
>         bmexec+2485:
>         00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
>         00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
>         00005641d5806bd6                        add %rdi, %rax
>         00005641d5806bd9                        movzxb  -0x1(%rax), %edx
>         00005641d5806bdd                        cmp %rax, %r14
>         00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
>         mismatch of LBR data and executable
>         00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi
> 
> After:
> 
>   $ perf script -F +brstackinsn --xed --itrace=i1usl100 | head
>             grep 13759 [002]  8091.310257:       1862                                        instructions:uH:      5641d58069eb bmexec+0x86b (/bin/grep)
>         bmexec+2485:
>         00005641d5806b35                        jnz 0x5641d5806bd0              # MISPRED
>         00005641d5806bd0                        movzxb  (%r13,%rdx,1), %eax
>         00005641d5806bd6                        add %rdi, %rax
>         00005641d5806bd9                        movzxb  -0x1(%rax), %edx
>         00005641d5806bdd                        cmp %rax, %r14
>         00005641d5806be0                        jnb 0x5641d58069c0              # MISPRED
>         00005641d58069c0                        movzxb  (%r13,%rdx,1), %edi
>         00005641d58069c6                        add %rax, %rdi

Thanks, applied,

- Arnaldo
 
> Reported-by: Andi Kleen <ak@linux.intel.com>
> Fixes: e98df280bc2a ("perf script brstackinsn: Fix recovery from LBR/binary mismatch")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/builtin-script.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index e8db26b9b29e..e2406b291c1c 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -1126,7 +1126,7 @@ static int perf_sample__fprintf_brstackinsn(struct perf_sample *sample,
>  				insn++;
>  			}
>  		}
> -		if (off != (unsigned)len)
> +		if (off != end - start)
>  			printed += fprintf(fp, "\tmismatch of LBR data and executable\n");
>  	}
>  
> -- 
> 2.17.1

-- 

- Arnaldo
