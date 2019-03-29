Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8049EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E6132173C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Ty8Kn1Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbfC2O1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:27:39 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729046AbfC2O1i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 10:27:38 -0400
Received: from zn.tnic (p200300EC2F148A000C2303278B6F16CD.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:c23:327:8b6f:16cd])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7A7941EC02C1;
        Fri, 29 Mar 2019 15:27:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553869656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=g66Y9KQ8P8D4SbrmnoAJ95U1RhuiyI40icRHIUKJjwA=;
        b=Ty8Kn1IiSdyJTwi6+WRedQVwaE0a/qMXyVVG9aQFGdFmc7DD+SYoh0cWFzptlZapdtHyQY
        Wb0Yt5LtQfJ3PraLnoCIVq1Qra4r+wsQdbpl+epgmPcTj/k+smSLZpKisXKkvlstymirkR
        rtJX4CvscEoJlKnt6ROcStXPWCrIHSM=
Date:   Fri, 29 Mar 2019 15:27:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Rob Herring <robh@kernel.org>
Cc:     James Morse <james.morse@arm.com>,
        Yash Shah <yash.shah@sifive.com>,
        linux-riscv@lists.infradead.org, linux-edac@vger.kernel.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] edac: sifive: Add DT documentation for SiFive L2
 cache Controller
Message-ID: <20190329142739.GG21152@zn.tnic>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
 <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
 <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 09:11:24AM -0500, Rob Herring wrote:
> I honestly don't understand the issue with EDAC is here.

The EDAC core supports only one driver and if you need to load more, you
need to dance around that.

Also, if those drivers need to talk amongst each other, then they need
to build something ad-hoc so that they can.

And the other architectures can very well do one driver per platform -
only ARM wants to do this special thing because DT said so. Or whatever.

> Highbank is separate drivers for L2 ECC (PL310) and DDR. Both are used
> on highbank.

That's because your L2 driver does allocate an edac_device
(edac_device_alloc_ctl_info()) and the DDR one an edac_mc
(edac_mc_add_mc_with_groups).

For example, altera_edac does edac_device_alloc_ctl_info() for each IP
block just fine. So a single driver *can* work.

> Only the DDR driver is used midway. (I think we never got around to
> how to report A15 L2 ECC errors within Linux.)
>
> In any case, it's all irrelevant to the DT binding. We don't design
> bindings around what some particular OS wants.

And just because DT dictates one driver per IP block, I'm not going to
redesign EDAC to fit that scheme. You or someone else who feels strongly
about it, is more than welcome to do so, of course. And then maintain it
too.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
