Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC97C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6262341C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbfH2Ojw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:39:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33850 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728282AbfH2Ojq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:39:46 -0400
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 45BD028A16C;
        Thu, 29 Aug 2019 15:39:44 +0100 (BST)
Date:   Thu, 29 Aug 2019 16:39:41 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Joao.Pinto@synopsys.com" <Joao.Pinto@synopsys.com>
Subject: Re: [PATCH 2/4] i3c: master: Check if devices have
 i3c_dev_boardinfo on i3c_master_add_i3c_dev_locked()
Message-ID: <20190829163941.45380b19@collabora.com>
In-Reply-To: <20190829163918.571fd0d8@collabora.com>
References: <cover.1567071213.git.vitor.soares@synopsys.com>
        <3e21481ddf53ea58f5899df6ec542b79b8cbcd68.1567071213.git.vitor.soares@synopsys.com>
        <20190829124457.3a750932@collabora.com>
        <SN6PR12MB265551F73B9B516CACB5B807AEA20@SN6PR12MB2655.namprd12.prod.outlook.com>
        <20190829163918.571fd0d8@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 16:39:18 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> On Thu, 29 Aug 2019 14:00:44 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> 
> > Hi Boris,
> > 
> > From: Boris Brezillon <boris.brezillon@collabora.com>
> > Date: Thu, Aug 29, 2019 at 11:44:57
> >   
> > > On Thu, 29 Aug 2019 12:19:33 +0200
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >     
> > > > The I3C devices described in DT might not be attached to the master which
> > > > doesn't allow to assign a specific dynamic address.    
> > > 
> > > I remember testing this when developing the framework, so, unless
> > > another patch regressed it, it should already work. I suspect patch 1
> > > is actually the regressing this use case.    
> > 
> > For today it doesn't address the case where the device is described with 
> > static address = 0, which isn't attached to the controller.  
> 
> Hm, I'm pretty sure I had designed the code to support that case (see
> [1]). It might be buggy, but nothing we can't fix I guess.
> 

[1]https://elixir.bootlin.com/linux/v5.3-rc6/source/drivers/i3c/master.c#L1898
