Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C212CC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91AB02075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 19:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uRrXk30j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbfECTGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 15:06:18 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45450 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfECTGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 15:06:17 -0400
Received: by mail-yw1-f65.google.com with SMTP id w18so5098975ywa.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 12:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RymFTzKSXlOnRrrgpzwhtG4p72cSVzEal0sZliJ6Yk4=;
        b=uRrXk30jt+H13y1AirjItdE9wVXL7iPzrxMsXZEtFCeWCW2CJhynIh9uLhjsYZuVSn
         HrdofWZDGaBVX08INVRieJyH5c0ZELiN9hSOHGii/3tyfEpICfSc8n3B0F4yDjArFL/a
         uR0Aawh19eusZT+C/011cNBNlPzNyZMcmpqg592TMiLWfZ4o7zYU1uC95JMJxSkGUkvj
         OBDhhB2S36V8KAxk1fyGQF/f+OsMMhciz3vxbJkkj4dGXVfBHvZj9uO+8sEjlFP4hSQZ
         JuUIm73Eat/9K+RaHX4dSdZRXSGt2RM5I38VJX+6JPJtLD1kD4OomSowBK1w6wfz7NWb
         j0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RymFTzKSXlOnRrrgpzwhtG4p72cSVzEal0sZliJ6Yk4=;
        b=ogWXMWwsfDQuZLFOVBkJT7kZdnKoNko5BHLg3KOQijT7oDFb4BUKNFOQ+1p9u5RNKm
         Bpnn5JUH2ExIgHpwm70FOvvEa01T0G7jd1Qd9LLjrA0oO6RCBiWRXBr+IYQbFjZNbyn7
         My2odQXxRPp+HQ0q57WXdbsUZOqlNg9G+G6E7kFPDmRD4P5+EzHQOTGjaeAnbG2sJcXa
         4U8Q6PdJFx6ZtAcAxa5wFdpeA1mKJiWz7266iRNjEmQKRxmiQnJRPUXD/v/udVTNX4P8
         DPJdi2oNV/V/P5riUURaZZIUy+Fg5GDiMtXKw+T0Q7jjD67O7l6Dqh5f27xhXVAZf3z5
         2DVA==
X-Gm-Message-State: APjAAAUOglQ4pYrDVFZwpQ1lzdGJGMr2v3HCuiFBYasNM7w/jgu/GT+K
        gtwSGfC/6aJG5NPUv6FRnQ8j79PQ25wemoUFYDz+BA==
X-Google-Smtp-Source: APXvYqzOuoTYhNiGdqWk2EZG7KZrqXO9w1/jyrlMyPjPpW8lxtRSmvbAVwyfRsZAZGvKpoAtwe8VCsUxSqWWcZrfIxA=
X-Received: by 2002:a25:25c9:: with SMTP id l192mr9104848ybl.63.1556910376548;
 Fri, 03 May 2019 12:06:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
In-Reply-To: <20190503174730.245762-1-dianders@chromium.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 3 May 2019 12:06:05 -0700
Message-ID: <CABXOdTdPXPc8Uq=08xYv2YTF-fn_ZX4kjCwRjMA7qL+Epu7WcA@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 10:48 AM Douglas Anderson <dianders@chromium.org> wrote:
>
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

Reviewed-by: Guenter Roeck <groeck@chromium.org>

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
