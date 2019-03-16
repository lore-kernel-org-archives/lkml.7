Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87096C4360F
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49635206DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 10:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5dyXlIv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfCPKYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 06:24:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34465 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPKYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 06:24:35 -0400
Received: by mail-pf1-f193.google.com with SMTP id v64so8059532pfb.1;
        Sat, 16 Mar 2019 03:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TW1V2gA4pvhVM39qDC9jod/6ylSRA9LZFZhJ9UEIH1I=;
        b=T5dyXlIvjjav8v8zZzZZI1oV3ngVkUUZYHKe+vLc0MneaXhv766IfKT+YIGOXB2QLP
         VrOoLqvwbBpMwKypJNW3OtyeZneHEyQUdRHyaL2vyZ6sjPIvB7FkPky4Q0yE9q7rQjwY
         g4qQGQqJJjglFTMI+UB00MLGbXRqSaNHatfPK5qnY2Mu/vbq8xP9SLVHnNAYvIpSZ/lS
         /0l4QzidsATnLEZqbYUniDM660RbHzpofNss1QwDrniyqj0KOcPZfHleK4j6fF9PwfWR
         gLMfIUYoE00Y5eEUEylf0opDtSQ/Hb8y7RPO58wG587fb15CuAOo4kz/xpAxRi5DQjhy
         u1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TW1V2gA4pvhVM39qDC9jod/6ylSRA9LZFZhJ9UEIH1I=;
        b=IhTNEVBRoo3GJ/EE2d7Lr3KJrWXPLjc1rbxx6FVO0m6P/j/iZAxy/eyLpAN63aB2up
         6poNJEH7gBcMsHqLTonEdP8T63sWG+XWTIefsk/pwr2hSVudTst/H8H1Unuc4BfBFZDz
         Nu19MGu86qEdn99sf8eLlLa8ZYvhuO0MH66UYTRm3wsGg8jBCOS8nfDrvqzzPcHjs0OU
         TLODwIZO7GXhDHXgB5AR0U7cE2XmICI6iKUgqZAy8xYLxHlo/q6fTGBrFkApJpOZ065y
         eT3vEOBrQgmdIH6LrCfDdyfnQXWTQNb0IhBHLv/zIlm29Q6wKdqMwhZUWl4Z8MGOQvLz
         DKyg==
X-Gm-Message-State: APjAAAWYGpAiHv4cguFBS0JoC3G/HcaOKwIX/d0hbAkUmgxHiY3i7G5E
        y1Otwd5FWqaZldGNhIkY1jQ=
X-Google-Smtp-Source: APXvYqyx6WN1euA6uaVhC3DUMYDVtqrU7+q1vge0/w6Orv5p37lvNoeQcpysnLc9oAmSkrivKq1/Rw==
X-Received: by 2002:a17:902:8497:: with SMTP id c23mr8952363plo.99.1552731874349;
        Sat, 16 Mar 2019 03:24:34 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.77.42.246])
        by smtp.gmail.com with ESMTPSA id k27sm12936843pgb.70.2019.03.16.03.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Mar 2019 03:24:33 -0700 (PDT)
Date:   Sat, 16 Mar 2019 15:54:25 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, dpfrey@gmail.com, colin.king@canonical.com
Subject: Re: [PATCH v3 2/2] iio/chemical/bme680: Fix SPI read interface
Message-ID: <20190316102425.GA26481@himanshu-Vostro-3559>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
 <1551857508-4254-2-git-send-email-mike.looijmans@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1551857508-4254-2-git-send-email-mike.looijmans@topic.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 06, 2019 at 08:31:48AM +0100, Mike Looijmans wrote:
> The SPI interface implementation was completely broken.
> 
> When using the SPI interface, there are only 7 address bits, the upper bit
> is controlled by a page select register. The core needs access to both
> ranges, so implement register read/write for both regions. The regmap
> paging functionality didn't agree with a register that needs to be read
> and modified, so I implemented a custom paging algorithm.
> 
> This fixes that the device wouldn't even probe in SPI mode.
> 
> The SPI interface then isn't different from I2C, merged them into the core,
> and the I2C/SPI named registers are no longer needed.
> 
> Implemented register value caching for the registers to reduce the I2C/SPI
> data transfers considerably.
> 
> The calibration set reads as all zeroes until some undefined point in time,
> and I couldn't determine what makes it valid. The datasheet mentions these
> registers but does not provide any hints on when they become valid, and they
> aren't even enumerated in the memory map. So check the calibration and
> retry reading it from the device after each measurement until it provides
> something valid.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---

I have been trying to test this patch in the past week and still it
failed everytime.

First I used ACPI to enumerate the device in QEMU setup:

Added some printks for debugging:

[   14.510198] bme680_spi spi-BME0680:00: Jumping to core driver now ...
[   14.544528] bme680_spi spi-BME0680:00: Page setting done, on Page :0 now
[   14.554363] bme680_spi spi-BME0680:00: bme680_regmap_spi_write: on Page :0 now
[   14.556151] bme680_spi spi-BME0680:00: bme680_regmap_spi_read: on Page :0 now
[   14.567815] bme680_spi spi-BME0680:00: Wrong chip ID, got ff expected 61

I also tried bypassing this by removing the following snippet and force
registration to see what happens next:

 > +     ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
 > +                        BME680_CMD_SOFTRESET);
 > +     if (ret < 0) {
 > +             dev_err(dev, "Failed to reset chip\n");
 > +             return ret;
 > +     }
 > +
 > +     ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
 > +     if (ret < 0) {
 > +             dev_err(dev, "Error reading chip ID\n");
 > +             return ret;
 > +     }
 > +
 > +     if (val != BME680_CHIP_ID_VAL) {
 > +             dev_err(dev, "Wrong chip ID, got %x expected %x\n",
 > +                             val, BME680_CHIP_ID_VAL);
 > +             return -ENODEV;
 > +     }
 > +

And it registered successfully, but all the bme680 attributes were
giving wrong values like temp was constant to 0.0000007, resistance
was resource busy due to insuffient target temperature error.
Pretty eveything was messed up at this stage.

Then I build and booted the kernel on BeagleBone Black Wireless with
DT matching this time:

debian@beaglebone:~$ uname -a
Linux beaglebone 4.19.5-ti-r5 #1xross SMP PREEMPT Sat Mar 16 12:11:50 IST 2019 armv7l GNU/Linux
debian@beaglebone:~$ dmesg | grep 'bme680'
[   30.269207] bme680_spi spi0.0: Wrong chip ID, got ff expected 61
[  361.867410] bme680_core: disagrees about version of symbol module_layout
debian@beaglebone:~$ lsmod | grep 'bme'
bme680_spi             16384  0
bme680_core            20480  1 bme680_spi
debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/
modalias    of_node/    power/      statistics/ subsystem/  uevent
debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/modalias
spi:bme680
debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/
compatible         name               reg                spi-max-frequency
debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/compatible
bme680
debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/name
bme680
debian@beaglebone:~$ dtc -f -I fs /proc/device-tree | grep -A3 'bme680'
                        bme680@0 {
                                compatible = "bme680";
                                reg = <0x0>;
                                spi-max-frequency = <0x989680>;
                        };

Same error again!

I really don't know where the problem is and how to rectify ?

OTOH, I2C works like a charm as it used to work before:

root@beaglebone:/sys/bus/iio/devices/iio:device1# cat name in_temp_input \
in_pressure_input in_humidityrelative_input in_resistance_input

bme680
26860 --> w/o your patch it used to be 26.86000 degC
990.870000000
55.265000000
10091


I'm still assuming that there is some problem on my side, as it works
flawless for you. But it is really difficult for me to figure out
exactly where the problem could be!


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
