Return-Path: <SRS0=CA45=ZK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184B2C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B33D420692
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Nov 2019 12:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kTqeBHTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbfKRMzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Nov 2019 07:55:48 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:35274 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbfKRMzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Nov 2019 07:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=960wzGvE+KcG1OqGD4Pmky51z5BTfCbb59hEtVos6UY=; b=kTqeBHTFI5VbTcrHrCYatitkc
        XFreysQNzWmafsaSmK4O84GWThZEpLvCZh7I6o0NcFGAwpWldEtZphBY1r9VZRwPQ7co2i+2j3DCk
        00JU5In5vbigEbEjNinbCx+LhgvuFjC8NhvpwWo+7tkVFOEaenej57vcN66EFaqSNAIY0jSs6XzAl
        rkaAESx2o9DXOTla9Ee75yHFUIz9S4iMC6BYM2J1mXBeYtBS304+r+6oUAZubou/A4jYdAK7j7FSN
        ImCJLzHmh2bCudQAe55CPAcNxgar2eG0dctNGYM2KssgMmjyMec5qL95FI3JMbaDZncfiKvVS/RUg
        xvqjY2sIg==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:37134)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iWgZD-0003Mi-39; Mon, 18 Nov 2019 12:55:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iWgZA-0008DI-Ny; Mon, 18 Nov 2019 12:55:40 +0000
Date:   Mon, 18 Nov 2019 12:55:40 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-kernel@vger.kernel.org, f.fainelli@gmail.com,
        "kernelci.org bot" <bot@kernelci.org>, wahrenst@gmx.net,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: dt: check MPIDR on MP devices built without SMP
Message-ID: <20191118125540.GW25745@shell.armlinux.org.uk>
References: <20191004155232.17209-1-nsaenzjulienne@suse.de>
 <5abdcb0e0e1043a101f579ea65d07a1f6b91f896.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5abdcb0e0e1043a101f579ea65d07a1f6b91f896.camel@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 18, 2019 at 12:49:04PM +0100, Nicolas Saenz Julienne wrote:
> On Fri, 2019-10-04 at 17:52 +0200, Nicolas Saenz Julienne wrote:
> > On SMP builds, in order to properly link CPU devices with their
> > respective DT nodes we start by matching the boot CPU. This is achieved
> > by comparing the 'reg' property on each of the CPU DT nodes with the
> > MPIDR. The association is necessary as to validate the whole CPU logical
> > map, which ultimately links CPU devices and their DT nodes.

No, that is not the primary purpose of the CPU logical map.  The CPU 
logical map is there to map the CPU logical number to a hardware number,
necessary for programming hardware.

> > On setups built without SMP, no MPIDR read is performed. The only thing
> > expected is for the 'reg' property in the CPU DT node to contain the
> > value 0x0.
> > 
> > This causes problems on MP setups built without SMP. As their boot CPU
> > DT node contains the relevant MPIDR as opposed to 0x0. No match is then
> > possible. This causes troubles further down the line as drivers are
> > unable to get the CPU's DT node.

So the DT is incorrect for the platform - it is not describing the
hardware.  Why can't the DT be fixed?  Clearly, it would have never
worked with the mainline kernel today.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
