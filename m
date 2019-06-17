Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C11F5C31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0C12086A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 15:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbfFQPAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 11:00:30 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43943 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbfFQPA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 11:00:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id w17so4644682qto.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2019 08:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NroUuAsloJGj3mM4R4Ih5K/r9SWKQSWxR5seYQXwI6g=;
        b=s0zmqW+esb8SP8XlLyhIom8er+qe66Zk/SwolPZyXbqWVZL/DofYlMRCHKn5Kbykfl
         hvXPJOIG72xEV7FdMsahongOrw0XvKQ3gj4n8+pI5QE3DXUgpkenBcBf0yf3YiZHE+bE
         RtElTcWtP7V9MdBmKjUO1G5fgYe86vxEnvaGe+rM4UMG7mgH/IKbkaPtKSuHR/0at+Vg
         3Gn2XOftE7xvOLE12vR8AeVNkHy0FHFggZ4ulVIouJMclPEVWyYcN/03ipsMiMcRoLiK
         3s01pQUZKFVSnc35ujZuS207Dm7tppugzihRvEcbFT7/aZ5RY6EDaRi94xhUCpyjBPiN
         dcCQ==
X-Gm-Message-State: APjAAAV4iCbha0EFMLLgaFDPz9Ll6J7O/XGOoCVmgSRAEyZZxNCYG5n+
        SJmylwocGPiby5NMMm82vGC93v6+jzkNGOwL6L8=
X-Google-Smtp-Source: APXvYqwrdtFcNJA9pBSO2r3YxSHCWm76xMLc9NrY0U8A5MpRCFUBqst9n0UdukCvKFaLTyk3x8tC1phbicRWwjn+KNM=
X-Received: by 2002:ac8:3485:: with SMTP id w5mr17421936qtb.142.1560783628828;
 Mon, 17 Jun 2019 08:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190617130014.1713870-1-arnd@arndb.de> <CAGnkfhwdDd=wR4A7C1n_fKXc1HZZMAOe3eUDxfq6QdBPZTpSRg@mail.gmail.com>
In-Reply-To: <CAGnkfhwdDd=wR4A7C1n_fKXc1HZZMAOe3eUDxfq6QdBPZTpSRg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Jun 2019 17:00:11 +0200
Message-ID: <CAK8P3a3SOgF90wf_huoYV9_OR+xU=007bdVPGoo7pE6FJBvwgw@mail.gmail.com>
Subject: Re: [PATCH] proc/sysctl: make firmware loader table conditional
To:     Matteo Croce <mcroce@redhat.com>
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

On Mon, Jun 17, 2019 at 4:42 PM Matteo Croce <mcroce@redhat.com> wrote:
> >  drivers/base/firmware_loader/fallback_table.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> > index 58d4a1263480..ba9d30b28edc 100644
> > --- a/drivers/base/firmware_loader/fallback_table.c
> > +++ b/drivers/base/firmware_loader/fallback_table.c
> > @@ -23,6 +23,7 @@ struct firmware_fallback_config fw_fallback_config = {
> >  };
> >  EXPORT_SYMBOL_GPL(fw_fallback_config);
> >
> > +#ifdef CONFIG_SYSCTL
> >  struct ctl_table firmware_config_table[] = {
> >         {
> >                 .procname       = "force_sysfs_fallback",
> > @@ -45,3 +46,4 @@ struct ctl_table firmware_config_table[] = {
> >         { }
> >  };
> >  EXPORT_SYMBOL_GPL(firmware_config_table);
> > +#endif
> > --
> > 2.20.0
> >
>
> Hi Arnd,
>
> I think I've posted a similar patch before, I don't know if it's
> already in linux-next:
>
> https://lore.kernel.org/linux-next/20190531012649.31797-1-mcroce@redhat.com/
>

Indeed, that is almost the same patch. Not sure what happened.

As Stephen replied to your patch, he had picked it up originally.
Maybe it got lost in a rebase since then.

        Arnd
