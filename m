Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1993C43140
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8402082C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567709799;
	bh=i6OWPx+i5LhSJ8Xv+mKDWS3PSY8etiDdSr67fqZVJWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qtHEmtJ2kZsMNZ25pt+S09sk9E0CN8JrdYzkmel3u2/6w5jxcemmFvhcwGFp4cZ+X
	 X9uJ9YL/+5AVipzS4C190JnwgxR/pV9muXgZudieVwt7X7y+tMD2xj+3bQuQjCzjCW
	 wEkvjiMMNRmHos9+z5JQF30DHm7x2XyMiZlgNowE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733016AbfIES4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 14:56:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbfIES4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 14:56:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 908DF206BA;
        Thu,  5 Sep 2019 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567709798;
        bh=i6OWPx+i5LhSJ8Xv+mKDWS3PSY8etiDdSr67fqZVJWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N102LImF8nNCUagp5r/MCOz8xNDTpCrW1O9Gyyag/79Pu0kqK3k0ZmbyNiCAKAHCB
         CusbZ4QFmYXhP9NEE+YEjvisgxFQPIDUfZ3h7k3r1YJ4CivdMLHgxK3WnhhT7c0x7e
         N3r6fv902bZZ9uEPbiG4WWldy/RDpyoP4NnQCnyE=
Date:   Thu, 5 Sep 2019 20:56:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ricard Wanderlof <ricardw@axis.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.9 07/83] ASoC: Fail card instantiation if DAI format
 setup fails
Message-ID: <20190905185634.GA24873@kroah.com>
References: <20190904175303.488266791@linuxfoundation.org>
 <20190904175304.389271806@linuxfoundation.org>
 <20190904181027.GG4348@sirena.co.uk>
 <20190904183527.GA364@kroah.com>
 <20190904190535.GH4348@sirena.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904190535.GH4348@sirena.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 04, 2019 at 08:05:35PM +0100, Mark Brown wrote:
> On Wed, Sep 04, 2019 at 08:35:27PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 04, 2019 at 07:10:27PM +0100, Mark Brown wrote:
> 
> > > I nacked this patch when Sasha posted it - it only improves diagnostics
> > > and might make systems that worked by accident break since it turns 
> > > things into a hard failure, it won't make anything that didn't work
> > > previously work.
> 
> > This is already in the 4.14.141, 4.19.69, and 5.2.11 releases, have you
> > heard any problems there?
> 
> Ugh, how did that happen?  I've not heard any reports but I'd be a lot
> more comfortable if this was reverted, these releases haven't been out
> that long and the users who'd be affected are mostly doing embedded
> stuff.
> 
> > I'll be glad to drop this from the 4.9.y and 4.4.y queues, now if you
> > wish, but just want you to know it's already out there in some releases.
> 
> Yes, please.

Now reverted and dropped, sorry about this.

greg k-h
