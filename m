Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B042BC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E59C206DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 00:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JIIfx6d5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbfCEAx5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 19:53:57 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33965 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCEAx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 19:53:57 -0500
Received: by mail-ot1-f68.google.com with SMTP id 98so5984342oty.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uXNLc6F0UiYjfZcRt3SiykY+FnlXWp8zrd0IEyVbGiI=;
        b=JIIfx6d5jU0HVabG0/g0ik1Fe7QSg+9fGC07k5C6VRy0q1yecBDje6+CPuHLvvRNfU
         XmOvRGbXGAIoEnRpU0yB9iNcJe9K0mD5Jnqi0q8QDN+p7gV5zMJsgqd34+ztj+5QRHjI
         McXf+NiYMqtTaGXGWnqB9k9sNjB0yDLZi4J70=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uXNLc6F0UiYjfZcRt3SiykY+FnlXWp8zrd0IEyVbGiI=;
        b=eGTyS1tvRfcFGPRqZ6deMDyHVBnxPNb2e9zZdDBOfFJdGzXJyf9PtuB/r6i+5rCF9t
         g7GkhJAVfVGCnSib/Z4bjd+41P8ltDQimb5HZu6DgrDSs5gpQo+EqoO8mN5g68YziAWx
         zL0SWHKeQ5Bk3yOtUOe3Mxk/DhnEsARuUFym4HwZhT3+9nH9otxhIidLqeub2FhG/H6g
         GzKq1vinDjmI7IbMuFoe+VuNP/P86N8s5nbMRnLYVkQlEhR6iN8qUW57OwEDJPGIAgeD
         mYNdckkzsp0Q4yUOgys8ZWIDuqt2DDO7/S19QXFlhGwJ3J7dzfZ2tsZ6k4ITioa6ZS4X
         yrVw==
X-Gm-Message-State: APjAAAVaAQjbTJ/ICVKOEnzyR3T3p/B1ZRYaF74xwfD5EdNk09D0wLxS
        ACFw/lQ+zAN99vrkTBxtyJjYvf65hHg=
X-Google-Smtp-Source: APXvYqz5ceFge7c3yz8m9PxP4TKNUBF7bAV6Yu0Ud3X4c72BJD1E7zvg/wC7Pd7w1UTWA35LjFa4sw==
X-Received: by 2002:a9d:1991:: with SMTP id k17mr14574180otk.20.1551747235557;
        Mon, 04 Mar 2019 16:53:55 -0800 (PST)
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com. [209.85.167.182])
        by smtp.gmail.com with ESMTPSA id q6sm3029092oia.4.2019.03.04.16.53.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 16:53:54 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id t206so5481363oib.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 16:53:53 -0800 (PST)
X-Received: by 2002:aca:d803:: with SMTP id p3mr372933oig.111.1551747233600;
 Mon, 04 Mar 2019 16:53:53 -0800 (PST)
MIME-Version: 1.0
References: <20190304200719.1382717-1-arnd@arndb.de>
In-Reply-To: <20190304200719.1382717-1-arnd@arndb.de>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 4 Mar 2019 17:53:42 -0700
X-Gmail-Original-Message-ID: <CAHX4x842P-V7VGTqRwuVfxk-zBOwMWGh5yLx6tnxEamj-Wt5SA@mail.gmail.com>
Message-ID: <CAHX4x842P-V7VGTqRwuVfxk-zBOwMWGh5yLx6tnxEamj-Wt5SA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix wilco-ec dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Duncan Laurie <dlaurie@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 4, 2019 at 1:06 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> When CROS_EC_LPC is set to =m, we get a link failure for a
> builtin wilco-ec module:
>
> drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_remove':
> core.c:(.text+0x26): undefined reference to `cros_ec_lpc_mec_destroy'
> drivers/platform/chrome/wilco_ec/core.o: In function `wilco_ec_probe':
> core.c:(.text+0x18c): undefined reference to `cros_ec_lpc_mec_init'
> core.c:(.text+0x224): undefined reference to `cros_ec_lpc_mec_destroy'
> drivers/platform/chrome/wilco_ec/mailbox.o: In function `wilco_ec_mailbox':
> mailbox.c:(.text+0x104): undefined reference to `cros_ec_lpc_io_bytes_mec'
>
> The problem with the existing CROS_EC_LPC_MEC dependency is that this
> is only for a 'bool' symbol, so the information about the exported
> functions being in a module is lost on the way, and we actually have
> to depend on both CROS_EC_LPC and CROS_EC_LPC_MEC.

Thanks for the catch Arnd. This looks like a workable solution, although it
brings up a different question to me: Is it weird for a bool option
(such as CROS_EC_LPC_MEC)
to depend upon a tristate option (such as CROS_EC_LPC)? It seems like
CROS_EC_LPC_MEC
should be tristate as well. Would changing this be a better solution?

>
> Fixes: 7b3d4f44abf0 ("platform/chrome: Add new driver for Wilco EC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/platform/chrome/wilco_ec/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index 4a119ced4d0c..e09e4cebe9b4 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,6 +1,6 @@
>  config WILCO_EC
>         tristate "ChromeOS Wilco Embedded Controller"
> -       depends on ACPI && X86 && CROS_EC_LPC_MEC
> +       depends on ACPI && X86 && CROS_EC_LPC && CROS_EC_LPC_MEC
>         help
>           If you say Y here, you get support for talking to the ChromeOS
>           Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> --
> 2.20.0
>
