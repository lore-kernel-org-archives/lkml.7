Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B0C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940020708
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 11:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mork.no header.i=@mork.no header.b="Y0ozO5lX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfKVLjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 06:39:24 -0500
Received: from canardo.mork.no ([148.122.252.1]:55969 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfKVLjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 06:39:24 -0500
Received: from miraculix.mork.no ([IPv6:2a02:2121:282:b3eb:68e2:39ff:fe1c:1a78])
        (authenticated bits=0)
        by canardo.mork.no (8.15.2/8.15.2) with ESMTPSA id xAMBcrd3005262
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Nov 2019 12:38:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mork.no; s=b;
        t=1574422737; bh=wfYrn3KtkSHcvrkxgI6n4PBGeVoGDfOTKtruuPGGVD4=;
        h=From:To:Cc:Subject:References:Date:Message-ID:From;
        b=Y0ozO5lXpA+nwFd29Y53ZFWliMxTIZUoU2vGigHCp06zXYVgT4HjsfX260dOCgda8
         s9VL66MrecBltNUHScS93Oa9ec83fuFi67P8jYkNbkQhhAftmKQrAdqzRPOJBOakaZ
         2Puo0GUCo5i0m99zkforlECblwQ5qPt5hpJedpgg=
Received: from bjorn by miraculix.mork.no with local (Exim 4.92)
        (envelope-from <bjorn@mork.no>)
        id 1iY7Gx-0006wV-VL; Fri, 22 Nov 2019 12:38:47 +0100
From:   =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
To:     Yongxin Liu <yongxin.liu@windriver.com>
Cc:     <andy@infradead.org>, <dvhart@infradead.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mario.limonciello@dell.com>
Subject: Re: [PATCH] Revert "platform/x86: wmi: Destroy on cleanup rather than unregister"
Organization: m
References: <20191115052710.46880-1-yongxin.liu@windriver.com>
Date:   Fri, 22 Nov 2019 12:38:47 +0100
In-Reply-To: <20191115052710.46880-1-yongxin.liu@windriver.com> (Yongxin Liu's
        message of "Fri, 15 Nov 2019 13:27:10 +0800")
Message-ID: <87blt45eew.fsf@miraculix.mork.no>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.101.4 at canardo
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yongxin Liu <yongxin.liu@windriver.com> writes:

> This reverts commit 7b11e8989618581bc0226ad313264cdc05d48d86.
>
> Consider the following hardware setting.
>
> |-PNP0C14:00
> |  |-- device #1
> |-PNP0C14:01
> |  |-- device #2
>
> When unloading wmi driver module, device #2 will be first unregistered.
> But device_destroy() using MKDEV(0, 0) will locate PNP0C14:00 first
> and unregister it. This is incorrect. Should use device_unregister() to
> unregister the real parent device.
>
> Signed-off-by: Yongxin Liu <yongxin.liu@windriver.com>
> ---
>  drivers/platform/x86/wmi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index 59e9aa0f9643..e16f660aa117 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -1347,7 +1347,7 @@ static int acpi_wmi_remove(struct platform_device *=
device)
>  	acpi_remove_address_space_handler(acpi_device->handle,
>  				ACPI_ADR_SPACE_EC, &acpi_wmi_ec_space_handler);
>  	wmi_free_devices(acpi_device);
> -	device_destroy(&wmi_bus_class, MKDEV(0, 0));
> +	device_unregister((struct device *)dev_get_drvdata(&device->dev));
>=20=20
>  	return 0;
>  }
> @@ -1401,7 +1401,7 @@ static int acpi_wmi_probe(struct platform_device *d=
evice)
>  	return 0;
>=20=20
>  err_remove_busdev:
> -	device_destroy(&wmi_bus_class, MKDEV(0, 0));
> +	device_unregister(wmi_bus_dev);
>=20=20
>  err_remove_notify_handler:
>  	acpi_remove_notify_handler(acpi_device->handle, ACPI_DEVICE_NOTIFY,


Definitely!  Good catch!

device_create() will allow registering multiple devices with a zero
major.  Using device_destroy() with MKDEV(0, 0) will unregister an
arbitrary one of them.

I believe all of these should be reviewed and fixed up:

drivers/nvme/host/fabrics.c:    device_destroy(nvmf_class, MKDEV(0, 0));
drivers/nvme/host/fabrics.c:    device_destroy(nvmf_class, MKDEV(0, 0));
drivers/nvme/host/fc.c: device_destroy(&fc_class, MKDEV(0, 0));
drivers/nvme/host/fc.c: device_destroy(&fc_class, MKDEV(0, 0));
drivers/nvme/target/fcloop.c:   device_destroy(fcloop_class, MKDEV(0, 0));
drivers/platform/x86/wmi.c:     device_destroy(&wmi_bus_class, MKDEV(0, 0));
drivers/platform/x86/wmi.c:     device_destroy(&wmi_bus_class, MKDEV(0, 0));
drivers/staging/comedi/drivers/comedi_test.c:   device_destroy(ctcls, MKDEV=
(0, 0));
drivers/staging/comedi/drivers/comedi_test.c:           device_destroy(ctcl=
s, MKDEV(0, 0));
drivers/video/fbdev/core/fbcon.c:       device_destroy(fb_class, MKDEV(0, 0=
));
net/netfilter/xt_IDLETIMER.c:   device_destroy(idletimer_tg_class, MKDEV(0,=
 0));
net/netfilter/xt_IDLETIMER.c:   device_destroy(idletimer_tg_class, MKDEV(0,=
 0));


Note that most of these probably are not bugs.  yet...

But there is no reason to look up the device by dev_t for drivers
allowing only one device anyway. Using device_unregister() directly
makes the code easier to follow and prevents future bugs in case
someone decides to support more devices.

Maybe we should add a WARN_ON(!MAJOR(devt)) or similar to
device_destroy() to prevent similar future problems?


Bj=C3=B8rn
