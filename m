Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28CBC432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42F521783
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 17:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfKRRNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 12:13:45 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:47408 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 12:13:44 -0500
Received: from [167.98.27.226] (helo=[10.35.5.173])
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1iWkas-0003iP-CR; Mon, 18 Nov 2019 17:13:42 +0000
Subject: Re: [PATCH] ELF: warn if process starts with executable stack
To:     Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        security@kernel.org
References: <20191118145114.GA9228@avx2>
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
Message-ID: <1981366e-93d7-79bd-749f-d5d08d689a52@codethink.co.uk>
Date:   Mon, 18 Nov 2019 17:13:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191118145114.GA9228@avx2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/11/2019 14:51, Alexey Dobriyan wrote:
> PT_GNU_STACK is fail open design, at least warn people that something
> isn't right.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>   fs/exec.c |    7 +++++++
>   1 file changed, 7 insertions(+)
> 
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -762,6 +762,13 @@ int setup_arg_pages(struct linux_binprm *bprm,
>   		goto out_unlock;
>   	BUG_ON(prev != vma);
>   

it might be worth to use:
  if (IS_ENABLED(CONFIG_MMU) && vm_flags & VM_EXEC) {

instead of the #ifdef


> +#ifdef CONFIG_MMU
> +	if (vm_flags & VM_EXEC) {
> +		pr_warn_once("process '%s'/%u started with executable stack\n",
> +			     current->comm, current->pid);
> +	}
> +#endif
> +
>   	/* Move stack pages down in memory. */
>   	if (stack_shift) {
>   		ret = shift_arg_pages(vma, stack_shift);
> 


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html
