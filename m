Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B66C10F14
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3283020835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 03:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KxEJeVgs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbfDQDVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 23:21:33 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:39288 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbfDQDVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 23:21:32 -0400
Received: by mail-vs1-f66.google.com with SMTP id g127so12786763vsd.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yKezm9r0olp54QGM5Hm5rJdwgLUK004Edlxk2j2pDwY=;
        b=KxEJeVgs0D8A1NkmLJaSkhnxrveRReA2blDNjCSR50u6qGIzZg4JJWN7GW9MdWT4kZ
         mSSE+bNIIGw2CAKRlHqruQZ9Vwr4lZWE6Yj9SDOZCL/3YAPsDrXA0fI+uQEVvGa230X7
         THhJwq+/j62qKOycT+Y6+zwYAU3R/zWgkkQDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yKezm9r0olp54QGM5Hm5rJdwgLUK004Edlxk2j2pDwY=;
        b=D2jNPD3UwIpd51ZQvGDJZ8plr4g7NL7dHOvh81LIf9iSYTe+xVXA+bYNOmZ4AEofuR
         nJs7LDphHtOZPBtbt95WJ9wFoRMuJz7n67plEURW/UMDAQKIsMTmBFBEPfnIpcA9Kvy7
         yLRC3wghTN/KFh+/g1wxOyiV6zT8rzX7oUu8Y8i+szAqRqSDYnc5ToFTeZ5jcL8ntqb1
         Kt2/gNESDsFfMWk29MUpUW/c2ge+qbHJq/H2bhDKbB+TDurM2K9Jay/9ucofCyhillTb
         eAAaip4QTmjEzk3s9kMiGrURMO5DerkqJOttMdUYRCm/UIaI09Dnwqu/uWiuxYIRuoXu
         tzGQ==
X-Gm-Message-State: APjAAAX6s3HSk9cay+z5m1ZhNEkdPset+cFaMPPG/Yhr3GqBWqQxxiol
        wT1xtL4X8pFKUt2d3f4XjyMYfsjfjc0=
X-Google-Smtp-Source: APXvYqyvP/RWa6NmY6Bud0Ou+0oIEcM885GtR4laA8a5adJyQ1IbebP1LBQWs5KPTEY65oVTeO50RA==
X-Received: by 2002:a67:fa04:: with SMTP id i4mr47105331vsq.18.1555471290013;
        Tue, 16 Apr 2019 20:21:30 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id o1sm13824731vsd.21.2019.04.16.20.21.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Apr 2019 20:21:29 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id d15so4899374vka.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2019 20:21:28 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr46643241vkp.24.1555471288313;
 Tue, 16 Apr 2019 20:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190408220925.13077-1-mcroce@redhat.com> <20190408220925.13077-3-mcroce@redhat.com>
In-Reply-To: <20190408220925.13077-3-mcroce@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 16 Apr 2019 22:21:16 -0500
X-Gmail-Original-Message-ID: <CAGXu5jKfWV=FXCoKORTdLooMxLCkzscPcq75HkM4EBGyvcVHkQ@mail.gmail.com>
Message-ID: <CAGXu5jKfWV=FXCoKORTdLooMxLCkzscPcq75HkM4EBGyvcVHkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kernel: use sysctl shared variables for range check
To:     Matteo Croce <mcroce@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 8, 2019 at 5:09 PM Matteo Croce <mcroce@redhat.com> wrote:
>
> Use the shared variables for range check, instead of declaring a local one
> in every source file.
>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---
>  kernel/pid_namespace.c |   3 +-
>  kernel/sysctl.c        | 193 ++++++++++++++++++++---------------------
>  kernel/ucount.c        |   6 +-
>  3 files changed, 98 insertions(+), 104 deletions(-)
>
> diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
> index aa6e72fb7c08..ddbb51bc4968 100644
> --- a/kernel/pid_namespace.c
> +++ b/kernel/pid_namespace.c
> @@ -290,14 +290,13 @@ static int pid_ns_ctl_handler(struct ctl_table *table, int write,
>  }
>
>  extern int pid_max;
> -static int zero = 0;
>  static struct ctl_table pid_ns_ctl_table[] = {
>         {
>                 .procname = "ns_last_pid",
>                 .maxlen = sizeof(int),
>                 .mode = 0666, /* permissions are checked in the handler */
>                 .proc_handler = pid_ns_ctl_handler,
> -               .extra1 = &zero,
> +               .extra1 = (void *)&sysctl_zero,

BTW, I don't think these (void *) casts are actually needed. I thought
extra1/2 were already void * so assignments don't need the casting.

-- 
Kees Cook
