Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1367C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A72B2168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 08:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558601002;
	bh=OXEG3ImZ2eXX8KNRXnS3l2zhG1HunyO5thpIuSZ0PVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FTYLJ9DKle2HJJ+Ut5lK8W3X/IkTrCU25LXtKCdaFtwkWVM9KiA1fItR8P3tnE7DF
	 uZN8ENMnlM5i51W+6a4i0VkVvROstpMoAvzmhEbKjttA44nKmS8RewiRJI88/tzMdc
	 HYEvd6g6hU6vISlCY67yMYwGAVIqkiDoo5CWRR50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730079AbfEWInV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 04:43:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbfEWInV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 04:43:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE3C21019;
        Thu, 23 May 2019 08:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558601000;
        bh=OXEG3ImZ2eXX8KNRXnS3l2zhG1HunyO5thpIuSZ0PVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B1b4DkIRb2OITYTbKqQDiZ8X1EyvG/ESTFwupm16zNCuuYoJwUdkbty0QyKnzWlCV
         v5Opug1jMOEp36PKSvZ80McmgfMrrRmxcnDdx+qBaDw+aZk/SMreDBudFveP8pyjgL
         //Yxrct3SxxCcBg+6IcgjVaa7mp5q1Wq/LltawIo=
Date:   Thu, 23 May 2019 10:43:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nishka Dasgupta <nishka.dasgupta@yahoo.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fieldbus: anybuss: Remove variable
Message-ID: <20190523084318.GB831@kroah.com>
References: <20190523070531.13510-1-nishka.dasgupta@yahoo.com>
 <20190523072246.GD24998@kroah.com>
 <4a3d571f-5987-6735-be56-7976457d0797@yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a3d571f-5987-6735-be56-7976457d0797@yahoo.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 01:52:29PM +0530, Nishka Dasgupta wrote:
> 
> 
> On 23/05/19 12:52 PM, Greg KH wrote:
> > On Thu, May 23, 2019 at 12:35:26PM +0530, Nishka Dasgupta wrote:
> > > Variable client, assigned to priv->client, is used only once in a
> > > function argument; hence, it can be removed and the function argument
> > > replaced with priv->client directly.
> > > Issue found with Coccinelle.
> > > 
> > > Signed-off-by: Nishka Dasgupta <nishka.dasgupta@yahoo.com>
> > > ---
> > >   drivers/staging/fieldbus/anybuss/hms-profinet.c | 4 +---
> > >   1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/fieldbus/anybuss/hms-profinet.c b/drivers/staging/fieldbus/anybuss/hms-profinet.c
> > > index 5446843e35f4..a7f85912fa92 100644
> > > --- a/drivers/staging/fieldbus/anybuss/hms-profinet.c
> > > +++ b/drivers/staging/fieldbus/anybuss/hms-profinet.c
> > > @@ -124,9 +124,7 @@ static int __profi_enable(struct profi_priv *priv)
> > >   static int __profi_disable(struct profi_priv *priv)
> > >   {
> > > -	struct anybuss_client *client = priv->client;
> > > -
> > > -	anybuss_set_power(client, false);
> > > +	anybuss_set_power(priv->client, false);
> > 
> > Same comments are relevant here as the last patch you sent.
> 
> So just to clarify this patch isn't necessary and I should cc Sven?

For future patches to any drivers/staging/fieldbus/ changes, yes.

thanks,

greg k-h
