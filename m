Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3428C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C41E24305
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="vrry6r0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbfE2XNB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:13:01 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:44877 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbfE2XNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559171580; x=1590707580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kf+YYPidV8/Ha/+Vglzg/t5JfZt167PpRucdfQl/36Y=;
  b=vrry6r0qD3odiepfpwNL1vTykGKgXJTrVakBdgrSqjTpYQNzG7isg0J1
   7bbS/gi182V/EymbcKWUv7R9/DEdeA82JyyFPPn/etXGR2Y129yE6n6Cy
   Q5zdiSDUX6B6oauwbapCthui+KTFggzfh9c5EWCfeJ6VekmyuBO33obSQ
   g=;
X-IronPort-AV: E=Sophos;i="5.60,527,1549929600"; 
   d="scan'208";a="768192754"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 29 May 2019 23:12:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-538b0bfb.us-west-2.amazon.com (Postfix) with ESMTPS id 7367DA1FD1;
        Wed, 29 May 2019 23:12:57 +0000 (UTC)
Received: from EX13D05UWC003.ant.amazon.com (10.43.162.226) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 23:12:57 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D05UWC003.ant.amazon.com (10.43.162.226) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 23:12:57 +0000
Received: from localhost (10.107.66.154) by mail-relay.amazon.com
 (10.43.162.232) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 29 May 2019 23:12:56 +0000
Date:   Wed, 29 May 2019 16:12:56 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] hwmon: core: add thermal sensors only if
 dev->of_node is present
Message-ID: <20190529231256.GB18339@u40b0340c692b58f6553c.ant.amazon.com>
References: <20190517231337.27859-1-eduval@amazon.com>
 <20190517231337.27859-2-eduval@amazon.com>
 <20190528150821.GB5516@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190528150821.GB5516@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:08:21AM -0700, Guenter Roeck wrote:
> Hi Eduardo,
> 
> On Fri, May 17, 2019 at 04:13:36PM -0700, Eduardo Valentin wrote:
> > Drivers may register to hwmon and request for also registering
> > with the thermal subsystem (HWMON_C_REGISTER_TZ). However,
> > some of these driver, e.g. marvell phy, may be probed from
> > Device Tree or being dynamically allocated, and in the later
> > case, it will not have a dev->of_node entry.
> > 
> > Registering with hwmon without the dev->of_node may result in
> > different outcomes depending on the device tree, which may
> > be a bit misleading. If the device tree blob has no 'thermal-zones'
> > node, the *hwmon_device_register*() family functions are going
> > to gracefully succeed, because of-thermal,
> > *thermal_zone_of_sensor_register() return -ENODEV in this case,
> > and the hwmon error path handles this error code as success to
> > cover for the case where CONFIG_THERMAL_OF is not set.
> > However, if the device tree blob has the 'thermal-zones'
> > entry, the *hwmon_device_register*() will always fail on callers
> > with no dev->of_node, propagating -EINVAL.
> > 
> > If dev->of_node is not present, calling of-thermal does not
> > make sense. For this reason, this patch checks first if the
> > device has a of_node before going over the process of registering
> > with the thermal subsystem of-thermal interface. And in this case,
> > when a caller of *hwmon_device_register*() with HWMON_C_REGISTER_TZ
> > and no dev->of_node will still register with hwmon, but not with
> > the thermal subsystem. If all the hwmon part bits are in place,
> > the registration will succeed.
> > 
> Makes sense. I'd apply it as-is, but it would be better if you resend
> it to the list to give others a chance to comment.

Ok Cool.

Yeah, the patches were copied to the mailing list. Only the cover letter
somehow I forgot to copy the mailing lists while git-sending-email.

I will resend the two patches (and the cover letter) after fixing
the comment on patch 2/2.

> 
> Thanks,
> Guenter
> 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >  drivers/hwmon/hwmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index fcdbac4a56e3..6b3559f58b67 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -619,7 +619,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  	if (err)
> >  		goto free_hwmon;
> >  
> > -	if (dev && chip && chip->ops->read &&
> > +	if (dev && dev->of_node && chip && chip->ops->read &&
> >  	    chip->info[0]->type == hwmon_chip &&
> >  	    (chip->info[0]->config[0] & HWMON_C_REGISTER_TZ)) {
> >  		const struct hwmon_channel_info **info = chip->info;
> > -- 
> > 2.21.0
> > 

-- 
All the best,
Eduardo Valentin
