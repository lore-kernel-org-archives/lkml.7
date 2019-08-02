Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A180C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67B332086A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564727668;
	bh=ndfRnwEPjNTMguRr/JEEwS9tJ5BdTF6DVhKBYKbVVao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EpW69caW0R2fh92zPdL5+b7t/DRHkVrn/TrRunPqkWWoloXYuTQnqbY46cJJA94gP
	 FbiWeWFiNx1ekEFcfSak6+iQHePuEhUstLeF7I0C6cvpDmISbgAVbFXA0kQcCvPBzp
	 obru5mwyNeowUH7RZQH/mvBKBqn4qCxOtFWYOv9s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbfHBGe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:34:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:56630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387789AbfHBGe0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:34:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AE922073D;
        Fri,  2 Aug 2019 06:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564727665;
        bh=ndfRnwEPjNTMguRr/JEEwS9tJ5BdTF6DVhKBYKbVVao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vUKMydQw2GfwigjUfYJzxeWLjbhwiRGiuSXRZwkrEfyh8PBxobr6XgP+oQBX+uoZi
         25kgvhUpDKL/kUN/H73h8paLI+CkDVTKfR0EkDaO7OHii4BPFKX35IDPTaowat42Ia
         deSr6DQuyaVZJKLtJNnC+6LkaNfIKhostFK0rfGU=
Date:   Fri, 2 Aug 2019 08:34:23 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "boqun.feng" <boqun.feng@gmail.com>,
        kimbrownkd <kimbrownkd@gmail.com>
Subject: Re: [PATCH 1/1] genirq: Properly pair kobject_del with kobject_add
Message-ID: <20190802063423.GA12360@kroah.com>
References: <1564703564-4116-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564703564-4116-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 11:53:53PM +0000, Michael Kelley wrote:
> If alloc_descs fails before irq_sysfs_init has run, free_desc in the
> cleanup path will call kobject_del even though the kobject has not
> been added with kobject_add. Fix this by making the call to
> kobject_del conditional on whether irq_sysfs_init has run.
> 
> This problem surfaced because commit aa30f47cf666
> ("kobject: Add support for default attribute groups to kobj_type")
> makes kobject_del stricter about pairing with kobject_add. If the
> pairing is incorrrect, a WARNING and backtrace occur in
> sysfs_remove_group because there is no parent.
> 
> Fixes: ecb3f394c5db ("genirq: Expose interrupt information through sysfs")
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  kernel/irq/irqdesc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 9484e88..5447760 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -438,7 +438,8 @@ static void free_desc(unsigned int irq)
>  	 * The sysfs entry must be serialized against a concurrent
>  	 * irq_sysfs_init() as well.
>  	 */
> -	kobject_del(&desc->kobj);
> +	if (irq_kobj_base)
> +		kobject_del(&desc->kobj);

But now you leak the memory of desc as there is no chance it could be
freed, because the kobject release function is never called :(

Relying on irq_kobj_bas to be present or not seems like an odd test
here.

thanks,

greg k-h
