Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 020B5C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77939206DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 13:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbfIENj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 09:39:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55768 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727143AbfIENj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 09:39:56 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 657C63081D8F;
        Thu,  5 Sep 2019 13:39:56 +0000 (UTC)
Received: from localhost (ovpn-12-28.pek2.redhat.com [10.72.12.28])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1FD7D6092F;
        Thu,  5 Sep 2019 13:39:53 +0000 (UTC)
Date:   Thu, 5 Sep 2019 21:39:50 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kaslr: simplify the code in mem_avoid_memmap()
Message-ID: <20190905133950.GA14840@MiWiFi-R3L-srv>
References: <1566483962-10046-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566483962-10046-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Thu, 05 Sep 2019 13:39:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/22/19 at 10:26am, Qian Cai wrote:
> If "i >= MAX_MEMMAP_REGIONS" already when entering mem_avoid_memmap(),
> even without the return statement the loop will not run anyway. The only
> time it needs to set "memmap_too_large = true" in this situation is
> "memmap_too_large" is "false" currently. Hence, the code could be
> simplified.

It seems not improved much. If far more than MAX_MEMMAP_REGIONS 'memmap='
specified, the if condition checking looks more straightforward. Anyway,
it's not simplifying much, in my opinion.

Thanks
Baoquan

> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  arch/x86/boot/compressed/kaslr.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> index 2e53c056ba20..35c6942fb95b 100644
> --- a/arch/x86/boot/compressed/kaslr.c
> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -176,9 +176,6 @@ static void mem_avoid_memmap(char *str)
>  {
>  	static int i;
>  
> -	if (i >= MAX_MEMMAP_REGIONS)
> -		return;
> -
>  	while (str && (i < MAX_MEMMAP_REGIONS)) {
>  		int rc;
>  		unsigned long long start, size;
> @@ -206,7 +203,7 @@ static void mem_avoid_memmap(char *str)
>  	}
>  
>  	/* More than 4 memmaps, fail kaslr */
> -	if ((i >= MAX_MEMMAP_REGIONS) && str)
> +	if (i >= MAX_MEMMAP_REGIONS && !memmap_too_large)
>  		memmap_too_large = true;
>  }
>  
> -- 
> 1.8.3.1
> 
