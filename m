Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD240C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEC5216C8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 08:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="nDWRpHby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfICIKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 04:10:41 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:41275 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfICIKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 04:10:41 -0400
Received: by mail-qt1-f170.google.com with SMTP id j10so996740qtp.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 01:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=XlGhAEQhS5vDA63JscWsmUO0Zxj4rYUWag9weQn38YI=;
        b=nDWRpHbydaDd1tKlATnHiW0Xk0qQHvQcJmSGqN0k0Dd/NPgfwuxwBgNx+wSldgM1mD
         w8u/W2WOS3efOXk0b0RcLIytnVbl0a9+v42WuTk66N6No20M2kp7b0e9nR/WNjwupgMw
         UbaGKxEYTSSvFtdtiVXklTupaBNZV8d6BtlcUoGPZve/z+r09tEeUKuiOZaeNXFBnjDR
         Fyc0SIYBFMc3kSAXHU3C2Ppb8eA7ihu7/xnTi8A6wd08B0ZJRJXLLp4tIWnz9K+S/pEA
         Mc/JIy1XnjVQ1iRGUoG+TLRUeCFnwJZfz9XGnUM73Z8uaXf5kMxshVU//GOpBqakWtuT
         cR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XlGhAEQhS5vDA63JscWsmUO0Zxj4rYUWag9weQn38YI=;
        b=CQAI6DqzxI3V05BD15tTuQVq54gEF0M/6V40NW0GdPFbve+dNub9ioW+hSEtjBAW/8
         OfuWnVGdxaMaN1JUeunrusBXUh4YfzLoc7OpCJUa+Oe+hy6IWYCASEfHRtvUt4QT/lTd
         Nec6u8rBRVpG82NwXVseuahVHRZB3QPhVhiQdkgQDUUpaNTXT4AfuTuCul/kJNldUm77
         mpkpl/BPIdHC7crdHiAiFoJZNmJZkdmbXZoO0wjguCcQ1GvmH4NTGK5MoS0+cpFn4p60
         if0Ogh6ai/NkaUeUBBFXO++H3aPk8KIcwrbBYtNzIRD0xXi5IKebmNA883Bx2e7xTenP
         YJcw==
X-Gm-Message-State: APjAAAWntspaoI7P0aXgtjL9x1Ca4jzm1CMw8pnDPdx2myCTbHmMekwn
        cSF+jPpaddmZ4UurxsG7EjZyP0/PhDjwIzYk9xyBaxY9wPE=
X-Google-Smtp-Source: APXvYqw+cUPAj7uf8xfh57/PSX+Qy32snhGaoKcV06DsA9Y9HAejLtWaGNRxZajlXWxBg0W2DBhWDqPPeltyzHGkYcY=
X-Received: by 2002:ac8:74c7:: with SMTP id j7mr1933769qtr.37.1567498240130;
 Tue, 03 Sep 2019 01:10:40 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Chiu <chiu@endlessm.com>
Date:   Tue, 3 Sep 2019 16:10:27 +0800
Message-ID: <CAB4CAwdo7H3QNEHLgG-h1Z_eRYkb+pc=V3Wvrmeju8fBByYJzw@mail.gmail.com>
Subject: Tweak I2C SDA hold time on GemniLake to make touchpad work
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        lee.jones@linaro.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're working on the acer Gemnilake laptop TravelMate B118-M for
touchpad not working issue. The touchpad fails to bring up and the
i2c-hid ouput the message as follows
    [    8.317293] i2c_hid i2c-ELAN0502:00: hid_descr_cmd failed
We tried on latest linux kernel 5.3.0-rc6 and it reports the same.

We then look into I2C signal level measurement to find out why.
The following is the signal output from LA for the SCL/SDA.
https://imgur.com/sKcpvdo
The SCL frequency is ~400kHz from the SCL period, but the SDA
transition is quite weird. Per the I2C spec, the data on the SDA line
must be stable during the high period of the clock. The HIGH or LOW
state of the data line can only change when the clock signal on the
SCL line is LOW. The SDA period span across 2 SCL high, I think
that's the reason why the I2C read the wrong data and fail to initialize.

Thus, we treak the SDA hold time by the following modification.

--- a/drivers/mfd/intel-lpss-pci.c
+++ b/drivers/mfd/intel-lpss-pci.c
@@ -97,7 +97,8 @@ static const struct intel_lpss_platform_info bxt_uart_info = {
 };

 static struct property_entry bxt_i2c_properties[] = {
-       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 42),
+       PROPERTY_ENTRY_U32("i2c-sda-hold-time-ns", 230),
        PROPERTY_ENTRY_U32("i2c-sda-falling-time-ns", 171),
        PROPERTY_ENTRY_U32("i2c-scl-falling-time-ns", 208),
        { },

The reason why I choose sda hold time is by the Table 10 of
https://www.nxp.com/docs/en/user-guide/UM10204.pdf, the device
must provide a hold time at lease 300ns and and 42 here is relatively
too small. The signal measurement result for the same pin on Windows
is as follows.
https://imgur.com/BtKUIZB
Comparing to the same result running Linux
https://imgur.com/N4fPTYN

After applying the sda hold time tweak patch above, the touchpad can
be correctly initialized and work. The LA signal is shown as down below.
https://imgur.com/B3PmnIp

The chart which has yellow mark is the tweak version, the red marks
the original version.

I need suggestions about whether if the hold time is the value I can tweak?
Or I should modify sda falling time? Please help if any better idea.

Thanks
