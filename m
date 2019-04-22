Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAADC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFA1214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:44:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="Qlb6Ka8j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbfDVQoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:44:11 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43504 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728345AbfDVQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:44:11 -0400
Received: by mail-lf1-f67.google.com with SMTP id i68so9429368lfi.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 09:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ms0rfvZRl0q7nQ2JjG0gB/4aq7m4g4BAWeD/32kGdqg=;
        b=Qlb6Ka8jzhKp6KmakCpuNsNkyLWhHvTiov1ihZVaaVdKamd9IQ/m2y6LwsFhEdoQnJ
         mYSzr+1ZCRJmbijqp//eJkFy249IY+dBMp+4pBOhKcmWyNmbGZWJX1L4Z2QHSTXBQGBR
         esMa2AtIiOjVa/5N02637M9NulFgKACiBIK17ft2CT4ROMvlGKvAVHfHYgHajDeqWEze
         2k7qpR0ufA0giD4UPfmnj5QY3v+SpGNS0efAiyNEm1VjwIRNOvxRn0ZrqyYIwJcehEr0
         XvCYC8X1sYH2c4eZCNJEC/RHDPuRswFEIa+72lAFdXiCsxDAR3mUpvXj8edSgBV1nfGa
         L+xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ms0rfvZRl0q7nQ2JjG0gB/4aq7m4g4BAWeD/32kGdqg=;
        b=cgsQ/N77WJBIjc2Lqsw5u3U7wToriFoNmjT6S/bJyxHP2qOyl4h512RVM0EkBxMgye
         duPXMNUHq8/qTk4G0z9gBgOZxOIBqCPGD0V0R6rYfEe+o0ALK5Oo58MXPKnEsXudE+ym
         zzo6p67k1homA9VZcB2IGp4bDy3790+0LLwwFaWJ+Zi7e4G8zAnfWx5jS/8qyYYRRVX9
         wxkkJdmnL/fqFJ0OLtatuhe+Rz80fgc8mm6+GSW7ze0Q3GvVo26ZqAK/+tY2ACm+XIcM
         MMP8vzHwRak9UE7WJgyYrrrlbuhl0Z0wxSuNFr4F+Znl/4mYtpKYKzOQ5gaGl6KJemdi
         Oocw==
X-Gm-Message-State: APjAAAW9k5KgtMIU7PFiWg6z4B1oO3q7vrkTh+JBGbA5IvDgPDKQiwhs
        0tLtVSOia2n0ifb8L4T97P4tQafWvaI=
X-Google-Smtp-Source: APXvYqyu6LlvcRCKE1SgKe5HFaDWfmwDK3BUWPZMJztLtiS5TjVT7IoHQHjK2Vkw7VdHQhV5lzAgpw==
X-Received: by 2002:ac2:5609:: with SMTP id v9mr10489369lfd.159.1555951448427;
        Mon, 22 Apr 2019 09:44:08 -0700 (PDT)
Received: from wasted.cogentembedded.com ([31.173.82.98])
        by smtp.gmail.com with ESMTPSA id n10sm3425619ljh.36.2019.04.22.09.44.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 09:44:06 -0700 (PDT)
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
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com>
 <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@LocalDomain>
 <OFE74649D4.F69BB5EF-ON482583E1.0033F73F-482583E1.00344ED2@mxic.com.tw>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <529fe004-63e2-43c3-0382-9aaa86d0c3a9@cogentembedded.com>
Date:   Mon, 22 Apr 2019 19:44:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <OFE74649D4.F69BB5EF-ON482583E1.0033F73F-482583E1.00344ED2@mxic.com.tw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/19/2019 12:31 PM, masonccyang@mxic.com.tw wrote:

>> > Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
>> >
>> > On 04/18/2019 05:51 AM, masonccyang@mxic.com.tw wrote:
>> >
>> > >> >> >> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>> > >> >> >>
>> > >> >> >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> > >> >> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>> > >> >> > [...]
>> > >> >> >> diff --git a/drivers/spi/spi-renesas-rpc.c b/drivers/spi/spi-
>> > >> renesas-rpc.c
>> > >> >> >> new file mode 100644
>> > >> >> >> index 0000000..037f273
>> > >> >> >> --- /dev/null
>> > >> >> >> +++ b/drivers/spi/spi-renesas-rpc.c
>> > >> >> > [...]
>> > >> >> >> +static int rpc_spi_probe(struct platform_device *pdev)
>> > >> >> >> +{
>> > >> >> >> +   struct spi_controller *ctlr;
>> > >> >> >> +   struct rpc_mfd *rpc_mfd = dev_get_drvdata(pdev->dev.parent);
>> > >> >> >> +   struct rpc_spi *rpc;
>> > >> >> >> +   int ret;
>> > >> >> >> +
>> > >> >> >> +   ctlr = spi_alloc_master(&pdev->dev, sizeof(*rpc));
>> > >> >> >> +   if (!ctlr)
>> > >> >> >> +      return -ENOMEM;
>> > >> >> >> +
>> > >> >> >> +   platform_set_drvdata(pdev, ctlr);
>> > >> >> >> +
>> > >> >> >> +   rpc = spi_controller_get_devdata(ctlr);
>> > >> >> >> +
>> > >> >> >> +   ctlr->dev.of_node = pdev->dev.of_node;
>> > >> >> > [...]
>> > >> >> >> +
>> > >> >> >> +   pm_runtime_enable(&pdev->dev);
>> > >> >> >> +   ctlr->auto_runtime_pm = true;
>> > >> >> >
>> > >> >> >    I think this line no longer works as expected with the new
>> > >> >> probing scheme.
>> > >>
>> > >>    That's because we added another (SPI) device under our MFD.
>> > >
>> > > Do you mean just to remove one line
>> > > ctlr->auto_runtime_pm = true;
>> > > ?
> 
>> how did you test it ?
>> what is your testing flow ?

   I think I've patched drivers/spi/spi-mem.c to get spi_mem_access_{start|end}()
to be called with ctlr->dev.parent->parent as an arg...

>> >    No, you should explicitly call RPM for the MFD (not the SPI device).
>>
>> okay, patch RPM to RPC MFD and will remove SPI RPM enable part.
> 
> wait! I test it ok.
> 
> Don't need to patch RPM to RPC MFD, just keep RPM in SPI.
> 
> root@draak:/sys/power# echo mem > state
> [  135.848711] PM: suspend entry (s2idle)
> [  135.852777] PM: Syncing filesystems ... done.
> [  135.869468] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [  135.879962] OOM killer disabled.
> [  135.883257] Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
> [  135.893474] Suspending console(s) (use no_console_suspend to debug)
> [  135.910946] [Mason] rpc_spi_suspend
> [  135.986022] PM: suspend devices took 0.084 seconds
> [  135.986047] PM: suspend debug: Waiting for 5 second(s).
> [  141.142024] [Mason] rpc_spi_resume
> [  141.220859] PM: resume devices took 0.116 seconds
> [  141.243179] OOM killer enabled.
> [  141.246417] Restarting tasks ... done.
> [  141.266579] PM: suspend exit
> root@draak:/sys/power#

   That's not *runtime* PM, it's the *plain* PM you're testing here...

> thanks & best regards,
> Mason

MBR, Sergei
