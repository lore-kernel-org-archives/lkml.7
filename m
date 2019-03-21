Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3535EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059DF218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 09:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553159199;
	bh=xlDPynwetnCQ3H7/Ydgq0AXB0mKRHZNXk2sMFprqLj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xMX9H/I/uaxt5A6pvGX4fNmU9yw7jovGKoii/fbMGRLNuLlNgUe3wr/QodLdohkkz
	 stE0TEl+FNKApL/Ou2jeqCe93HurhjM0JVSWDMMfooupEf0vYI7bDlZtKLXtheMI5L
	 YPSiSRtAXbgG43C7GYQETbgrV8Nw5HWiHtfjUSYo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfCUJGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 05:06:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfCUJGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 05:06:37 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68FBA218E2;
        Thu, 21 Mar 2019 09:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553159196;
        bh=xlDPynwetnCQ3H7/Ydgq0AXB0mKRHZNXk2sMFprqLj0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DYH40JXogRzFgF0HyPRHB1SyyFZzlZjRiqTSeZncg7yMFnjnySNhxxQjhK8K5tkIR
         71ylSec0N3eYHeqytcmhhzE6sFcZsp/IJT/QPhwqgqC1unSo+Xc6qn5+A1TNmzSrTJ
         AmyHKTw8rqH4cHcfmxGVsmj7Xp6NtMmf+pkQvdYU=
Received: by mail-wm1-f53.google.com with SMTP id v14so1839039wmf.2;
        Thu, 21 Mar 2019 02:06:36 -0700 (PDT)
X-Gm-Message-State: APjAAAVQaMi7JN4QDx3+/lCQwqgjuKfAhTZvFHvAxagqMGCPsAwDghYo
        wlsOLgouoU199fCUU445RSEA1NgDrH3Yf8QQzXk=
X-Google-Smtp-Source: APXvYqyyaTLaUpdy1BjJdk3HC/dnTz5r04pxjP/Mt8dSe5SOzLMs2O/AbLtr3DkV3xv33GPKyjl0obBW0in692YwG4M=
X-Received: by 2002:a1c:f502:: with SMTP id t2mr1627944wmh.124.1553159194961;
 Thu, 21 Mar 2019 02:06:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190318073354.12151-1-wens@kernel.org> <437873bb-26c5-a451-0a4e-5d846b05244a@linaro.org>
In-Reply-To: <437873bb-26c5-a451-0a4e-5d846b05244a@linaro.org>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Thu, 21 Mar 2019 17:06:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v65MEF8VNx3SZkBfO2x6=vPb6kuFmO+yJyyR1qZbXD8EwQ@mail.gmail.com>
Message-ID: <CAGb2v65MEF8VNx3SZkBfO2x6=vPb6kuFmO+yJyyR1qZbXD8EwQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] nvmem: sunxi_sid: native format and A83T/H5 support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 10:25 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
> On 18/03/2019 07:33, Chen-Yu Tsai wrote:
> > From: Chen-Yu Tsai <wens@csie.org>
> >
> > Hi everyone,
> >
> > This series converts the sunxi_sid driver to read out data in native
> > endianness for all Allwinner SoCs. It was already the case for the H3,
> > which used a different read-out method. The endianness for this hardware
> > was found to be either native or little endian [1], based on the data
> > layout for the thermal sensor calibration data stored within. Some SoCs
> > have either 1 or 3 sensors, and calibration data for each sensor is 2
> > bytes wide, with data for 2 sensors packed into 1 word.
> >
> > The first three patches do some clean-up and improvements of the code
> > overall. The fourth patch converts the driver to reading out data in
> > native endianness. The fifth adds support for the A83T and H5. These
> > two were already listed in the device tree bindings. The last patch
> > adds a device node for it on H3 and H5.
> >
> > Please have a look.
> >
> > Regards
> > ChenYu
> >
> > [1] https://lkml.org/lkml/2019/2/18/134
> >
> > Chen-Yu Tsai (6):
> >    nvmem: sunxi_sid: Read out SID for randomness without looping
> >    nvmem: sunxi_sid: Optimize register read-out method
> >    nvmem: sunxi_sid: Dynamically allocate nvmem_config structure
> >    nvmem: sunxi_sid: Read out data in native format
> >    nvmem: sunxi_sid: Support SID on A83T and H5
> >    ARM: dts: sunxi: h3/h5: Add device node for SID
> >
> Applied all the nvmem patches except DTS patch to nvmem next

Thanks. Merged the DTS patch with Maxime's ack for 5.2.

ChenYu
