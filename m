Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17934C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1189D216C4
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mI3ai4sU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="mI3ai4sU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbfEIPm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 11:42:28 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:46948 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbfEIPm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 11:42:28 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id C2F998EE2F4;
        Thu,  9 May 2019 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557416547;
        bh=MFzfvCr0ghlSwCqfMPN+3U/z7LPdQOpfgYAbwLhIp/s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mI3ai4sUaDOITFli4oAi51bk6X9VCi1bBBwRf7j0NOq7QYPskHyAD1FgKe0XNQDMn
         GYnRzV0Mln13+7JvwrGFBnYU4+UPrSGRjLYaN9QkzOgecwdMvEoBFhgge9m6cpI71s
         X1LaIhSLodhbat/qaxnwA8MWdS7s+bpANUWat2V0=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rwh2OIwpaMgk; Thu,  9 May 2019 08:42:27 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 1AE748EE101;
        Thu,  9 May 2019 08:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557416547;
        bh=MFzfvCr0ghlSwCqfMPN+3U/z7LPdQOpfgYAbwLhIp/s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mI3ai4sUaDOITFli4oAi51bk6X9VCi1bBBwRf7j0NOq7QYPskHyAD1FgKe0XNQDMn
         GYnRzV0Mln13+7JvwrGFBnYU4+UPrSGRjLYaN9QkzOgecwdMvEoBFhgge9m6cpI71s
         X1LaIhSLodhbat/qaxnwA8MWdS7s+bpANUWat2V0=
Message-ID: <1557416545.4268.22.camel@HansenPartnership.com>
Subject: Re: [PATCH] mptsas: fix undefined behaviour of a shift of an int by
 more than 31 places
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Hannes Reinecke <hare@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 09 May 2019 08:42:25 -0700
In-Reply-To: <9b4c84b5-31eb-6068-57c2-80ededc21b43@suse.de>
References: <20190504164010.24937-1-colin.king@canonical.com>
         <1557027274.2821.2.camel@HansenPartnership.com>
         <de7e3aaf-0155-5007-c228-510f0d0de428@canonical.com>
         <1557325468.3196.2.camel@HansenPartnership.com>
         <9b4c84b5-31eb-6068-57c2-80ededc21b43@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-05-09 at 17:30 +0200, Hannes Reinecke wrote:
> On 5/8/19 4:24 PM, James Bottomley wrote:
> > On Wed, 2019-05-08 at 14:07 +0100, Colin Ian King wrote:
> > > On 05/05/2019 04:34, James Bottomley wrote:
> > > > On Sat, 2019-05-04 at 17:40 +0100, Colin King wrote:
> > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > > 
> > > > > Currently the shift of int value 1 by more than 31 places can
> > > > > result in undefined behaviour. Fix this by making the 1 a ULL
> > > > > value before the shift operation.
> > > > 
> > > > Fusion SAS is pretty ancient.  I thought the largest one ever
> > > > produced had four phys, so how did you produce the overflow?
> > > 
> > > This was an issue found by static analysis with Coverity; so I
> > > guess won't happen in the wild, in which case the patch could be
> > > ignored.
> > 
> > The point I was more making is that if we thought this could ever
> > happen in practice, we'd need more error handling than simply this:
> > we'd be setting the phy_bitmap to zero which would be every bit as
> > bad as some random illegal value.
> > 
> 
> Thing is, mptsas is used as the default emulation in VMWare, and
> that does allow you to do some pretty weird configurations (I've
> found myself  fixing a bug with SATA hotplug on mptsas once ...).
> So I wouldn't discard this issue out of hand.

I'm not, I'm just saying the proposed fix is no fix at all since it
would just produce undefined behaviour in the driver.  I thought the
issue might have been coming from VMWare, which is why I asked how the
bug was seen.  The proper fix is probably to fail attachment if the phy
number goes over a fixed value (16 sounds reasonable) but if it's never
a problem in the field, I'm happy doing nothing because we have no real
idea what the reasonable value is.

James

