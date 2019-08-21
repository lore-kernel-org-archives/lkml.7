Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB980C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5642082F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 12:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfHUMfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 08:35:32 -0400
Received: from www62.your-server.de ([213.133.104.62]:42416 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfHUMfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 08:35:32 -0400
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0Ppg-0007MX-QA; Wed, 21 Aug 2019 14:35:20 +0200
Received: from [2a02:120b:2c12:c120:71a0:62dd:894c:fd0e] (helo=pc-66.home)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1i0Ppg-000PkR-Hr; Wed, 21 Aug 2019 14:35:20 +0200
Subject: Re: [PATCH bpf-next v2 0/3] xdpsock: allow mmap2 usage for 32bits
To:     Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>,
        magnus.karlsson@intel.com, bjorn.topel@intel.com
Cc:     davem@davemloft.net, hawk@kernel.org, john.fastabend@gmail.com,
        jakub.kicinski@netronome.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, xdp-newbies@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlemon@flugsvamp.com, yhs@fb.com,
        andrii.nakryiko@gmail.com
References: <20190815121356.8848-1-ivan.khoronzhuk@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <95fb201c-1623-149b-a72e-ed4860f742e1@iogearbox.net>
Date:   Wed, 21 Aug 2019 14:35:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190815121356.8848-1-ivan.khoronzhuk@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.3/25548/Wed Aug 21 10:27:18 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/15/19 2:13 PM, Ivan Khoronzhuk wrote:
> This patchset contains several improvements for af_xdp socket umem
> mappings for 32bit systems. Also, there is one more patch outside of
> this series that on linux-next tree and related to mmap2 af_xdp umem
> offsets: "mm: mmap: increase sockets maximum memory size pgoff for 32bits"
> https://lkml.org/lkml/2019/8/12/549
> 
> Based on bpf-next/master
> 
> Prev: https://lkml.org/lkml/2019/8/13/437
> 
> v2..v1:
> 	- replaced "libbpf: add asm/unistd.h to xsk to get __NR_mmap2" on
> 	 "libbpf: use LFS (_FILE_OFFSET_BITS) instead of direct mmap2
> 	 syscall"
> 	- use vmap along with page_address to avoid overkill
> 	- define mmap syscall trace5 for mmap if defined
> 
> Ivan Khoronzhuk (3):
>    libbpf: use LFS (_FILE_OFFSET_BITS) instead of direct mmap2 syscall
>    xdp: xdp_umem: replace kmap on vmap for umem map
>    samples: bpf: syscal_nrs: use mmap2 if defined
> 
>   net/xdp/xdp_umem.c         | 36 +++++++++++++++++++++++-----
>   samples/bpf/syscall_nrs.c  |  6 +++++
>   samples/bpf/tracex5_kern.c | 13 ++++++++++
>   tools/lib/bpf/Makefile     |  1 +
>   tools/lib/bpf/xsk.c        | 49 +++++++++++---------------------------
>   5 files changed, 64 insertions(+), 41 deletions(-)
> 

Applied, and fixed up typo in last one's subject, thanks!
