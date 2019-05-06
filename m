Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A06CC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2FDF2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:10:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="efbGg26t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfEFVKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:10:11 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41322 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfEFVKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:10:11 -0400
Received: by mail-ua1-f67.google.com with SMTP id s30so5208565uas.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8bHpgQyzNXmSigtHpLPdMgiBL3zjoqHtCMHUPQ65vlc=;
        b=efbGg26t1plscKmTr5AG/RpzJ3Ly5HJYzat+OL5lpECeRe1if/gjdAvwM+3ktU48Ud
         FmojR3dM0QW0g9CApczD3ijClH8YvAj9cTzAqrmcZ0tq90TckGXajrvoaa1RrzTz9rR/
         tjoKcGH8AkqVNdaJKEU9GZYqZp4DICTTtYSnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8bHpgQyzNXmSigtHpLPdMgiBL3zjoqHtCMHUPQ65vlc=;
        b=GERRpCzQY0qIkEz0IdIFTehXEpXz+stmu3xOJPvmz0V7uYwxvNLA5XZEab9Efhjtjl
         VHGUqRqn5J+HiZFD9/xbh/XiWHp8eSXxi35eII91DTMu7Qyh/u32cf2HVG5PDWBZqivg
         vG7lB5Bqc79tvN5xnCGHuzK4KI+EzPWqxn1adhWJcu0wWcUeIP8y+TzcHMbAmYXwcWPJ
         EvHhAGuMyGado6z2+CAVBTjzzQOSyx/rpYtesFf84JD8kEDUhaQhPh+NX1czRvPHP4JT
         LhobkSTCK1fBcSXkTUV5VFSHaXrckDt8agxD3qzYusbOmhD/gWK4XhU0gVC7f8rxzdqe
         JJOQ==
X-Gm-Message-State: APjAAAWLcGc1eZlZMU8CRtVirJs9ccxSAKduDXruUuEA+hGl1dp/Zljc
        81DChEJaRy2JQONN0sBXsPEkIt1AHWM=
X-Google-Smtp-Source: APXvYqyVRGNqCSUFAnJJ9rm44NNz0M8XJjdxWzYMChqgeScVvaGCq2eeg9n/E8IAGn1OQVSdGGgDDg==
X-Received: by 2002:ab0:70d4:: with SMTP id r20mr12008901ual.67.1557177009060;
        Mon, 06 May 2019 14:10:09 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id 15sm1923057vkg.16.2019.05.06.14.10.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:10:08 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id e2so9030041vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:10:07 -0700 (PDT)
X-Received: by 2002:a67:f849:: with SMTP id b9mr9084650vsp.188.1557177007238;
 Mon, 06 May 2019 14:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
In-Reply-To: <20190503174730.245762-1-dianders@chromium.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 6 May 2019 14:09:55 -0700
X-Gmail-Original-Message-ID: <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
Message-ID: <CAGXu5jL9cJ+8scZ+Cg9yqdc9+rb563xs-qVjXXuPRJYjNa4Y8w@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh@kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        linux-rockchip@lists.infradead.org, jwerner@chromium.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>
Date: Fri, May 3, 2019 at 10:48 AM
To: Kees Cook, Anton Vorontsov
Cc: <linux-rockchip@lists.infradead.org>, <jwerner@chromium.org>,
<groeck@chromium.org>, <mka@chromium.org>, <briannorris@chromium.org>,
Douglas Anderson, Colin Cross, Tony Luck,
<linux-kernel@vger.kernel.org>

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

I like this; thanks! Rob is this okay by you? I just want to
double-check since it's part of the DT parsing logic.

I'll pick it up and add a Cc: stable.

-Kees

> ---
>
>  fs/pstore/ram.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> index c5c685589e36..8df3bfa2837f 100644
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
> @@ -703,6 +704,23 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>
>  #undef parse_size
>
> +       /*
> +        * Some old Chromebooks relied on the kernel setting the console_size
> +        * and pmsg_size to the record size since that's what the downstream
> +        * kernel did.  These same Chromebooks had "ramoops" straight under
> +        * the root node which isn't according to the upstream bindings.  Let's
> +        * make those old Chromebooks work by detecting this and mimicing the
> +        * expected behavior.
> +        */
> +       parent_node = of_get_parent(of_node);
> +       if (of_node_is_root(parent_node) &&
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


-- 
Kees Cook
