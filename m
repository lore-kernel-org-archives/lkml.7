Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D85C10F0E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7A86214AE
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Apr 2019 19:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LapOJaf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfDGTzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Apr 2019 15:55:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36865 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbfDGTzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Apr 2019 15:55:22 -0400
Received: by mail-io1-f67.google.com with SMTP id x7so9231964ioh.4;
        Sun, 07 Apr 2019 12:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2EWbvybACw2pSft+F1QNp/jKhIc9KZCDXtH4EJ6g6PI=;
        b=LapOJaf0RNbdg3JVgScEJq9pCS0Le+0P958mg0oFP14h4/F3pWrmrL2pmQxZ44k7Mz
         4Jh9Rlt9CeHevs7Ji3Uv58E5fTxTLJOR+zUvUI7lyoTa62IxW+2dfFFCpmxTanq84Ylm
         1PSI8IcvLZ13rV6Tu46cacvm+EtSJgSvGSEIga5RB35J358D/4Z2FoIIKrIlN1c/A6bf
         Kpqck6qDWWWDZJdSHnRLTSEhX0LkcOh/nIK3qzY9gCu1n2lZf8FMYo+t8uhl4u4FainX
         H5YQopnB/9aFWbpwABmKfS3yrsMoFoNRHRSrXUYIq5Je79+gXHlbXQQnkV0CHOxpa2zt
         HgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2EWbvybACw2pSft+F1QNp/jKhIc9KZCDXtH4EJ6g6PI=;
        b=Vb+4F+CkEDHJ/4J9prrjVZ4hxp5PHCpNnVr8RyiIFXym2VZIE+GlhP6C3PiFSac7bM
         PbVwaBrgG/0TWMc5mlMXdQGQy3zqxxQxei+qqyYG65yNbwAXDbCGsxVsIfaOQDLbFlb9
         W7QyaONqRLp4FvmGMaZhRDW1HTA7161ONSX1e6Q+OI9bzX+NIAx/6cJehqbl3S0maelM
         nRGQUQHiq3+OOV2XwPHqqu2nv4jFPmdfU3cuscJvyVm2tr45359TTL8OJvtUMozgwJfv
         qxjoLihyqdfiRG1eqEluY3BK6K4Ve1xbe1EUQA3Byv03Ons2kRLfDWQcvtPoWXqRxRzp
         xwgQ==
X-Gm-Message-State: APjAAAWCUspVyuVyTWtmAW5Qc7of0892GE6UXQt355sd3zgP+50DiNu5
        X9Nm3FJKymMJNtb6aAPwNW+iG86llv2dBzlao0s=
X-Google-Smtp-Source: APXvYqx0LbMcwaYEC11t/Y3Vniv00WToYUFSWOlFL+8L3oi45ov8pNkWZxG8I5pM/VSOKPTXEp2h4M7SHTy+WojY6+k=
X-Received: by 2002:a6b:ca87:: with SMTP id a129mr16787818iog.187.1554666921482;
 Sun, 07 Apr 2019 12:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
In-Reply-To: <21d83ed2-a8db-49cf-ba8c-c7844157d7b0@gmail.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Sun, 7 Apr 2019 21:55:10 +0200
Message-ID: <CANBLGcyeroURDCHrBPRQ8bbhNsy9u0LkCq0MQmWUyvPR=p4b8w@mail.gmail.com>
Subject: Re: [BUG] Rockchip SPI: long burst writes produce unexpected result
To:     Vicente Bergas <vicencb@gmail.com>
Cc:     "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vicente,

On Sat, 6 Apr 2019 at 19:35, Vicente Bergas <vicencb@gmail.com> wrote:
>
> Hi,
> i have been experiencing issues writing to NOR-Flash SPI Memories
> from two RK3399-based platforms: gru-kevin and sapphire board.
> For kevin, this resulted in a bricked device because that memory
> is the only boot device.
> Fortunately an external programmer is available.
>
> In order to isolate where the issue can be, several tests have been
> done, after which it makes me think the issue is related to the
> Rockchip SPI driver.
>
> 4KB burst reads work fine.
> The issue is only observed on the write burst length.
>
> Test user     user/kernel kernel    RK3399
> Num  space    interface   space       SoC   Status Notes
> --------------------------------------------------------
> 1    flashrom linux_mtd   MTD/RKspi RKspi   Fail
> 2    flashrom linux_spi   RKspi     RKspi   Fail
> 3    flashrom linux_spi   spi_gpio  GPIO    OK
> 4    custom   linux_spi   spi_gpio  GPIO    OK   260-byte burst writes
> 5    custom   linux_spi   RKspi     RKspi   Fail 260-byte burst writes
> 6    custom   linux_spi   RKspi     RKspi   OK     1-byte burst writes
> 7    custom   linux_spi   RKspi     RKspi   OK    47-byte burst writes
> 8    custom   linux_spi   RKspi     RKspi   Fail  48-byte burst writes
>
> 3, 4) Unaccetably slow, device tree is
>   spi_gpio {
>     compatible = "spi-gpio";
>     #address-cells = <1>;
>     #size-cells = <0>;
>     cs-gpios   = <&gpio1 RK_PB2 GPIO_ACTIVE_HIGH>;
>     sck-gpios  = <&gpio1 RK_PB1 GPIO_ACTIVE_HIGH>;
>     mosi-gpios = <&gpio1 RK_PB0 GPIO_ACTIVE_HIGH>;
>     miso-gpios = <&gpio1 RK_PA7 GPIO_ACTIVE_HIGH>;
>     num-chipselects = <1>;
>     spidev@0 {
>       compatible = "spidev";
>       reg = <0>;
>       spi-max-frequency = <50000000>;
>     };
>   };
> 2, 5, 6, 7, 8) device tree is
>   &spi1 {

Since you say reverting the "set min/max speed" patch fixes your issues
could you try raising the spi clock like this and see if it works for you?

+       assigned-clocks = <&cru SCLK_SPI1>;
+       assigned-clock-rates = <400000000>;

Of course the driver shouldn't let you configure the spi-controller in a way
that makes it skip bytes, but if this works for you then I still think
you're better off explicitly setting the spi clock speed rather than having
the driver raise it for you. At least while it does it without
checking for errors
or having a way to lower it again as outlined in the commit message.

>     status = "okay";
>     spidev@0 {
>       compatible = "spidev";
>       reg = <0>;
>       spi-max-frequency = <50000000>;
>     };
>   };
> ...

/Emil
