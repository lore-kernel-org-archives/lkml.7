Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA1C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F412089F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 12:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DWY1fkE+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbfFXMYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 08:24:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34124 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728552AbfFXMYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 08:24:15 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x5OCNcJr006146;
        Mon, 24 Jun 2019 07:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1561379018;
        bh=T1q2FQcEBznzi7DLWeCI39uS9gU76CChdki0O3aXxMQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DWY1fkE+g2GW/G6QTkEn34ovWtWmUempqk+L2lviBBRBH8WS/Td01h9ufhLf3J8/z
         98L+WMy2BtTN3MMvqhhKnsSPieo3OsrEkyOJmtGavY6g8sKH6U/fymEwCmANWjn2e7
         fSzu6i4KA8TGEv3j2MIvzG7F9L4uBwd/SwIq8PLA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x5OCNcPp005882
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Jun 2019 07:23:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 24
 Jun 2019 07:23:38 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 24 Jun 2019 07:23:38 -0500
Received: from ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with SMTP id x5OCNcWq000775;
        Mon, 24 Jun 2019 07:23:38 -0500
Date:   Mon, 24 Jun 2019 07:24:57 -0500
From:   Benoit Parrot <bparrot@ti.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-input <linux-input@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/1] Input: edt-ft5x06 - disable irq handling during
 suspend
Message-ID: <20190624122457.seiezk4cla2gjh5u@ti.com>
References: <20190621185124.28966-1-bparrot@ti.com>
 <CAHp75VdcAfmn8u0du-Y95SjMcmuJa2402tdXCNHMcme1Y925xg@mail.gmail.com>
 <20190623055940.GA204275@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190623055940.GA204275@dtor-ws>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote on Sat [2019-Jun-22 22:59:40 -0700]:
> On Sat, Jun 22, 2019 at 01:37:10PM +0300, Andy Shevchenko wrote:
> > On Fri, Jun 21, 2019 at 9:53 PM Benoit Parrot <bparrot@ti.com> wrote:
> > >
> > > As a wakeup source when the system is in suspend there is little point
> > > trying to access a register across the i2c bus as it is probably still
> > > inactive. We need to prevent the irq handler from being called during
> > > suspend.
> > >
> > 
> > Hmm... But how OS will know what the event to handle afterwards?
> > I mean shouldn't we guarantee somehow the delivery of the event to the
> > input, in this case, subsystem followed by corresponding user space?
> 
> If we are using level interrupts then it will work OK, however it is
> really easy to lose edge here, as replaying disabled edge triggered
> interrupts is not really reliable.
> 
> Benoit, what kind of interrupt do you use in your system?

Dmitry,

On our systems we currently used edge trigger. One example is available in
mainline: arch/arm/boot/dts/am437x-sk-evm.dts
632:              interrupts = <31 IRQ_TYPE_EDGE_FALLING>;


Benoit

> 
> Thanks.
> 
> -- 
> Dmitry
