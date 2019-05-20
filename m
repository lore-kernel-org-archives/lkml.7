Return-Path: <SRS0=lq4r=TU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DF7C04AAC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CCB120675
	for <linux-kernel@archiver.kernel.org>; Mon, 20 May 2019 19:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558379533;
	bh=E8pMuiwfZgjxTLRmJMgwxsXlsA2mXiO98wkkgNNvwlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mVuViHNVH60/Gw3Tj0LQpd6xPpzLFkwD0B7++GTRTipntoSimApyBDA6ZL714oyMW
	 K5SesAJwGLUmgg+XugjXorCUjNuzOG3CZH4CN9SXnHbc+4+/iTUgGrZBUUoSgA5/2x
	 wl2dwFgCW6VQIKB5IuSjNeOc8ME+gfQ5oJ47SRd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfETTMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 May 2019 15:12:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfETTMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 May 2019 15:12:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F23D20656;
        Mon, 20 May 2019 19:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558379531;
        bh=E8pMuiwfZgjxTLRmJMgwxsXlsA2mXiO98wkkgNNvwlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RdCTxd1KM+wLYnt0A36WyDCg/zX+DJMto7nraVMOHwFmahuKoaVnwTaFRNM+R8Xnc
         6R2SC41yVXOR7hxCmpe0/8aSXiW+hY9Ui6F8o5xUWjR01XPtxQpXQ5x2wii9FW3DBx
         zZ4Z8ZTqdPNu46Dy6+eKdgy6d1iI+ctg7Qpi7NaM=
Date:   Mon, 20 May 2019 21:12:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Liming Sun <lsun@mellanox.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        David Woods <dwoods@mellanox.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] platform/mellanox: Add bootctl driver for
 Mellanox BlueField Soc
Message-ID: <20190520191209.GA29776@kroah.com>
References: <0b74e9ad12360b56bc0a3c2ca972798c424f2610.1548790896.git.lsun@mellanox.com>
 <1558115345-32476-1-git-send-email-lsun@mellanox.com>
 <20190520155658.GA14165@kroah.com>
 <DB6PR05MB32232CA5DD05D1A923A28215A1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR05MB32232CA5DD05D1A923A28215A1060@DB6PR05MB3223.eurprd05.prod.outlook.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 06:07:44PM +0000, Liming Sun wrote:
> > > +static struct platform_driver mlxbf_bootctl_driver = {
> > > +	.probe = mlxbf_bootctl_probe,
> > > +	.driver = {
> > > +		.name = "mlxbf-bootctl",
> > > +		.groups = mlxbf_bootctl_groups,
> > > +		.acpi_match_table = mlxbf_bootctl_acpi_ids,
> > 
> > Why is an acpi driver a platform driver?  Isn't there a "real" acpi
> > driver interface you should be tieing into instead?
> > 
> > Only use a platform driver as an absolute last resort.  I don't think
> > that is the case here.
> 
> The driver is trying to configure boot-swapping and display secure state,
> and is defined/initiated in ACPI table in UEFI. It seems a little hard to
> categorize this driver to any existing subsystem. Any suggestion
> where it might be a better fit (like drivers/misc, drivers/firmware, etc)? 
> Please correct me if I misunderstand the comments. Thanks!.

The comment was asking why an acpi driver is a platform driver, but then
I went and looked now at a bunch of acpi drivers, and they all are
platform drivers :(

Anyway, drivers/acpi/ seems like the best place for this file, right?

thanks,

greg k-h
