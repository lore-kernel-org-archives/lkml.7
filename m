Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BCCC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A17923402
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 06:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="sw34W2ei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfIDGYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 02:24:38 -0400
Received: from mail-qk1-f170.google.com ([209.85.222.170]:39197 "EHLO
        mail-qk1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfIDGYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 02:24:38 -0400
Received: by mail-qk1-f170.google.com with SMTP id 4so18582464qki.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 23:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Di+GnDQ2TnjFeODH4tBfbLUz3tcQ/aVDZSgnwbe0+G4=;
        b=sw34W2eiN25sNXFeN8XcPZRfTjzJ9WiqbXI5QElU4GEHV0DY73/iysR6tIrZ5bj+ru
         N1q/jf5kMqw1WKASyIXUaNZmXjxynGDYh2Ps/g/K65gB3aoqH0etGpva9cEuTEZ9yAmL
         NPOFGy1sTDIIhwkCChDz+AZG+gQs2aoBKoC9JPUXzhDVN9R665r3rFtmQAALZfJcG7Qr
         /A0utUCvrMzmh5iGkW4tB+Rp0DujmxCblXA6pAePmnQUNM7SdsoWZEmv4/fWk3qK933a
         bxA5GdJt2LonHiE+xKiv16/eHTalLMFJryARg1fN1GCrBkj/NmB1vVbHQuY2q/MMXd5m
         pBMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Di+GnDQ2TnjFeODH4tBfbLUz3tcQ/aVDZSgnwbe0+G4=;
        b=DWNQh+7eTs0nsEKzTFYfRPKdFfW6h0cMB+l1mGJbSiHosqGDUgUUrE9hE1IzOBpBrK
         IjCWy90BE5v8zWfQbzJSg/Q9EwFwqXBhRuWYCmyEtfKc3VqBQkoBrTP+lz0Dvs3WssmE
         dj36lIVpPjT1K+HyPxMq/5gFWxGNEyXbFesIYOfL+h5pXLVh4qhRvfMqxMhIdGReNv39
         aIStRJqqxLMTEHDWtJwzsVDFGUW67FRXoAC6GIMJG+DkQHITcIkclA/WJNFxEu43xyEC
         /xC1N57j3P8R4n+smtM7/N0WiB93tMJHKHxd73qsvZc4dQNSrvJZQkeYDrX5PZ9tm/Wb
         iUQQ==
X-Gm-Message-State: APjAAAVunWUnEKhvR3Q7G256ItIVZ/YlCVqPNjQXp2hTFszabOKcx2wT
        buPBXxUbcWGsYZRyzijD0CWHhFkwXYapXWI7VmspqQ==
X-Google-Smtp-Source: APXvYqxS1H9FjbQL3VVWe5xB1by8z85l6KZ7J60TlCoh93QflHXIg7dBFhDVhv8EoQH7f7qbB5SuHzjqsX9n1naG3xo=
X-Received: by 2002:a05:620a:5ad:: with SMTP id q13mr20244042qkq.297.1567578276980;
 Tue, 03 Sep 2019 23:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
 <20190903081858.GA2691@lahna.fi.intel.com> <3141a819-5964-4082-6f05-1926e16468b4@linux.intel.com>
 <CAB4CAwdRHQOiqrK5utgCzZKB-X+mDcJePBLa7o0rTWzAogo5vw@mail.gmail.com> <63364b2f-dc55-4fcb-5de5-d09c9622943a@linux.intel.com>
In-Reply-To: <63364b2f-dc55-4fcb-5de5-d09c9622943a@linux.intel.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Wed, 4 Sep 2019 14:24:26 +0800
Message-ID: <CAB4CAweM7BHkE_GmKYwQtXQbctfhXUn2fYrL_3C+tyt-NQZNDg@mail.gmail.com>
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

On Wed, Sep 4, 2019 at 1:54 PM Jarkko Nikula
<jarkko.nikula@linux.intel.com> wrote:
>
> On 9/4/19 7:38 AM, Chris Chiu wrote:
> > On Tue, Sep 3, 2019 at 8:03 PM Jarkko Nikula
> > <jarkko.nikula@linux.intel.com> wrote:
> >>
> >> Hi Chris
> >>
> >> On 9/3/19 11:18 AM, Mika Westerberg wrote:
> >>> +Jarkko
> >>>
> >>> On Tue, Sep 03, 2019 at 04:10:27PM +0800, Chris Chiu wrote:
> >>>> Hi,
> >>>>
> >>>> We're working on the acer Gemnilake laptop TravelMate B118-M for
> >>>> touchpad not working issue. The touchpad fails to bring up and the
> >>>> i2c-hid ouput the message as follows
> >>>>       [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
> >>>> We tried on latest linux kernel 5.3.0-rc6 and it reports the same.
> >>>>
> >>>> We then look into I2C signal level measurement to find out why.
> >>>> The following is the signal output from LA for the SCL/SDA.
> >>>> https://imgur.com/sKcpvdo
> >>>> The SCL frequency is ~400kHz from the SCL period, but the SDA
> >>>> transition is quite weird. Per the I2C spec, the data on the SDA line
> >>>> must be stable during the high period of the clock. The HIGH or LOW
> >>>> state of the data line can only change when the clock signal on the
> >>>> SCL line is LOW. The SDA period span across 2 SCL high, I think
> >>>> that's the reason why the I2C read the wrong data and fail to initialize.
> >>>>
> >>>> Thus, we treak the SDA hold time by the following modification.
> >>>>
> >>>> --- a/drivers/mfd/intel-lpss-pci.c
> >>>> +++ b/drivers/mfd/intel-lpss-pci.c
> >>>> @@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
> >>>>    };
> >>>>
> >>>>    static struct property_entry bxt_i2c_properties[] = {
> >>>> -       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
> >>>> +       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
> >>>>           PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
> >>>>           PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
> >>>>           { },
> >>>>
> >>>> The reason why I choose sda hold time is by the Table 10 of
> >>>> https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
> >>>> must provide a hold time at lease 300ns and and 42 here is relatively
> >>>> too small. The signal measurement result for the same pin on Windows
> >>>> is as follows.
> >>>> https://imgur.com/BtKUIZB
> >>>> Comparing to the same result running Linux
> >>>> https://imgur.com/N4fPTYN
> >>>>
> >>>> After applying the sda hold time tweak patch above, the touchpad can
> >>>> be correctly initialized and work. The LA signal is shown as down below.
> >>>> https://imgur.com/B3PmnIp
> >>>>
> >> Could you try does attached patch work for you?
> >>
> >> It's from last year for another related issue but there platform was
> >> actually Apollo Lake instead of Gemini Lake but anyway it was found out
> >> that Windows uses different timing parameters than Linux on Gemini Lake.
> >>
> >> I didn't take patch forward back then due known Gemini Lake machines
> >> were working with the Broxton I2C timing parameters but now it's time if
> >> attached patch fixes the issue on your machine.
> >>
> >> Patch is from top of v5.3-rc7 but should probably apply also to older
> >> kernels.
> >>
> >> --
> >> Jarkko
> >
> > Thanks, Jarkko, the patche works on my acer laptops.
> >
> Thanks. I'll send the patch out with Cc'ing you. I took the freedom to
> add your Tested-by tag if you don't mind :-)
>
> --
> Jarkko

No problem. Thanks
