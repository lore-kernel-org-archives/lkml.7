Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A94C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC52020657
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 20:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Oi+QWpnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbfC2UYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 16:24:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45338 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730092AbfC2UYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 16:24:16 -0400
Received: from zn.tnic (p200300EC2F148A00E59BAD4CF0BA983E.dip0.t-ipconnect.de [IPv6:2003:ec:2f14:8a00:e59b:ad4c:f0ba:983e])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 168FD1EC00FF;
        Fri, 29 Mar 2019 21:24:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1553891054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WCNTVbcKj6aP3VoHv0OOak5vhWNJhjZVZAm5pLFuQlM=;
        b=Oi+QWpnm5zcoX4nxl5tVGQlHyIlVjYA7H9QRTD8Fl7FGN5VX8HnNnidUEEmamM1X3cJUWM
        HJ4W7eRCcgm9RCfNkQJDqjYIP6C8jonsNcxLdJhdmac3ZTa5AiBgzV4CTyFcZWhc14SAmm
        K1/31p0/51t089gTs/2Zycos2e6WFSk=
Date:   Fri, 29 Mar 2019 21:24:16 +0100
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
Message-ID: <20190329202416.GI21152@zn.tnic>
References: <1552382461-13051-1-git-send-email-yash.shah@sifive.com>
 <1552382461-13051-2-git-send-email-yash.shah@sifive.com>
 <20190328131657.GA9056@bogus>
 <be7246a0-2426-995d-0a24-f104c173d752@arm.com>
 <CAL_Jsq+s77J=Bwiyow2d7Q=e+z+5d64i_cL6xaYn0xdvJDb4Vg@mail.gmail.com>
 <20190329142739.GG21152@zn.tnic>
 <CAL_JsqLQ1XvQq7L=xA5Z8Y0Xa4Bmp0t2pgxn+hLF+tD=_L7Mvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqLQ1XvQq7L=xA5Z8Y0Xa4Bmp0t2pgxn+hLF+tD=_L7Mvg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2019 at 02:41:05PM -0500, Rob Herring wrote:
> DT dictates aligning with what the h/w looks like which has little to
> do with OS driver design.

Ok, then, where does this goal for doing a driver or compilation unit
per IP block come from?

Because everytime an ARM EDAC driver pops up, we are having the same
discussion.

> I never said you should change EDAC and I outlined how things should
> be handled if it is one driver.

Ok, we will add that to the EDAC driver design document we're currently
working on.

> DT and OS subsystems are independent things. I can't tell you how to
> design the subsystem and you can't dictate DT design (based on EDAC
> design).

I don't think I've ever intentionally or unintentionally dictated DT
design - all I've opposed to is having multiple EDAC drivers on ARM.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
