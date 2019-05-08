Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9317C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06A821530
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 14:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g9J2++dy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="g9J2++dy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfEHOYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 10:24:30 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51052 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726914AbfEHOYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 10:24:30 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D13058EE2B1;
        Wed,  8 May 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557325469;
        bh=xydTi/hn1JDJTRyeJqcJB5CNRIzFduahaKTlPNfO1IM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g9J2++dy2yHjw1VgAG+xuKtM3+Ffdl90VFrw8hMWS5OgnG15ZSG29vx3WWHYinwv9
         NaciE0RfPfGVsVKEOEphmxnK7sbh/ih6GLZ8a7E9qR9BsXxXllu2adpGkb7yLMZFup
         w6Bk1ctdc12FOZRshyvo/zvuvq7udEKyH3RQjoOs=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xgX-hAvPV0kW; Wed,  8 May 2019 07:24:29 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 22C688EE0D2;
        Wed,  8 May 2019 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1557325469;
        bh=xydTi/hn1JDJTRyeJqcJB5CNRIzFduahaKTlPNfO1IM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=g9J2++dy2yHjw1VgAG+xuKtM3+Ffdl90VFrw8hMWS5OgnG15ZSG29vx3WWHYinwv9
         NaciE0RfPfGVsVKEOEphmxnK7sbh/ih6GLZ8a7E9qR9BsXxXllu2adpGkb7yLMZFup
         w6Bk1ctdc12FOZRshyvo/zvuvq7udEKyH3RQjoOs=
Message-ID: <1557325468.3196.2.camel@HansenPartnership.com>
Subject: Re: [PATCH] mptsas: fix undefined behaviour of a shift of an int by
 more than 31 places
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Colin Ian King <colin.king@canonical.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 08 May 2019 07:24:28 -0700
In-Reply-To: <de7e3aaf-0155-5007-c228-510f0d0de428@canonical.com>
References: <20190504164010.24937-1-colin.king@canonical.com>
         <1557027274.2821.2.camel@HansenPartnership.com>
         <de7e3aaf-0155-5007-c228-510f0d0de428@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-08 at 14:07 +0100, Colin Ian King wrote:
> On 05/05/2019 04:34, James Bottomley wrote:
> > On Sat, 2019-05-04 at 17:40 +0100, Colin King wrote:
> > > From: Colin Ian King <colin.king@canonical.com>
> > > 
> > > Currently the shift of int value 1 by more than 31 places can
> > > result in undefined behaviour. Fix this by making the 1 a ULL
> > > value before the shift operation.
> > 
> > Fusion SAS is pretty ancient.  I thought the largest one ever
> > produced had four phys, so how did you produce the overflow?
> 
> This was an issue found by static analysis with Coverity; so I guess
> won't happen in the wild, in which case the patch could be ignored.

The point I was more making is that if we thought this could ever
happen in practice, we'd need more error handling than simply this:
we'd be setting the phy_bitmap to zero which would be every bit as bad
as some random illegal value.

James

