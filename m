Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41021C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A788206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 10:04:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ewHpbL8X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfKNKEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 05:04:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725977AbfKNKEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 05:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573725860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLl4ACsFJPD0eyiByuCfJkYMTcF52xdC015U8Ny7BfU=;
        b=ewHpbL8XuosxCAnVAnsfVRlvx9rcx+MUuWz/vyVgJa3VB5gPIz5K69BqOg7prmXOU9aSry
        raQxArXVTsQF1lSMb68OAqjhoZNt2JfvB9pHfrixIRgpaazf+M1aFjRiQl9rbkxNCqLtZs
        3mxqtWQBhlzC3811aLBmwO+lnvBK5bY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-TQbE3uXJP327T7ab2sT5rw-1; Thu, 14 Nov 2019 05:04:19 -0500
Received: by mail-wm1-f70.google.com with SMTP id g13so3867221wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 02:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MIYY6vTJ40iNpcIA6nOMAvyesiyY+lIANTNB53LU3fw=;
        b=X03BMYvEV59WQOv6BxixMT7wiDu+kNYwEmaVQexm77FL818G3TWz73sVqsa6HfzyJk
         2kn5xd5jDlruE/gXT+yMv4P0CJUraiGgqjIi8vdbzRjB2r8JmnjuLJ/FiLuuls+VBeiK
         /WgccTxFpRHEndx7BqSn4C+NqwUPdeWzx970krjhtwkeIovmyj/OtIwPdKcT5cq9Eg+Z
         0gbZLU0IU5eAUK6WeR/U8R2oYuu2+idCiEL22DRgHYS3sc8lKWF6EeB/k7TqJ6WOZSO5
         Fuz7UanCGbS/vNt4sNybNoPNTTtDdcBU8gIxa26EenUQPhORXJ7g9vS4MRH1eARmCYZC
         0CxA==
X-Gm-Message-State: APjAAAUEj7ThNGL44koH524WVmjPIFACWnDNm40L/x/bRO+ddxdIiEvO
        emMb31maqvStepM+aceQyaYG4wVSw+8lfHk2jgbowHi/17KkGQZdoIZPZ+FhiSH6CKOZqwxg1fy
        zMNeb559TPb2vBI7cP6dtig7a
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr7088533wrr.88.1573725858622;
        Thu, 14 Nov 2019 02:04:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqyOtVn0G+YuKxp+AJfhyXSauq4aTtil7UF2WPkekaphH4ARhSylyzFJu+uHYsv/QY5pO9f4yg==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr7088501wrr.88.1573725858332;
        Thu, 14 Nov 2019 02:04:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y6sm6459803wrr.19.2019.11.14.02.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 02:04:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "sashal\@kernel.org" <sashal@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv\@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of Hyper-V synic
In-Reply-To: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
References: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
Date:   Thu, 14 Nov 2019 11:04:16 +0100
Message-ID: <87mucykc4f.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
X-MC-Unique: TQbE3uXJP327T7ab2sT5rw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Kelley <mikelley@microsoft.com> writes:

> The crash handler calls hv_synic_cleanup() to shutdown the
> Hyper-V synthetic interrupt controller.  But if the CPU
> that calls hv_synic_cleanup() has a VMbus channel interrupt
> assigned to it (which is likely the case in smaller VM sizes),
> hv_synic_cleanup() returns an error and the synthetic
> interrupt controller isn't shutdown.  While the lack of
> being shutdown hasn't caused a known problem, it still
> should be fixed for highest reliability.
>
> So directly call hv_synic_disable_regs() instead of
> hv_synic_cleanup(), which ensures that the synic is always
> shutdown.

Generally, when performing kdump doing as little work as possible is
always preferred and hv_synic_cleanup() does too much: taking mutex,
walking through channel list,...=20

Also, hv_synic_cleanup() was calling hv_stimer_cleanup() and we have a
second redundant invocation in hv_crash_handler().

>
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 664a415..665920d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -2305,7 +2305,7 @@ static void hv_crash_handler(struct pt_regs *regs)
>  =09vmbus_connection.conn_state =3D DISCONNECTED;
>  =09cpu =3D smp_processor_id();
>  =09hv_stimer_cleanup(cpu);
> -=09hv_synic_cleanup(cpu);
> +=09hv_synic_disable_regs(cpu);
>  =09hyperv_cleanup();
>  };

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

--=20
Vitaly

