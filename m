Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F5DC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:38:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E37BA21D56
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 15:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddZiXkOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfIZPio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 11:38:44 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43146 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbfIZPio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 11:38:44 -0400
Received: by mail-io1-f67.google.com with SMTP id v2so7629735iob.10;
        Thu, 26 Sep 2019 08:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li57q73MX1RVx23YfgpvWF5w0x4ow2nEwbE6KvqKXw4=;
        b=ddZiXkOGcNyt3yIpQx4T3/Gj0lMxo5fD6jC8orTuZHFI28MUf8nRRhWDRT3KHHhPSL
         2QkgJq3B3CkBEs2qVqnO2XzZ/b3xh0C5DItoQmeyhM7ZssdZUem0rhRUJRkkwSEPuqhb
         TsfJnifEzBgUSl6rNTR6Y/I2+QwUfSAfrIXzYsLw6zlKsb4ORWAJKTPEGEaz6/z2Rrjj
         grlrAU5A1pz8Td00+qZCozRZVZZTVsLUU1RticRT0EcsJ+s0Plpjbpu5nuzCJcIz9FmW
         isHVVt8SUg33ne8/OYfOzsug+Y6qdnVxsb6lh7qYLCuzfIGgUWWjX5c1x0HLg9PR8gQ9
         I1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li57q73MX1RVx23YfgpvWF5w0x4ow2nEwbE6KvqKXw4=;
        b=HJG6FLr3Sgs6HXoFNYOpzhv1X9k6GKjQA3ACDq2R5PraYChE0lJ4VaX7uq9qIJ4TWy
         M+IO24C8qp0u5n63NozF+GZpruiedD+R+k1E/SYpghKA0wvPkDIhqWbI4d2Zby+3Tea3
         tNwcEWZdZjG8YjF7mmH7kTxvyJmDM6mHzi+eXs33XPYDVv/T75GzKnTVwQCs2bMVpbHz
         7I0nc55H4ltoejFBV3YMgpUud1g/Um2/qcf8GAQqzuWyaBZUPeNNcP92DcypHztxepju
         GU7eOitujsXA0skc3ipkNlAv6ZFEc7YBASQ7o2xHkFoiBPUWxWJRU7/uLcvUzUKSkI9t
         9OQg==
X-Gm-Message-State: APjAAAVUr1kvO0Uaobfh2JAWTr83Y2AYVq63EugID+Myk4osoZ2eAWag
        OLRgz0DFJMK9h5Q7grRF7mDyImfAPLzx2eQucEo=
X-Google-Smtp-Source: APXvYqz8oVdb4PXIBRw7lIbY55HKL5mDby64gFcwc20gU6l9i2bzFhmg5ZIz7Rt3qIXsTSJXHdzLp4EDv7kKxqLjQbg=
X-Received: by 2002:a02:e47:: with SMTP id 68mr4042317jae.126.1569512323132;
 Thu, 26 Sep 2019 08:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190906122044.372-1-linux.amoon@gmail.com>
In-Reply-To: <20190906122044.372-1-linux.amoon@gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Thu, 26 Sep 2019 21:08:31 +0530
Message-ID: <CANAwSgT-RDicoTxe1574_0KhCJ0=JpRGXydjGPdedJ+sULRfpA@mail.gmail.com>
Subject: Re: [PATCHv3-next 0/3] Odroid c2 missing regulator linking
To:     Rob Herring <robh+dt@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,

On Fri, 6 Sep 2019 at 17:50, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Below small changes help re-configure or fix missing inter linking
> of regulator node.
>
> Re-based on linux-next-20190904
> Changes from previous patch's series.
> Build using Cross Compiler.
>
> Added missing Reviewed-by Neil's and Martin.
> Added few suggestion from martin for rename of node.
>
> Dependencies:
> Changes based top on my previous usb fix series patch's.
>
> [0] https://patchwork.kernel.org/patch/11113095/
> [1] https://patchwork.kernel.org/patch/11113099/
> [3] https://patchwork.kernel.org/patch/11113103/
>
> Hope this series get picked up for 5.4-rc1, finger crossed.
>
> Changes for previous changes.
> Fix some typo.
> Updated few patches as per Martin's suggestion.
>
> I will try to commit less mistake in the future.
>
> Best Regards
> -Anand
>

Gentle ping for this series.

Best Regards
-Anand

> Anand Moon (3):
>   arm64: dts: meson: odroid-c2: Add missing regulator linked to P5V0
>     regulator
>   arm64: dts: meson: odroid-c2: Add missing regulator linked to
>     VDDIO_AO3V3 regulator
>   arm64: dts: meson: odroid-c2: Add missing regulator linked to HDMI
>     supply
>
>  .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 53 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
>
> --
> 2.23.0
>
