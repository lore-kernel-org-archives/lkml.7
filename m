Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB2F6C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FE920833
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 14:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbfFQOm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 10:42:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39001 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbfFQOm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 10:42:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id p24so6708329lfo.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 07:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFVbZuwFBrpLkkmQkez8Z5/71rrlk7EfJ1oTuMENBo8=;
        b=p87ix/gxbw68FDnkv4mXOL9P1ZRXT5HszJwZ7qfW9zhGShZ6b7Kqn+m3RiKN9zmp+4
         krjvFTRc0iuoRDSUnSP5WyGYL/oVXIJrUtX7kkePQFYQ+8+FJF7iY6okYPcz+tEDvBsX
         hFfQkQqZtkKAxU4AwAbSACty2KUQSSEpWx8wGWvRqxD4GnqXEzqOJLfBJrtxzDsS4IE1
         Egj57muahCLqrfoYjAB/sUMWRIKwnjNoua2IH+iWLou2CYLfGAvRqBNActTV+A5T7jDH
         lyo6KAxteIMtrYn517scjZqbn/yT+xlP39KoGixfnl2mF4ZzNVtWNYhl8PD/RDlaH/xf
         sOtw==
X-Gm-Message-State: APjAAAVh/5JSeqkt2+LrjcJoIEWnf+R4mA4svJ8vt5Kxf6RaHmVQzwOm
        hrgri5M6mibQXmG0wcXYsUDic5C643Dge/Hx0OovAQ==
X-Google-Smtp-Source: APXvYqzq7dzF6Lmgp3VgZsfzXejl5e5AeheLwaU1iJbzREHrBkGf1pB9O7WteE2KJaeCO+5foQcCrlxdEOJ+QRzc41c=
X-Received: by 2002:a19:dc0d:: with SMTP id t13mr30517940lfg.152.1560782544075;
 Mon, 17 Jun 2019 07:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190617130014.1713870-1-arnd@arndb.de>
In-Reply-To: <20190617130014.1713870-1-arnd@arndb.de>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Mon, 17 Jun 2019 16:41:47 +0200
Message-ID: <CAGnkfhwdDd=wR4A7C1n_fKXc1HZZMAOe3eUDxfq6QdBPZTpSRg@mail.gmail.com>
Subject: Re: [PATCH] proc/sysctl: make firmware loader table conditional
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Aaron Tomlin <atomlin@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2019 at 3:00 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> We get a link error in the firmware loader fallback table,
> which now refers to the global sysctl_vals variable:
>
> drivers/base/firmware_loader/fallback_table.o:(.data+0x2c): undefined reference to `sysctl_vals'
> drivers/base/firmware_loader/fallback_table.o:(.data+0x30): undefined reference to `sysctl_vals'
> drivers/base/firmware_loader/fallback_table.o:(.data+0x50): undefined reference to `sysctl_vals'
> drivers/base/firmware_loader/fallback_table.o:(.data+0x54): undefined reference to `sysctl_vals'
>
> Add an #ifdef that only builds that table when it is being
> used.
>
> Fixes: c81c506545f4 ("proc/sysctl: add shared variables for range check")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/base/firmware_loader/fallback_table.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 58d4a1263480..ba9d30b28edc 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -23,6 +23,7 @@ struct firmware_fallback_config fw_fallback_config = {
>  };
>  EXPORT_SYMBOL_GPL(fw_fallback_config);
>
> +#ifdef CONFIG_SYSCTL
>  struct ctl_table firmware_config_table[] = {
>         {
>                 .procname       = "force_sysfs_fallback",
> @@ -45,3 +46,4 @@ struct ctl_table firmware_config_table[] = {
>         { }
>  };
>  EXPORT_SYMBOL_GPL(firmware_config_table);
> +#endif
> --
> 2.20.0
>

Hi Arnd,

I think I've posted a similar patch before, I don't know if it's
already in linux-next:

https://lore.kernel.org/linux-next/20190531012649.31797-1-mcroce@redhat.com/

Regards,
-- 
Matteo Croce
per aspera ad upstream
