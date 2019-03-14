Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E798C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09320854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfCNWCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:02:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:18400 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbfCNWCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:02:34 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x2EM2Ruo092182;
        Fri, 15 Mar 2019 07:02:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Fri, 15 Mar 2019 07:02:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.8] (softbank126126163036.bbtec.net [126.126.163.36])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x2EM2Msb092156
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 15 Mar 2019 07:02:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH 1/2] elf: simpler check for -EEXIST
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>
References: <20190314204208.GA18143@avx2>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <52458645-823f-825e-660f-7b01d5dbb979@i-love.sakura.ne.jp>
Date:   Fri, 15 Mar 2019 07:02:23 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190314204208.GA18143@avx2>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/03/15 5:42, Alexey Dobriyan wrote:
> 	PTR_ERR((void *)map_addr) == -EEXIST
> 
> is a very complicated way of doing the obvious.

Michal suggested me to explicitly use PTR_ERR() for documentation purpose in
a reply mail to https://lkml.kernel.org/r/20180418115546.GZ17484@dhcp22.suse.cz .

> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  fs/binfmt_elf.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -375,8 +375,7 @@ static unsigned long elf_map(struct file *filep, unsigned long addr,
>  	} else
>  		map_addr = vm_mmap(filep, addr, size, prot, type, off);
>  
> -	if ((type & MAP_FIXED_NOREPLACE) &&
> -	    PTR_ERR((void *)map_addr) == -EEXIST)
> +	if ((type & MAP_FIXED_NOREPLACE) && map_addr == -EEXIST)
>  		pr_info("%d (%s): Uhuuh, elf segment at %px requested but the memory is mapped already\n",
>  			task_pid_nr(current), current->comm, (void *)addr);
>  
> 

