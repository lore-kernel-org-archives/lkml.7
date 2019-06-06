Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B1C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E002089E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559847850;
	bh=nE5tGyT6iFVO9pBfrN6905TKjYR4oXGv9UpQLxq2xgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mf/YDSN63qLYivwO6lk53s9TM9OeR8Zsl5yE5aARuoprFJHsHGXzUhO5+NxG4ky4W
	 N1011yQXk27LwxAajnabWErsZ0mcSyCyQaojJFXBWITwpC9GcyIuIqMmb0SifjIDoy
	 yWgMaWsAkzyQyLjT8np1iynCw34TCWFbZf9/ZbMo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbfFFTEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:04:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:43186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728483AbfFFTEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:04:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A732083D;
        Thu,  6 Jun 2019 19:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559847848;
        bh=nE5tGyT6iFVO9pBfrN6905TKjYR4oXGv9UpQLxq2xgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxDmf2mcACTGIUiuRUAm1Ea0Trtu3Cn0u0iT4HNZ9Gh89PFTWYeZ+3wztGyJSKA1X
         AvUyB9vrGAXKCQ2o/hJ0pzjjaPBHCoPOSw3e84JQ5Qz9Y94alVllfuBMgDLvhMtdKj
         OQ0htRourVGkq0rT4gO/WsBOnzSNrAguP7YZ0HzQ=
Date:   Thu, 6 Jun 2019 21:04:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <draganc@xilinx.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>, Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <dkiernan@xilinx.com>
Subject: Re: [PATCH V4 02/12] misc: xilinx-sdfec: add core driver
Message-ID: <20190606190406.GA20166@kroah.com>
References: <1558784245-108751-1-git-send-email-dragan.cvetic@xilinx.com>
 <1558784245-108751-3-git-send-email-dragan.cvetic@xilinx.com>
 <20190606132517.GA7943@kroah.com>
 <CH2PR02MB63592DAB5E23A35C86F81D09CB170@CH2PR02MB6359.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR02MB63592DAB5E23A35C86F81D09CB170@CH2PR02MB6359.namprd02.prod.outlook.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2019 at 06:16:48PM +0000, Dragan Cvetic wrote:
> > 
> > > +
> > > +	misc_deregister(&xsdfec->miscdev);
> > > +	atomic_dec(&xsdfec_ndevs);
> > > +	return 0;
> > 
> > You free nothing?
> > 
> > You are leaking resources like crazy here, this is not ok at all.
> 
> The managed resources are used.
> Anyway, I'll test for memory leak and search for the answer.

Oops, no, you are right, I missed the "devm" prefix on those calls.  My
fault.

thanks,

greg k-h
