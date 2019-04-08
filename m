Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4405C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA45213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 13:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="a2hneQ1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfDHNwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 09:52:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39940 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbfDHNwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 09:52:00 -0400
Received: by mail-it1-f195.google.com with SMTP id k64so21025029itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 06:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TC6tYCX6enQH47A4j1WyW70lzdF17radDX8UgXC6Sx8=;
        b=a2hneQ1IwcBFZ+crljs4tR3u/TpuCoBJm1IkQanmJ6vkAYc2L41xqZexlXAGjGBuES
         3yCgKhffYo89perWBSqv5OIuWcWVT3xjz1NJXJ9enLXd6fP6IvFImDWEu4unZ3BJ1EfA
         QWYjVR7lzybYO5xV6krsWNv0ktzHeHSNkURUzerkGVXtA0H5rLiAZF2rgLp4/Rk9D85g
         alTuwtGBO9w68p1OQfjZu/2OI+6w+44oawizqyS6+KiHdkAjPMi6yYazX2D6N+MFgLOO
         guD9GrmrTjIuDvSqrLR3ln/K2PtFTGPdzLrxFLCV0OygrO29fIfNan53CtyxNNEfN7lf
         aYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TC6tYCX6enQH47A4j1WyW70lzdF17radDX8UgXC6Sx8=;
        b=QOuS4j4/PLq6AXXyX5D/yidiV4qz3VpDhan/c7m7mGg057Lm6ZMWIiWg6LFYW4QFET
         4OFUuPNdgW6fzvab1e6NwnFF5DA9kgn2vxB1mczBnk4E5PCibCfmhB+2tf+P9hqtkYgP
         YgGk/Gp1HdacJ++61PDM6w1EOjnr+M/AisAfvuNOf003FBUGtJRbZusiyxoHY9X44g1s
         fGPN6j6TbUnhZ8FGJh/TfCHrKfRwuqVmzZn5+MYl7JbfGLyhslEa1k1sBpMNkKh7HzAV
         iU5202Jk0eYkLvvg6FCe9t6S8dHpn0v6Mmy1bnjnfaDIgoaltvxMpemiKnkt+oc+cRBJ
         fpTA==
X-Gm-Message-State: APjAAAVqQcvQBwPFWfq6Vlg5r4dN07x/EsqGxrnEpuEsd1K0ll7ex9jA
        OX3hihriPnJATDJlLlskoc/+bihLGonu9LvK4MtQew==
X-Google-Smtp-Source: APXvYqzE0m+RKfg0+GIupVP7hiCyvaxY5/9AG+laRt90EG+IDHd8pAI0DPLcWnOPXvXxfJlzCsfCoGiPrGrllnBTwVY=
X-Received: by 2002:a24:351:: with SMTP id e78mr18694686ite.160.1554731519995;
 Mon, 08 Apr 2019 06:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190408075924.2284-1-brgl@bgdev.pl> <20190408075924.2284-2-brgl@bgdev.pl>
 <236c4d1d-7275-3223-ee06-0a25982b1fe3@lechnology.com>
In-Reply-To: <236c4d1d-7275-3223-ee06-0a25982b1fe3@lechnology.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 8 Apr 2019 15:51:49 +0200
Message-ID: <CAMRc=Mf7tT1j5n8kM4TJXy7sHYmyfu8DTOwMKwo-d3VG4qOXgQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] ARM: dts: da850: add cpu node and operating points
 to DT
To:     David Lechner <david@lechnology.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Adam Ford <aford173@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 8 kwi 2019 o 15:47 David Lechner <david@lechnology.com> napisa=C5=82(=
a):
>
> On 4/8/19 2:59 AM, Bartosz Golaszewski wrote:
> > From: David Lechner <david@lechnology.com>
> >
> > This adds a cpu node and operating points to the common da850.dtsi file=
.
> >
> > Additionally, a regulator is added to the LEGO EV3 board along with
> > some board-specific CPU configuration.
> >
> > Regulators need to be hooked up on other boards to get them working.
> >
>
> I still have the same comments that I made on v1. It would be nice to
> also mention the LCDK board in the commit message since it is included
> in this patch.
>

My bad, I forgot it.

> Also, the 415MHz operating point is something I just made up for testing
> and I'm not sure that it is actually useful in general. It could be
> omitted from this patch.
>

The board file has the 408 opp, I guess this is in line with other
operating points defined by you which have slightly higher frequencies
than those in the da850.c. Let's see what Sekhar thinks.

Bart
