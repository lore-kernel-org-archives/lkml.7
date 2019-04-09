Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F36C10F13
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9246020883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 00:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rbux+UAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbfDIAN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 20:13:57 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44169 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDIAN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 20:13:57 -0400
Received: by mail-vs1-f68.google.com with SMTP id j184so8722754vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 17:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrLsBPd2Y7M4EbT1Vid4g2EYEGyG8/cCk7DGM9WAOz0=;
        b=Rbux+UAk6O3pt2Yp8YSyJ1oaea8YM9cOSH82Ji7bQuC7b3IHSqi6b1tGfWDgQREERc
         hzjgAt4ksZX6+c6QELmbfYOO1TCS/xz+hARTqm26jlHlMsYDmZwK/kv8o3ngrGmTw868
         /rSPZyoXKwjj6Gz2CUZmkGQi25YM6o8qbpeu+FDfgwdyG/5X4hxjZNjlTSRAYNT2U/uF
         Hbi2SD8tkjK+d3Pzvlq64f/dP8eIMfMGAurd69JFYccFP4NvNuNo1RrVjFUusrE/LuYZ
         tRvdZZDmiQDlT1R0+uAW5JtVqKYbiwde7+hsOV1bLbd6AMQoZ95D85SkyoGD+CsdEH7e
         34vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrLsBPd2Y7M4EbT1Vid4g2EYEGyG8/cCk7DGM9WAOz0=;
        b=Nv9tdFS/lMUWm7icu5jbGcT4cIx+qoVo+YuqG7uYgplwQ4rS11X/IIecBG9oq7XyKW
         or7LhI/KPjcLjbaId2lmtg3WeV6kTl7utzv5/5qtLkIgsf6JJd4Uhs3cn7NRny+H6sdk
         fbaCJP97WCF4aWrLFYf52YJ7oO0+8oBa3MPfw4f1EB4u7Hm96JfDS8ymycpow1Wh8fVp
         pzYU9HzToFT377b+mkX2QWcucpd71cRhyNKpfiJ6Q9nyUUyymqRAAE5nwHqBrt0g66/Q
         wRYnLwZ1kGb2M/t2PMKlCYVL8ZBiBBt991EanXuz7nYq/wmlDM1IKcY/3LuFBorQz7Bl
         WV4A==
X-Gm-Message-State: APjAAAVmhU+SZKZTpiXetp4zUEKM/AePoocXAu30YFo/n8ve0nufsmHq
        kcgK/9e5vPd4n0uLDteUtZwB84OYOvitKs+/1GNNFw==
X-Google-Smtp-Source: APXvYqzYkPYSfbQXyohvKKNf9PIpYA1s0rN4YU9jEkTRwRqj3OulQ33tUrNG6c5rfadKninlhnn+ZR2gHRCO6UieIU0=
X-Received: by 2002:a67:f04e:: with SMTP id q14mr18800008vsm.133.1554768836217;
 Mon, 08 Apr 2019 17:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190114203507.GA17953@embeddedor>
In-Reply-To: <20190114203507.GA17953@embeddedor>
From:   Kees Cook <keescook@google.com>
Date:   Mon, 8 Apr 2019 17:13:43 -0700
Message-ID: <CAGXu5jK_D8hEMW4nJfwxf8rw6ADFB5H=POh8wsk6001SYrs2Jw@mail.gmail.com>
Subject: Re: [PATCH] adfs: mark expected switch fall-throughs
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 12:35 PM Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
>
> Warning level 3 was used: -Wimplicit-fallthrough=3
>
> This patch is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Please consider this reviewed! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
