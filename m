Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC70C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D6520870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbfDALLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:11:48 -0400
Received: from ozlabs.org ([203.11.71.1]:35789 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:11:47 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44XqRP0wNTz9sR0;
        Mon,  1 Apr 2019 22:11:45 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Mark Brown <broonie@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Annaliese McDermond <nh6z@nh6z.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Subject: Re: linux-next: build failure after merge of the sound-asoc tree
In-Reply-To: <20190327115745.GA11404@sirena.org.uk>
References: <20190326133349.3d9427dc@canb.auug.org.au> <20190326131550.GB10898@sirena.org.uk> <87pnqdndmk.fsf@concordia.ellerman.id.au> <20190327115745.GA11404@sirena.org.uk>
Date:   Mon, 01 Apr 2019 22:11:44 +1100
Message-ID: <87tvfiou8f.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:
> On Wed, Mar 27, 2019 at 03:29:55PM +1100, Michael Ellerman wrote:
>> Mark Brown <broonie@kernel.org> writes:
>
>> > Hrm, seems PowerPC is still not using the common clock API - is there
>> > any plan for that?  There are some ASoC PowerPC uses so it's going to be
>> > a bit of an issue as we expand our use of the clock API.
>
>> I don't know anything about the common clock API. What would it involve
>> for powerpc to use it?
>
> It's what's in drivers/clk - you'd have to provide clock drivers for all
> the clocks that are current supported by arch-specific code, make sure
> that those drivers can be instantiated and then remove the custom
> implementation of the clock API in arch/powerpc in favour of those.

OK. I realise we do have some support for the common clock API, but only
on certain sub-platforms (PPC_MPC512x, PPC_MPC52xx, PPC_E500MC).

On other platforms we have nothing at all AFAICS.

Seems Ben posted an RFC to support it in 2009, but nothing since:
  http://patchwork.ozlabs.org/patch/31551/


Anyway I think what you've done in next, make the code depend on
COMMON_CLOCK, is the best option. If anyone cares about that driver on
powerpc platforms that don't support COMMON_CLOCK they should speak up.

cheers
