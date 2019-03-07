Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A25C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E8C20840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 15:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfCGP7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 10:59:41 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36485 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbfCGP7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 10:59:38 -0500
Received: by mail-qt1-f194.google.com with SMTP id p25so17649051qtb.3;
        Thu, 07 Mar 2019 07:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RUg+lYsZP7w962oQo6Vktz83Dw9cdj8a3+anhAM+t+4=;
        b=JavWXzMi0UzMCn1wkrHU8k22jgHZUpiCgstlcPJo2qzdpdLg7y7PmMOyX1yBzOM3pT
         +ViMhaXLE8EBRho3yUlx89ZZLwLZMyXEB/D/GvjBWFeRSJO1UOrGVa3uZrB4hgUJiVvS
         2kMILw2kYZtirbzzWcyx1BFLWHHVNJRmhhsDcSHcK0cB0PAc90P3LTdkds3vrkUVZog3
         VayBdpPVceGEnw1lcpTF7dPCeNAGh0TNHoMjuU8neY2O/msNvS9E+8tcp+d5lRCPRZ1r
         +eQzB5MDGYGQnI02OeDnnNK3QuiN5Oldr1hS2yXf5dkwvF1EZ28oIehUAWZcotoPBssk
         7Xkw==
X-Gm-Message-State: APjAAAU7C6ENK1i100gaBoYqy7hkKCuhIYj0hH0qCtdzl3tv+p2uG8Ab
        Cb0q58g0UHMrqUG8ne5S04wQVsD5vYXE/CWtjkE=
X-Google-Smtp-Source: APXvYqyVI2l2JLvyyldnF+vpyuccbq95rFjxwk+AtVNgkAJZb9q+pci9U7y/8lEvPEZiqmncrLEDoFs7Zdc1+05t/Iw=
X-Received: by 2002:ac8:2bcf:: with SMTP id n15mr10364282qtn.96.1551974377813;
 Thu, 07 Mar 2019 07:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20190307093408.3425010-1-arnd@arndb.de> <20190307100605.GA20309@unicorn.suse.cz>
In-Reply-To: <20190307100605.GA20309@unicorn.suse.cz>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 7 Mar 2019 16:59:19 +0100
Message-ID: <CAK8P3a3YLD2K-bGXCiN4xQNQhGCLzVE4C9WonFGTo7LN30v4pg@mail.gmail.com>
Subject: Re: [PATCH] ethtool: reduce stack usage with clang
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Wenwen Wang <wang6495@umn.edu>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Edward Cree <ecree@solarflare.com>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 11:06 AM Michal Kubecek <mkubecek@suse.cz> wrote:
>
> On Thu, Mar 07, 2019 at 10:33:35AM +0100, Arnd Bergmann wrote:

> > @@ -2533,7 +2535,7 @@ static int ethtool_set_fecparam(struct net_device *dev, void __user *useraddr)
> >
> >  /* The main entry point in this file.  Called from net/core/dev_ioctl.c */
> >
> > -int dev_ethtool(struct net *net, struct ifreq *ifr)
> > +int noinline_for_stack dev_ethtool(struct net *net, struct ifreq *ifr)
> >  {
> >       struct net_device *dev = __dev_get_by_name(net, ifr->ifr_name);
> >       void __user *useraddr = ifr->ifr_data;
>
> Is this part really needed? AFAICS dev_ethtool() is only called from
> dev_ioctl() which is in a different compilation unit so that
> dev_ethtool() won't be inlined anyway.

No, you are right. I had accidentally left this in place from an earlier
version. Sending a v2 now.

      Arnd
