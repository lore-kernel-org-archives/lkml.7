Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1894C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA12421872
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfFABVr/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbfHZSFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:05:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34483 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732707AbfHZSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:05:22 -0400
Received: by mail-io1-f68.google.com with SMTP id s21so39573444ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 11:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xErunZPuJorD94l/vc7ENj6uuFr7usZrxrb/oaGw5eQ=;
        b=IfFABVr/1KfuRZB6p1y3WOunsyErFqxPhnXEOJrvwyDMOpnxu1fcWFb+OuGgHaLwY8
         P4QRB/Crm8ezMc8G4RzbPnMRC8hvlvj68jeVc1TMsvmrr/6W0zCHdu8wtEC9ReP+xPID
         +wFqzAUUHx4WZwrW4HxwQAKyKZ8uE1ZxNQE2eaS0XH9V0oNaEcwcjALuFQV3v+baB3Wy
         r2MLOlynILeLaeGT/NnJjBAm5tu9XUgMSYRadJvCkBBEQuWPNuaE+WMj7ylKNr8rkMm3
         mntJ2PgJ05bGqQFpe1hc+NvWiEsSw91U/pt1ZaPV2w5IiJOnX0RRBIqHDmruFJtSKrY2
         dvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xErunZPuJorD94l/vc7ENj6uuFr7usZrxrb/oaGw5eQ=;
        b=I/bkMaHARnmDkZNo0ET8KHtFbt6igAcXpMZXjmeEw0H6jwpbBAaXy+KiHYom/KSHrD
         V5qlPlQz5sYi7yxeidTOvp5ADEQXwFPo2ut0rtXbhWdmJ5HZHopWBB1xJyfb+0rJtFf2
         xV+w110IyI4dtiTFgucFv4tVk9aXiR3tyr73j2owm0SpdnAvxh/rwB1aZWeq3hOPxylY
         oCfBYP6KdZee84JDrFA3pNonKQfBbDpgMEnY/Ur9DQhda3fm+iiKFKncPcZMkOjnP/p1
         l6nUDz2mDFMBD6JHgAr3tyr8JIanKpcoNAUpB/0meXgkkXtU/xWNUUNEj2Rfy9bmDL5o
         Ov4w==
X-Gm-Message-State: APjAAAVMqk8zM1tZJAipkVAaJUsxEtfMKcNkwjysi3XIOW7X+plszZI+
        BqNwkimNGdFuWMRKVlP2tSB/YKno/P9Op4FafAE=
X-Google-Smtp-Source: APXvYqw0YR2dFpgRDEYpOGIx9y+J6vXPTCqZruvnSxh0xULxLyWz6aaBXEf5EATJxms/V5T0eV7N7QEL3tgnqQNZEwY=
X-Received: by 2002:a5e:8e08:: with SMTP id a8mr18337621ion.94.1566842721537;
 Mon, 26 Aug 2019 11:05:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190820031301.11172-1-andrew.smirnov@gmail.com> <20190824190903.GC16308@X250.getinternet.no>
In-Reply-To: <20190824190903.GC16308@X250.getinternet.no>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 26 Aug 2019 11:05:10 -0700
Message-ID: <CAHQ1cqENuDQ6OKHiP-ecxOHrjTHN1_Gf6DqrAwAq6W3PBE6Ggw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: vf610-zii-scu4-aib: Drop "rs485-rts-delay" property
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Chris Healy <cphealy@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 12:09 PM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Mon, Aug 19, 2019 at 08:13:01PM -0700, Andrey Smirnov wrote:
> > LPUART driver does not support specifying "rs485-rts-delay"
> > property. Drop it.
>
> If so, we need to fix bindings/serial/fsl-lpuart.txt in the meantime?
>

Yeah, good point. Will submit a separate patch for that.

Thanks,
Andrey Smirnov
