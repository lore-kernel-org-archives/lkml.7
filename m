Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B600DC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B75324C21
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 11:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559647976;
	bh=z2EjDCTcT92+f1VvJz7U+5/wwwQjkLdwVNlS8g18beE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wsUYsARK+1+aT/w/EYhLvPfq+fY6JXgheC1mjGDTASMO68ws4MwMbrsUWn8r+bHRs
	 8w2mJBy/iAJ7DuyjqO4c/hoIfRF66bgUBxMs2i3qefZjp2GLFCuDzJVE/qHjoWyShZ
	 MlTc1spRs9NjFUCOT557kZYL8TxbQ+fySL1qAoBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfFDLcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 07:32:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727180AbfFDLcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 07:32:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EA7524BF6;
        Tue,  4 Jun 2019 11:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559647974;
        bh=z2EjDCTcT92+f1VvJz7U+5/wwwQjkLdwVNlS8g18beE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Otof87+OfgLmvRj/6KNALbkbBBNOkDHFxW0rhMxulQlRP2l51oSC6ApSOC2jq9eT2
         etgU13TSvXmDkgvnPUpTuxfL+iPqHUKp5EQNkTITOgVPMbdbX0+QhIRhvNsJXIwnGM
         I5r7me5wfGuUiFEj24BpwT864wipnPaJPDJMl4i4=
Date:   Tue, 4 Jun 2019 13:32:52 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH 46/57] driver: Add variants of driver_find_device()
Message-ID: <20190604113252.GB18535@kroah.com>
References: <1559577023-558-1-git-send-email-suzuki.poulose@arm.com>
 <1559577023-558-47-git-send-email-suzuki.poulose@arm.com>
 <20190603191041.GD6487@kroah.com>
 <97a6b41f-7b30-54fc-a633-e59895467902@arm.com>
 <0ed1eb1e-df7f-d531-19ee-8b29ee37ae6d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ed1eb1e-df7f-d531-19ee-8b29ee37ae6d@arm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 11:55:36AM +0100, Suzuki K Poulose wrote:
> 
> 
> On 04/06/2019 09:45, Suzuki K Poulose wrote:
> > 
> > 
> > On 03/06/2019 20:10, Greg KH wrote:
> > > On Mon, Jun 03, 2019 at 04:50:12PM +0100, Suzuki K Poulose wrote:
> > > > Add a wrappers to lookup a device by name for a given driver, by various
> > > > generic properties of a device. This can avoid the proliferation of custom
> > > > match functions throughout the drivers.
> > > > 
> > > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > ---
> > > >    include/linux/device.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
> > > >    1 file changed, 44 insertions(+)
> > > 
> > > You should put the "here are the new functions that everyone can use"
> > > much earlier in the patch series, otherwise it's hard to dig out.
> > 
> > Sure, I will add it in the respective commits.
> > 
> > > 
> > > And if you send just those as an individual series, and they look good,
> > > I can queue them up now so that everyone else can take the individual
> > > patches through their respective trees.
> > 
> > I see. I think I may be able to do that.
> 
> The API change patch (i.e, "drivers: Unify the match prototype for
> bus_find_device with class_find_device" ) is tricky and prevents us from
> doing
> this. So, that patch has to come via your tree as it must be a one shot change.
> And that would make the individual subsystem patches conflict with your tree.
> Also, it would break the builds until the individual subsystem trees are merged
> with your tree with the new API.
> 
> So I am not quite sure what the best approach here would be.

That's for you to work out :)

one-shot changes are usually not a good idea, there are lots of ways to
prevent this from being required.

good luck!

greg k-h
