Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555FAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D5120820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A2KujDtS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437560AbfIWIOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:14:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38154 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2437271AbfIWIOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1569226485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WgjhOA0zyVcAZNXjRIcpen414kkZtL+EdIeyI3wtD/s=;
        b=A2KujDtSR+8xDXv5y11wsB6MOkOniIOQroZI+w0BGQqm1DQ80cFsT9s893pL3wycoFEn0c
        z27DYoA3C4TbkMxBVtUS8zbkonU675g8Qpi+fUj33u4CI22OKH2iZ9xg/DqE2tyIaUNgev
        K20HxnCqLSs7xEANzDaNlV9l3lWz+Qc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-TSfk1Wp3NYKK8mvxKhCvPg-1; Mon, 23 Sep 2019 04:14:43 -0400
Received: by mail-ed1-f72.google.com with SMTP id n14so8403884edt.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 01:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SGnsNHhO6VDfdoucoStGXGb4btl6LzMLnLQlg8egQPM=;
        b=MMTXA/aORal1nJAaumG5ShjSDysf1y4rf6J/ws+etxQwk7arPpUfbLHkeMIS6BFA+C
         8mo1HZJQhZKn4g3IlcbwqlfXazIjjZ8wTIo2g+FUs4UgFtPQ2khNkGRJXr2ixBb/Wdz0
         OUsMxEwc7bYwb1oDnyx9i9pWbFfRGc2QfiCt7wWbrPwPgR6vxLnuafr3UBzu6YINtFnd
         bsiXAOu7fsOpKpTSfkh9ZgCVWqkQqj3H503UOGDL6rrqZhCNlVNJRHDUldwLQj6KhuVv
         J4KetEfx1c8/TwuLPK041Q5P0LfHyf8CFTvBjStoKQM0GVIIErBmGKuPTw88bCa5q5U0
         dx8Q==
X-Gm-Message-State: APjAAAWxMzVFC1zXIaIPEPOctkoF1hh2sHhnzGoqYQCbbXTZVLrdERvk
        LhUsPWCVIlG3oWyGIH3FnxBx9v6Lf7n6zBFzhdJaAVeCgUnBcpf30LdKQBCPef9Fg5sD1mspfac
        /+4HNDjV3t7oVagDiPOaWiS+r
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189229ede.51.1569226482500;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxc5e7k3VAzRdcPID6YxsIF0up8i6QsaNpxbtG6XkJUN3zr6gMWoDf/Moazau7pRW8wC7jlxQ==
X-Received: by 2002:a50:8933:: with SMTP id e48mr35189208ede.51.1569226482339;
        Mon, 23 Sep 2019 01:14:42 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id b16sm1025855eju.74.2019.09.23.01.14.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 01:14:41 -0700 (PDT)
Subject: Re: [PATCH] serdev: Add ACPI devices by ResourceSource field
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190919195624.1140941-1-luzmaximilian@gmail.com>
 <50b016a1-ed4a-b848-4658-a05731727d7e@redhat.com>
 <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8bed7cde-1f59-c5bf-9506-757dd89ad594@redhat.com>
Date:   Mon, 23 Sep 2019 10:14:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <4c2cc8b7-8541-0912-3162-399777dc8dd2@gmail.com>
Content-Language: en-US
X-MC-Unique: TSfk1Wp3NYKK8mvxKhCvPg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-09-2019 00:29, Maximilian Luz wrote:
> Hi all,
>=20
> On 9/20/19 5:00 PM, Hans de Goede wrote:
>> So as promised I've given this patch a try, unfortunately it breaks
>> existing users of ACPI serdev device instantation.
>>
>> After adding this patch "ls /sys/bus/serial/devices" is empty,
>> where as before it gives:
>>
>> [root@dhcp-45-50 ~]# ls -l /sys/bus/serial/devices/
>> total 0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0 -> ../../../devices/pci00=
00:00/8086228A:00/serial0
>> lrwxrwxrwx. 1 root root 0 Sep 20 16:43 serial0-0 -> ../../../devices/pci=
0000:00/8086228A:00/serial0/serial0-0
>>
>> And since the serdev is missing bluetooth does not work.
>=20
> Thanks to some testing by Hans, it turns out that the reason for this is
> that acpi_walk_resources fails with AE_AML_INVALID_RESOURCE_TYPE for a
> specific device. If anyone is interested, the _CRS of the device in
> question is
>=20
>  =C2=A0=C2=A0=C2=A0 Method (_CRS, 0, NotSerialized)=C2=A0 // _CRS: Curren=
t Resource Settings
>  =C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (NAM, Buffer (0x14)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "\\_S=
B.PCI0.SDHB.BRC1"
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (SPB, Buffer (0x0C)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
00 */=C2=A0 0x8E, 0x1D, 0x00, 0x01, 0x00, 0xC0, 0x02, 0x00,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 00=
08 */=C2=A0 0x00, 0x01, 0x00, 0x00
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Name (END, ResourceTemplate (=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 })
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (SPB, NAM, Local0=
)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Concatenate (Local0, END, Loc=
al1)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Return (Local1)
>  =C2=A0=C2=A0=C2=A0 }
>=20
> To solve this, I propose ignoring errors that occur when evaluating the
> _CRS method. Note that with the previously discussed change for v2,
> where we will only look at the first device in _CRS, we should be able
> to handle errors from the actual serdev device allocation separately
> (and only ignore AML evaluation errors).
>=20
> Further, I think it might also make sense to move the status and
> already-enumerated checks out of acpi_serdev_register_device to before
> looking at _CRS.

Ack, this is what drivers/i2c/i2c-core-acpi.c is doing and more in general
all ACPI enumeration code always first checks _STA before doing anything
else, so I think it would be best to do this here too.

Actually I think it might be best to fully copy how drivers/i2c/i2c-core-ac=
pi.c
does things.

Regards,

Hans

