Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77364C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452D72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 23:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563233841;
	bh=rG3h1CCwAFZcD67QhSxNdHQ/Kh5vcwoW6i8O8rEvLxs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VDRVfUFEtVhUpwMmV4QF0xgq6BxM+53FX8+oo7uMMNwh5gFhu6vc0JNcL43NnEQy6
	 7UmJx9F45af1fkeQ0tDwZZePAURqQx06X1ntFKVAnrHRAA7fjN1hgcDjHhHRAzsHrt
	 gp1n3pnpfGpJ3cF3JjJX96kSA4R945iYRhXfOu44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732713AbfGOXhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 19:37:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731412AbfGOXhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 19:37:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33D9220693;
        Mon, 15 Jul 2019 23:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563233839;
        bh=rG3h1CCwAFZcD67QhSxNdHQ/Kh5vcwoW6i8O8rEvLxs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y4A+RIVv9w6aNcb2AVOqzfA76/Z/mJYm9CUvm+FOJSElGvHz5RJIEE6B0+P/krc93
         uZUO6RD1vpx5dmlRAX67rdUug14E06LKigjQuU9byBl1w+Ohs1pxLGLDgMgycI2GZb
         EQKXNxH2fL2zXPa2aMicYFftOFt2VVJbXV9xVX0k=
Date:   Mon, 15 Jul 2019 18:37:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Kelsey Skunberg <skunberg.kelsey@gmail.com>,
        linux-pci@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] PCI: Remove functions not
 called in include/linux/pci.h
Message-ID: <20190715233717.GA79424@google.com>
References: <20190715175658.29605-1-skunberg.kelsey@gmail.com>
 <20190715181312.31403-1-skunberg.kelsey@gmail.com>
 <alpine.DEB.2.21.1907152138120.2564@felia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1907152138120.2564@felia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 15, 2019 at 09:42:47PM +0200, Lukas Bulwahn wrote:
> On Mon, 15 Jul 2019, Kelsey Skunberg wrote:
> 
> > Remove the following uncalled functions from include/linux/pci.h:
> > 
> >         pci_block_cfg_access()
> >         pci_block_cfg_access_in_atomic()
> >         pci_unblock_cfg_access()
> > 
> > Functions were added in patch fb51ccbf217c "PCI: Rework config space
> > blocking services", ...

> Also note that commits are referred to with this format:
> 
> commit <12-character sha prefix> ("<commit message>")

FWIW, I use this shell alias to generate these references:

  gsr is aliased to `git --no-pager show -s --abbrev-commit --abbrev=12 --pretty=format:"%h (\"%s\")%n"'

  $ gsr fb51ccb
  fb51ccbf217c ("PCI: Rework config space blocking services")

Documentation/process/submitting-patches.rst mentions a 12-char (at
least) SHA-1 but the e21d2170f36 example shows a *20*-char SHA-1,
which seems excessive to me.

I personally skip the word "commit" because I figure it's pretty
obvious what it is, but it's fine either way.

Bjorn
