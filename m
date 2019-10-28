Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE27CA9EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D33720B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 08:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572250144;
	bh=LlIrMK4H2FX/ElMC68HUSkCIrf+CSFBsfV3lLy7IFU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PvwgwPFFoEKZeJ3VUapOHiG+0uNqCapO/GU7vgKWLKo4YCR5vgdBm7VV55CrEy1q8
	 O8PdUFEzMdDPay1Yk0md++XnOfoMbTndw2RqYHVNcZW9yc+9EQtBK/52rx5xfmLgbC
	 WVPYJiEP3bIxoLfTg3gZB/ANwvhjBYlAXWa4FDOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733215AbfJ1IJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 04:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731255AbfJ1IJD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 04:09:03 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8E6420862;
        Mon, 28 Oct 2019 08:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572250142;
        bh=LlIrMK4H2FX/ElMC68HUSkCIrf+CSFBsfV3lLy7IFU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Av5WlIuLfRNpYN3ggTKCRP4vYawnYNrgiql5lhXdg1WySpujaEZZLe9BpOfSo77At
         GPrn1l9cU48yGmVXsDDvJDiTTLZw7QCJB2pMVK76phI2d4o8hKTSDJQ8+MnxJht0BE
         rUTHrMIrZGxTCfo5USWWJoUNSp4t7LKXdoIdkXIc=
Date:   Mon, 28 Oct 2019 17:08:58 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Healy <Chris.Healy@zii.aero>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org,
        Akinobu Mita <akinobu.mita@gmail.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH] nvme: Add hardware monitoring support
Message-ID: <20191028080858.GB1718@redsun51.ssa.fujisawa.hgst.com>
References: <20191028024156.23964-1-linux@roeck-us.net>
 <20191028073953.GA20443@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028073953.GA20443@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 08:39:53AM +0100, Christoph Hellwig wrote:
> On Sun, Oct 27, 2019 at 07:41:56PM -0700, Guenter Roeck wrote:
> > nvme devices report temperature information in the controller information
> > (for limits) and in the smart log. Currently, the only means to retrieve
> > this information is the nvme command line interface, which requires
> > super-user privileges.
> > 
> > At the same time, it would be desirable to use NVME temperature information
> > for thermal control.
> > 
> > This patch adds support to read NVME temperatures from the kernel using the
> > hwmon API and adds temperature zones for NVME drives. The thermal subsystem
> > can use this information to set thermal policies, and userspace can access
> > it using libsensors and/or the "sensors" command.
> 
> So these reported values seem to generate some interest.  Adding Akinobu
> Mita who also planned to wire them up to the thermal framework.  I don't
> really know either upper layer so I'm not sure which is the right one,
> but with this just like with the previous series I am quite worried that
> we add a lot of kernel boilerplate code for information people can
> trivially get using nvme-cli.

I think it's nvme-cli requires root, where this conveniently doesn't
need those elevated rights.

I'm not familiar with either upper level framework either; my only review
comment for this patch is to use devm_kfree() for the error cases.
