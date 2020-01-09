Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9792BC32771
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6563620678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 09:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MC9xf9Me"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbgAIJsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 04:48:09 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33457 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729826AbgAIJsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 04:48:08 -0500
Received: by mail-qk1-f195.google.com with SMTP id d71so5431893qkc.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 01:48:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kFt5sINwCshN7f9XPeO36FD74hM2+ZVDRrYbGF8loWg=;
        b=MC9xf9MeaTGS0ORWl9iQ4wapynYiCn/Ktx+vvFlfK7odU2KpzoA3/BD2X7r+BBwEUj
         AJ+a/oeCIJjWrmW+5Jkmq9Yz9BZKT3Bmjjfzm56uBKhiMmmYCEBALZMqSORH3orOG9Qe
         TAgbPzK5lBIgc+Er5fKe809mLb5nhY4ThWFYcg73GSGOAZbFnxeBRDy1jP/4ew9PsA3N
         K5n2c3kN97ulvkzH79saWCh2c62itzxld2703wwno5bBSesTGCIUGJHKceWczsTpMIz1
         GFHWXdjGPtiqukwIyrP4OipPnI1rXSeO7ZUlKGAtio6wR4aDkXYfl3sLVndplD62fp2K
         TjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kFt5sINwCshN7f9XPeO36FD74hM2+ZVDRrYbGF8loWg=;
        b=qDUKcSIaw7EX/egsUmb5BEYdQhivGbfpr1svYbM5sS7G2+ytE0D04tZOXl9t6PWdtg
         Lpysa5p3qaUkcX+wjS1gXWUsox5twWIL/SCBEvcr6jhBMv/d5+ds3USf1jej9QVC7ijO
         lSeNHmZEps8VROIQYm/+83RLyxiLegNxWuA2lbTbjfT/WevaEQHei1WcbCUkytsaJ26g
         3MezNiWVsRyNxVRyv+Jq6xRszF5SOT47xJE6E59PWHvyj3VlHM9HhGcKQCb8pJwedO8P
         nQU7IyjA8HFh+n39wGPs5bWrX1ifCzx0IMPfS8MyTYpyHte0MsAzU0whpvhTA0kZs60a
         kxNA==
X-Gm-Message-State: APjAAAXIqkGVt7fCl0NORm7RDjsQsp+UixiFqNgFLD+fwZulgK3qZM18
        oK0P/QEftqDclRLW8+QfrrfkmfK+WhEDmvPGfIWLGw==
X-Google-Smtp-Source: APXvYqwtJLDiExkWMnInqbVktQr9vDV/d5lmAhlTP7G0mBpb6RfrkdSR6eG91YtmQ+x9YK8qMe3vwS9aE/HYkSbCbkg=
X-Received: by 2002:a05:620a:12cf:: with SMTP id e15mr8766111qkl.120.1578563287029;
 Thu, 09 Jan 2020 01:48:07 -0800 (PST)
MIME-Version: 1.0
References: <20200107092922.18408-1-ktouil@baylibre.com> <20200107092922.18408-5-ktouil@baylibre.com>
 <20200108205447.GA16981@bogus>
In-Reply-To: <20200108205447.GA16981@bogus>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 9 Jan 2020 10:47:56 +0100
Message-ID: <CAMpxmJXffr-S51udNmUyMHz687jAoBKrYspNypfUUqjOD45zxQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: at25: add reference for the wp-gpios property
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Khouloud Touil <ktouil@baylibre.com>,
        baylibre-upstreaming@groups.io,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 8 sty 2020 o 21:54 Rob Herring <robh@kernel.org> napisa=C5=82(a):
>
> On Tue,  7 Jan 2020 10:29:21 +0100, Khouloud Touil wrote:
> > As the at25 uses the NVMEM subsystem, and the property is now being
> > handled, adding reference for it in the device tree binding document,
> > which allows to specify the GPIO line to which the write-protect pin
> > is connected.
> >
> > Signed-off-by: Khouloud Touil <ktouil@baylibre.com>
> > ---
> >  Documentation/devicetree/bindings/eeprom/at25.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>

Hi Greg,

AT25 patches usually go through the char-misc tree. In this case
however, the change depends on the other patches in this series. Can
you ack this and I'll take it through the AT24 tree exceptionally?

Best regards,
Bartosz Golaszewski
