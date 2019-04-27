Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC26EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFEB2087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 10:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfD0Kmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 06:42:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48804 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725871AbfD0Kmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 06:42:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2CF29368B1;
        Sat, 27 Apr 2019 10:42:52 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.khw1.lab.eng.bos.redhat.com [10.16.200.63])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D44D60C82;
        Sat, 27 Apr 2019 10:42:51 +0000 (UTC)
Subject: Re: [-next] system hangs likely due to "modules: Only return -EEXIST
 for modules that have finished loading"
To:     Heiko Carstens <heiko.carstens@de.ibm.com>
Cc:     Jessica Yu <jeyu@kernel.org>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Cathy Avery <cavery@redhat.com>
References: <20190426130736.GB8646@osiris>
 <d4d75ad1-e193-c230-1edc-a93db2b068d7@redhat.com>
 <20190426150741.GD8646@osiris> <20190426160956.GA3827@linux-8ccs>
 <2e047a7e-bf08-be8c-bdd0-429464fa133d@redhat.com>
 <52c293e9-ddfa-426a-a8f1-2106e250e78d@redhat.com>
 <f74996cb-3e0a-ab23-00b9-85ac782583d1@redhat.com>
 <20190427102440.GA28889@osiris>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <6a69074a-e913-3b67-feef-9b62a7400f8a@redhat.com>
Date:   Sat, 27 Apr 2019 06:42:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190427102440.GA28889@osiris>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Sat, 27 Apr 2019 10:42:52 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/19 6:24 AM, Heiko Carstens wrote:

> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 410eeb7e4f1d..48748cfec991 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -3585,6 +3585,7 @@ again:
>  					       finished_loading(mod->name));
>  			if (err)
>  				goto out_unlocked;
> +			cond_resched();
>  			goto again;
>  		}
>  		err = -EEXIST;
> 

Heiko, I'm testing on 2-cpu systems which appear to show the problem ~10% of the
time.  On another system I backed out my original patch to set a baseline, and
noticed that occasionally the time to boot the system doubles from ~4 seconds to
9 seconds.  Is this something you're also concerned with?

P.
