Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70ECBFC6195
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4397321882
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 15:35:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijCUyc5i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389298AbfKGPfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 10:35:05 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42168 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389213AbfKGPfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 10:35:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id b16so2356941otk.9;
        Thu, 07 Nov 2019 07:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4Awp6aOhgxlUbwSvEpd03sWLJcXbVuHqaesNRPrPJo=;
        b=ijCUyc5iys61fP5qEnvqB8BCmoBcDMao3mCulvGbWvgt55dkkYzlQq0oJND3XvRnBi
         YX/rX62aJZPdsgNa5wqocPqqKdiY4uUUBqLXVdkOVPvGzrCzQWan6hlUDPEy6m+8yrx/
         ryzXIA6mflIgSgR//YvsyL1BcQ/3ElJPQwUxHHpuzOgUDRau5Aho3VfkvjiXUhq/UMSo
         L2QLyWG0HdNqsrpkzuBewcFBc4q3C6WsFKch57Su8Q3AFKl/WCGb1LZSgIPs7q2NFUaJ
         COtnVEMPQS6kzIgp3u/4H2p1rCrdZu6XeNJqzALe+E896Lw+1OuBmqf8O38BJwTTKygZ
         XYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4Awp6aOhgxlUbwSvEpd03sWLJcXbVuHqaesNRPrPJo=;
        b=a5MPQazJJ7QIqCIpfFY4BzZFlvBIVxsYxB7SjgzFO39oNvuqDnQuaQim/xg0amF8p5
         FIXski+SiTBuKgolhYmlKCAEcZuW+ghvz6nC0FVDfp9O3hhs2hWD6jv7iuGWBGWff8Gf
         es1thO3fysPJ+Jv7GULytk/iQd4eTM6paHNI1f5CP966moUGEVI14t3tk0Qi/i5Q7f13
         O18cwUufQEXrsrTWum1IDkoYFl26imNkOBGJXi4q4/PADENNRwrMo2yULHhRqNoiOraS
         tWACPEguxTiAzU/OVuZmHuu/Z7kXDQs3rg0lqHtB9oUMbB2tS/NlLSUxpZHg+5uMAfe+
         rztw==
X-Gm-Message-State: APjAAAWx+w1Vl7s/jpLBi+KDiKnotyBZCK5J93aSpsVOgojibSgHTkCr
        vNl1R8oycCGS+MLebsQbdJezqzU5rHhvdeL1Xjo=
X-Google-Smtp-Source: APXvYqztU5GX0wlrnLPTMRH3pBVlSCTlwNpEd98regvGSDq6dRbCARkLpuzO2q7834lI/wC55JMJf9/Mpu2uMwyeWNY=
X-Received: by 2002:a9d:1b0d:: with SMTP id l13mr1540580otl.84.1573140903023;
 Thu, 07 Nov 2019 07:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20191106140748.13100-1-gch981213@gmail.com> <20191106140748.13100-2-gch981213@gmail.com>
 <1573132996.8833.3.camel@mtksdaap41>
In-Reply-To: <1573132996.8833.3.camel@mtksdaap41>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Thu, 7 Nov 2019 23:34:49 +0800
Message-ID: <CAJsYDV+UJFHsZWMOrvQFRm5BeG-6-YW8KSatSTxA=_gPuHJ6sw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mtd: mtk-quadspi: add support for memory-mapped flash reading
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     linux-mtd@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Richard Weinberger <richard@nod.at>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Thu, Nov 7, 2019 at 9:23 PM Yingjoe Chen <yingjoe.chen@mediatek.com> wrote:
>
> On Wed, 2019-11-06 at 22:07 +0800, Chuanhong Guo wrote:
> > PIO reading mode on this controller is ridiculously inefficient
> > (one cmd+addr+dummy sequence reads only one byte)
> > This patch adds support for reading from memory-mapped flash area
> > which increases reading speed from 1MB/s to 5.6MB/s
>
> This may not be true for all MTK SoC. Which one are you testing?
>

I tested it on MT7629.
There should be a 5x reading speed increment under DMA or direct read
mode than PIO mode because PIO mode needs 30 or 36 clocks for every
single byte of data while DMA or direct read only needs 24 or 30
clocks for initial command/address/dummy and every byte of data after
that only need 8 clocks.

Regards,
Chuanhong Guo
