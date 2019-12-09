Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3E3C04E30
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E54B20726
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 14:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo1DFtbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLIO4z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Dec 2019 09:56:55 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:37693 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfLIO4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 09:56:55 -0500
Received: by mail-il1-f193.google.com with SMTP id t9so12975433iln.4;
        Mon, 09 Dec 2019 06:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZjkca3Zp9sYYYIS/QPCEF0H2DGmE3kQodC7U7RI6jg=;
        b=Jo1DFtbfEqbVJQq5XZ5LYzCv5LfIMXre5rs2IBqXAEswSM4ZyGHTOACUpAWl/JxobF
         HLX/pPfXm0RL9M3l645yavzaROmAbjPrumBgCxOs+qt0jECTLvAP2saRGhxDiE4oVabe
         x5ksCotFtF8bz+kAXYWj99jBeJUme6AdylQlFhZHK5Pd5Gk1t3eZiddRZuYK0LK40RxD
         YSVYDjyxUtLqzzIQK4xOZoi+glaFkyr5SiLcxWGHnk44UhVVdqwlxJe//NV2RaRGPTNP
         gl8tmVv118OmwBXVwaHHpaVbbEq1vi6cVvltYUcazpnix7+plbZ6LF5IODbwmjQ4/C3R
         9miQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZjkca3Zp9sYYYIS/QPCEF0H2DGmE3kQodC7U7RI6jg=;
        b=HGkTwBtNpfa0PsAvonHxJuAzOIxbuXF03Cfft+CY/0La5g/uYt4+7CnOehphaIlYAf
         oeVVf4hvIWtiwAV8s5Z29TaVHg0+9ptlOm1akBduHliIGI0nOWkFyawwi23sQAhGcrp5
         M784IiwdijVdyyiJP05KvYzUrW5cB6ayAHEmvRFzhV+JcQ+8c4g3uuC+H2kJBACGGorh
         k6gAXLtw4YyHf2rxQnJg0tEkgbyF9itKdCruZWlqLsvb+Xzf98EsM+JYWl9TZEEdfyJA
         R9t1oB/NrFSVKWP/AE2RfY0ssvSrHX5YY9j/WFuGC+Bs3ef2OP5gex6vM3907pQ6ROM7
         Al/A==
X-Gm-Message-State: APjAAAXsKve5UM7kJ0xhJpWIDjOoQcCXi2/iZJ48/TC16wV2jlNNzNnh
        6UrflmFgg8uYpJi46BVnYk0yzGhLQYid/1iMFwcOUGi6
X-Google-Smtp-Source: APXvYqxlvrvi0P/1yFULp5Ov9uTz23XUXUnTAB4CPJ8ux5bZ/ALMike0pN8bBYyFrKhz/ds6VBHl/XO9ocuzIVo34UE=
X-Received: by 2002:a92:3919:: with SMTP id g25mr10786954ila.221.1575903414183;
 Mon, 09 Dec 2019 06:56:54 -0800 (PST)
MIME-Version: 1.0
References: <20191206184536.2507-1-linux.amoon@gmail.com> <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
In-Reply-To: <724aa7db-3838-16f9-d344-1789ae2a5746@arm.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 9 Dec 2019 20:26:42 +0530
Message-ID: <CANAwSgTPrP5FS3xb7SadZ+BwASWQxfO8rBmno8ZW0JzAxcqWKA@mail.gmail.com>
Subject: Re: [RFCv1 0/8] RK3399 clean shutdown issue
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Daniel Schultz <d.schultz@phytec.de>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-rockchip@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On Mon, 9 Dec 2019 at 18:59, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 06/12/2019 6:45 pm, Anand Moon wrote:
> > Most of the RK3399 SBC boards do not perform clean
> > shutdown and clean reboot.
>
> FWIW reboot problems on RK3399 have been tracked down to issues in
> upstream ATF, and are unrelated to the PMIC.

Yes I am aware of this changes.
But, I have tired to study *RK808 datasheet V1.4* [0] below section
*5.2.3 Power Channel Control/Monitor Registers*
for clean reboot I was going to try disable some bit in below
into reboot handle in the future patch.

DCDC_EN_REG
SLEEP_SET_OFF_REG1
SLEEP_SET_OFF_REG2
DCDC_UV_STS_REG

I was going see if this helps to do clean reboot.
further more use this in suspend/resume operation.

[0] http://rockchip.fr/RK808%20datasheet%20V1.4.pdf

But I feed that their is some more issue with related to mmc or PCIe
not able to cleanly release the resources while reboot which caused
then to disable after reboot.

>
> > These patches try to help resolve the issue with proper
> > shutdown by turning off the PMIC.
>
> As mentioned elsewhere[1], although this is what the BSP kernel seems to
> do, and in practice it's unlikely to matter for the majority of devboard
> users like you and me, I still feel a bit uncomfortable with this
> solution for systems using ATF as in principle the secure world might
> want to know about orderly shutdowns, and this effectively makes every
> shutdown an unexpected power loss from secure software's point of view.
>
> Robin.
>
> [1]
> http://lists.infradead.org/pipermail/linux-rockchip/2019-December/028183.html
>

Yes I have follow the mailing list and I read this thread.
I am not aware of ATF complete architecture.

-Anand
