Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FF7C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84121841
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 11:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbfCULVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 07:21:33 -0400
Received: from www62.your-server.de ([213.133.104.62]:60962 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbfCULVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 07:21:33 -0400
Received: from [88.198.220.132] (helo=sslproxy03.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6vlK-0002DL-Tp; Thu, 21 Mar 2019 12:21:31 +0100
Received: from [178.197.248.24] (helo=linux.home)
        by sslproxy03.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h6vlK-0005Ow-L2; Thu, 21 Mar 2019 12:21:30 +0100
Subject: Re: [PATCH v2] bpf: do not restore dst_reg when cur_state is freed
To:     Xu Yu <xuyu@linux.alibaba.com>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <eec7905a71d207f7612e9d86e1bf59c43efc65a4.1553156792.git.xuyu@linux.alibaba.com>
 <ae7834dda12cb2a88dd8471132d6274a7d1ec5f0.1553161998.git.xuyu@linux.alibaba.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cbcf0c58-b15f-c82d-1274-1a7d17d75799@iogearbox.net>
Date:   Thu, 21 Mar 2019 12:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <ae7834dda12cb2a88dd8471132d6274a7d1ec5f0.1553161998.git.xuyu@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25395/Thu Mar 21 08:52:58 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/21/2019 11:00 AM, Xu Yu wrote:
> Syzkaller hit 'KASAN: use-after-free Write in sanitize_ptr_alu' bug.
> Call trace:
>   dump_stack+0xbf/0x12e
>   print_address_description+0x6a/0x280
>   kasan_report+0x237/0x360
>   sanitize_ptr_alu+0x85a/0x8d0
>   adjust_ptr_min_max_vals+0x8f2/0x1ca0
>   adjust_reg_min_max_vals+0x8ed/0x22e0
>   do_check+0x1ca6/0x5d00
>   bpf_check+0x9ca/0x2570
>   bpf_prog_load+0xc91/0x1030
>   __se_sys_bpf+0x61e/0x1f00
>   do_syscall_64+0xc8/0x550
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> Fault injection trace:
>   kfree+0xea/0x290
>   free_func_state+0x4a/0x60
>   free_verifier_state+0x61/0xe0
>   push_stack+0x216/0x2f0	          <- inject failslab
>   sanitize_ptr_alu+0x2b1/0x8d0
>   adjust_ptr_min_max_vals+0x8f2/0x1ca0
>   adjust_reg_min_max_vals+0x8ed/0x22e0
>   do_check+0x1ca6/0x5d00
>   bpf_check+0x9ca/0x2570
>   bpf_prog_load+0xc91/0x1030
>   __se_sys_bpf+0x61e/0x1f00
>   do_syscall_64+0xc8/0x550
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> When kzalloc() fails in push_stack(), free_verifier_state() will free
> current verifier state. As push_stack() returns, dst_reg was restored
> if ptr_is_dst_reg is false. However, as member of the cur_state, dst_reg
> is also freed, and error occurs when dereferencing dst_reg.
> 
> Simply fix it by testing ret of push_stack() before retoring dst_reg.
> 
> Signed-off-by: Xu Yu <xuyu@linux.alibaba.com>

Applied, thanks!
