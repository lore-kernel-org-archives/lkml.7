Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FEC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7108A2173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 14:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VjrIjovF";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aM0Bw8VT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfC1Og2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 10:36:28 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37804 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbfC1Og2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 10:36:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 794F26087A; Thu, 28 Mar 2019 14:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553783787;
        bh=sBRUGr4QtW5Bk45iBhvdyNhyKiNESDR7U1nKNggJRBY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=VjrIjovFaFO/R0KsbsHXIRnZ0U4mmd9WnJYj1p8oTwp82Xp734rxxiDR64ihQZcvN
         V+IMrL9t+OJ84GBn4RhtKB8NpvRg/1jXpMVoBIYNgcMDoZPOKVActWTdtxo3YkYpY1
         wgSgcaSvR7Q2k3oMGBZgpvcuDpO1GEo01W7Tx2B0=
Received: from [10.204.79.83] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6DF0F6053B;
        Thu, 28 Mar 2019 14:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1553783778;
        bh=sBRUGr4QtW5Bk45iBhvdyNhyKiNESDR7U1nKNggJRBY=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=aM0Bw8VTAw5R9vY58a89Ym3SdRH21TQln4tOklIUVrmdNmXXE2xCgE1oIRC5mEeK7
         X/eXoB8+UpQhr4CsH3EhABpE6NnmCBNH92y99JOeQLbKRft2org2zQnyJmxFLP/YVG
         2r0d+B1YH1h/hHPvByXVi5AhMCvF0l/NY1n+xpco=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6DF0F6053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gYnBmOiBicGZ0b29sOiBjb252ZXJ0IOKAmGNvbnN0?=
 =?UTF-8?Q?_char_*=e2=80=99_type_into_=27char_*=27_in_assignment?=
To:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, jakub.kicinski@netronome.com,
        df@google.com, quentin.monnet@netronome.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190328141652.wssqboyekxmp6tkw@yubo-2>
From:   Mukesh Ojha <mojha@codeaurora.org>
Message-ID: <9846e3b1-1878-990a-61ef-464eb71fe048@codeaurora.org>
Date:   Thu, 28 Mar 2019 20:06:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190328141652.wssqboyekxmp6tkw@yubo-2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/28/2019 7:46 PM, Bo YU wrote:
> When compiling with check flag: make -C tools/bpf/bpftool/
> gcc will warning:
>
> jit_disasm.c:119:29: warning: assignment discards ‘const’ qualifier 
> from pointer target type [-Wdiscarded-qualifiers]
>   info.disassembler_options = disassembler_options;
>
> So convert 'const char *' type into 'char *' to fix the warning.
>
> Fixes:3ddeac6705aba(tools: bpftool: use 4 context mode for the NFP 
> disasm)
> Signed-off-by: Bo YU <tsu.yubo@gmail.com>


Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

-Mukesh

> ---
> tools/bpf/bpftool/jit_disasm.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpftool/jit_disasm.c 
> b/tools/bpf/bpftool/jit_disasm.c
> index 3ef3093560ba..40b46e46454a 100644
> --- a/tools/bpf/bpftool/jit_disasm.c
> +++ b/tools/bpf/bpftool/jit_disasm.c
> @@ -116,7 +116,7 @@ void disasm_print_insn(unsigned char *image, 
> ssize_t len, int opcodes,
>     info.arch = bfd_get_arch(bfdf);
>     info.mach = bfd_get_mach(bfdf);
>     if (disassembler_options)
> -        info.disassembler_options = disassembler_options;
> +        info.disassembler_options = (char *)disassembler_options;
>     info.buffer = image;
>     info.buffer_length = len;
>
