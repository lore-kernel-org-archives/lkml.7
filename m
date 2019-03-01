Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48846C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C7C20848
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 17:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OswRkEMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389360AbfCARFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 12:05:24 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36414 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbfCARFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 12:05:23 -0500
Received: by mail-ot1-f66.google.com with SMTP id v62so21558830otb.3;
        Fri, 01 Mar 2019 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TS2oNY4HfsJhDMVwcswsu8FZ8ib/zHV6j835eCfyGLI=;
        b=OswRkEMstAuif4RS3Do5iMeBc6c6jEl9neM4eEGAmREZtvhMRvkuhx7NHuGwCbk9BK
         4peoKFHecQZV3Wbrv+tnDtzrcqM8gvi/Nh+ii9elIkK5zQQ6puG1UjfagRu4gkyzLIjA
         sfPLkdRWEfNfiBtlOh+ts5NXOmjowuowEmTZimb6YRoZJKaMDoE/zKsYb5MVHh0VJDOB
         zsUTN9k8RXr0wiWlzfJj06hTNtIawJJj+ADbvWR902bAwYEZ63jra8Hmfum+c7dGFrwg
         7StgPhwxvubuCEJt2jU6WwtF/RGI9Ldw1n+pl9RO4wPPA9kKnvj4AVBOfrG1AOYUE9TN
         imVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TS2oNY4HfsJhDMVwcswsu8FZ8ib/zHV6j835eCfyGLI=;
        b=Ui0o48HMnoE5jyEAPeEB+NoHkZUgrj47lZrKNw7R7JlIC34id29rIZz7PcHNZ9qBA3
         PrM1C7rGGYcZW+wqErovcHx/GfvQAqGnPKSS4A7RGcyN5fnqWAdYVhTkeaBgFY2IUFd/
         KM2mcE+yvySobSeJKLt9eEhZ04qJjlaKuLF36RE620q8y8c5EyUYRBRalUciM/G6qbcH
         +dO9oykIut85Lh77OtEZXFocIgUn7u1+o61y9MKsBzAW1XfCNNM14ociT5+GezbKLJrN
         qOtEooKR7Cz2SWRvRX2VkD9FHBB2LZMud3JoKtrcAcHvwUgSIgCsjwf5HWeK4J2N6vdj
         aUoQ==
X-Gm-Message-State: APjAAAVnvb7Ln0RNaEwVeZwe2iAQGdel87+ukQ0qYaky6e1TJ9eN8Es2
        SVJphKgOsjSbJMdKMIwTfXYF/NeLQzdCacGic1RlJDnT
X-Google-Smtp-Source: APXvYqwsTkIjwBot2w5Ng+9fomMlKgcYPCmyZUu9wklmT2VrB9CBW57WGAe247B9PS+bZOAvuoupKOZDqRmri1HYgMA=
X-Received: by 2002:a9d:a11:: with SMTP id 17mr4219386otg.148.1551459923091;
 Fri, 01 Mar 2019 09:05:23 -0800 (PST)
MIME-Version: 1.0
References: <20190301102140.7181-1-narmstrong@baylibre.com>
 <20190301102140.7181-2-narmstrong@baylibre.com> <CAFBinCCtmykL-ccWd9cporEOmxeUKC-RgrP3wfuSuYoAEjrGWA@mail.gmail.com>
 <d841b285-7994-fd7a-215b-13314bd0b298@baylibre.com>
In-Reply-To: <d841b285-7994-fd7a-215b-13314bd0b298@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 1 Mar 2019 18:05:12 +0100
Message-ID: <CAFBinCDt=BB_nAJ5P1TX0ahmOiqTaLGrqv5X4v2u62KCPw1UGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: meson-g12a: add cpu clock bindings
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Fri, Mar 1, 2019 at 5:43 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi Martin,
>
> On 01/03/2019 16:26, Martin Blumenstingl wrote:
> > Hi Neil,
> >
> > On Fri, Mar 1, 2019 at 11:22 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> Add Amlogic G12A Family CPU clocks bindings, only export CPU_CLK since
> >> it should be the only ID used.
> > is this also true for the CPU post-dividers (APB, ATB, AXI, CPU CLK TRACE)?
>
> Do we need these to be exported ?
I'm not sure as I couldn't find more details about APB, ATB and AXI on G12A:
- APB and ATB may be needed by the CoreSight bindings
(Documentation/devicetree/bindings/arm/coresight.txt)
- AXI may be needed by the VPU driver (the S912 datasheet mentions in
OSD1_AFBCD_ENABLE: "id_fifo_thrd : unsigned , default = 64, axi id
fifo threshold")

if you don't know either then I'm fine with skipping them for now, we
can still export them later.


Martin
