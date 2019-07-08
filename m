Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC85C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3B020665
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 06:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfGHGeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 02:34:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:36798 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbfGHGeZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 02:34:25 -0400
Received: from [172.16.25.169]
        by relay.sw.ru with esmtp (Exim 4.92)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1hkNE7-0007Z0-NZ; Mon, 08 Jul 2019 09:34:15 +0300
Subject: Re: [PATCH] mm/ksm: One function call less in __ksm_enter()
To:     Markus Elfring <Markus.Elfring@web.de>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <997c8ec3-9af8-3db0-24dc-cd99fe3efe14@web.de>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <64187a86-e704-140a-ec86-817c14db1812@virtuozzo.com>
Date:   Mon, 8 Jul 2019 09:34:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <997c8ec3-9af8-3db0-24dc-cd99fe3efe14@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2019 17:16, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jul 2019 16:02:26 +0200
> 
> Avoid an extra function call by using a ternary operator instead of
> a conditional statement.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  mm/ksm.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 3dc4346411e4..7934bab8ceae 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2521,10 +2521,10 @@ int __ksm_enter(struct mm_struct *mm)
>  	 * scanning cursor, otherwise KSM pages in newly forked mms will be
>  	 * missed: then we might as well insert at the end of the list.
>  	 */
> -	if (ksm_run & KSM_RUN_UNMERGE)
> -		list_add_tail(&mm_slot->mm_list, &ksm_mm_head.mm_list);
> -	else
> -		list_add_tail(&mm_slot->mm_list, &ksm_scan.mm_slot->mm_list);
> +	list_add_tail(&mm_slot->mm_list,
> +		      ksm_run & KSM_RUN_UNMERGE
> +		      ? &ksm_mm_head.mm_list
> +		      : &ksm_scan.mm_slot->mm_list);

Despite coccinelle warnings, I'm not sure this patch does not make the readability worse...

>  	spin_unlock(&ksm_mmlist_lock);
> 
>  	set_bit(MMF_VM_MERGEABLE, &mm->flags);
