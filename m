Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BAFC10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15BD2173B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 15:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W70crH8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbfJHPOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 11:14:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40836 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbfJHPOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 11:14:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id d26so10407877pgl.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 08:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=b0SnpNhMUbVCEQgJptnlWM+4wSJCqeG8y6NSSqT0tLc=;
        b=W70crH8RHO9sJtcShnUUaAlhOqFx2fMphJf1FO7wncUFAdi+rPx2p2X7u3oTQd8EC8
         ++vTMzXltZIE+ovOXoCoiQHFZewsdb4/vLA0FByTnqyF0lP07t6J9LlLGfO5MaJHb4JK
         f8/vvpD8yJ1PAxVUxdM2BGMSJbc49rHkSdgXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=b0SnpNhMUbVCEQgJptnlWM+4wSJCqeG8y6NSSqT0tLc=;
        b=A9p0HWdHCsEJLXqZc8fV3PDJtDP9ArQ7yGXURlEb8wj14gwWTTkEFNQJswU+arKTtb
         g7QKz6JY/tqN+VE7yh9jtqgUgc5FioHXWoXCJEkdGthVZ+7EK8EdW8Hxx7sV9pZYC7td
         BzfWHzvLlnf9fP8Mn65cbdqYAqiReCdQAo1sSOb0ANRMaId8toR/Y1du4nOatKJhEmRM
         2nJA4jvQnKPluDBGs9Xyj2XUCIEvVejN1xi4aY9h4QSrbLTcEbMJpvFvN4FAoVaLzbG7
         vK6+2p7UbqcdUj6fomh58fMHbeVsejW4fMsG0bpDWKZiV3oXog+xgdgMJdX1Ngnx13qR
         cB8A==
X-Gm-Message-State: APjAAAWhBWk3xmE37j1/0aFrcY/6GT2H+7jTDvjl3FyGYcalmh/XGyPj
        xVW6pJAFVlFJsbph66GKkG132w==
X-Google-Smtp-Source: APXvYqwEyFPtcLS13yv1gL8f/6Ms8qqajmvMZiGwmNGwHT4zxY9yfThc0vYuQ761Jws4hBNSomME4Q==
X-Received: by 2002:a17:90a:cc08:: with SMTP id b8mr6352843pju.119.1570547685494;
        Tue, 08 Oct 2019 08:14:45 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l21sm15295740pgm.55.2019.10.08.08.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 08:14:44 -0700 (PDT)
Message-ID: <5d9ca7e4.1c69fb81.7f8fa.3f7d@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
References: <20191007071610.65714-1-cychiang@chromium.org> <CA+Px+wWkr1xmSpgEkSaGS7UZu8TKUYvSnbjimBRH29=kDtcHKA@mail.gmail.com> <ebf9bc3f-a531-6c5b-a146-d80fe6c5d772@roeck-us.net> <CAFv8NwLuYKHJoG9YR3WvofwiMnXCgYv-Sk7t5jCvTZbST+Ctjw@mail.gmail.com> <5d9b5b3e.1c69fb81.7203c.1215@mx.google.com> <CAFv8Nw+x6V-995ijyws1Q36W1MpaP=kNJeiVtNakH-uC3Vgg9Q@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Cheng-yi Chiang <cychiang@chromium.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        Hung-Te Lin <hungte@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH] firmware: vpd: Add an interface to read VPD value
User-Agent: alot/0.8.1
Date:   Tue, 08 Oct 2019 08:14:43 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Cheng-yi Chiang (2019-10-07 11:50:31)
> On Mon, Oct 7, 2019 at 11:35 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > Quoting Cheng-yi Chiang (2019-10-07 06:58:41)
> > >
> > > Hi Guenter,
> > > Thanks for the quick review.
> > > I'll update accordingly in v2.
> >
> > I'd prefer this use the nvmem framework which already handles many of
> > the requirements discussed here. Implement an nvmem provider and figure
> > out how to wire that up to the kernel users. Also, please include a user
> > of the added support, otherwise it is impossible to understand how this
> > code is used.
> >
> Hi Stephen,
> Thanks for the suggestion.
> My usage is for Intel machine driver to read a string for speaker calibra=
tion.
>=20
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/=
+/1838091/4/sound/soc/intel/boards/cml_rt1011_rt5682.c#325
>=20
> Based on the comments in this thread, its usage would look like
>=20
> #define DSM_CALIB_KEY "dsm_calib"
> static int load_calibration_data(struct cml_card_private *ctx) {
>           char *data =3D NULL;
>           int ret;
>           u32 value_len;
>=20
>           /* Read calibration data from VPD. */
>           ret =3D vpd_attribute_read(1, DSM_CALIB_KEY,
>                                          (u8 **)&data, &value_len);
>=20
>           /* Parsing of this string...*/
> }
>=20
> It is currently pending on unmerged machine driver cml_rt1011_rt5682.c
> in ASoC so I can not post it for review for now.
>=20
> As for nvmem approach, I looked into examples of nvmem usage, and have
> a rough idea how to do this.
>=20
> 1) In vpd.c, as it parses key and value in the VPD section, add nvmem cel=
l  with
> {
> .name=3Dkey,
> .offset=3Dconsumed,   // need some change in vpd_decodec.c to get the
> offset of value in the section.
> .bytes=3Dvalue
> }
> Implement read function with vpd_section as context.
>=20
> 2) In vpd.c, register an nvm_device using devm_nvmem_register in
> coreboot_driver's probe function vpd_probe.
>=20
> 3) As my use case does not use device tree, it is hard for ASoC
> machine to access nvmem device. I am wondering if I can use
> nvm_cell_lookup so machine driver can find the nvmem device using a
> con_id. But currently the cell lookup API requires a matched device,
> which does not fit my usage because there will be different machine
> drivers requesting the value.
> I think I can still workaround this by adding the lookup table in
> machine driver. This would seem to be a bit weird because I found that
> most lookup table is added in provider side, not consumer side. Not
> sure if this is logically correct.

Maybe Srini has some input here. It looks like your main concern is
consumer to provider mapping?

>=20
> IMO the nvmem approach would create more complexity to support this
> simple usage. Plus, the underlying assumption of accessing data with
> offset in a buffer does not fit well with the already parsed VPD
> values in a list of vpd_attrib_info. But if you strongly feel that
> this is a better approach I can work toward this.
>=20

I'm not sure how an ACPI system like this would work because my exposure
to ACPI is extremely limited. I would expect there to be some sort of
firmware property indicating that an nvmem should be used and it's
provided by VPD or for firmware to parse VPD itself and put the
information into the ACPI table for this device.

Has either of those things been done? If it is a reference/property in
firmware then it should be possible to connect consumer devices like the
audio device you mention to VPD via the nvmem APIs with some changes to
the nvmem framework assuming there's an approach for nvmem in ACPI in
some "standard" way.=20

I'd like to use nvmem for two reasons. First, it is a kernel framework
for reading non-volatile memories, which is fairly close to what VPD is
for. Second, it makes a standard, i.e. non-vpd/coreboot specific, API
that drivers can use to read memories. Of course in ASoC the machine
driver is already very platform specific, but the idea is to avoid
platform specific APIs so that drivers are loosely coupled with the rest
of the kernel. We shouldn't push against that goal by introducing more
platform specific APIs.

