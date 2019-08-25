Return-Path: <SRS0=9baz=WV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681B9C3A5A1
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43CAD20674
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Aug 2019 21:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbfHYVTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Aug 2019 17:19:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44901 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbfHYVTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Aug 2019 17:19:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id e24so13244339ljg.11
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2019 14:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XAGbIDdFga1X2HlsM3DdDuO+5VUileKxN3AsXn36/xY=;
        b=PdlCHmffCCrSZO/JGd1pD4URjz/3MmNUpLc6+6cifx0wYNMMnIc4ihsxv6wmWfxs+N
         Zam7b7QA6yeDZtjWyUvyI/kklrcm+HF00dzCnrT6eECoPwiDTIbgZLcbL2M4euUuLSNU
         01j8zxJ91qhvyobvma2SSYWxHXIdVbEU15arTjN85+6+mfTiCtH5JVm5lfUIZJlS3BHh
         50ThOoqpoLT44CWYCoiXA0H2ZRgCHdvkmphZ57kkmTcpimARzWFqNmcFltYKjDTr8pXl
         +KT5I/1k/QuzC5P+seofYK/OEQf9Z/VvqY1l2DjjSG7HdtRwplTu1PIt4a0ElDj2x7BL
         dm+Q==
X-Gm-Message-State: APjAAAV2AR/txDOUZ5CqUNg1HM9vcONsSxcwtV+ouRxvzS3x02KolVNt
        9ODdVE631VCfQJutaMKzngMdwOX4
X-Google-Smtp-Source: APXvYqy8P4V6TzHzyfGdKLQHZ8Clh8NRX1pSFmfp2r760J2XBalgrBjfT6OhBC7Fdns2DUts2xzEQQ==
X-Received: by 2002:a2e:875a:: with SMTP id q26mr8656162ljj.107.1566767975775;
        Sun, 25 Aug 2019 14:19:35 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id f28sm1516386lfp.28.2019.08.25.14.19.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Aug 2019 14:19:35 -0700 (PDT)
Subject: Re: [PATCH] scripts: coccinelle: check for !(un)?likely usage
From:   Denis Efremov <efremov@linux.com>
To:     Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
Cc:     linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Message-ID: <25032fea-bda4-a491-def3-05bb5f569875@linux.com>
Date:   Mon, 26 Aug 2019 00:19:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it's incorrect to say so in general. For example, on x86/64:
> 
> $ make mrproper
> $ make allyesconfig
> $ make && mv vmlinux vmlinux-000
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/misc/unlikely.cocci | patch -p1
> $ make 
> $ ./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
> add/remove: 0/0 grow/shrink: 3/4 up/down: 41/-35 (6)
> Function                                     old     new   delta
> dpaa2_io_service_rearm                       357     382     +25
> intel_pmu_hw_config                         1277    1285      +8
> get_sigframe.isra.constprop                 1657    1665      +8
> csum_partial_copy_from_user                  605     603      -2
> wait_consider_task                          3807    3797     -10
> __acct_update_integrals                      384     373     -11
> pipe_to_sendpage                             459     447     -12
> Total: Before=312759461, After=312759467, chg +0.00%
> 
> It definitely influence the way the compiler optimizes the code.  

Small addition:

Results with allyesconfig and KCOV, KASAN, KUBSAN, FTRACE, TRACE_BRANCH_PROFILING,
PROFILE_ALL_BRANCHES disabled:
./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
add/remove: 0/0 grow/shrink: 2/3 up/down: 22/-22 (0)
Function                                     old     new   delta
i40e_xmit_xdp_ring                           457     477     +20
__acct_update_integrals                      127     129      +2
csum_partial_copy_from_user                  208     207      -1
dpaa2_io_service_rearm                       180     177      -3
wait_consider_task                          1338    1320     -18

For defconfig:
./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux 
add/remove: 0/0 grow/shrink: 3/1 up/down: 16/-5 (11)
Function                                     old     new   delta
do_signal                                   1513    1521      +8
wait_consider_task                          2151    2157      +6
__acct_update_integrals                      127     129      +2
csum_partial_copy_from_user                  223     218      -5

Denis
