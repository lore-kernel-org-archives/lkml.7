Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52692C04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206AA206BF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 21:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m0ZBtK+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfEFVk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 17:40:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38843 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfEFVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 17:40:56 -0400
Received: by mail-lj1-f196.google.com with SMTP id u21so3297076lja.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xUYUM3YLijTLeXzveWxy2iQb0w6OPHiVIv+ceBz6sbU=;
        b=m0ZBtK+RKIGoQCPFhcGmfz/fR3JKMpEkCQ2BKr5QPJZXeqhFiy2oIj3ZogI+wRIxj0
         jifNGNwp6ddF/XhxQP3WkBjB3ovSwqjpy/mWyntoNVojLGJau7uISsv+WyTvOF3J4IRk
         4Ycf7GbpX+jn2dskciVGM8+W8mrEHA2nlVBtE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xUYUM3YLijTLeXzveWxy2iQb0w6OPHiVIv+ceBz6sbU=;
        b=EmxsoCy+SUnxBTXN5IPmded2J+OJUBJuk7CEW6SLc9vjdGy+WmtJd8Au0J5qcvbmLZ
         UEGBrAR2C/Qx8kaL2F4xGIC5TtygaQPENQPqehmQFiKdeE2cRTlOGQSnIsaZLeyMkXiC
         HteDNUrS+C+j8G09i2cgph2AfOUxS6AwyCEfQESq/d9oEJzyTP55+TTKoCFF58nkSqut
         8Zz566+G/IvLQs6aD0eH67fldpG6TtdSTdyP35KR6o86VaBHY8/HAJMZB3AJzgUp37Vw
         eBlO2RaGmOSOKhV1qRPoB4n9+ihmk7psP1kH1218/oi0qi/MWVaARDjmMkrG69LGOPgE
         r87Q==
X-Gm-Message-State: APjAAAU/9HmdCIYI3earBb/R1EsCw1ZnEttWwj2YG+IAc5Eyy6oF25O7
        smxo2OV0eEoauihxIoz15i9942KCwXA=
X-Google-Smtp-Source: APXvYqxaNzH3u8iEg31KGdX++txgdZVJIXj9xW1eItA2iUvYSlEdl01cqBsZLBH0Z/EIMZufKHy7Cw==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr14469750ljj.137.1557178854022;
        Mon, 06 May 2019 14:40:54 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id l5sm2743059lfh.70.2019.05.06.14.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 14:40:53 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id q10so12426919ljc.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 14:40:53 -0700 (PDT)
X-Received: by 2002:a2e:4a1a:: with SMTP id x26mr13281214lja.49.1557178852739;
 Mon, 06 May 2019 14:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190503174730.245762-1-dianders@chromium.org>
In-Reply-To: <20190503174730.245762-1-dianders@chromium.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Mon, 6 May 2019 14:40:40 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOkHxYumCBv-T0gxTjdMVTu-c=33Lk-0TUgJ3WGUn2DVQ@mail.gmail.com>
Message-ID: <CA+ASDXOkHxYumCBv-T0gxTjdMVTu-c=33Lk-0TUgJ3WGUn2DVQ@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Improve backward compatibility with older Chromebooks
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Julius Werner <jwerner@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 3, 2019 at 10:48 AM Douglas Anderson <dianders@chromium.org> wrote:
> When you try to run an upstream kernel on an old ARM-based Chromebook
> you'll find that console-ramoops doesn't work.

Ooh, nice! I still get annoyed by old depthcharge firmware. It's
almost as if we should have gotten an upstream binding approved before
baking it into firmware...

> --- a/fs/pstore/ram.c
> +++ b/fs/pstore/ram.c

> @@ -703,6 +704,23 @@ static int ramoops_parse_dt(struct platform_device *pdev,
>
>  #undef parse_size
>
> +       /*
> +        * Some old Chromebooks relied on the kernel setting the console_size
> +        * and pmsg_size to the record size since that's what the downstream
> +        * kernel did.  These same Chromebooks had "ramoops" straight under
> +        * the root node which isn't according to the upstream bindings.

The last part of the sentence technically isn't true -- the original
bindings (notably, with no DT maintainer Reviewed-by) didn't specify
where such a node should be found:

35da60941e44 pstore/ram: add Device Tree bindings

so child-of-root used to be a valid location. But anyway, this code is
just part of a heuristic for "old DT" (where later bindings clarified
this), so it still seems valid.

>  Let's
> +        * make those old Chromebooks work by detecting this and mimicing the

s/mimicing/mimicking/

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

Otherwise, looks good to me:

Reviewed-by: Brian Norris <briannorris@chromium.org>
