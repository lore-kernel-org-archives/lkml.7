Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E199C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AD7208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:36:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lQCO0wdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbfHNIgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:36:15 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34469 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:36:14 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so71490179lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9m/ClKWZBZ4cKiuiDXlzmOAFeeYlFwcr35QV9Gd9YOo=;
        b=lQCO0wdj4cBFymMjPac0TynRfsXFyNg+5yMGu9feG0KP+a+4yM8+eM1GfChG8bkqS8
         05JUSJJ88TvTBcqRbNosmozevJ/uITH1hLF7YI+YkMwa9/ScmTrCq2YNeJ19lCyikFfn
         tMEf3nfpQhwXTU6RRxbsZahJdyuPCNibAKpol0j247AOOgoch4G85EQ5whTQ5eIM18mv
         3cYYVZGdbgWLw1FISkT4XIy37uU2dIJI8SVzU1cBeNEELWQ13/oNRMPTK+/BMtxO65m9
         15l4ZrXz4powXzJMgqlbddMyAVwOYPN9jEU0duoewvy83pwOvWWDd0wNzuySdh3ooTpX
         PkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9m/ClKWZBZ4cKiuiDXlzmOAFeeYlFwcr35QV9Gd9YOo=;
        b=FaYQMmYCiBTBsQCauCBgi+cj/QOrNFQs3kTJ3H3F0zRUv9O/8chBXR+rHhDfbSathB
         eQbd26ouGupl567kVnRev1eDk+jUysmmwloo5oV2uLkCZLA73cOhguZAd95DWNA/kjWv
         d22X9QdvUu+vpEAn+6/DW+1WZBy2nJtf3s5d00DAPdEZ3JYp64L8O2vliD4eAkxfn5SL
         ZbI2qE0P+UJNNJ5ofyTZxKYbUCBpPeTBj7GrGljKUX1knlJ8ZRTNKLg5DEgD1xxKkfXw
         sCd6rUKCD/OicoApLPj42yYg2YmhpIBZ46uBE6jd2FIPOHNiLq1wK2mdyZPq7FCPn69a
         suyg==
X-Gm-Message-State: APjAAAWaHlrYUhsXIE9HTwE5BjsZWgiORHo6dqZwmocAYLtzYMC6MVYb
        /Ujzv3P2Nywoi/Fe/USMyWBqZJYB3wWfzW2yFpGS1w==
X-Google-Smtp-Source: APXvYqznbmtSAAQS/LW5nR9i4yrmWUGYLkBCD0/kjsmr5yLyxGjMyWL3WMpAlXpxiLeD6i4k4a5/J5sHITEp2/ghPp4=
X-Received: by 2002:a19:ed11:: with SMTP id y17mr24953593lfy.141.1565771772948;
 Wed, 14 Aug 2019 01:36:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190809162956.488941-1-arnd@arndb.de> <20190809163334.489360-1-arnd@arndb.de>
 <CAA9_cmdDbBm0ookyqGJMcyLVFHkYHuR3mEeawQKS2UqYJoWWaQ@mail.gmail.com> <20190812094456.GI10598@jirafa.cyrius.com>
In-Reply-To: <20190812094456.GI10598@jirafa.cyrius.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Aug 2019 10:36:01 +0200
Message-ID: <CACRpkdao8LF8g5qi_h+9BT9cHwmB4OadabkdGfP0sEFeLbmiLw@mail.gmail.com>
Subject: Re: [PATCH 1/7] [RFC] ARM: remove Intel iop33x and iop13xx support
To:     Martin Michlmayr <tbm@cyrius.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Arnd Bergmann <arnd@arndb.de>, soc@kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Peter Teichmann <lists@peter-teichmann.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 12, 2019 at 11:45 AM Martin Michlmayr <tbm@cyrius.com> wrote:

> As Arnd points out, Debian used to have support for various iop32x
> devices.  While Debian hasn't supported iop32x in a number of years,
> these devices are still usable and in use (RMK being a prime example).

I suppose it could be a good idea to add support for iop32x to
OpenWrt and/or OpenEmbedded, both of which support some
pretty constrained systems. I am personally using these
distributions to support elder ARM hardware these days.

Just my =E2=82=AC0.01
Linus Walleij
