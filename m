Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2A8C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72FD227BF
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576166450;
	bh=zOhoZ96LZPHtESEGfmQk605Uix32gjBq5vRqbFWGo50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AXH0EOc96DIMOr8y/DOD76SknZXfUgPz644urLXYX5h1vURw5cXLEPLlXiufZxRBc
	 pRdh3FrmvODzlw+NF3YXRtVZ5yNUqEZ4yMDQMaI08toKi6K5LrzpW1frR4Adc381gb
	 8yybOzFS9ifuhNLMqj7b12AIux5D9TY/Qk3zfIic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfLLQAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 11:00:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729247AbfLLQAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 11:00:48 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42DC92073D;
        Thu, 12 Dec 2019 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576166447;
        bh=zOhoZ96LZPHtESEGfmQk605Uix32gjBq5vRqbFWGo50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r57OQ5Q6oili066DWlG8wNJ7fCnYqAjMHu8NCCPkw5/HF22VkrDgo5MdRtXUeS6G+
         jFzQ9AV0kI7c+ArFu7TsHFJIR4R/SEf5Eh9lpAGndlSSlEr8MR9rHNfNPu2T5SvfBq
         1xCrraeRlQKZkHh1836t26NluQWN5Wy7Xcidf7i8=
Date:   Thu, 12 Dec 2019 17:00:45 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC 5/5] i3c: add i3cdev module to expose i3c dev in /dev
Message-ID: <20191212160045.GA1672362@kroah.com>
References: <cover.1575977795.git.vitor.soares@synopsys.com>
 <f9f20eaf900ed5629dd3d824bc1e90c7e6b4a371.1575977795.git.vitor.soares@synopsys.com>
 <20191212144459.GB1668196@kroah.com>
 <CH2PR12MB421658E00DF331400728DB6CAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR12MB421658E00DF331400728DB6CAE550@CH2PR12MB4216.namprd12.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 02:56:56PM +0000, Vitor Soares wrote:
> Hi Greg,
> 
> From: Greg KH <gregkh@linuxfoundation.org>
> Date: Thu, Dec 12, 2019 at 14:44:59
> 
> > On Tue, Dec 10, 2019 at 04:37:33PM +0100, Vitor Soares wrote:
> > > +static int __init i3cdev_init(void)
> > > +{
> > > +	int res;
> > > +
> > > +	pr_info("i3c /dev entries driver\n");
> > 
> > Please remove debugging information, kernel code should be quiet unless
> > something goes wrong.
> 
> I will remove it.
> 
> > 
> > > +	/* Dynamically request unused major number */
> > > +	res = alloc_chrdev_region(&i3cdev_number, 0, N_I3C_MINORS, "i3c");
> > 
> > Do you really need a whole major, or will a few minors work?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I'm reserving one per device. What do you suggest?

How many devices do you have in a system?
