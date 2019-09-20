Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A8BC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E6220882
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 15:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gi2fySNF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389942AbfITPAk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 11:00:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20434 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389094AbfITPAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1568991637;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eU6kqPiujW1B3w1mQlqkIqX0q06KEXv+uqjn+5HJvNc=;
        b=Gi2fySNF8UcYhAPPz/VT9eDTRPQmwE7foGxpPVFSflqJDz/SAus96tYv9qM7Nmo+ohUOQn
        7M3061GtDeZviBHNjF8C3iZ9ZSEgNAzfYN2IhK3Vf1i8Wl4vcAli855HDbdfodhoRNDihd
        b2T2c+ELeNvK8p9EPQDTf9qxbI44J0Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-_rsp5isVMd6AkEdp_xgWog-1; Fri, 20 Sep 2019 11:00:34 -0400
Received: by mail-ed1-f71.google.com with SMTP id p55so4395017edc.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2019 08:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LIEvaHWl+TgVQ81gN9syCKlW+rXjlPdhuPqlnIXrkVA=;
        b=t8dff06ICxBFOni9CgO3hYak9vj3PP/2ujTn5PhZJR1V7H6ex5g4slSlGLSqlHov0k
         +Dfonj2WXuVmhMw6G9tiXZ/VvvNnYc3IABHMSpoCQGsV0wy9AlukE5F/zLHY9Ki8H7Ba
         9kdTr4zf21BiIOx2kFOmzTIRrI6dpUTyAYZOATSdr8OXXfgB95otYgj4Ldc1UcIIyJiL
         VndhBOKkyCKxjY9tTYquAiKhxlmh1Dvd3I97lbGN934P5e0HgJecCeu+kciP+FlgYevb
         sfdVC1DqXH7ozrtckQ2vu6IwnxKbAe05Q9BlPEnRModgeBHUG+6BVVdYT7MBUK0MeY0J
         JwnA==
X-Gm-Message-State: APjAAAWwwFoo7pu38p24EYsNran3fkKvNsoXGvCGZ3VAEQyMk66ajtqX
        j2i6vs0DSsi44EOSwhD3QJH80kRUv/q+OMCXKU38CkLmH6rmNgUswSs2Q3UAzuQlUr6Her1EkSC
        mnJBfzUu79YjUWlOm0TqIyzAr
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr18592043ejv.263.1568991632680;
        Fri, 20 Sep 2019 08:00:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyoFOPw5hvUocXOrNuPY0ea52dYYJ7Fm2ithxt7/2Ck81TNLtAlq5H1WkBixjYklFhIo2uaOA==
X-Received: by 2002:a17:906:4d58:: with SMTP id b24mr18591948ejv.263.1568991631923;
        Fri, 20 Sep 2019 08:00:31 -0700 (PDT)
Received: from dhcp-44-196.space.revspace.nl ([2a0e:5700:4:11:6eb:1143:b8be:2b8])
        by smtp.gmail.com with ESMTPSA id y5sm368389edr.94.2019.09.20.08.00.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2019 08:00:31 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
Date:   Fri, 20 Sep 2019 17:00:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919195624.1140941-1-luzmaximilian@gmail.com>
Content-Language: en-US
X-MC-Unique: _rsp5isVMd6AkEdp_xgWog-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/19/19 9:56 PM, Maximilian Luz wrote:
> When registering a serdev controller, ACPI needs to be checked for
> devices attached to it. Currently, all immediate children of the ACPI
> node of the controller are assumed to be UART client devices for this
> controller. Furthermore, these devices are not searched elsewhere.
>=20
> This is incorrect: Similar to SPI and I2C devices, the UART client
> device definition (via UARTSerialBusV2) can reside anywhere in the ACPI
> namespace as resource definition inside the _CRS method and points to
> the controller via its ResourceSource field. This field may either
> contain a fully qualified or relative path, indicating the controller
> device. To address this, we need to walk over the whole ACPI namespace,
> looking at each resource definition, and match the client device to the
> controller via this field.
>=20
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

So as promised I've given this patch a try, unfortunately it breaks
existing users of ACPI serdev device instantation.

After adding this patch "ls /sys/bus/serial/devices" is empty,
where as before it gives:

[root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
total 0
lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci0000:=
00/8086228A:00/serial0
lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci000=
0:00/8086228A:00/serial0/serial0-0

And since the serdev is missing bluetooth does not work.

(ACPI instantiated serdev is used for UART attached Blueooth HCI-s on
many Cherry Trail devices).

I haven't looked why your patch is breakig things, I have a large backlog
so I do not have time for that.

But if you can provide me with a version of the patch with a bunch of
debug printk-s added I'm happy to run that for you.

I'll also send you the DSDT of the device I tested on off-list.

Regards,

Hans




> ---
> This patch is similar to the the implementations in drivers/spi/spi.c
> (see commit 4c3c59544f33e97cf8557f27e05a9904ead16363) and
> drivers/i2c/i2c-core-acpi.c. However, I think that there may be an
> issues with these two implementations: Both walk over the whole ACPI
> namespace, but only match the first SPI or I2C resource (respectively),
> so I think there may be problems when multiple SPI or I2C resources are
> defined under the same ACPI device node (as in second or third SPI/I2C
> resource definitions being ignored). Please note, however, that I am by
> no means qualified with regards to this, and this might be totally fine.
> Nevertheless I'd appreciate if anyone with more knowledge on the subject
> could have a look at it. This patch would avoid this problem (for UART)
> by simply walking all resource definitions via acpi_walk_resources.
>=20
> There is a further issue in the serdev ACPI implementation that this
> patch does not address: ACPI UART resource definitions contain things
> like the initial baud-rate, parity, flow-control, etc. As far as I know,
> these things can currently only be set once the device is opened.
> Furthermore, some option values, such as ParityTypeMark, are not (yet)
> supported. I'd be willing to try and implement setting the currently
> supported values based on ACPI for a future patch, if anyone can provide
> me with some pointers on how to do that.
>=20
> I have personally tested this patch on a Microsoft Surface Book 2, which
> like all newer MS Surface devices has a UART EC, and it has been in use
> (in some form or another) for a couple of months on other Surface
> devices via a patched kernel [1, 2, 3]. I can, however, not speak for
> any non-Microsoft devices or potential Apple ACPI quirks.
>=20
> [1]: https://github.com/jakeday/linux-surface/
> [2]: https://github.com/qzed/linux-surface/
> [3]: https://github.com/qzed/linux-surfacegen5-acpi/
>=20
>   drivers/tty/serdev/core.c | 64 ++++++++++++++++++++++++++++++++++-----
>   1 file changed, 56 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
> index a0ac16ee6575..1c8360deea77 100644
> --- a/drivers/tty/serdev/core.c
> +++ b/drivers/tty/serdev/core.c
> @@ -582,18 +582,64 @@ static acpi_status acpi_serdev_register_device(stru=
ct serdev_controller *ctrl,
>   =09return AE_OK;
>   }
>  =20
> -static acpi_status acpi_serdev_add_device(acpi_handle handle, u32 level,
> -=09=09=09=09       void *data, void **return_value)
> +struct acpi_serdev_resource_context {
> +=09struct serdev_controller *controller;
> +=09struct acpi_device *device;
> +};
> +
> +static acpi_status
> +acpi_serdev_add_device_from_resource(struct acpi_resource *resource, voi=
d *data)
>   {
> -=09struct serdev_controller *ctrl =3D data;
> -=09struct acpi_device *adev;
> +=09struct acpi_serdev_resource_context *ctx
> +=09=09=3D (struct acpi_serdev_resource_context *)data;
> +=09struct acpi_resource_source *ctrl_name;
> +=09acpi_handle ctrl_handle;
> +
> +=09if (resource->type !=3D ACPI_RESOURCE_TYPE_SERIAL_BUS)
> +=09=09return AE_OK;
>  =20
> -=09if (acpi_bus_get_device(handle, &adev))
> +=09if (resource->data.common_serial_bus.type
> +=09    !=3D ACPI_RESOURCE_SERIAL_TYPE_UART)
>   =09=09return AE_OK;
>  =20
> -=09return acpi_serdev_register_device(ctrl, adev);
> +=09ctrl_name =3D &resource->data.common_serial_bus.resource_source;
> +=09if (ctrl_name->string_length =3D=3D 0 || !ctrl_name->string_ptr)
> +=09=09return AE_OK;
> +
> +=09if (acpi_get_handle(ctx->device->handle, ctrl_name->string_ptr,
> +=09=09=09    &ctrl_handle))
> +=09=09return AE_OK;
> +
> +=09if (ctrl_handle =3D=3D ACPI_HANDLE(ctx->controller->dev.parent))
> +=09=09return acpi_serdev_register_device(ctx->controller,
> +=09=09=09=09=09=09   ctx->device);
> +
> +=09return AE_OK;
>   }
>  =20
> +static acpi_status
> +acpi_serdev_add_devices_from_resources(acpi_handle handle, u32 level,
> +=09=09=09=09       void *data, void **return_value)
> +{
> +=09struct acpi_serdev_resource_context ctx;
> +=09acpi_status status;
> +
> +=09ctx.controller =3D (struct serdev_controller *)data;
> +=09status =3D acpi_bus_get_device(handle, &ctx.device);
> +=09if (status)
> +=09=09return AE_OK;=09=09// ignore device if not present
> +
> +=09status =3D acpi_walk_resources(handle, METHOD_NAME__CRS,
> +=09=09=09=09     acpi_serdev_add_device_from_resource,
> +=09=09=09=09     &ctx);
> +=09if (status =3D=3D AE_NOT_FOUND)
> +=09=09return AE_OK;=09=09// ignore if _CRS is not found
> +=09else
> +=09=09return status;
> +}
> +
> +#define SERDEV_ACPI_ENUMERATE_MAX_DEPTH=09=0932
> +
>   static int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>   {
>   =09acpi_status status;
> @@ -603,8 +649,10 @@ static int acpi_serdev_register_devices(struct serde=
v_controller *ctrl)
>   =09if (!handle)
>   =09=09return -ENODEV;
>  =20
> -=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, 1,
> -=09=09=09=09     acpi_serdev_add_device, NULL, ctrl, NULL);
> +=09status =3D acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> +=09=09=09=09     SERDEV_ACPI_ENUMERATE_MAX_DEPTH,
> +=09=09=09=09     acpi_serdev_add_devices_from_resources,
> +=09=09=09=09     NULL, ctrl, NULL);
>   =09if (ACPI_FAILURE(status))
>   =09=09dev_dbg(&ctrl->dev, "failed to enumerate serdev slaves\n");
>  =20
>=20

