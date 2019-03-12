Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C953C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033752147C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:20:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727597AbfCLIUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:20:47 -0400
Received: from relay.sw.ru ([185.231.240.75]:53370 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726724AbfCLIUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:20:43 -0400
Received: from [172.16.24.21]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <vvs@virtuozzo.com>)
        id 1h3ceO-0003FS-Fi; Tue, 12 Mar 2019 11:20:40 +0300
Subject: Re: [PATCH] notifiers: double register detection
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <04127e71-4782-9bbb-fe5a-7c01e93a99b0@virtuozzo.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <70db0274-2dfc-8cd1-9e0b-74e035a089d6@virtuozzo.com>
Date:   Tue, 12 Mar 2019 11:20:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <04127e71-4782-9bbb-fe5a-7c01e93a99b0@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,
could you please pick up this patch?

Few years ago I investigated described problem, host was cycled because of notifier's list corruption.
I've prepared this patch applied it to OpenVZ kernel and sent this patch first time, but nobody commented it.
Later it helped us to detect similar problem on OpenVz kernel.

Mistakes with notifiers register can happen for example during subsystem initilazation
from different namespaces, or because of lost unregister in roll-back path on initialization failures.

Thank you,
	Vasily Averin

On 3/12/19 11:06 AM, Vasily Averin wrote:
> By design notifiers can be registerd once only,
> 2nd register attempt called by mistake silently corrupts notifiers list.
> 
> Proposed check cannot prevent described problem,
> however it allows to detect its reason quickly without coredump analyze.
> 
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
> ---
>  kernel/notifier.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/notifier.c b/kernel/notifier.c
> index 6196af8a8223..bfc95b3e4235 100644
> --- a/kernel/notifier.c
> +++ b/kernel/notifier.c
> @@ -22,6 +22,7 @@ static int notifier_chain_register(struct notifier_block **nl,
>  		struct notifier_block *n)
>  {
>  	while ((*nl) != NULL) {
> +		WARN_ONCE(((*nl) == n), "double register detected");
>  		if (n->priority > (*nl)->priority)
>  			break;
>  		nl = &((*nl)->next);
> 
