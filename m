Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E94C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F12AA21726
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 18:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FlaN5J1m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbfEHSKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 14:10:19 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:39888 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbfEHSKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 14:10:19 -0400
Received: by mail-vk1-f195.google.com with SMTP id s80so5192609vke.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F3GSYUt5BCOwJ4C2jh44sg2SA8WHx9EsOyf2WJj0PXY=;
        b=FlaN5J1m3i0G1C1e5AUzwxem3wCG+Fc8/Vc4jRlvw1b71OZCzWEpfzh5bf1gqiZamd
         6LQJSrPG5AHJ0i7TZBu/tSAtYEnGstBAztw9NM7KO/wqZJsTuO5INLfbcCxRRRsEozcj
         DPfJJKf5Ar2zSnRmEED2scZ0nNEDB4TAKKWrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F3GSYUt5BCOwJ4C2jh44sg2SA8WHx9EsOyf2WJj0PXY=;
        b=t10I/BsBj09m3AocHshCgKmnKLCTaNAQk0MyQw9suM+YZsoEekjdn8ujwI4V6m0/NZ
         31vcFrO2YS/bLWpwbmnhm4aXxHowulYQhtXJny184+Bijz7b10mTA0v5sAwZJf5DnWg9
         QdoJQ9/UCbYv4ZhIARiyfmAoTKaENsQxNtilnPTk99CqfMLvLHh6xGyBZ7J1wDe26qlO
         2AF/w//wWSOYwwgVM9vrZxEjvTM2CizdJScyQ9aTRDAUhcm6Fdf+cVVk8HNy54WZ2MX/
         swWKVb4LVXRsSPphRAGXfi25Hqj8A+tZ6IgBeJZeYREBkS4L8AEh8XUlQknA9ltM8d3k
         Zk8Q==
X-Gm-Message-State: APjAAAXLZyFXhuPJubkBc3z9LHPXW/VeRwXXwem0mWZZ6TnL1KuqkYOp
        hiQmabJYO/h1uwU1zyIRGkPeHBzekI0=
X-Google-Smtp-Source: APXvYqzzZ9IjpbWeEJBHV5o38T0hqjRDAdIU6ALQeks2DBPCCgL/7VNbmqg/6djsO6qR+fMEGT/Emw==
X-Received: by 2002:a1f:9ed5:: with SMTP id h204mr5867584vke.13.1557339017464;
        Wed, 08 May 2019 11:10:17 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id j71sm11368423vsd.0.2019.05.08.11.10.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 11:10:16 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id d128so1788300vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2019 11:10:15 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr15669234vsp.188.1557339015476;
 Wed, 08 May 2019 11:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190508154832.241525-1-dianders@chromium.org>
In-Reply-To: <20190508154832.241525-1-dianders@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 8 May 2019 11:10:03 -0700
X-Gmail-Original-Message-ID: <CAGXu5jLhmvRbZOhNPkGr9=oSn-aA1CempctTyM3hfW3uOf8DpQ@mail.gmail.com>
Message-ID: <CAGXu5jLhmvRbZOhNPkGr9=oSn-aA1CempctTyM3hfW3uOf8DpQ@mail.gmail.com>
Subject: Re: [PATCH v2] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 8, 2019 at 8:49 AM Douglas Anderson <dianders@chromium.org> wrote:
> When you try to run an upstream kernel on an old ARM-based Chromebook
> you'll find that console-ramoops doesn't work.
>
> Old ARM-based Chromebooks, before <https://crrev.com/c/439792>
> ("ramoops: support upstream {console,pmsg,ftrace}-size properties")
> used to create a "ramoops" node at the top level that looked like:
>
> / {
>   ramoops {
>     compatible = "ramoops";
>     reg = <...>;
>     record-size = <...>;
>     dump-oops;
>   };
> };
>
> ...and these Chromebooks assumed that the downstream kernel would make
> console_size / pmsg_size match the record size.  The above ramoops
> node was added by the firmware so it's not easy to make any changes.
>
> Let's match the expected behavior, but only for those using the old
> backward-compatible way of working where ramoops is right under the
> root node.
>
> NOTE: if there are some out-of-tree devices that had ramoops at the
> top level, left everything but the record size as 0, and somehow
> doesn't want this behavior, we can try to add more conditions here.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thanks! I've applied this to my testing tree and I'll push to Linus in
a couple days.

-Kees

> ---
>
> Changes in v2:
> - s/mimicing/mimicking/ (Brian Norris)
> - Slight rewording of the comment (Brian Norris)
> - Check name rather than relying on of_node_is_root() (Frank Rowand)
>
>  fs/pstore/ram.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index c5c685589e36..5195a3a3daec 100644
> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c
> @@ -669,6 +669,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>                             struct ramoops_platform_data *pdata)
>  {
>         struct device_node *of_node = pdev->dev.of_node;
> +       struct device_node *parent_node;
>         struct resource *res;
>         u32 value;
>         int ret;
> @@ -703,6 +704,26 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>
>  #undef parse_size
>
> +       /*
> +        * Some old Chromebooks relied on the kernel setting the
> +        * console_size and pmsg_size to the record size since that's
> +        * what the downstream kernel did.  These same Chromebooks had
> +        * "ramoops" straight under the root node which isn't
> +        * according to the current upstream bindings (though it was
> +        * arguably acceptable under a prior version of the bindings).
> +        * Let's make those old Chromebooks work by detecting that
> +        * we're not a child of "reserved-memory" and mimicking the
> +        * expected behavior.
> +        */
> +       parent_node = of_get_parent(of_node);
> +       if (!of_node_name_eq(parent_node, "reserved-memory") &&
> +           !pdata->console_size && !pdata->ftrace_size &&
> +           !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
> +               pdata->console_size = pdata->record_size;
> +               pdata->pmsg_size = pdata->record_size;
> +       }
> +       of_node_put(parent_node);
> +
>         return 0;
>  }
>
> --
> 2.21.0.1020.gf2820cf01a-goog
>
