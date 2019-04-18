Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84DB0C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4226E2054F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 19:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="AA0XF2WT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbfDRTn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 15:43:29 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40447 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389853AbfDRTn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 15:43:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id q66so2882426ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 12:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XUmQZUroLSq8VM9KcgwpO5tCDJ8qvU+XJMEYuDb8suw=;
        b=AA0XF2WTNDDJ8BZw2HaVd2Fgha117OpICQoS8GEyb9ufD4FvuUF26vM8gE2BT39agy
         Qmh0teU9I/dT+QmyXTOKysyxrQYOV9SwFzaOVRpxa9Rizz8p9XnHv2o3ahzqPMk6yRrA
         fbPdjws1vWR+N/L5vdyn5wp/rnTyrK/SvPbMIGLbgIWi8k5kBUm7y70GLbRjDsmIwNjp
         oQFNblkWNgkLrFgwjHizbkeabI0cHsiHW+FpaWv8T4+Hcmfgz00Tc8KCsu4wi5pgB7w2
         xa1kGIjJCD44SWhyY19WgntRni77DTzZBMt/g5UHxT6+mIM33SQaRV9y/Npv1yR297Oy
         RZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=XUmQZUroLSq8VM9KcgwpO5tCDJ8qvU+XJMEYuDb8suw=;
        b=J+kG9EcDuLs5DoxZHfL8eTYfFsbtcaKrqPHIyaZN2fy1DoZEnzLLCY5VXZjHMvqybf
         zWa0wJQjPLBp0K5NlaC4W7oNCQrC1FV1JbY641Cmy3qUWBHV2evE2FPbK1I99Uxex+Ft
         uZylb3bE2PHFgZ4OHIJB3W5Mu7Rlb95K+WOy0+GDat1+ZQnQTdisLqxHdINUO+/meAl9
         sgpbiRb+Bbh9BnYre0LXnmCBpNmkJbRKLSI0y4Hts6eLm9w009nJQvda0thraNqHazQe
         spJ+rujdd+2yUwfh/ruWpxBg2O3qKSsYRj/T6gKFI2ASCvuQXSdt214XH4uK8rrtdn+Q
         BvHA==
X-Gm-Message-State: APjAAAWxrOM9eI0yptSKdZRKCHisYu689DyXxjWadxDNNCV3pMauqAKS
        YtQsqGfyMIJs+2nggiVpO5IFFA==
X-Google-Smtp-Source: APXvYqw5RUU1izCppInhWCe25YM77ulA03rNbQRyw+7btmW1o+KuHb31PP9Eq8zfFaCNiaHhldK0+g==
X-Received: by 2002:a2e:89c8:: with SMTP id c8mr52189172ljk.73.1555616606373;
        Thu, 18 Apr 2019 12:43:26 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.67])
        by smtp.gmail.com with ESMTPSA id f25sm621553lfk.69.2019.04.18.12.43.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 12:43:25 -0700 (PDT)
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
To:     masonccyang@mxic.com.tw
Cc:     bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org,
        zhengxunli@mxic.com.tw
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com>
 <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com>
 <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com>
Date:   Thu, 18 Apr 2019 22:43:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/18/2019 05:51 AM, masonccyang@mxic.com.tw wrote:

>> >> >> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> >> >>
>> >> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> >> > [...]
>> >> >> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-
>> renesas-rpc.c
>> >> >> new file mode 100644
>> >> >> index 0000000..037f273
>> >> >> --- /dev/null
>> >> >> +++ b/drivers/spi/spi-renesas-rpc.c
>> >> > [...]
>> >> >> +static int rpc_spi_probe(struct platform_device *pdev)
>> >> >> +{
>> >> >> +   struct spi_controller *ctlr;
>> >> >> +   struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> >> >> +   struct rpc_spi *rpc;
>> >> >> +   int ret;
>> >> >> +
>> >> >> +   ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> >> >> +   if (!ctlr)
>> >> >> +      return -ENOMEM;
>> >> >> +
>> >> >> +   platform_set_drvdata(pdev, ctlr);
>> >> >> +
>> >> >> +   rpc = spi_controller_get_devdata(ctlr);
>> >> >> +
>> >> >> +   ctlr->dev.of_node = pdev->dev.of_node;
>> >> > [...]
>> >> >> +
>> >> >> +   pm_runtime_enable(&pdev->dev);
>> >> >> +   ctlr->auto_runtime_pm = true;
>> >> >
>> >> >    I think this line no longer works as expected with the new
>> >> probing scheme.
>>
>>    That's because we added another (SPI) device under our MFD.
> 
> Do you mean just to remove one line
> ctlr->auto_runtime_pm = true;
> ?

   No, you should explicitly call RPM for the MFD (not the SPI device).

>> >> > Have you tested reading? v8 patch still works while v9 patches
>> >> > hang on doing:
>> >> >
>> >> > $ cat /dev/mtd<n>...
>> >>
>> >>    Sorry, 'od -x', not 'cat'.
>> >
>> > root@draak:/# cat /proc/mtd
>> > dev:    size   erasesize  name
>> > mtd0: 00040000 00001000 "Bank 1 - Boot parameter"
>> > mtd1: 00140000 00001000 "Bank 1 - Loader-BL2"
>> > mtd2: 00040000 00001000 "Bank 1 - Certification"
>> > mtd3: 00080000 00001000 "Bank 1 - ARM Trusted FW"
>> > mtd4: 00400000 00001000 "Bank 1 - Reserved-1"
>> > mtd5: 00300000 00001000 "Bank 1 - U-Boot"
>> > mtd6: 00200000 00001000 "Bank 1 - Reserved-2"
>> > mtd7: 00480000 00001000 "Bank 1 - Splash"
>> > mtd8: 00040000 00001000 "Bank 1 - Device Tree"
>> > root@draak:/# od -x /dev/mtd1
>> > 0000000 0000 d280 0001 d280 0002 d280 0003 d280
>> > 0000020 0004 d280 0005 d280 0006 d280 0007 d280
>> > 0000040 0008 d280 0009 d280 000a d280 000b d280
>> > 0000060 000c d280 000d d280 000e d280 000f d280
>> > 0000100 0010 d280 0011 d280 0012 d280 0013 d280
>> > 0000120 0014 d280 0015 d280 0016 d280 0017 d280
>> > 0000140 0018 d280 0019 d280 001a d280 001b d280
>> > 0000160 001c d280 001d d280 001e d280 1000 d53e
>> > 0000200 f800 9266 1000 d51e 3fdf d503 3ba0 1005
>>
>>    Still hangs for me. After I patches spi-mem.c and the driver to
>> call RPM for the MFD, it started working again. Perhaps, that clock
>> is still enabled on your target. What does the following print (for
>> the RPC clocks)?
>>
>> $ mount none -t debugfs /sys/kernel/debug/
>> $ cat /sys/kernel/debug/clk/clk_summary
>>
> 
> root@draak:/# cat /sys/kernel/debug/clk/clk_summary
>                                  enable  prepare  protect                                duty
>    clock                          count    count    count        rate   accuracy phase  cycle
> ---------------------------------------------------------------------------------------------
>  audio_clkout1                        0        0        0    11289600          0     0  50000
>  x19_clk                              0        0        0    24576000          0     0  50000
>  dclkin-0                             0        0        0           0          0     0  50000
>  scif                                 1        1        0           0          0     0  50000
>  audio_clkb                           0        0        0    22579200          0     0  50000
>  msiof-ref-clock                      0        0        0    66666666          0     0  50000
>  extal                                2        3        0    48000000          0     0  50000
>     r                                 0        2        0       31250          0     0  50000
>        rpc-if                         0        1        0       31250          0     0  50000

   This looks wrong, the RPC-IF module clock should have RPC or RPCD2 (where ae they?)
as a source, not RLCK...

>        rwdt                           0        1        0       31250          0     0  50000
>        cmt0                           0        0        0       31250          0     0  50000
>        cmt1                           0        0        0       31250          0     0  50000
>        cmt2                           0        0        0       31250          0     0  50000
>        cmt3                           0        0        0       31250          0     0  50000
>     osc                               0        0        0      125000          0     0  50000
> 
> 
> thanks & best regards,
> Mason

MBR, Sergei
