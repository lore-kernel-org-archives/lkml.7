Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBC9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFAB20854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 07:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfCYHaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:30:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:57990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729720AbfCYHaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 03:30:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7778FAE31;
        Mon, 25 Mar 2019 07:30:45 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 1459AE1404; Mon, 25 Mar 2019 08:30:45 +0100 (CET)
Date:   Mon, 25 Mar 2019 08:30:45 +0100
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: regression (bisected): "modprobe parport_pc" hangs in current
 mainline
Message-ID: <20190325073045.GC26076@unicorn.suse.cz>
References: <20190313064557.GA14531@unicorn.suse.cz>
 <20190320211813.GE29968@unicorn.suse.cz>
 <CADVatmNVM3a=L6McdCsr5xzCwZnW6N4r9Cf55gjQZjsGGosBDg@mail.gmail.com>
 <1572645.oXzt2vILsi@alaris>
 <20190324193838.ubiljot22zhf5mjq@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324193838.ubiljot22zhf5mjq@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 07:38:38PM +0000, Sudip Mukherjee wrote:
> And I was able to reproduce the problem using a vm and Suse Tumblewood with
> next-20190322. Can you please try the attached patch and test on your vm and
> machine and check if it fixes the problem.
> 
> --
> Regards
> Sudip

> diff --git a/drivers/parport/share.c b/drivers/parport/share.c
> index 0171b8dbcdcd..f87948fbfc34 100644
> --- a/drivers/parport/share.c
> +++ b/drivers/parport/share.c
> @@ -274,7 +274,7 @@ static int port_check(struct device *dev, void *dev_drv)
>  int __parport_register_driver(struct parport_driver *drv, struct module *owner,
>  			      const char *mod_name)
>  {
> -	if (list_empty(&portlist))
> +	if (list_empty(&portlist) && strcmp(drv->name, "daisy_drv"))
>  		get_lowlevel_driver();
>  
>  	if (drv->devmodel) {

Yes, with this patch (on top of v5.1-rc2), both physical machine and VM
let the module(s) load cleanly even with the alias line restored.

Tested-by: Michal Kubecek <mkubecek@suse.cz>

Thank you,
Michal
