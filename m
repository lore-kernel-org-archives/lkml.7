Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66DC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF969207E0
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552152739;
	bh=xpR9CZBTvu1EoR62SAfjWrmd5OFjqVE601E5z9BK+E8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rGfEe0CynJmyPibLEkvib9XW0g01uE7Vm8rBOppXF3P0OBuN8ANn+00xT093M+9ot
	 pcgqvayIEEyxFUxSU7xD3HL0neXzBF6smzNJ7ioRDRiT0UqwSS7+9WN7/eEd17pLDl
	 GCSS6KmTa7xKHuJrhaP9ne8UzA4QL7nZkGjAvqps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCIRcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 12:32:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:50286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbfCIRcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 12:32:17 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A60ED20652;
        Sat,  9 Mar 2019 17:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552152736;
        bh=xpR9CZBTvu1EoR62SAfjWrmd5OFjqVE601E5z9BK+E8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1CSueVFoKlKYg0cVZaCPmtqp8sKPdWkiU47+NEwTHY/ciNHh4c5xf/nZfxd/RJBGy
         S+KeIRVz5fcI/JmQCt8f9Openetj6siQFoftXRCs76GvaCLi6bdYrVK7edIfyp0DqV
         p2XAY2eou8Ajvr2fnsCwgJBZPcRDAZGN+EVKL0xg=
Date:   Sat, 9 Mar 2019 17:32:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Chen, Hu" <hu1.chen@intel.com>, bo.he@intel.com,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] io: accel: kxcjk1013: restore the range after
 resume.
Message-ID: <20190309173211.00c205e3@archlinux>
In-Reply-To: <cac7810e-04df-8aca-fbd9-2433b544960c@redhat.com>
References: <23ced5ac-b0a0-7d87-76d7-bdec0c3e0e15@redhat.com>
        <20190306023224.23695-1-hu1.chen@intel.com>
        <cac7810e-04df-8aca-fbd9-2433b544960c@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Mar 2019 09:43:24 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 06-03-19 03:32, Chen, Hu wrote:
> > From: "he, bo" <bo.he@intel.com>
> > 
> > On some laptops, kxcjk1013 is powered off when system enters S3. We need
> > restore the range regiter during resume. Otherwise, the sensor doesn't
> > work properly after S3.
> > 
> > Signed-off-by: he, bo <bo.he@intel.com>
> > Signed-off-by: Chen, Hu <hu1.chen@intel.com>  
> 
> Thanks, patch looks good to me:
I'd have had an ever so slight preference for a goto as I prefer
errors to be checked for rather than good paths (as that's the more
common pattern), but I don't care strongly enough to ask for
a v4!

> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
> 
> Regards,
> 
> Hans
> 
> 
> 
> > ---
> >   v3: Avoid unnecessary mutex_unlock (Hans).
> >   v2: Handle return value independently (Jonathan).
> > 
> >   drivers/iio/accel/kxcjk-1013.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> > index 7096e577b23f..50f3ff386bea 100644
> > --- a/drivers/iio/accel/kxcjk-1013.c
> > +++ b/drivers/iio/accel/kxcjk-1013.c
> > @@ -1437,6 +1437,8 @@ static int kxcjk1013_resume(struct device *dev)
> >   
> >   	mutex_lock(&data->mutex);
> >   	ret = kxcjk1013_set_mode(data, OPERATION);
> > +	if (ret == 0)
> > +		ret = kxcjk1013_set_range(data, data->range);
> >   	mutex_unlock(&data->mutex);
> >   
> >   	return ret;
> >   

