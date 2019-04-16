Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F9BC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D2A920675
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 09:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="l9v9kb6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728908AbfDPJ6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 05:58:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728230AbfDPJ6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 05:58:54 -0400
Received: from zn.tnic (p200300EC2F0D6900D0FA583685BBD9D6.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:6900:d0fa:5836:85bb:d9d6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 20EE01EC0104;
        Tue, 16 Apr 2019 11:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1555408732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1MZxvXYuVs+fI0+BvuKgIZlp+pBnyc+2rhlviDrQ/mE=;
        b=l9v9kb6IMVKKX7RToUNNfOhNALaqicCd5VUSgpddhrtlIONM20Y1muZKrI0Yhbd4Yqhbcg
        pYsubgA96Rb4HaM/lRKpqUEku4qdDIpSa15wmQ0iHjoSMuhcYCSrQHuyFN2VTyl1iaipHb
        zSfymjr+6TWV08x5sFcmCY1CaA6WKdA=
Date:   Tue, 16 Apr 2019 11:58:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] ras: close the race condition with timer
Message-ID: <20190416095852.GA31772@zn.tnic>
References: <20190416012001.5338-1-xiyou.wangcong@gmail.com>
 <20190416012001.5338-2-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190416012001.5338-2-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 06:20:01PM -0700, Cong Wang wrote:
> cec_timer_fn() is a timer callback which reads ce_arr.array[]
> and updates its decay values. Elements could be added to or
> removed from this global array in parallel, although the array
> itself will not grow or shrink. del_lru_elem_unlocked() uses
> FULL_COUNT() as a key to find a right element to remove,
> which could be affected by the parallel timer.
> 
> Fix this by converting the mutex to a spinlock and holding it
> inside the timer.
> 
> Fixes: 011d82611172 ("RAS: Add a Corrected Errors Collector")
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  drivers/ras/cec.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
> index 61332c9aab5a..a82c9d08d47a 100644
> --- a/drivers/ras/cec.c
> +++ b/drivers/ras/cec.c
> @@ -117,7 +117,7 @@ static struct ce_array {
>  	};
>  } ce_arr;
>  
> -static DEFINE_MUTEX(ce_mutex);
> +static DEFINE_SPINLOCK(ce_lock);

Nah, pls keep the simplicity here by retaining the mutex. Use a
workqueue instead to queue the spring cleaning from IRQ context and then
do it when back in preemptible context.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
