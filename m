Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D91F8C10F05
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6DE42184C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 09:48:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9SaSxJI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfCQJsS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 05:48:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35562 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQJsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 05:48:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id j5so9281957pfa.2;
        Sun, 17 Mar 2019 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Sg+SZsCPQaufLXlCGZZDisdR11DSzLP0Hfud9RhzmVs=;
        b=j9SaSxJImsU03OIKnz8fahse+KfzlobOMB4Xzdlx0B06w7SEaN6CPcDCDhsK5MSuwF
         VHH+JJkrNEhPWH7bqO/Qvb0gp6RKKaTvAySs2Uv0Y2pJgPT2Lpz/JehZVEmq+X+zqLkS
         Cf5q7yZH6Pe6aETyfgQVkT+l8DxTvH+IR8Yo1729Lb/yAJh5E5IYYFW23pNkUB73fpW0
         llZ2oGcaNS6b9mcqS5kDSHA39C0WuUzLULbRp8uiJzmxKC7N3W8NKSQKYwWJXTlXwNZ6
         sinIP6YqpjeOhh0unH+1CZhk7/AfsDxfjcv4lfaxZHAkSqDJ3oqPUP6aFH5ChZHQPc1A
         cseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Sg+SZsCPQaufLXlCGZZDisdR11DSzLP0Hfud9RhzmVs=;
        b=SiJ//2jKPtWQNPz+qEHI4KK+vBNT3xgwn7hSLAqNT5pUTc2Q+V5aaSkuLLI/bFCVoA
         zD6W0e4k1ASFVFjk/ZJaezCzpYsfQZE/G6eKfrcY/1NxK0I2izPUDbzrAuUAv7D1sPnL
         hy8qTKtlAZFqLppAkWl3X2OYvscLB+gMrpa2jhnF6C28S2/4GjESjb/N/jvCFbiPZSbB
         W1mKeVkiwQwdSUG3iAoy4Zh/yFsncM60A/iZmE5vbKxUcwS0OZ2H6hhWZ12y4p7fftSZ
         bF7j2cIIuTfbmDHjE1Em3Ju6S9I/fzAiCYRUSCPU6PPlGlewg6hOcgzkQymTeLhPG/1O
         ns6w==
X-Gm-Message-State: APjAAAUHsVtHvcrQiJni1lQetdb9Qx7FfQvn6ro8Kbq2dJxVAm+IxZY2
        Pp3HS9m7hWEakTUvO+aZCaE=
X-Google-Smtp-Source: APXvYqygg9EmJZXVv4tiW+hJKzHdyumapixeyum8+VzKoM27HFvyagkA5Kl00wAah3wU4HL8d6C9OA==
X-Received: by 2002:a17:902:a714:: with SMTP id w20mr14113465plq.331.1552816096615;
        Sun, 17 Mar 2019 02:48:16 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.77.42.179])
        by smtp.gmail.com with ESMTPSA id s6sm9447828pfe.37.2019.03.17.02.48.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 02:48:15 -0700 (PDT)
Date:   Sun, 17 Mar 2019 15:18:06 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "dpfrey@gmail.com" <dpfrey@gmail.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>
Subject: Re: [PATCH v3 2/2] iio/chemical/bme680: Fix SPI read interface
Message-ID: <20190317094806.GA2883@himanshu-Vostro-3559>
References: <1550238475-25698-1-git-send-email-mike.looijmans@topic.nl>
 <1551857508-4254-2-git-send-email-mike.looijmans@topic.nl>
 <20190316102425.GA26481@himanshu-Vostro-3559>
 <929ccc7f-3fdd-d28b-d469-68f2373cdd82@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <929ccc7f-3fdd-d28b-d469-68f2373cdd82@topic.nl>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2019 at 01:00:39PM +0000, Mike Looijmans wrote:
> On 16-03-19 11:24, Himanshu Jha wrote:
> > On Wed, Mar 06, 2019 at 08:31:48AM +0100, Mike Looijmans wrote:
> >> The SPI interface implementation was completely broken.
> >>
> >> When using the SPI interface, there are only 7 address bits, the upper bit
> >> is controlled by a page select register. The core needs access to both
> >> ranges, so implement register read/write for both regions. The regmap
> >> paging functionality didn't agree with a register that needs to be read
> >> and modified, so I implemented a custom paging algorithm.
> >>
> >> This fixes that the device wouldn't even probe in SPI mode.
> >>
> >> The SPI interface then isn't different from I2C, merged them into the core,
> >> and the I2C/SPI named registers are no longer needed.
> >>
> >> Implemented register value caching for the registers to reduce the I2C/SPI
> >> data transfers considerably.
> >>
> >> The calibration set reads as all zeroes until some undefined point in time,
> >> and I couldn't determine what makes it valid. The datasheet mentions these
> >> registers but does not provide any hints on when they become valid, and they
> >> aren't even enumerated in the memory map. So check the calibration and
> >> retry reading it from the device after each measurement until it provides
> >> something valid.
> >>
> >> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> >> ---
> > 
> > I have been trying to test this patch in the past week and still it
> > failed everytime.
> > 
> > First I used ACPI to enumerate the device in QEMU setup:
> > 
> > Added some printks for debugging:
> > 
> > [   14.510198] bme680_spi spi-BME0680:00: Jumping to core driver now ...
> > [   14.544528] bme680_spi spi-BME0680:00: Page setting done, on Page :0 now
> > [   14.554363] bme680_spi spi-BME0680:00: bme680_regmap_spi_write: on Page :0 now
> > [   14.556151] bme680_spi spi-BME0680:00: bme680_regmap_spi_read: on Page :0 now
> > [   14.567815] bme680_spi spi-BME0680:00: Wrong chip ID, got ff expected 61
> > 
> 
> Looks like the SPI communication isn't working. At this point I'd check 
> the wires using an osciloscope or analyzer or something.

OK. Will give it a try at university lab.

> > I also tried bypassing this by removing the following snippet and force
> > registration to see what happens next:
> > 
> >   > +     ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> >   > +                        BME680_CMD_SOFTRESET);
> >   > +     if (ret < 0) {
> >   > +             dev_err(dev, "Failed to reset chip\n");
> >   > +             return ret;
> >   > +     }
> >   > +
> >   > +     ret = regmap_read(regmap, BME680_REG_CHIP_ID, &val);
> >   > +     if (ret < 0) {
> >   > +             dev_err(dev, "Error reading chip ID\n");
> >   > +             return ret;
> >   > +     }
> >   > +
> >   > +     if (val != BME680_CHIP_ID_VAL) {
> >   > +             dev_err(dev, "Wrong chip ID, got %x expected %x\n",
> >   > +                             val, BME680_CHIP_ID_VAL);
> >   > +             return -ENODEV;
> >   > +     }
> >   > +
> > 
> > And it registered successfully, but all the bme680 attributes were
> > giving wrong values like temp was constant to 0.0000007, resistance
> > was resource busy due to insuffient target temperature error.
> > Pretty eveything was messed up at this stage.
> 
> Makes perfect sense if it's unable to read the registers.
> 
> If you cannot read the chip ID, nothing will work, no point skipping that.

Agreed! I was just trying to triage the issue.

> > Then I build and booted the kernel on BeagleBone Black Wireless with
> > DT matching this time:
> > 
> > debian@beaglebone:~$ uname -a
> > Linux beaglebone 4.19.5-ti-r5 #1xross SMP PREEMPT Sat Mar 16 12:11:50 IST 2019 armv7l GNU/Linux
> > debian@beaglebone:~$ dmesg | grep 'bme680'
> > [   30.269207] bme680_spi spi0.0: Wrong chip ID, got ff expected 61
> > [  361.867410] bme680_core: disagrees about version of symbol module_layout
> 
> Looks like a compilation problem with your kernel module?

No. I doesn't appear now.
I also build a more latest kernel but same error:

[  519.741364] bme680_spi spi0.0: Wrong chip ID, got ff expected 61

> > debian@beaglebone:~$ lsmod | grep 'bme'
> > bme680_spi             16384  0
> > bme680_core            20480  1 bme680_spi
> > debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/
> > modalias    of_node/    power/      statistics/ subsystem/  uevent
> > debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/modalias
> > spi:bme680
> > debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/
> > compatible         name               reg                spi-max-frequency
> > debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/compatible
> > bme680
> > debian@beaglebone:~$ cat /sys/bus/spi/devices/spi0.0/of_node/name
> > bme680
> > debian@beaglebone:~$ dtc -f -I fs /proc/device-tree | grep -A3 'bme680'
> >                          bme680@0 {
> >                                  compatible = "bme680";
> >                                  reg = <0x0>;
> >                                  spi-max-frequency = <0x989680>;
> >                          };
> > 
> > Same error again!
> > 
> > I really don't know where the problem is and how to rectify ?
> > 
> > OTOH, I2C works like a charm as it used to work before:
> 
> That's reassuring, good to know i didn't kill that part.

Yes!

> > root@beaglebone:/sys/bus/iio/devices/iio:device1# cat name in_temp_input \
> > in_pressure_input in_humidityrelative_input in_resistance_input
> > 
> > bme680
> > 26860 --> w/o your patch it used to be 26.86000 degC
> > 990.870000000
> > 55.265000000
> > 10091
> > 
> > 
> > I'm still assuming that there is some problem on my side, as it works
> > flawless for you. But it is really difficult for me to figure out
> > exactly where the problem could be!
> 
> I would not go as far as calling it "flawless". The "resistance" 
> measurement usually fails a few times, and the calibration values aren't 
> available at the first read apparently.

I know about resistance measurement failing intially "sometimes"
and it depends on environment factors as well. If there is sufficient
heat, then less chances of failure on initial reading.

> After reading the values 
> multiple times (hint: "grep . *" is really nice for showing file 
> contents in a sysfs directory) the chip appears to function okay. That's 
> what my last commit paragraph was explaining.

I use watch command instead.

> It's a big improvement over the previous version where the SPI interface 
> wouldn't work at all.

Agreed, Sir _/\_

> -- 
> Mike Looijmans


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
