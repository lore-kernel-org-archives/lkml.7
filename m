Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D79C0650E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE0EB2187F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 12:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="RVVGw0F7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfGCMtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:49:04 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:46986 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbfGCMtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jul 2019 08:49:03 -0400
Received: by mail-wr1-f53.google.com with SMTP id n4so2632068wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2019 05:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=FuvWmI2Ac2pIZhwnDICxrWfsRIUJnwbmAdcXZhrnIuk=;
        b=RVVGw0F7gOGZQ4TEpiyVQ85EpiJgXCb6jLFkfKamOa6QYuyFWojlAQNggohYTdzr2d
         9q2ep+cHOl6daAeiE6MSXobfTG5aGX49Tvu2IO5enl0jIOe6+Fyc7YPKt62Lp3z//l+t
         5afqY4Jrp15R8g77nUuJE0zNLnB+tFRaJJvPrdtgVU2z1eELcxW59gMb5Oc4lSJZx/bT
         yrhnSvteITwxxjIIy0k5vLmKmkPekYMDBmwxbyS+P7F+r3r29MkFd6jsS4TkM4huPNnH
         M1SHjrbF1o55wajA4Td86/gDNbl3yNNhwWYJOd8Rqh38DRdqqOeBuQVLho6nh0gafS1M
         9Y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FuvWmI2Ac2pIZhwnDICxrWfsRIUJnwbmAdcXZhrnIuk=;
        b=S3oGYT4c1WHryKeYKWgQBJ2LvsojZiExnCYGEjdY1h6FfcrX0gpwSRbpYUAGyGX8EB
         FeLDZD77Fc6GTV00qwSJPbn+o8Wp+8DYplYFNReKoS4DGqeCAvXwk8zWLFWGzVYCA3gw
         SVGLh8RSa1/9vIWSTcHDhKN3r7zYFnWovwAT4jnD/bUTsmAs01LoKxcPQFSpTMTF5NeB
         X7jHOn9FCf31YAeZ4ldZ/94aBtR/pce/MEIUVBYAEwOOMXplKOw2bUYHtNgzjYt4AHb3
         9p1gmFQ3AG+725Mg/HhAWRNEtgARzEuwj518ZrKeH8f9vTp9px3iAhz/8aYQrO7iUVgb
         knig==
X-Gm-Message-State: APjAAAVaBgdQSswpDGAU5pBGa5xm6y7MRN0ZYr6jp+GWWWToK5h3SstN
        zd9+yTlyCMLKH0qiH10sKQsNcg==
X-Google-Smtp-Source: APXvYqyDAfOGOAjcImm7vz1haXRMsa83iykN2nsIK77a4bhegzF3S2j2rg4Wk9JFZ82wUNU8F7il6Q==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr29086502wre.205.1562158140924;
        Wed, 03 Jul 2019 05:49:00 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id q1sm1504594wmq.25.2019.07.03.05.49.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 03 Jul 2019 05:49:00 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC/RFT v3 09/14] arm64: dts: move common G12A & G12B modes to meson-g12-common.dtsi
In-Reply-To: <e49bfb8f-23e9-c834-62c7-a40528a2ef06@baylibre.com>
References: <20190701091258.3870-1-narmstrong@baylibre.com> <20190701091258.3870-10-narmstrong@baylibre.com> <CAFBinCA537EV9kzz+5syaF1Q-stTJ4no+NBdcYD3QL-FJSoWfQ@mail.gmail.com> <e49bfb8f-23e9-c834-62c7-a40528a2ef06@baylibre.com>
Date:   Wed, 03 Jul 2019 14:48:59 +0200
Message-ID: <1jlfxf7078.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Jul 2019 at 13:51, Neil Armstrong <narmstrong@baylibre.com> wrote:

> On 03/07/2019 01:54, Martin Blumenstingl wrote:
>> Hi Neil,
>> 
[...]
>> does it make sense to name this file "meson-g12a-g12b-sm1-common.dtsi" instead?
>> do you know whether there will be a successor to G12B and what it's
>> code-name will be?
>
> meson-g12a-g12b-sm1-common seems a bit long to me...

+1 ... and what if the generation after that is compatible as well ? We
extend the name again ? Such naming scheme does not scale.

meson-g12-common.dtsi looks good to me. IMO, The fact the sm1 dtsi includes
the file is enough to understand that sm1 derive from the g12a/b

>
> We don't have naming of the future SoCs, since SM1 is only available on
> prototypes yet.
>
> Neil
>
>> 
>> 
>> Martin
>> 
