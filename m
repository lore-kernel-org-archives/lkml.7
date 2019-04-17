Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA17BC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79CF9206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:44:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="kkTQf8Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731430AbfDQSoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:44:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46981 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbfDQSoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:44:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id h21so23384178ljk.13
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UIpbSehmMz/KBZb19dBtzvSykR387AXU45bcF3kvkm4=;
        b=kkTQf8JtZ71uXPtgkEd9gma7wpUmmx97NZ4TWJbrHb6Mvoz6PzbcY5tElGbAw2wEy7
         nAGlO/uaLeiabYx1t2rzhxWXwq7HcBgQtFxq1659PIaOkTEC9xEfFmnYORvswqZjYlwd
         8iuvFnUPE1UI97SYp/4ezmLr+NwANP7Lj0KvqP9VMWxjJnm3H4IUVniN3E8BiG5jqNJ+
         lm6DngII0v1QzGgJPVNWYjl7H9SfYstTBsfJU9qoO1pyaueTUyxwUYVBA4aAYA2iRvKK
         mO+HulbfJZ4S0gNbtTGxumtVn+ZSd4QyIBU5HNp5g9yuOtyZwC3HKCKJUgVCkaZ6vN9z
         /xEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UIpbSehmMz/KBZb19dBtzvSykR387AXU45bcF3kvkm4=;
        b=o01ZqIRKyN1YFMhK5BUgt9PFsfSqSQj0APHFdrZN2o16KOxqPaK+QouV9c5MqbyV8s
         /43ppQfWWBTB0GbwOfiosAjdCPt26WbOl9Nq7M8JvRA6QdrME2plneD+7JfdBt4/+MA7
         BaJ1opkgWjkK2sDIruCuYZysx8Ka4UDuMV36FEfmjGhzDdNDm573aFUGb5eQnqSdNPCw
         On7YUuS9K489R6ulGrn0ZGyPghVz3o2Y7ifszruq5lsTnZVj5Hg0Tks+nI3iep/gk7nz
         BVcFjC5VNqEkHO7EzC0FjF7FQEw3cCwvAm9WNJrIqkRGqGTsvyyv7XaFjDJSi4AnlGiI
         MzZg==
X-Gm-Message-State: APjAAAWJo8O6ALVr6mJDpKNIFyXOnMarMJq/NVw4dqMpsWOGBVxVr9gI
        HYJN3F2//ydWlCHJReYQl1RdJA==
X-Google-Smtp-Source: APXvYqxllGYHF/7d868/kgXmY+um13gPE6GMCnNJm0Fd/serotSJLU44EMco9Z4AIHSdG1aVu77gFg==
X-Received: by 2002:a2e:3e18:: with SMTP id l24mr50998325lja.68.1555526649813;
        Wed, 17 Apr 2019 11:44:09 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.81.147])
        by smtp.gmail.com with ESMTPSA id w19sm10875592lfe.23.2019.04.17.11.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:44:08 -0700 (PDT)
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
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com>
Date:   Wed, 17 Apr 2019 21:44:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2019 05:36 AM, masonccyang@mxic.com.tw wrote:

>> >> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> >>
>> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> > [...]
>> >> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-renesas-rpc.c
>> >> new file mode 100644
>> >> index 0000000..037f273
>> >> --- /dev/null
>> >> +++ b/drivers/spi/spi-renesas-rpc.c
>> > [...]
>> >> +static int rpc_spi_probe(struct platform_device *pdev)
>> >> +{
>> >> +   struct spi_controller *ctlr;
>> >> +   struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> >> +   struct rpc_spi *rpc;
>> >> +   int ret;
>> >> +
>> >> +   ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> >> +   if (!ctlr)
>> >> +      return -ENOMEM;
>> >> +
>> >> +   platform_set_drvdata(pdev, ctlr);
>> >> +
>> >> +   rpc = spi_controller_get_devdata(ctlr);
>> >> +
>> >> +   ctlr->dev.of_node = pdev->dev.of_node;
>> > [...]
>> >> +
>> >> +   pm_runtime_enable(&pdev->dev);
>> >> +   ctlr->auto_runtime_pm = true;
>> >
>> >    I think this line no longer works as expected with the new
>> probing scheme.

   That's because we added another (SPI) device under our MFD.

>> > Have you tested reading? v8 patch still works while v9 patches
>> > hang on doing:
>> >
>> > $ cat /dev/mtd<n>...
>>
>>    Sorry, 'od -x', not 'cat'.
> 
> root@draak:/# cat /proc/mtd
> dev:    size   erasesize  name
> mtd0: 00040000 00001000 "Bank 1 - Boot parameter"
> mtd1: 00140000 00001000 "Bank 1 - Loader-BL2"
> mtd2: 00040000 00001000 "Bank 1 - Certification"
> mtd3: 00080000 00001000 "Bank 1 - ARM Trusted FW"
> mtd4: 00400000 00001000 "Bank 1 - Reserved-1"
> mtd5: 00300000 00001000 "Bank 1 - U-Boot"
> mtd6: 00200000 00001000 "Bank 1 - Reserved-2"
> mtd7: 00480000 00001000 "Bank 1 - Splash"
> mtd8: 00040000 00001000 "Bank 1 - Device Tree"
> root@draak:/# od -x /dev/mtd1
> 0000000 0000 d280 0001 d280 0002 d280 0003 d280
> 0000020 0004 d280 0005 d280 0006 d280 0007 d280
> 0000040 0008 d280 0009 d280 000a d280 000b d280
> 0000060 000c d280 000d d280 000e d280 000f d280
> 0000100 0010 d280 0011 d280 0012 d280 0013 d280
> 0000120 0014 d280 0015 d280 0016 d280 0017 d280
> 0000140 0018 d280 0019 d280 001a d280 001b d280
> 0000160 001c d280 001d d280 001e d280 1000 d53e
> 0000200 f800 9266 1000 d51e 3fdf d503 3ba0 1005

   Still hangs for me. After I patches spi-mem.c and the driver to
call RPM for the MFD, it started working again. Perhaps, that clock
is still enabled on your target. What does the following print (for
the RPC clocks)?

$ mount none -t debugfs /sys/kernel/debug/
$ cat /sys/kernel/debug/clk/clk_summary

> fyi~
> 
> best regards,
> Mason

MBR, Sergei
