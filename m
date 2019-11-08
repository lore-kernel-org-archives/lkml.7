Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A380FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D03222CE
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573216462;
	bh=Tp/mJy2ordfJXjH1/nl11N6dP2U17R3lP2KncOqlLPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XP2JuunPjziKvmh9wFIy5w+9SMQaIdbBl+IDsZmeR5KJG60vVlY8JVdV5AaEVBllj
	 IQcvp3Ait/OwLuIwFgFatwOLbQgZkM006Ijr7tJ4q7JCy8Qx66lDn8iPjesCO5RbgD
	 6zyx2QmQfBbkvZKu0mYJBSVbBkBUTml2yGPEn1vU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfKHMeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:34:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:42622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725883AbfKHMeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:34:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87788222C6;
        Fri,  8 Nov 2019 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573216459;
        bh=Tp/mJy2ordfJXjH1/nl11N6dP2U17R3lP2KncOqlLPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QS7A4MHMADPPwdCjCQFnF8fFONxKv97OJOn0wTV8ACdb+uNUtyjKOlsHcfi86ISMP
         yIyYFFbzsqE3Kaf70NDdBj6RZit0Cw8APFlApq4X8fgjTRveyoacuQFmxAw+kl1vU6
         oreciYK+/wFP4uC73oZmBr9e6utaWeRDH+WH4oMw=
Date:   Fri, 8 Nov 2019 13:34:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
Message-ID: <20191108123416.GA732985@kroah.com>
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-204-sashal@kernel.org>
 <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
 <20191108120025.GM4787@sasha-vm>
 <4d8f1938-af6e-7e0e-4085-2f7c53390b2d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d8f1938-af6e-7e0e-4085-2f7c53390b2d@linux.ibm.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 01:16:26PM +0100, Julian Wiedmann wrote:
> On 08.11.19 13:00, Sasha Levin wrote:
> > On Fri, Nov 08, 2019 at 12:50:24PM +0100, Julian Wiedmann wrote:
> >> On 08.11.19 12:37, Sasha Levin wrote:
> >>> From: Julian Wiedmann <jwi@linux.ibm.com>
> >>>
> >>> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
> >>>
> >>> Combined L3+L4 csum offload is only required for some L3 HW. So for
> >>> L2 devices, don't offload the IP header csum calculation.
> >>>
> >>
> >> NACK, this has no relevance for stable.
> > 
> > Sure, I'll drop it.
> > 
> > Do you have an idea why the centos and ubuntu folks might have
> > backported this commit into their kernels?
> > 
> 
> No clue, I trust they have their own reasons.
> 

I cant see centos backporting anything unless they were asked to do so.
And this really looks like a "bugfix" to me, why isn't this relevant for
any older kernel versions?

thanks,

greg k-h
