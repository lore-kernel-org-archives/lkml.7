Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5090CC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D04206DD
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 02:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfCFCYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Mar 2019 21:24:18 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39032 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726347AbfCFCYR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Mar 2019 21:24:17 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id F15424AA157B39F7CD91;
        Wed,  6 Mar 2019 10:24:15 +0800 (CST)
Received: from [127.0.0.1] (10.177.31.96) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Mar 2019
 10:24:10 +0800
Subject: Re: [PATCH] appletalk: Fix compile regression
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
References: <20190305132430.3821758-1-arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>
From:   YueHaibing <yuehaibing@huawei.com>
Message-ID: <9d4884eb-eee7-334f-801c-e3089d296308@huawei.com>
Date:   Wed, 6 Mar 2019 10:24:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190305132430.3821758-1-arnd@arndb.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/3/5 21:24, Arnd Bergmann wrote:
> A bugfix just broke compilation of appletalk when CONFIG_SYSCTL
> is disabled:
> 
> In file included from net/appletalk/ddp.c:65:
> net/appletalk/ddp.c: In function 'atalk_init':
> include/linux/atalk.h:164:34: error: expected expression before 'do'
>  #define atalk_register_sysctl()  do { } while(0)
>                                   ^~
> net/appletalk/ddp.c:1934:7: note: in expansion of macro 'atalk_register_sysctl'
>   rc = atalk_register_sysctl();
> 
> This is easier to avoid by using conventional inline functions
> as stubs rather than macros. The header already has inline
> functions for other purposes, so I'm changing over all the
> macros for consistency.
> 

Thank you for fix this


> Fixes: 6377f787aeb9 ("appletalk: Fix use-after-free in atalk_proc_exit")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/atalk.h | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/atalk.h b/include/linux/atalk.h
> index 5a90f28d5ff2..d5cfc0b15b76 100644
> --- a/include/linux/atalk.h
> +++ b/include/linux/atalk.h
> @@ -161,16 +161,26 @@ extern int sysctl_aarp_resolve_time;
>  extern int atalk_register_sysctl(void);
>  extern void atalk_unregister_sysctl(void);
>  #else
> -#define atalk_register_sysctl()		do { } while(0)
> -#define atalk_unregister_sysctl()	do { } while(0)
> +static inline int atalk_register_sysctl(void)
> +{
> +	return 0;
> +}
> +static inline void atalk_unregister_sysctl(void)
> +{
> +}
>  #endif
>  
>  #ifdef CONFIG_PROC_FS
>  extern int atalk_proc_init(void);
>  extern void atalk_proc_exit(void);
>  #else
> -#define atalk_proc_init()	({ 0; })
> -#define atalk_proc_exit()	do { } while(0)
> +static inline int atalk_proc_init(void)
> +{
> +	return 0;
> +}
> +static inline void atalk_proc_exit(void)
> +{
> +}
>  #endif /* CONFIG_PROC_FS */
>  
>  #endif /* __LINUX_ATALK_H__ */
> 

