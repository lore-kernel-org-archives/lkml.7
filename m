Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A848EC10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FFFD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 20:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eit6iETq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDWUDA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 16:03:00 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:41045 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWUC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 16:02:59 -0400
Received: by mail-vs1-f66.google.com with SMTP id g187so9029488vsc.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn029gGTaHxQzQAl65/qsgZCJOSa6TMpn22GgTs5x8s=;
        b=eit6iETq17e5JT8cVVbeZbCfkcseEi3TJs/Cvtb5S926TK7fRU312XcucWKUwcEbQW
         dt07lhOL+hWzGOkgFmz5Xj9PuqPP5q2/6bpUFtlLyZ0Zt3waxOYHhpqOYVUaKkInW9s1
         V1g6hZ9c/SbDkNvVuNGyJlTKiz7HNK8ioyQNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn029gGTaHxQzQAl65/qsgZCJOSa6TMpn22GgTs5x8s=;
        b=YstReXp9Uqh4h+xdLg7lCrjnIoden7Uul/TlzzAy16DHF0WcpemAgKngPwMVhJ6swF
         4EfmXCzTMw13kllDU+XwjYq9qHoO//lFhn1IFKUR8de6qXDqNYBgpAQLfS0yic7lOgYD
         rdjScVoZOVbRvRE6RUCDCs3GF8SyiDuyBxoWrjDCtIrN53AgYmwNYiaLY+dBbSnSvsaO
         wSTfw9sHgDEtq7JjP54Hyz1lwn8k1ymQPnaPHqTtuoHTg/tPAtfbzkHyqZCWp+BXFGWT
         MTGd9FWompBw+lowu5PPSlfxr08dN5CdkknYEqnSHvXHJjeZPeq/hEzK7ytbFUN9nx9w
         6MFw==
X-Gm-Message-State: APjAAAWCTFEfUJff0zGi46kdsdazeWkD2piAxOvkskltEr3vU1GUe7D2
        t8OSvtk9AzcKXgKJczq7yH8LqBkv06M=
X-Google-Smtp-Source: APXvYqyg1ktmgqu0pZREamoeU84Oa1pn/ZXY9pSrNCpyg2fMKqXD6jHuCh70MiCat4Lsw35dr69dpA==
X-Received: by 2002:a67:f753:: with SMTP id w19mr15039609vso.27.1556049777971;
        Tue, 23 Apr 2019 13:02:57 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id z192sm7758788vkd.45.2019.04.23.13.02.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:02:56 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id x84so3500275vkd.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2019 13:02:56 -0700 (PDT)
X-Received: by 2002:a1f:2e07:: with SMTP id u7mr14896270vku.44.1556049775730;
 Tue, 23 Apr 2019 13:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190325125528.GM12016@zn.tnic> <20190325202924.4624-1-kjlu@umn.edu>
In-Reply-To: <20190325202924.4624-1-kjlu@umn.edu>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 23 Apr 2019 13:02:43 -0700
X-Gmail-Original-Message-ID: <CAGXu5jJ_MdFE_aTc9rFY9SwympdXdJA9WhdaaPJo4UvP9OaqDg@mail.gmail.com>
Message-ID: <CAGXu5jJ_MdFE_aTc9rFY9SwympdXdJA9WhdaaPJo4UvP9OaqDg@mail.gmail.com>
Subject: Re: [PATCH v2] platform: uv: fix missing checks for kcalloc
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Banman <abanman@hpe.com>,
        Varsha Rao <rvarsha016@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nicolai Stange <nstange@suse.de>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 1:29 PM Kangjie Lu <kjlu@umn.edu> wrote:
>
> In case kcalloc fails, the patch return an error to avoid
> potential NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

>
> ---
> v2: reuse existing error path as suggested by
> Borislav Petkov <bp@alien8.de>
> ---
>  arch/x86/platform/uv/tlb_uv.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/platform/uv/tlb_uv.c b/arch/x86/platform/uv/tlb_uv.c
> index 2c53b0f19329..7b41b51b9a86 100644
> --- a/arch/x86/platform/uv/tlb_uv.c
> +++ b/arch/x86/platform/uv/tlb_uv.c
> @@ -2133,14 +2133,18 @@ static int __init summarize_uvhub_sockets(int nuvhubs,
>   */
>  static int __init init_per_cpu(int nuvhubs, int base_part_pnode)
>  {
> -       unsigned char *uvhub_mask;
>         struct uvhub_desc *uvhub_descs;
> +       unsigned char *uvhub_mask = NULL;
>
>         if (is_uv3_hub() || is_uv2_hub() || is_uv1_hub())
>                 timeout_us = calculate_destination_timeout();
>
>         uvhub_descs = kcalloc(nuvhubs, sizeof(struct uvhub_desc), GFP_KERNEL);
> +       if (!uvhub_descs)
> +               goto fail;
>         uvhub_mask = kzalloc((nuvhubs+7)/8, GFP_KERNEL);
> +       if (!uvhub_mask)
> +               goto fail;
>
>         if (get_cpu_topology(base_part_pnode, uvhub_descs, uvhub_mask))
>                 goto fail;
> --
> 2.17.1
>


-- 
Kees Cook
