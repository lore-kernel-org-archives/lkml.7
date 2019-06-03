Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A83C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9275426A4C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 23:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xfn13xPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFCXDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 19:03:02 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35143 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbfFCXDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 19:03:02 -0400
Received: by mail-pf1-f195.google.com with SMTP id d126so11473157pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2019 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=M0Hol1AOy0PKp1c8t8OnpXkvg1N8/Tmp5x6wPCFFMsw=;
        b=Xfn13xPJjjwbLXR9uug3Z3G6LQb+xBE4ONBMi76WHafAXU8u3CBRtuKcEB+IYyRXLD
         df0YOzJAgsBizPo4j8K2kObvDFTIa00ANWFb0BsDU0KgNxuBCjcQy0Ye0Glb5SZ8I7Uy
         d0e1kVim0sDFhNYzBkTSEazmw7ZzArabm1gNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=M0Hol1AOy0PKp1c8t8OnpXkvg1N8/Tmp5x6wPCFFMsw=;
        b=IcE9TGJVYP4FZUSXBZECCc0Wfm2jog5mPHKBNt573iK8IG2ik8BVJz1Bos8tsShg7O
         yd/ThbZPjY7INJjd+oDwbTnGkNBTTUraAfr1YUiZ5ANqueOJXqyBmG911z+ya+Zik0xn
         kvxjD8kpqGNyxkrSvvMpb/Lqzw2DVY6i9yKnPcKoADMqvsGq0ZR48SaHMLBedoBWjQ+J
         KBEaWe60jALctEkSfNQ97bJJxGxU/vMO+Wb9UTBa5k20uHZ4Xuf5jcnKvmWGXC251Ibm
         8d9Skr0rhbJdAcgv4PBAcHeyCMBU0TcPJtvvizmaB62JBDAutQoXyqoQV7ZW5CxI+MUO
         1PWA==
X-Gm-Message-State: APjAAAWrPsKW7ehwzlaGcckMUCqaqNykdNVCZOOa11lrUpC1AwzPhkhR
        rFrYRuyyLXF9fQKUJRgCAsxaAQ==
X-Google-Smtp-Source: APXvYqxm7Ws5lscObY+oPn1h3+ONhLwXf8YRLVndDfYmndsXiVoHaByRfk1oBLv+cxwcrRXvWyohLg==
X-Received: by 2002:a63:6c87:: with SMTP id h129mr32302973pgc.427.1559602981281;
        Mon, 03 Jun 2019 16:03:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c142sm17390174pfb.171.2019.06.03.16.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 16:03:00 -0700 (PDT)
Message-ID: <5cf5a724.1c69fb81.1e8f0.08fb@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190221203334.24504-1-helen.koike@collabora.com>
References: <20190221203334.24504-1-helen.koike@collabora.com>
Cc:     wad@chromium.org, keescook@chromium.org, snitzer@redhat.com,
        linux-doc@vger.kernel.org, richard.weinberger@gmail.com,
        linux-kernel@vger.kernel.org, linux-lvm@redhat.com,
        enric.balletbo@collabora.com, kernel@collabora.com, agk@redhat.com
To:     Helen Koike <helen.koike@collabora.com>, dm-devel@redhat.com
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12] dm: add support to directly boot to a mapped device
User-Agent: alot/0.8.1
Date:   Mon, 03 Jun 2019 16:02:59 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Helen Koike (2019-02-21 12:33:34)
> Add a "create" module parameter, which allows device-mapper targets to be
> configured at boot time. This enables early use of dm targets in the boot
> process (as the root device or otherwise) without the need of an initramf=
s.
>=20
> The syntax used in the boot param is based on the concise format from the
> dmsetup tool to follow the rule of least surprise:
>=20
>         sudo dmsetup table --concise /dev/mapper/lroot
>=20
> Which is:
>         dm-mod.create=3D<name>,<uuid>,<minor>,<flags>,<table>[,<table>+][=
;<name>,<uuid>,<minor>,<flags>,<table>[,<table>+]+]
>=20
> Where,
>         <name>          ::=3D The device name.
>         <uuid>          ::=3D xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx | ""
>         <minor>         ::=3D The device minor number | ""
>         <flags>         ::=3D "ro" | "rw"
>         <table>         ::=3D <start_sector> <num_sectors> <target_type> =
<target_args>
>         <target_type>   ::=3D "verity" | "linear" | ...
>=20
> For example, the following could be added in the boot parameters:
> dm-mod.create=3D"lroot,,,rw, 0 4096 linear 98:16 0, 4096 4096 linear 98:3=
2 0" root=3D/dev/dm-0
>=20
> Only the targets that were tested are allowed and the ones that doesn't
> change any block device when the dm is create as read-only. For example,
> mirror and cache targets are not allowed. The rationale behind this is
> that if the user makes a mistake, choosing the wrong device to be the
> mirror or the cache can corrupt data.
>=20
> The only targets allowed are:
> * crypt
> * delay
> * linear
> * snapshot-origin
> * striped
> * verity
>=20
> Co-developed-by: Will Drewry <wad@chromium.org>
> Co-developed-by: Kees Cook <keescook@chromium.org>
> Co-developed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Helen Koike <helen.koike@collabora.com>
>=20
> ---
>=20

I'm trying to boot a mainline linux kernel on a chromeos device with dm
verity and a USB stick but it's not working for me even with this patch.
I've had to hack around two problems:

 1) rootwait isn't considered

 2) verity doesn't seem to accept UUID for <hash_dev> or <dev>

For the first problem, it happens every boot for me because I'm trying
to boot off of a USB stick and it's behind a hub that takes a few
seconds to enumerate. If I hack up the code to call dm_init_init() after
the 'rootdelay' cmdline parameter is used then I can make this work. It
would be much nicer if the whole mechanism didn't use a late initcall
though. If it used a hook from prepare_namespace() and then looped
waiting for devices to create when rootwait was specified it would work.

The second problem is that in chromeos we have the bootloader fill out
the UUID of the kernel partition (%U) and then we have another parameter
that indicates the offset from that kernel partition to add to the
kernel partition (typically 1, i.e. PARTNROFF=3D1) to find the root
filesystem partition. The way verity seems to work here is that we need
to specify a path like /dev/sda3 or the major:minor number of the device
on the commandline to make this work. It would be better if we could add
in support for the PARTNROFF style that name_to_dev_t() handles so we
can specify the root partition like we're currently doing. I suspect we
should be able to add support for this into the device mapper layer so
that we can specify devices this way.

If it helps, an example commandline I've been using to test out a usb
stick is as follows:

dm-mod.create=3D"vroot,,0,ro, 0 4710400 verity 0 8:19 8:19 4096 4096 588800=
 588800 sha1 9b0a223aedbf74b06442b0f05fbff33c55edd010 414b21fba60a1901e23ae=
c373e994942e991d6762631e54a39bc42411f244bd2"

Also, the documentation (Documentation/device-mapper/dm-init.txt) says
we can use a way that doesn't specify so many arguments, but dm verity
complains about not enough arguments (10) when following the example:

  vroot,,,ro,
  0 1740800 verity 254:0 254:0 1740800 sha1
  76e9be054b15884a9fa85973e9cb274c93afadb6
  5b3549d54d6c7a3837b9b81ed72e49463a64c03680c47835bef94d768e5646fe;   =20

So the documentation needs an update?

