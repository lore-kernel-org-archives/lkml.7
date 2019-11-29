Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D44D3C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5EB2464C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 21:58:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+Urcqkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfK2V4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 16:56:54 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39310 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbfK2V4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 16:56:53 -0500
Received: by mail-lf1-f65.google.com with SMTP id q6so563405lfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 13:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LD4rQhoJx4ZWspvu75ddE3vIc7NmBG4blVspw65+Ak=;
        b=h+UrcqkvvN9oJJUK//cTB3MxoQBX/E+7ZKK7ZuLVAqkSaZ8unS864P1OMcS1vg2a3Q
         +4hoafy8DD/IG50/pEM2wJK6aDj54jKpzntXyDmHkwT0XCSKMnhW5wXqQHwU5iySfKyI
         GLHLk/7hxanv+rwdJB71FGUDdvqK97cyLo0aXVEddkXDmk27Ea0GYFzpktLN/T0aDRkY
         TMdWqD1JB/lj55gA5rZtU8T9+fd8UNhzgnpdWdjo8z5fUCGleC1y/5GGEhn307QxsjgH
         +lwUR/Zz4+wufbCuGvtgMx41MPXI2I0K7PC7na1MIoQA4ppYUzHnpljncGPzRU7HKyMX
         9ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LD4rQhoJx4ZWspvu75ddE3vIc7NmBG4blVspw65+Ak=;
        b=Ry1MXLJgAEdoOnpzj9hfiACjE88NWBMzCcKlhZoKNz55Ja9wVTsJ5qLwcOmClUDpNW
         ipOcohaAw9Q+GItmlwYQgm5P9OzgiUex86HQj9jksMEouaFkW9gJcOUgSV4HAJ3H8kyX
         cFNPOhBaTpLW+f8NkDPatRFu7pSEtx8J/fXtieFD9oq2mhF/RjXwPEwpisuIYwKCfs57
         5fgP3Nsx4CTIA74vt4Fj7XT7s2t/Ofre2wOQ9Nir+VLFt1gADQRbZS0puvEL6k2xYzrn
         Ic+sQ9o5hCwbMv3WlWDUYHYYbddnVfMUrRpgRXjT5VkitSlDyfef1ecGEDVi9R3p+/AP
         WIag==
X-Gm-Message-State: APjAAAWTP0Lomjb5Y02TECOH2gs/aa/8xRaRGB4xOIYICUiAJeHc4yYq
        NFtHuUa8t4iHJ7TuuFGXMtFbc8/kLtnqP+f+WcE=
X-Google-Smtp-Source: APXvYqzr4BSwRZNjxhOAWUVDRbfg2dtVgVWBqnqcRA37vtO1uegkRbcP0hHi7H8HMy5Gjx8/7y0dzxANy2cw7iFxak4=
X-Received: by 2002:a05:6512:1cf:: with SMTP id f15mr5449017lfp.12.1575064611401;
 Fri, 29 Nov 2019 13:56:51 -0800 (PST)
MIME-Version: 1.0
References: <20191128223802.18228-1-michael@walle.cc>
In-Reply-To: <20191128223802.18228-1-michael@walle.cc>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Fri, 29 Nov 2019 18:57:04 -0300
Message-ID: <CAOMZO5CP6ohaHqv5qy=RAisjiYQ6pO9xqGfKbHDzQ77gsm=CwA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: add IRQF_SHARED
To:     Michael Walle <michael@walle.cc>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Timur Tabi <timur@kernel.org>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Thu, Nov 28, 2019 at 7:38 PM Michael Walle <michael@walle.cc> wrote:
>
> The LS1028A SoC uses the same interrupt line for adjacent SAIs. Use
> IRQF_SHARED to be able to use these SAIs simultaneously.

On i.MX8M SAI5 and SAI6 share the same interrupt number too:

Reviewed-by: Fabio Estevam <festevam@gmail.com>

Thanks
