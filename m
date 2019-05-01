Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC50C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8350320656
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbfEAV0w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 17:26:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44642 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfEAV0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 17:26:51 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A49A93082A24;
        Wed,  1 May 2019 21:26:51 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3755678905;
        Wed,  1 May 2019 21:26:51 +0000 (UTC)
Subject: Re: [PATCH v3] kernel/module: Reschedule while waiting for modules to
 finish loading
To:     linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Arcari <darcari@redhat.com>
References: <20190430222207.3002-1-prarit@redhat.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <90e18809-2b70-52d8-00b3-9c16768db9ad@redhat.com>
Date:   Wed, 1 May 2019 17:26:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430222207.3002-1-prarit@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Wed, 01 May 2019 21:26:51 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/19 6:22 PM, Prarit Bhargava wrote:
> On a s390 z14 LAR with 2 cpus about stalls about 3% of the time while
> loading the s390_trng.ko module.
> 
> Add a reschedule point to the loop that waits for modules to complete
> loading.
> 
> v3: cleanup Fixes line.

Jessica, even with this additional patch there appears to be some other issues
in the module code that are causing significant delays in boot up on large
systems.

Please revert these fixes from linux-next & modules-next.  I apologize for the
extra work but I think it is for the best until I come up with a more complete &
better tested patch.

FWIW, the logic in the original patch is correct.  It's just that there's, as
Heiko discovered, some poor scheduling, etc., that is impacting the module
loading code after these changes.

Again, my apologies,

P.

> 
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Fixes: f9a75c1d717f ("modules: Only return -EEXIST for modules that have finished loading")
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: Jessica Yu <jeyu@kernel.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> ---
>  kernel/module.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 410eeb7e4f1d..48748cfec991 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3585,6 +3585,7 @@ static int add_unformed_module(struct module *mod)
>  					       finished_loading(mod->name));
>  			if (err)
>  				goto out_unlocked;
> +			cond_resched();
>  			goto again;
>  		}
>  		err = -EEXIST;
> 
