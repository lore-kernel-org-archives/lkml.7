Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EF8620854
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 09:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552900200;
	bh=ztu6KI9VW23jrEl5bm7d+m0A1csyhmYy2gl1eld6ggU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zKKKbVEIb8YgSzm6UloUrdE3VxZwrQg5/VlA7uHXdJ4BE3VgvLTwThLBp9rbjfkoe
	 dt1ioQo1RSw9gKP7Bm2EOImwJXmPA40ZfLRPm/ALCK1wTuIOaxhGNhSV/ECK8BVjKu
	 B83V0kpomUsRRqWbWG2vr2VmH2VYsuj8Wpv62HjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRJJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 05:09:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726835AbfCRJJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 05:09:58 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B916B20854;
        Mon, 18 Mar 2019 09:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552900198;
        bh=ztu6KI9VW23jrEl5bm7d+m0A1csyhmYy2gl1eld6ggU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MWne1QOUuAXuQRdwEDLGxu9BOdiGw1UhRnqMYRETqkphkAqp2YVL3zhIuGxMJpkFi
         /j47adKJ+du1Tlt+Lk+J8zWOhHfFCfJpzDnEyKHeBiXuIJZiUI9jppdSLOYlHlkx2h
         MVJWVY6qyR1+d2N6TRO+kILqvEo6pzpokcgYHrgE=
Received: by mail-wm1-f46.google.com with SMTP id v14so3337463wmf.2;
        Mon, 18 Mar 2019 02:09:57 -0700 (PDT)
X-Gm-Message-State: APjAAAX5UQUX63EO2i1rZ4IW+AkRqds46GEXXq6A2gCGq1Yrcl1X8a6r
        e/PWG7k8N8Hla0kk+NljfZKceDT5vcaX4Sgpa1E=
X-Google-Smtp-Source: APXvYqzvlm+p/sP/Uv1Ii+yABATTrl+GGCEZxaUWCMwaRyVBULft8DiUyxcUI2IovQn1uq1H6VFF/3Of/aotEOgZIKE=
X-Received: by 2002:a1c:2543:: with SMTP id l64mr10658898wml.116.1552900196348;
 Mon, 18 Mar 2019 02:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190318073354.12151-1-wens@kernel.org> <20190318073354.12151-5-wens@kernel.org>
 <20190318084212.lv2lorskizl65uzg@flea> <CAGb2v67H9FkjKjSE5a7fUCb_t95Zfuk1p0bjWYJxjMqhMN-hfg@mail.gmail.com>
 <20190318085751.kziqzxnadtho4kdb@flea>
In-Reply-To: <20190318085751.kziqzxnadtho4kdb@flea>
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Mon, 18 Mar 2019 17:09:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v64pq5V0_nZ7f0ZPwuNxNU8HbY0A6CqeC6TMd2z2xhJHwg@mail.gmail.com>
Message-ID: <CAGb2v64pq5V0_nZ7f0ZPwuNxNU8HbY0A6CqeC6TMd2z2xhJHwg@mail.gmail.com>
Subject: Re: [PATCH 4/6] nvmem: sunxi_sid: Read out data in native format
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 4:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Mar 18, 2019 at 04:45:19PM +0800, Chen-Yu Tsai wrote:
> > On Mon, Mar 18, 2019 at 4:42 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > >
> > > Hi,
> > >
> > > On Mon, Mar 18, 2019 at 03:33:52PM +0800, Chen-Yu Tsai wrote:
> > > > From: Chen-Yu Tsai <wens@csie.org>
> > > >
> > > > Originally the SID e-fuses were thought to be in big-endian format.
> > > > Later sources show that they are in fact native or little-endian.
> > > > The most compelling evidence is the thermal sensor calibration data,
> > > > which is a set of one to three 16-bit values. In native-endian they
> > > > are in 16-bit cells with increasing offsets, whereas with big-endian
> > > > they are in the wrong order, and a gap with no data will show if there
> > > > are one or three cells.
> > > >
> > > > Switch to a native endian representation for the nvmem device. For the
> > > > H3, the register read-out method was already returning data in native
> > > > endian. This only affects the other SoCs.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > >
> > > I thought only the newer SoCs were impacted by this issue?
> >
> > It is noticable on the newer SoCs. The old ones only have the 128-bit SID,
> > which could be read either way, as AFAIK it's just a serial number.
> >
> > If you think we should leave the old ones alone I can factor that in.
>
> IIRC, there was also the SoC ID in the SID on those SoCs as well,
> which we might have to use in the future so we'll want to make sure it
> is correct.

We'll need to ask Allwinner about this then.

FWIW, the fel command in sunxi-tools reads them out in little endian. I
believe this and the SID page on the linux-sunxi wiki predate the sunxi_sid
driver.

ChenYu
