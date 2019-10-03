Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDDE7C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A0D21A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 07:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJOoeEVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbfJCH1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 03:27:00 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36765 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfJCH07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 03:26:59 -0400
Received: by mail-pg1-f193.google.com with SMTP id 23so1212155pgk.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 00:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=IVr7iCQ0cHeNyNwPRuU5jCxRdkEqJuzZ+TVTYQ7Mnp4=;
        b=KJOoeEVbMXRr2W1fgcNTlyDaex0VQ3Ba2U2xe2RMUPXgiwzZU02fevNV0NSR5ZnC1K
         sjB4AJxqFFvCEPCJhEI6BooZ5yl6/Q6EvhMyblDp4qmbFuNAKMuzllOpMhooEGzHMssh
         Ur0d98VTS+WXGooohEQRDLI88ewpGWZSDH6bX9i7v/WSolJkadOHFEF1p7X59TE4DYmz
         Ec6yRLbsnCRXuRC+avSoRUlcDpzIWO8LM5Q7EV6ppA/dXZiCeLeYYxP0q6ZBNK6OjFIn
         iYE0KOBw3k4jHM8PgDAT+lARJhCsSYN8VyDEiOP7eL8Q/SCn+UhsNp6VeGbeYrCsXrbN
         VICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=IVr7iCQ0cHeNyNwPRuU5jCxRdkEqJuzZ+TVTYQ7Mnp4=;
        b=Wl2YqgI5LsdBf8WuyYqAFtgg5eaZr68hVkpxi7rKl59MAbBQBrnTv5A/xCSjALfco1
         SFNIUyzb+1FHEjchETBpuB/5U0fiN2i2iobEIN4hvTwqDBPye0c8GgCq/UAHOrscEceU
         t2E5fe0AXs+85odtdsLbl9LV+GPS3BV8z4Oarqpr6o4NYonRrZxCA+TxXDG1TjI+sH8J
         mQn/8UHiWfQrgVEYMyZx70ji2wA4KVOVaSGaRcku6WWYoTYGgOmYWSdey2XLToD3FCip
         NPhL8mqECRG4gd/n+gCBSYuz/zp8Sl0Xp0PYA5BQe0RPuZdQkrYFpnCcqfZ+Ap6jJvK0
         Ey7Q==
X-Gm-Message-State: APjAAAWHOBn1PCaK4VGTS0tVwN27GTe83lDoS69WZpD9NoOiLoPijCvg
        mL0+TDlT9cCi43iKHHDjDG43OhR2tA==
X-Google-Smtp-Source: APXvYqybPBUNXzjIAvdhsZUlz4yV8jJBXb+GFM9eK9pzjSoe7b60QfMcTAatnjNLj9/2jmJS/axrCw==
X-Received: by 2002:a63:fe56:: with SMTP id x22mr5720985pgj.423.1570087618720;
        Thu, 03 Oct 2019 00:26:58 -0700 (PDT)
Received: from ?IPv6:2405:204:7341:7bd7:48be:62db:2019:7e4d? ([2405:204:7341:7bd7:48be:62db:2019:7e4d])
        by smtp.gmail.com with ESMTPSA id e9sm1377846pgs.86.2019.10.03.00.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 00:26:58 -0700 (PDT)
Date:   Thu, 03 Oct 2019 12:56:48 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20191003071646.GZ896@valkosipuli.retiisi.org.uk>
References: <20190830091943.22646-1-manivannan.sadhasivam@linaro.org> <20190830091943.22646-3-manivannan.sadhasivam@linaro.org> <20190923092209.GL5525@valkosipuli.retiisi.org.uk> <20191001184200.GA7739@Mani-XPS-13-9360> <20191002103715.GR896@valkosipuli.retiisi.org.uk> <20191003053338.GA7868@Mani-XPS-13-9360> <20191003071646.GZ896@valkosipuli.retiisi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 2/3] media: i2c: Add IMX290 CMOS image sensor driver
To:     Sakari Ailus <sakari.ailus@iki.fi>
CC:     mchehab@kernel.org, robh+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        c.barrett@framos.com, a.brela@framos.com
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Message-ID: <3FAB5E91-9FD2-4052-881B-E4B18D44D33B@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,=20

On 3 October 2019 12:46:46 PM IST, Sakari Ailus <sakari=2Eailus@iki=2Efi> =
wrote:
>Hi Manivannan,
>
>On Thu, Oct 03, 2019 at 11:03:38AM +0530, Manivannan Sadhasivam wrote:
>=2E=2E=2E=2E
>> > > > > +static int imx290_set_gain(struct imx290 *imx290, u32 value)
>> > > > > +{
>> > > > > +	int ret;
>> > > > > +
>> > > > > +	u32 adjusted_value =3D (value * 10) / 3;
>> > > >=20
>> > > > What's the purpose of this? Why not to use the value directly?
>> > > >=20
>> > >=20
>> > > The gain register accepts the value 10/3 of the actual gain
>required=2E Hence,
>> > > we need to manually do the calculation before updating the value=2E
>I can
>> > > add a comment here to clarify=2E
>> >=20
>> > It's better to use the register value directly=2E Otherwise the
>granularity
>> > won't be available to the user space=2E
>> >=20
>>=20
>> The sensor datasheet clearly defines that the 10/3'rd of the expected
>gain
>> should be set to this register=2E So, IMO we should be setting the
>value as
>
>The unit of that gain is decibels, but the controls do not have a unit=2E
>Register value is really preferred here=2E
>

Hmm, okay=2E Will just pass the value directly=2E=20

>> mentioned in the datasheet=2E I agree that we are missing the userspace
>> granularity here but sticking to the device limitation shouldn't be a
>problem=2E
>> As I said, I'll add a comment here to clarify=2E
>
>The comment isn't visible in the uAPI=2E
>

Yes=2E It would be good to have the units passed onto the userspace someho=
w like it is done in IIO=2E Then we don't need to fiddle in the driver for =
mismatch=2E Something consider in future=2E=2E=2E=20

>>=20
>> > >=20
>> > > > > +
>> > > > > +	ret =3D imx290_write_buffered_reg(imx290, IMX290_GAIN, 1,
>adjusted_value);
>> > > > > +	if (ret)
>> > > > > +		dev_err(imx290->dev, "Unable to write gain\n");
>> > > > > +
>> > > > > +	return ret;
>> > > > > +}
>> > > > > +
>> > > > > +static int imx290_set_power_on(struct imx290 *imx290)
>> > > > > +{
>> > > > > +	int ret;
>> > > > > +
>> > > > > +	ret =3D clk_prepare_enable(imx290->xclk);
>> > > >=20
>> > > > Please move the code from this function to the runtime PM
>runtime suspend
>> > > > callback=2E The same for imx290_set_power_off()=2E
>> > > >=20
>> > >=20
>> > > May I know why? I think since this is being used only once,
>you're suggesting
>> > > to move to the callback function itself but please see the
>comment below=2E I
>> > > will reuse this function to power on the device during probe=2E
>> >=20
>> > Yes, you can call the same function from probe, even if it's used
>as a
>> > runtime PM callback=2E
>> >=20
>> > There's no need to have a function that acts as a wrapper for
>calling it
>> > with a different type of an argument=2E
>> >=20
>>=20
>> You mean directly calling imx290_runtime_resume() from probe is fine?
>
>Yes=2E Feel free to call it e=2Eg=2E imx290_power_on or something=2E

Okay=2E=20

Thanks,=20
Mani

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
