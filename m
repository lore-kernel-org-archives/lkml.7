Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F66FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 943562067B
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 20:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571343878;
	bh=dEhlN1U9q8+rO6EnwLvvcaOV2HkWaFaoPFGlTDAzBkU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OUeQ9S3Y/50PwqgH5evt3vJnRkHtqK9SufjMqG55+kVBEEnO4lrRM1Itpe0QUx2A7
	 +SrXhMa2gzGUhMU+AA5D1oApJO17CcrxBS0mQ/37B5K1ybyqNz6X6Qh2WjG7Id3nEJ
	 n9sF7RhBiLYfLPbgsSto6YF5KINyl3/mKH3BDlCo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436893AbfJQUYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 16:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731007AbfJQUYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:24:37 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1289C21A4C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 20:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571343876;
        bh=dEhlN1U9q8+rO6EnwLvvcaOV2HkWaFaoPFGlTDAzBkU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p0p74HCbcYgT+5BHELgLVVDLse9PuVLzUI7RhtxUlznok7FoWM8BTCUDW6OfRAsWJ
         sKCG8evw/FdP5rx4S5WFuknm58Ye9ZzkQV2ZeMMpth1T9QJt97kKtpOECpLzg8m/38
         iM9+osJSRegBD9vDvVv32TixDV2qnpAXHEMuE2Jk=
Received: by mail-qk1-f178.google.com with SMTP id 4so3153448qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:24:36 -0700 (PDT)
X-Gm-Message-State: APjAAAV7ZC/BTfKmE76dSdTJVS9fbEqfUcM2qdU1HTjp7JRpTvKTeU4W
        D3zq3AichtWEYiJFqn45Y78Fzi35PytWwsp2lA==
X-Google-Smtp-Source: APXvYqzTmET9v/HoWM4B05yMpwM8+3yzzIySduIZIhutbnTMwvD8uVjHA8EJZZjwbzfPxG+9hNuiNmL4AhABoqOGOR0=
X-Received: by 2002:a37:9847:: with SMTP id a68mr5331285qke.223.1571343875161;
 Thu, 17 Oct 2019 13:24:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191004214334.149976-1-swboyd@chromium.org> <20191004214334.149976-11-swboyd@chromium.org>
 <6ce47827-55e4-dd15-6a05-f25a2f8a8bb7@gmail.com>
In-Reply-To: <6ce47827-55e4-dd15-6a05-f25a2f8a8bb7@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 17 Oct 2019 15:24:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLf+dLgva+xYNr56xQx3fsLNWsdJBxaJo8nyJDtRxoiyA@mail.gmail.com>
Message-ID: <CAL_JsqLf+dLgva+xYNr56xQx3fsLNWsdJBxaJo8nyJDtRxoiyA@mail.gmail.com>
Subject: Re: [PATCH 10/10] of/device: Don't NULLify match table in
 of_match_device() with CONFIG_OF=n
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:48 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 10/04/2019 16:43, Stephen Boyd wrote:
> > This effectively reverts 1db73ae39a97 ("of/device: Nullify match table
> > in of_match_device() for CONFIG_OF=n") because that commit makes it more
> > surprising to users of this API that the arguments may never be
> > referenced by any code. This is because the pre-processor will replace
> > the argument with NULL and then the match table will be left unreferenced
> > by any code but the compiler optimizer doesn't know to drop it. This can
> > lead to compilers warning that match tables are unused, when we really
> > want to pass the match table to the API but have the compiler see that
> > it's all inlined and not used and then drop the match table while
> > silencing the warning. We're being too smart here and not giving the
> > compiler the chance to do dead code elimination.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Frank Rowand <frowand.list@gmail.com>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Please ack or pick for immediate merge so the last patch can be merged.

As this one is the last patch, I guess you don't want it picked up by itself.

It seems everyone has acked rather than applying. Do you want me to
take the series?

Rob

> >
> >  include/linux/of_device.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> > index 8d31e39dd564..3f8ca55bc693 100644
> > --- a/include/linux/of_device.h
> > +++ b/include/linux/of_device.h
> > @@ -93,13 +93,11 @@ static inline int of_device_uevent_modalias(struct device *dev,
> >
> >  static inline void of_device_node_put(struct device *dev) { }
> >
> > -static inline const struct of_device_id *__of_match_device(
> > +static inline const struct of_device_id *of_match_device(
> >               const struct of_device_id *matches, const struct device *dev)
> >  {
> >       return NULL;
> >  }
> > -#define of_match_device(matches, dev)        \
> > -     __of_match_device(of_match_ptr(matches), (dev))
> >
> >  static inline struct device_node *of_cpu_device_node_get(int cpu)
> >  {
> >
>
>
> Acked-by: Frank Rowand <frowand.list@gmail.com>
