Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DKIM_ADSP_ALL,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 115A1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1FC620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfEGFFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:05:22 -0400
Received: from vulcan.natalenko.name ([104.207.131.136]:56392 "EHLO
        vulcan.natalenko.name" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfEGFFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:05:22 -0400
Received: from mail.natalenko.name (vulcan.natalenko.name [IPv6:fe80::5400:ff:fe0c:dfa0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 1765853D517;
        Tue,  7 May 2019 07:05:19 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 May 2019 07:05:18 +0200
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com, linux-kernel@vger.kernel.org,
        xdp-newbies@vger.kernel.org, valdis@vt.edu
Subject: Re: [oss-drivers] netronome/nfp/bpf/jit.c cannot be build with -O3
In-Reply-To: <87mujzutsw.fsf@netronome.com>
References: <673b885183fb64f1cbb3ed2387524077@natalenko.name>
 <87mujzutsw.fsf@netronome.com>
Message-ID: <4414f1798ea3c0f70128b7e4caa14edc@natalenko.name>
X-Sender: oleksandr@natalenko.name
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On 07.05.2019 00:01, Jiong Wang wrote:
> I guess it's because constant prop. Could you try the following change 
> to
> __emit_shift?
> 
> drivers/net/ethernet/netronome/nfp/bpf/jit.c
> __emit_shift:331
> -       if (sc == SHF_SC_L_SHF)
> +       if (sc == SHF_SC_L_SHF && shift)
>                 shift = 32 - shift;
> 
> emit_shf_indir is passing "0" as shift to __emit_shift which will
> eventually be turned into 32 and it was OK because we truncate to 
> 5-bit,
> but before truncation, it will overflow the shift mask.

Yup, it silences the error for me.

-- 
   Oleksandr Natalenko (post-factum)
