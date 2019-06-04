Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196ECC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E120F24AF2
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 10:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qYCsaPX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbfFDKdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 06:33:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40028 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726877AbfFDKdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 06:33:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id p11so10400023wre.7;
        Tue, 04 Jun 2019 03:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=earafvYrtHKW675fqvDjWCC/8Qf9Geg5oAtOEq+3h4s=;
        b=qYCsaPX3965LwfBNITJf+QhEYqlYgjqgsLeUo6L/o7Ti1263rsedKnAiaw0j/tRPYf
         t42+5ATBBW5NZ/DDqebnlSmYiiaibe+Ort8iULSCZwFuujnCieGl8uZ7Nt4G5H+Pmifq
         klXo8h/0txLzbeK5bbJCSYy0SQufMmnyMt/cQidS6idO0iNK5oPFONK/ARuzTp/MgUJR
         0O4s6+8SxMW1Mt8gJwDTk/VtfmK4MyDDlpTftFih4oTtkL09uKN3bS8R2vKL5UE5GACx
         H5V88iRDEJiBwtV6kFqssasb39pa+qvMJD2ksOrv5cM+odfqp6Eza3vLq9Bwr4PnoGBz
         +b3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=earafvYrtHKW675fqvDjWCC/8Qf9Geg5oAtOEq+3h4s=;
        b=NZR0ziiQC+BgBhJd1FinFySOqovBONzYb2gwvt9zwbNxi9ldB+W1c8RBVuDO6mGNpk
         PRr4+i1hM3ZKC6CFt3Txpixfhectt2Ygclj11rfj8yawGfcE4HCiOGJ1gv+NF66C8tfH
         W25WqtCZB/WGCHVpdmnTkOTjBypCBvkdWmk/ZADLxXLGOP9L8JiYDt/r4DCRuB2fPd4O
         XCX+I/a+FArzX9tRLlOQ4znmtzkhibLIGJ2jR89jA5olowEcwphSgdLMBFTMb9aHTX3k
         VLwLyWl4aJl7TvaQzysJ1FuFpuMGrqnFfnUxQsZ1XJHRsEcockEU1yO+6lp8gBNUSFb3
         7gxQ==
X-Gm-Message-State: APjAAAVlUU5TggkhPAqcyfwieEYiuC22RNUy6icTnhP2svvxTT3B0osO
        2rRDW/qUZzpnWcNtHm3dDJs=
X-Google-Smtp-Source: APXvYqzvrV4tFMgHpWkR4RpdGNb7oSeNaRa2s36bVeHEWmNTjau4k7L60C8i2Ea7H2n+YhYaHfNOvA==
X-Received: by 2002:a5d:694c:: with SMTP id r12mr6551209wrw.214.1559644391661;
        Tue, 04 Jun 2019 03:33:11 -0700 (PDT)
Received: from 5WDYG62 (static-css-cqn-143221.business.bouyguestelecom.com. [176.149.143.221])
        by smtp.gmail.com with ESMTPSA id o21sm16990674wmc.46.2019.06.04.03.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Jun 2019 03:33:10 -0700 (PDT)
Date:   Tue, 4 Jun 2019 12:33:03 +0200
From:   Romain Izard <romain.izard.pro@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Richard Gong <richard.gong@linux.intel.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, dinguyen@kernel.org, atull@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sen.li@intel.com, Richard Gong <richard.gong@intel.com>
Subject: Re: A potential broken at platform driver?
Message-ID: <20190604103241.GA4097@5WDYG62>
References: <1559074833-1325-1-git-send-email-richard.gong@linux.intel.com>
 <1559074833-1325-3-git-send-email-richard.gong@linux.intel.com>
 <20190528232224.GA29225@kroah.com>
 <1e3b5447-b776-f929-bca6-306f90ac0856@linux.intel.com>
 <b608d657-9d8c-9307-9290-2f6b052a71a9@linux.intel.com>
 <20190603180255.GA18054@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603180255.GA18054@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 08:02:55PM +0200, Greg KH wrote:
> > @@ -394,7 +432,7 @@ static struct platform_driver stratix10_rsu_driver = {
> >  	.remove = stratix10_rsu_remove,
> >  	.driver = {
> >  		.name = "stratix10-rsu",
> > -		.groups = rsu_groups,
> > +//		.groups = rsu_groups,
> 
> Are you sure this is the correct pointer?  I think that might be
> pointing to the driver's attributes, not the device's attributes.
> 
> If platform drivers do not have a way to register groups properly, then
> that really needs to be fixed, as trying to register it by yourself as
> you are doing, is ripe for racing with userspace.
 
This is a very common issue with platform drivers, and it seems to me that
it is not possible to add device attributes when binding a device to a
driver without entering the race condition.

My understanding is the following one:

The root cause is that the device has already been created and reported
to the userspace with a KOBJ_ADD uevent before the device and the driver
are bound together. On receiving this event, userspace will react, and
it will try to read the device's attributes. In parallel the kernel will
try to find a matching driver. If a driver is found, the kernel will
call the probe function from the driver with the device as a parameter,
and if successful a KOBJ_BIND uevent will be sent to userspace, but this
is a recent addition.

Unfortunately, not all created devices will be bound to a driver, and the
existing udev code relies on KOBJ_ADD uevents rather than KOBJ_BIND uevents.
If new per-device attributes have been added to the device during the
binding stage userspace may or may not see them, depending on when userspace
tries to read the device's attributes.

I have this possible workaround, but I do not know if it is a good solution:

When binding the device and the driver together, create a new device as a
child to the current device, and fill its "groups" member to point to the
per-device attributes' group. As the device will be created with all the
attributes, it will not be affected by the race issues. The functions
handling the attributes will need to be modified to use the parents of their
"device" parameter, instead of the device itself. Additionnaly, the sysfs
location of the attributes will be different, as the child device will show
up in the sysfs path. But for a newly introduced device this will not be
a problem.

Is this a good compromise ?

Best regards,
-- 
Romain Izard
