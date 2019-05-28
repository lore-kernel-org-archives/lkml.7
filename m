Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E9AC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3E208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559047311;
	bh=Xaq21r4/1kcsZKef9cVyQ0Ykq/zbC4IiQzxkBr5Eqec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tLHawna18WJjXd37CH0OWNh22h6GEN80yKatGpsTGjCVLuwCo8RNmKqOG6I8occPV
	 iKiT3GXeGY8NoJuAHaz0Co0TKTU8ppOAZWJ6qXI2j45bN6Eo2C5zgK9mpMm/JybVK5
	 R3x6/Zz+ITTOTSMpZTOLMJZCv3TSArDeUrOF617w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfE1Mlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:41:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726933AbfE1Mlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:41:49 -0400
Received: from localhost (unknown [8.46.75.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2120220883;
        Tue, 28 May 2019 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559047309;
        bh=Xaq21r4/1kcsZKef9cVyQ0Ykq/zbC4IiQzxkBr5Eqec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXcKPW643A9rKgkDdRcy/XkiE+mouN55ATNtIAtNSR8ZdD8EkTEbF8h+7RvgVprJO
         Ycqw6fz6kASeSdsfHmvWUPmEyw8cA29tjPVJQDS5oFD6APxkOZFlZh1cbg3+fjducN
         aXksPzcj35NUqfUr0NqkvJtZoC+C/6sy/ZKcdRPk=
Date:   Tue, 28 May 2019 14:41:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gen Zhang <blackgod016574@gmail.com>
Cc:     rafael@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Question: devm_kfree] When should devm_kfree() be used?
Message-ID: <20190528124138.GA3578@kroah.com>
References: <20190528003257.GA12065@zhanggen-UX430UQ>
 <20190528064949.GC2428@kroah.com>
 <20190528071400.GB18498@zhanggen-UX430UQ>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190528071400.GB18498@zhanggen-UX430UQ>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 03:14:00PM +0800, Gen Zhang wrote:
> On Tue, May 28, 2019 at 08:49:49AM +0200, Greg KH wrote:
> > On Tue, May 28, 2019 at 08:32:57AM +0800, Gen Zhang wrote:
> > > devm_kmalloc() is used to allocate memory for a driver dev. Comments
> > > above the definition and doc 
> > > (https://www.kernel.org/doc/Documentation/driver-model/devres.txt) all
> > > imply that allocated the memory is automatically freed on driver attach,
> > > no matter allocation fail or not. However, I examined the code, and
> > > there are many sites that devm_kfree() is used to free devm_kmalloc().
> > > e.g. hisi_sas_debugfs_init() in drivers/scsi/hisi_sas/hisi_sas_main.c.
> > > So I am totally confused about this issue. Can anybody give me some
> > > guidance? When should we use devm_kfree()?
> > 
> > If you "know" you need to free the memory now, call devm_kfree().  If
> > you want to wait for it to be cleaned up latter, like normal, then do
> > not call it.
> > 
> > Do you have a driver that you think uses it incorrectly?
> > 
> > thanks,
> > 
> > greg k-h
> Yes, that is my question! I do have several patches about devm_kfree() 
> and debate with maintainers. e.g. you can kindly refer to this lkml:
> https://lkml.org/lkml/2019/5/23/1547. 
> 
> In tegra_wm9712_driver_probe(), 'machine->codec' is allocated by
> platform_device_alloc(). When it is NULL, function returns ENOMEM.
> However, 'machine' is allocated by devm_kzalloc() before this site.
> Thus we should free 'machine' before function ends to prevent memory
> leaking.

No, you are not leaking any memory if you do not call that function.
Try it and see :)

The function is there if you just want to "free the memory now!", it's
not necessary if you return an error as when the device is removed the
memory will be freed then (or if probe fails, depending on the code
path.)

thanks,

greg k-h
