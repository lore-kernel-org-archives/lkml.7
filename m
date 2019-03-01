Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB57C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C6DF20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 23:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfCAXHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 18:07:04 -0500
Received: from www62.your-server.de ([213.133.104.62]:60398 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfCAXHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 18:07:04 -0500
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrF7-000444-CH; Sat, 02 Mar 2019 00:07:01 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzrF7-000Cyr-4L; Sat, 02 Mar 2019 00:07:01 +0100
Subject: Re: [PATCH] MIPS: eBPF: Fix icache flush end address
To:     Paul Burton <paul.burton@mips.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20190301225743.8632-1-paul.burton@mips.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <6319f997-bc83-5515-4b3b-a87f57c65db3@iogearbox.net>
Date:   Sat, 2 Mar 2019 00:07:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190301225743.8632-1-paul.burton@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2019 11:58 PM, Paul Burton wrote:
> The MIPS eBPF JIT calls flush_icache_range() in order to ensure the
> icache observes the code that we just wrote. Unfortunately it gets the
> end address calculation wrong due to some bad pointer arithmetic.
> 
> The struct jit_ctx target field is of type pointer to u32, and as such
> adding one to it will increment the address being pointed to by 4 bytes.
> Therefore in order to find the address of the end of the code we simply
> need to add the number of 4 byte instructions emitted, but we mistakenly
> add the number of instructions multiplied by 4. This results in the call
> to flush_icache_range() operating on a memory region 4x larger than
> intended, which is always wasteful and can cause crashes if we overrun
> into an unmapped page.
> 
> Fix this by correcting the pointer arithmetic to remove the bogus
> multiplication, and use braces to remove the need for a set of brackets
> whilst also making it obvious that the target field is a pointer.
> 
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Fixes: b6bd53f9c4e8 ("MIPS: Add missing file for eBPF JIT.")
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: netdev@vger.kernel.org
> Cc: bpf@vger.kernel.org
> Cc: linux-mips@vger.kernel.org
> Cc: stable@vger.kernel.org # v4.13+

Good catch, applied to bpf, thanks!
