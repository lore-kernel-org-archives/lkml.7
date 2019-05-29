Return-Path: <SRS0=t3dz=T5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59587C28CC2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FBF2430D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 May 2019 23:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QT+5lcc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfE2XOv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 19:14:51 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:50197 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfE2XOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 19:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559171690; x=1590707690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jg4D4al/bAP7eHh51drOSBVTrjBox73axyszTJCSwQM=;
  b=QT+5lcc6dlSg4a/kQz/5EIwY9YwRWM6FQ2sCKJ37jfrcKFOh7ChxjHoA
   YjGdSezN4mAwIA7xONUAIIDxtdu4kkT+ukMSfbojNy/mzZRyDCbMjGd5E
   o6jA8lB9f/pMrfnkdPAA9c9xT/8QT/0H+Rxq+48dFM2ez2ERv/rnmSy7K
   A=;
X-IronPort-AV: E=Sophos;i="5.60,527,1549929600"; 
   d="scan'208";a="802508188"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 29 May 2019 23:14:48 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id 005DEA21D6;
        Wed, 29 May 2019 23:14:46 +0000 (UTC)
Received: from EX13D05UWB004.ant.amazon.com (10.43.161.208) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 23:14:46 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB004.ant.amazon.com (10.43.161.208) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 29 May 2019 23:14:45 +0000
Received: from localhost (10.107.66.154) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Wed, 29 May 2019 23:14:46 +0000
Date:   Wed, 29 May 2019 16:14:45 -0700
From:   Eduardo Valentin <eduval@amazon.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Jean Delvare <jdelvare@suse.com>,
        <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] hwmon: core: fix potential memory leak in
 *hwmon_device_register*
Message-ID: <20190529231445.GC18339@u40b0340c692b58f6553c.ant.amazon.com>
References: <20190517231337.27859-1-eduval@amazon.com>
 <20190517231337.27859-3-eduval@amazon.com>
 <20190528150640.GA5516@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190528150640.GA5516@roeck-us.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 08:06:40AM -0700, Guenter Roeck wrote:
> Hi Eduardo,
> 
> On Fri, May 17, 2019 at 04:13:37PM -0700, Eduardo Valentin wrote:
> > When registering a hwmon device with HWMON_C_REGISTER_TZ flag
> > in place, the hwmon subsystem will attempt to register the device
> > also with the thermal subsystem. When the of-thermal registration
> > fails, __hwmon_device_register jumps to ida_remove, leaving
> > the locally allocated hwdev pointer and also the hdev registered.
> > 
> > This patch fixes both issues by jumping to a new label that
> > will first unregister hdev and the fall into the kfree of hwdev
> > to finally remove the idas and propagate the error code.
> > 
> > Cc: Jean Delvare <jdelvare@suse.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: linux-hwmon@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Eduardo Valentin <eduval@amazon.com>
> > ---
> >  drivers/hwmon/hwmon.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
> > index 6b3559f58b67..6f1194952189 100644
> > --- a/drivers/hwmon/hwmon.c
> > +++ b/drivers/hwmon/hwmon.c
> > @@ -637,7 +637,7 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  								hwdev, j);
> >  					if (err) {
> >  						device_unregister(hdev);
> > -						goto ida_remove;
> > +						goto device_unregister;
> 
> Good find, but device_unregister() is already called above.
> You need to either remove that, or replace the goto to point to free_hwmon.
> The new label would probably the cleaner solution since it follows the
> coding style.

Right, somehow I completely missed that unregister call. In any case, I will
take the route of adding a new label and remove the unregister call above.

> 
> Thanks
> Guenter
> 
> >  					}
> >  				}
> >  			}
> > @@ -646,6 +646,8 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
> >  
> >  	return hdev;
> >  
> > +device_unregister:
> > +	device_unregister(hdev);
> >  free_hwmon:
> >  	kfree(hwdev);
> >  ida_remove:
> > -- 
> > 2.21.0
> > 

-- 
All the best,
Eduardo Valentin
