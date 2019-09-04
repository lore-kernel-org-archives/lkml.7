Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FCAC3A59E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04C0A22CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 04:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="nNUzE22s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728215AbfIDEih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 00:38:37 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:41387 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfIDEig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 00:38:36 -0400
Received: by mail-qt1-f182.google.com with SMTP id j10so5273704qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 21:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rCfo8ZTPLFD1J9LanJqx/ih06mAfCjEXW/qtymlzmaY=;
        b=nNUzE22szLB6fIHBMR61HcFOyBi2VxuEnTbkYKcFzTfAR0nkrN45m6Of3tnpFA2oyx
         P1fi4etH/iQsP64d4b0YNZlnLtUlvmEHAgNlv66WbzKe+8hmp7jUpcRvHOuDj5i0FLU3
         A3HVwuRPEMedPMCsVK5PH0596ZxTw9AkeUxaZOlFEBRtYx83g+ZOEE/OV5cRlC3r4r7a
         gf8CohZBRIO4k48aQnrWZDr/m9fQ3BsOpyj4KcC0VmY768nqdBJtX/njhT0kB4h21Due
         SxBimvqXPlVileAF76Tzhf6zGehsrzX/zAWBFjDRoPinSnt8+/kxRe3juVV0snbQlQ8Y
         pcOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rCfo8ZTPLFD1J9LanJqx/ih06mAfCjEXW/qtymlzmaY=;
        b=L00wLmqASJbeQSi46pKpQjrNi7AYbDFElJ38xQPNFFsT6ep7+Zd9xSswoWbmNaf7iO
         zHaD5TqpSiKIAtbyHLcCO9xS/zePdlJUEpYEsdCkYyuB3W8OfZfBnXFv3LBEUwt1W30h
         OKb2PFvgm6b7YMGnttKGhKyl1lYf9X8iXbImXsdCjV+48qiWoHB5xyhuDxv1rmYec6qE
         QKqIlnUnNraXVcdlbz/TS9ByUPp/9grvfvp1ytqRh5SZmkwowDmHscCqVX4QWnOWYExT
         UnWkfzwhjUR48bI1v+9GFlTSGic7vtee8IPdOnpHC8dkCy7AkIoznsICaBOHgu+E4D7q
         MLYA==
X-Gm-Message-State: APjAAAXIpq5/ycUyWlUD7+58+ZwfV9mJcaSNppuj09bXbjKJSAfZQhHb
        oXpMCiwR7E7eNLdIZkBS+fiaLhIRcZnYzSsvmAmPMQ==
X-Google-Smtp-Source: APXvYqyGEOXLOXrHz31XbbkOyu/PhaDVQ5axvbUz3OqstIKTzlq16n68flaEzNvHDLw7Qn3j0Twu0+XOyVZW+dXa+og=
X-Received: by 2002:ac8:7959:: with SMTP id r25mr37347795qtt.208.1567571915575;
 Tue, 03 Sep 2019 21:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
 <20190903081858.GA2691@lahna.fi.intel.com> <3141a819-5964-4082-6f05-1926e16468b4@linux.intel.com>
In-Reply-To: <3141a819-5964-4082-6f05-1926e16468b4@linux.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 4 Sep 2019 12:38:24 +0800
Message-ID: <CAB4CAwdRHQOiqrK5utgCzZKB-X+mDcJePBLa7o0rTWzAogo5vw@mail.gmail.com>
Subject: Re: Tweak I2C SDA hold time on GemniLake to make touchpad work
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lee.jones@linaro.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 3, 2019 at 8:03 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> Hi Chris
>
> On 9/3/19 11:18 AM, Mika Westerberg wrote:
> > +Jarkko
> >
> > On Tue, Sep 03, 2019 at 04:10:27PM +0800, Chris Chiu wrote:
> >> Hi,
> >>
> >> We're working on the acer Gemnilake laptop TravelMate B118-M for
> >> touchpad not working issue. The touchpad fails to bring up and the
> >> i2c-hid ouput the message as follows
> >>      [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
> >> We tried on latest linux kernel 5.3.0-rc6 and it reports the same.
> >>
> >> We then look into I2C signal level measurement to find out why.
> >> The following is the signal output from LA for the SCL/SDA.
> >> https://imgur.com/sKcpvdo
> >> The SCL frequency is ~400kHz from the SCL period, but the SDA
> >> transition is quite weird. Per the I2C spec, the data on the SDA line
> >> must be stable during the high period of the clock. The HIGH or LOW
> >> state of the data line can only change when the clock signal on the
> >> SCL line is LOW. The SDA period span across 2 SCL high, I think
> >> that's the reason why the I2C read the wrong data and fail to initialize.
> >>
> >> Thus, we treak the SDA hold time by the following modification.
> >>
> >> --- a/drivers/mfd/intel-lpss-pci.c
> >> +++ b/drivers/mfd/intel-lpss-pci.c
> >> @@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
> >>   };
> >>
> >>   static struct property_entry bxt_i2c_properties[] = {
> >> -       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
> >> +       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
> >>          PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
> >>          PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
> >>          { },
> >>
> >> The reason why I choose sda hold time is by the Table 10 of
> >> https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
> >> must provide a hold time at lease 300ns and and 42 here is relatively
> >> too small. The signal measurement result for the same pin on Windows
> >> is as follows.
> >> https://imgur.com/BtKUIZB
> >> Comparing to the same result running Linux
> >> https://imgur.com/N4fPTYN
> >>
> >> After applying the sda hold time tweak patch above, the touchpad can
> >> be correctly initialized and work. The LA signal is shown as down below.
> >> https://imgur.com/B3PmnIp
> >>
> Could you try does attached patch work for you?
>
> It's from last year for another related issue but there platform was
> actually Apollo Lake instead of Gemini Lake but anyway it was found out
> that Windows uses different timing parameters than Linux on Gemini Lake.
>
> I didn't take patch forward back then due known Gemini Lake machines
> were working with the Broxton I2C timing parameters but now it's time if
> attached patch fixes the issue on your machine.
>
> Patch is from top of v5.3-rc7 but should probably apply also to older
> kernels.
>
> --
> Jarkko

Thanks, Jarkko, the patche works on my acer laptops.

Chris
