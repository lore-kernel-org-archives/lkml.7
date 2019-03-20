Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E20C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7EF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 14:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbfCTOH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 10:07:28 -0400
Received: from www62.your-server.de ([213.133.104.62]:51188 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTOH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 10:07:27 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6bsH-0007ia-T6; Wed, 20 Mar 2019 15:07:22 +0100
Received: from [2a02:120b:c3fc:feb0:dda7:bd28:a848:50e2] (helo=linux.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6bsH-000Kmj-Ma; Wed, 20 Mar 2019 15:07:21 +0100
Subject: Re: [PATCH v2 3/3] MIPS: eBPF: Initial eBPF support for MIPS32
 architecture.
To:     Hassan Naveed <hnaveed@wavecomp.com>,
        Paul Burton <pburton@wavecomp.com>
Cc:     "kafai@fb.com" <kafai@fb.com>,
        "songliubraving@fb.com" <songliubraving@fb.com>,
        "yhs@fb.com" <yhs@fb.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:MIPS" <linux-mips@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190312224706.6121-1-hnaveed@wavecomp.com>
 <20190312224706.6121-3-hnaveed@wavecomp.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <98323a41-2851-d000-c928-242d055a5bc1@iogearbox.net>
Date:   Wed, 20 Mar 2019 15:07:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190312224706.6121-3-hnaveed@wavecomp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25394/Wed Mar 20 08:52:02 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/12/2019 11:48 PM, Hassan Naveed wrote:
> Currently MIPS32 supports a JIT for classic BPF only, not extended BPF.
> This patch adds JIT support for extended BPF on MIPS32, so code is
> actually JIT'ed instead of being only interpreted. Instructions with
> 64-bit operands are not supported at this point.
> We can delete classic BPF because the kernel will translate classic BPF
> programs into extended BPF and JIT them, eliminating the need for
> classic BPF.
> 
> Signed-off-by: Hassan Naveed <hnaveed@wavecomp.com>

Nice! Did you check BPF test suite (lib/test_bpf.ko) that both before/after
the same number of cBPF programs could be JITed?

Please also follow-up to update Documentation/sysctl/net.txt, bpf_jit_enable
section, and adding yourself as co-maintainer for 'BPF JIT for MIPS' wouldn't
hurt either if Paul would be good with that, too.

Any plans on completing eBPF support for mips32?

Thanks,
Daniel
