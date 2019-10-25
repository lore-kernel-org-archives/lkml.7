Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891FFCA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB7020578
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 10:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571998437;
	bh=pX8I7MddPjhiQt1tmFZPNzNEVzJyim/J8/uVuvd/pfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=0wH3M+yiFAF8tzBYRzr3U7Smnot8r+uzebD5HDbegsiyNJ4AwYB+sOPym7MYiEbjj
	 LPZr7zA1nXG2nxvBhZ47xiE3B+okk4y2AvgBDqf9yfwmWaCRcDfQ+aNVZliezVX9O+
	 pLWy1EsuzWXKV3gE+8MK5oUZ931T8euj3eGa1ruk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409191AbfJYKN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 06:13:56 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34314 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405970AbfJYKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 06:13:56 -0400
Received: by mail-lf1-f68.google.com with SMTP id f5so1282009lfp.1;
        Fri, 25 Oct 2019 03:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=pX8I7MddPjhiQt1tmFZPNzNEVzJyim/J8/uVuvd/pfQ=;
        b=oo3kXop08vDvHnbsuRDxvT3y0x5vjdOTyTKqP76miGg7pBdv3KOUZXIr4VhcTJwVk5
         cCCtzymOA5BNbym+xOUJKM35VS0/ZgAWJPo0ON2oIuXKq7ZXupCwAQ0YtyiYiS5sUBRw
         90aydh/cL4t4kEu0vV7qjjaqrAeOJRgVIVU241m1Pv/JFZq4dmYkkZC3OThYMcbgUh/V
         IEfgLKA1W0ITNpVuITJzzH22vq0wOjVzJeMVXRe/NxWr4dfEUPrS/q93zHVJ+sbsagRZ
         KtJHlAS/+6DzSh4iR3ENN7z5Q6rPfxW8i2NkyOxOTEPo4Qh3AVRXnRcVpwSta3qmR/Ed
         yHVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=pX8I7MddPjhiQt1tmFZPNzNEVzJyim/J8/uVuvd/pfQ=;
        b=CNlOJ50lamSe86pxaaC0DDTUOdQPlxbzhJNbNlFwlTN1vA3Lwu6cF4g6ozBfpPkpZW
         UO1vSFH03M+q0df5HcJ5Q5KeYMGxelWveWbnjkfEIUMI4l2Um2hjuJVL23Lyng9Hwp4a
         NGcbnszN1YoIRXH/EuVVG3CW5F5pAVh8hZs34T7onAmIU+98rmGnmAuWPtYUOOEv6aZh
         IdyhzACJzREhI4RRGT90GTEVHWnSTnlN6ND/wop3GWMsBb8j275sKlr3O5dNNdiXLWg7
         RZEXmtZ8pmdsFejSzCq2A6YjlC9Ozv+A6hWBPWxp/bASAIM2rBKBK6fg0hiIrTUBJdaJ
         vyNA==
X-Gm-Message-State: APjAAAXJBzayKt0FcDFkoCsIVyCmKoq9IiECkSQLTZmTiRKuEcU9UCrm
        DjVC/mDIKX46ZJhFp3PNcR48kVtz0dq4NdwX
X-Google-Smtp-Source: APXvYqzcJ4s/IAQ2BA+QGiJZPkxDc8DDgYD+6MmPWEX6PPu+11wNM6nHgaxqryM5bir0htVl93PYxA==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr2097986lfh.85.1571998433190;
        Fri, 25 Oct 2019 03:13:53 -0700 (PDT)
Received: from saruman (85-76-160-55-nat.elisa-mobile.fi. [85.76.160.55])
        by smtp.gmail.com with ESMTPSA id k82sm792084lje.101.2019.10.25.03.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 03:13:52 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Roger Quadros <rogerq@ti.com>, Peter Chen <peter.chen@nxp.com>,
        Pawel Laszczak <pawell@cadence.com>
Cc:     "felipe.balbi\@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh\@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "nsekhar\@ti.com" <nsekhar@ti.com>,
        Rahul Kumar <kurahul@cadence.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: cdns3: gadget: Don't manage pullups
In-Reply-To: <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
References: <20191023090232.27237-1-rogerq@ti.com> <BYAPR07MB4709A6212601A75DCB1A25ACDD6B0@BYAPR07MB4709.namprd07.prod.outlook.com> <20191025031343.GA13392@b29397-desktop> <83a1da01-19d6-65a9-aecd-2027fd62a272@ti.com>
Date:   Fri, 25 Oct 2019 13:14:33 +0300
Message-ID: <87y2x9xhbq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Roger Quadros <rogerq@ti.com> writes:
> On 25/10/2019 06:13, Peter Chen wrote:
>> On 19-10-23 09:17:45, Pawel Laszczak wrote:
>>> Hi,
>>>
>>> Reviewed-by: Pawel Laszczak <pawell@cadence.com>
>>=20
>> Hi Roger & Pawel,
>>=20
>> Assume gadget function has already enabled, if you switch host mode
>> to device mode, with your changes, where the device mode will be enabled
>> again?
>
> When it switches from device mode to host the UDC is removed. When we swi=
tch
> back from host to device mode the UDC is added, so,
>
> usb_add_gadget_udc_release()-> check_pending_gadget_drivers()->
> udc_bind_to_driver()->usb_udc_connect_control()->usb_gadget_connect()->
> gadget->ops->pullup()

I agree with Roger here. UDC shouldn't try to manage pullups
directly. If there are any bugs related to role switch, we should fix it
in udc core, so the fix applies to everyone ;-)

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl2yywkACgkQzL64meEa
mQZhnA/+KbCx3ho/LG/P+vHwaG8HWQT4rebxmRH2GjM8sbRwREGP0EDPJORGHscd
oLLXpFnLcoaph2dRzJaLi51CMdseCkEoPAC5ElNMRixhhIE0hvA6GEFlJh2CaBEl
tQtMZ5PTurQam4i8biyu9sGZtOzmg2LIibUsP5bcGJAqgPMSlmvuOpMaDBGuYi5I
4mvbwAszsizQT1skMDFiIuHYIMQ9shAOLkTz2k6ARC7nLFKtqBcaM/zSwkxrW3E3
u1CL7HQqWa5IDC4L2OvvVCdjc9JWMY35k1yvf4vGChyTUPLdksIo2TFJ5k3MSkP4
0djrSTQbox0iHimscZbaD9iPEX02/0et9M9/Lf+0phQ6GT5gRaDfRF+KN/gu5Jbo
EUTJIsmOKaXuLW0pxLs2HwiudpE3de8VG28acQayqCq5JEMcffGVOrsoBczE+0M9
jueAqXvy/e96hq5MnIsF40N9sWQG4qq53gChj7KU0VRlVlhXoIfP8hw59O4FCuPI
zw0RnmwhjMGyinh0E97j9WXRa6PjsjMWX68f1cOs1JSM08T+YdoiW9bjZK3yNqBG
PchUVJ5GgGiIEP02APziCb2rwCLFztI5wiZ4IlItQcyNxnRRqlB1jV1ilaN35Q0e
qlq6pcytzDHpvGQ/P8ehMJfWpDOxDwYpX58f5x7Jloue2aWT1bE=
=SMdL
-----END PGP SIGNATURE-----
--=-=-=--
