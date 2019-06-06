Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E90C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3968320684
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 14:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aGtubtOB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfFFOgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 10:36:24 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:27975 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbfFFOgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 10:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559831781; x=1591367781;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLzEF5AzOpV6fnQ8fVRLQhxhBcwCON1BJjsm+1F9fTg=;
  b=aGtubtOBSSfCd/Us9r1WMlpAy/LpeUgv1w8AaVCuKWEx4CgPct1tf4Yw
   U9HFmiC0tTq7b+e/ihMQiNzx2LfoobZ2NZsOSN+8p/K/RnneuQ1an0HNQ
   34D2UinKkwBxQdkrm4hZSLYpoJe8lSxuY2g8s5IjFPrfMvUjqLkZ5NbXI
   g=;
X-IronPort-AV: E=Sophos;i="5.60,559,1549929600"; 
   d="scan'208";a="769272317"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-168cbb73.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 06 Jun 2019 14:36:19 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2c-168cbb73.us-west-2.amazon.com (Postfix) with ESMTPS id 804B7A07C3;
        Thu,  6 Jun 2019 14:36:19 +0000 (UTC)
Received: from EX13D05UWC003.ant.amazon.com (10.43.162.226) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 14:36:19 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D05UWC003.ant.amazon.com (10.43.162.226) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 6 Jun 2019 14:36:19 +0000
Received: from localhost (10.95.251.103) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 6 Jun 2019 14:36:17 +0000
Date:   Thu, 6 Jun 2019 07:35:44 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190606143509.GF1534@u40b0340c692b58f6553c.ant.amazon.com>
References: <20190530025605.3698-1-eduval@amazon.com>
 <20190530025605.3698-3-eduval@amazon.com>
 <20190605203837.GA30238@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190605203837.GA30238@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2019 at 01:38:38PM -0700, Guenter Roeck wrote:
> On Wed, May 29, 2019 at 07:56:05PM -0700, Eduardo Valentin wrote:
> > When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> > in place, the hwmon subsystem will attempt to register the device
> > also with the thermal subsystem. When the of-thermal registration
> > fails, __hwmon_device_register jumps to ida_remove, leaving
> > the locally allocated hwdev pointer.
> > 
> > This patch fixes the leak by jumping to a new label that
> > will first unregister hdev and then fall into the kfree of hwdev
> > to finally remove the idas and propagate the error code.
> > 
> 
> Hah, actually this is wrong. hwdev is freed indirectly with the
> device_unregister() call. See commit 74e3512731bd ("hwmon: (core)
> Fix double-free in __hwmon_device_register()").

heh.. I see it now. Well, it is not a straight catch though. 

> 
> It may make sense to add a respective comment to the code, though.
> 

I agree. Or a simple comment saying "dont worry about freeing hwdev
because hwmon_dev_release() takes care of it".

Are you patching it ?

> Guenter
> 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> > V1->V2: removed the device_unregister() before jumping
> > into the new label, as suggested in the first review round.
> > 
> >  drivers/hwmon/hwmon.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index 429784edd5ff..620f05fc412a 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -652,10 +652,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  				if (info[i]->config[j] & HWMON_T_INPUT) {
> >  					err = hwmon_thermal_add_sensor(dev,
> >  								hwdev, j);
> > -					if (err) {
> > -						device_unregister(hdev);
> > -						goto ida_remove;
> > -					}
> > +					if (err)
> > +						goto device_unregister;
> >  				}
> >  			}
> >  		}
> > @@ -663,6 +661,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  
> >  	return hdev;
> >  
> > +device_unregister:
> > +	device_unregister(hdev);
> >  free_hwmon:
> >  	kfree(hwdev);
> >  ida_remove:

-- 
All the best,
Eduardo Valentin
