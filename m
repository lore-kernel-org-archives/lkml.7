Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4452C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E6562146E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561986392;
	bh=MX534DB5F1oWDPJd99YbzQMmvY84Xf+8KunFqPNXLCs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0+0wbFCi0J40uCSF1EfyM7pEjmFMftPahf/q6jTb+HwOmIyi0sc6kY/HV/X8mr613
	 gkGPcDughiRjyIxlofuSSdBX8OCqrHEX6BlNM0ATl0e55DUy4synUBCiIfudQ3OSFY
	 bNbiEPiQnymr/tFxjCen7uxStKMqxnKgT+YiTCsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfGANGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANG3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:06:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 387542146E;
        Mon,  1 Jul 2019 13:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986388;
        bh=MX534DB5F1oWDPJd99YbzQMmvY84Xf+8KunFqPNXLCs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5ssHk0UwE9WD4gvmfy8huApyqTdaCKkxz5YwFE3wSILs3i8GdfdUyF2GrvX6hmG/
         86+rnUb04UCqTETUItQUVWEKmLZvW7hZNOOdcNGUWErUiSxEtqP79QWqZplUnwmBFc
         luwgqm/VpagzwVeagHa4QN7CC6qi60OVG/TkPNuc=
Date:   Mon, 1 Jul 2019 15:06:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL v2] PHY: for 5.2-rc
Message-ID: <20190701130607.GB14021@kroah.com>
References: <20190612102803.25398-1-kishon@ti.com>
 <3c16d177-adb3-5c42-7e90-49ddae9723cb@ti.com>
 <20190621064019.GA12643@kroah.com>
 <105a126a-5897-5607-e371-1af958523631@ti.com>
 <194c1b99-aff4-6118-b853-6745b306567f@ti.com>
 <20190701101415.GC23548@kroah.com>
 <b32ec30d-d31a-e2d3-7817-ab7615aa8039@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b32ec30d-d31a-e2d3-7817-ab7615aa8039@ti.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 01, 2019 at 04:01:55PM +0530, Kishon Vijay Abraham I wrote:
> Hi Greg,
> 
> On 01/07/19 3:44 PM, Greg Kroah-Hartman wrote:
> > On Thu, Jun 27, 2019 at 06:46:50PM +0530, Kishon Vijay Abraham I wrote:
> >> Hi Greg,
> >>
> >> On 21/06/19 12:50 PM, Kishon Vijay Abraham I wrote:
> >>>
> >>>
> >>> On 21/06/19 12:10 PM, Greg Kroah-Hartman wrote:
> >>>> On Fri, Jun 21, 2019 at 11:41:26AM +0530, Kishon Vijay Abraham I wrote:
> >>>>> Hi Greg,
> >>>>>
> >>>>> On 12/06/19 3:57 PM, Kishon Vijay Abraham I wrote:
> >>>>>> Hi Greg,
> >>>>>>
> >>>>>> Please find the updated pull request for 5.2 -rc cycle. Here I dropped
> >>>>>> the patch that added "static" for a function to fix sparse warning.
> >>>>>>
> >>>>>> I'm also sending the patches along with this pull request in case you'd
> >>>>>> like to look them.
> >>>>>>
> >>>>>> Consider merging it in this -rc cycle and let me know if you want me
> >>>>>> to make any further changes.
> >>>>>
> >>>>> Are you planning to merge this?
> >>>>
> >>>> Ugh, fell through the cracks of my huge TODO mbox at the moment, sorry.
> >>>> It's still there, should get to it next week...
> >>>
> >>> All right, thanks!
> >>
> >> I think it's not merged yet. If you think it's too late, I can send it along
> >> with the merge window pull request.
> > 
> > Sorry for the delay, I've merged this into my branch for 5.3-rc1.  If
> > anything needed to go into 5.2, can you send the git commit ids to
> > stable@vger.kernel.org when they hit Linus's tree?
> 
> Sure, I'll do that. Meanwhile I've sent pull request for 5.3 merge window. It
> would be great if you can pick that one too.

Now picked up, thanks.

greg k-h
