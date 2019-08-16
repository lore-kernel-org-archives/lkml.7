Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC83C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D352064A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 12:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="QTkZSQVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfHPMVB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 08:21:01 -0400
Received: from aibo.runbox.com ([91.220.196.211]:48154 "EHLO aibo.runbox.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfHPMVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 08:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=rbselector1; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date;
        bh=BSu8IvWvvbvmrGb/CgKULzr7aYTiI6QZczZ8env2h1U=; b=QTkZSQVcELXjXkSq0+dXq4vNKe
        Z9vQKAfK2tbEDiTWhDalupw7jgMTtZmSyU9iybb4gDQwyMmo3k241qjQRMhE/YHSa+X9bA/VMko6u
        v1iq/lNAoo46FpYHfgsIEdMJNotE1UrKoL6t/cNKX/bg8GiR+ewcS368/HTNVaizneAQbOqiG4yrW
        bliM1f5ue0C2u1RsiULBfmv8DxqLqrWNV9tEeKMAgRXqrCWTNyBTBxgX++33laohz3HriBgu4PeIF
        9t8pO8P2Z0xMzUo/q7Hb0xECtxJIjTFhgvEzbMJaHvcyBoVOsdiidPZBabCLzF2K9bNCTWFtVzngS
        Si5UYQkw==;
Received: from [10.9.9.203] (helo=mailfront21.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1hybE0-0003Sd-R7; Fri, 16 Aug 2019 14:20:56 +0200
Received: by mailfront21.runbox with esmtpsa  [Authenticated alias (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1hybDn-0002aC-4s; Fri, 16 Aug 2019 14:20:43 +0200
Date:   Fri, 16 Aug 2019 08:20:36 -0400
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Subject: Re: [PATCH] platform/x86: intel_pmc_core: Do not ioremap RAM
Message-ID: <20190816082036.7b60c9f5@runbox.com>
In-Reply-To: <CAHp75Vc1BP9UXBWW1tv7T8v8vgqxZWngD+tN9=ZKkgc1imUVxQ@mail.gmail.com>
References: <20190816014140.10687-1-m.v.b@runbox.com>
 <CAHp75Vc1BP9UXBWW1tv7T8v8vgqxZWngD+tN9=ZKkgc1imUVxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2019 12:21:58 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Aug 16, 2019 at 4:42 AM M. Vefa Bicakci <m.v.b@runbox.com> wrote:
> >
> > On a Xen-based PVH virtual machine with more than 4 GiB of RAM,
> > intel_pmc_core fails initialization with the following warning message
> > from the kernel, indicating that the driver is attempting to ioremap
> > RAM:
> >
> >   ------------[ cut here ]------------
> >   ioremap on RAM at 0x00000000fe000000 - 0x00000000fe001fff  
> 
> > This issue appears to manifest itself because of the following fallback
> > mechanism in the driver:
> >
> >         if (lpit_read_residency_count_address(&slp_s0_addr))
> >                 pmcdev->base_addr = PMC_BASE_ADDR_DEFAULT;
> >
> > The validity of address PMC_BASE_ADDR_DEFAULT (i.e., 0xFE000000) is not
> > verified by the driver, which is what this patch introduces. With this
> > patch, if address PMC_BASE_ADDR_DEFAULT is in RAM, then the driver will
> > not attempt to ioremap the aforementioned address.  
> 
> Thank you for the patch.

Hello Andy,

Thank you for reviewing the patch!

> Is there anything preventing us to use memremap() in such case?

I re-read the documentation for memremap a few times along with taking
a look at its code, but I think I am missing an important piece of
information. As I understand it, depending on its flags, memremap would
allow a section of RAM to be mapped for the PMC driver.

The intention with this patch is to prevent the driver from being
instantiated when the default/fallback memory address is in RAM, as
this issue occurs with a non-administrative virtual machine (domU in
Xen terminology) that does not simulate or pass-through a corresponding
PMC device.

I think that I have misunderstood your review comment though, so I
would apppreciate it if you could elaborate.

Thanks again for reviewing the patch,

Vefa

(Please note that my next reply may be delayed by about 10 hours.)
