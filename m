Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A251AC28CC6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73B9B219BE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559654334;
	bh=kstaWkEOjz4sGnvduRYtac82iKRZqlwD3wYOfYdZAJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z6/3tY5IWnljw5XvZJFknuDmPqA7IZOsfGCBHzUs96OtcLj5uylkAE2VXD4PY5WKr
	 cevouHs5vPiwZZLL2Ena1Jr0N+keyFAMYvKa79xZzG/IdCpCLzzBYbJtQIyhGW38nM
	 aJLTsoL0aO3rFsaSd6Bml3e2YzZF5LdDQtqMnV0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbfFDNSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 09:18:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfFDNSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 09:18:50 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B3242199C;
        Tue,  4 Jun 2019 13:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559654329;
        bh=kstaWkEOjz4sGnvduRYtac82iKRZqlwD3wYOfYdZAJU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ne0yes6lGitXgq3FdEvA/6cW2YR77DufQi52Gox4dH+56J4CFagViIAsuRlw+SY1h
         GeQJt2hA7XSzmQP1p1M+2CIZZKq/BL7Y+B9v74X6DxRsjFb3vBQaL3elhp51Wu0q/L
         /lWNsSEXnx/Kduvzcs5X43uAwHfOAN0pyqHu50Vo=
Date:   Tue, 4 Jun 2019 08:18:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ley Foon Tan <ley.foon.tan@intel.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, lftan.linux@gmail.com
Subject: Re: [PATCH] PCI: altera: Allow building as module
Message-ID: <20190604131848.GA40122@google.com>
References: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556081835-12921-1-git-send-email-ley.foon.tan@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 12:57:14PM +0800, Ley Foon Tan wrote:
> Altera PCIe Rootport IP is a soft IP and is only available after
> FPGA image is programmed.
> 
> Make driver modulable to support use case FPGA image is programmed
> after kernel is booted. User proram FPGA image in kernel then only load
> PCIe driver module.

I'm not objecting to these patches, but help me understand how this
works.  The "usual" scenario is that if a driver is loaded before a
matching device is available, i.e., either the driver is built
statically or it is loaded before a device is hot-added, the event of
the device being available causes the driver's probe method to be
called.

This seems to be a more manual process of programming the FPGA which
results in a new "altera-pcie" platform device.  And then apparently
you need to load the appropriate module by hand?  Is there no
"hot-add" type of event for this platform device that automatically
looks for the driver?

Bjorn
