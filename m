Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1547C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 05:20:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6452148D
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 05:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553404831;
	bh=VmIf77tgOCgjnAUAJxp2bwTuKfOqa0STy3Rl5EVbvW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aDusEtdfwfVCPlNCwVfoSBydfKsTH57BD/fNmK0zU40B1S5CtyIWd3T4y39vYG3i8
	 E8wrMZh6b6sLmkHcqAOJq72pyF+Cwp05Me5slvkoQjqDTa03KnojY9TWL5osnztQgi
	 rq5z0yv5Kb8cgAnivX4OfZ67ovBPr/KZ+mW/dwaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfCXFP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 01:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbfCXFP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 01:15:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20CCA21473;
        Sun, 24 Mar 2019 05:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553404557;
        bh=VmIf77tgOCgjnAUAJxp2bwTuKfOqa0STy3Rl5EVbvW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AOAPD26hqQVZN70MSQ7XtLMJjC2YsDLOh+S4hZBGGdwh2G1FQ2KGZkxcG8lLf0m6b
         MaJMwm2T4w0Nvp7R/GJ/fPRDjlxKgXk6kh1yF1rrSF2gWv1m0IQR+aXkolrU57URWV
         4pDnIsUw2WbtiFgCg8i30H+hZvJhJgt8m0X4nBSA=
Date:   Sun, 24 Mar 2019 06:15:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Add support for default attribute groups to
 kobj_type
Message-ID: <20190324051553.GA18887@kroah.com>
References: <20190322201440.GA30814@ubu-Virtual-Machine>
 <20190323060737.GA28563@kroah.com>
 <20190324034821.GA47676@ubu-Virtual-Machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190324034821.GA47676@ubu-Virtual-Machine>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 11:48:21PM -0400, Kimberly Brown wrote:
> On Sat, Mar 23, 2019 at 07:07:37AM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 22, 2019 at 04:14:40PM -0400, Kimberly Brown wrote:
> > > kobj_type currently uses a list of individual attributes to store
> > > default attributes. Attribute groups are more flexible than a list of
> > > attributes because groups provide support for attribute visibility. So,
> > > add support for default attribute groups to kobj_type.
> > > 
> > > In future patches, the existing uses of kobj_type’s attribute list will
> > > be converted to attribute groups. When that is complete, kobj_type’s
> > > attribute list, “default_attrs”, will be removed.
> > > 
> > > Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>
> > > ---
> > >  include/linux/kobject.h |  3 ++-
> > >  lib/kobject.c           | 14 ++++++++++++++
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > 
> > Yes!  Thanks for doing this.
> > 
> > But how did you test it?  Did you convert any kobj_type structures to
> > the attribute group and see that all was the same?  Ideally I'd like to
> > take this patch with at least one subsystem that uses the change,
> > otherwise this looks like unused code in the kernel.
> 
> Yes, I tested it by converting a couple of kobj_type structures,
> including one that I recently added an is_visible() function to
> (vmbus_chan_ktype in the hv_vmbus driver).
> 
> I'll put together a patchset with this patch and at least one
> subsystem's changes.

Wonderful, I'll wait to take this when you send that series.

thanks,

greg k-h
