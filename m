Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C33C31E44
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B1821721
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 00:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392176AbfFLAIw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 20:08:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36284 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbfFLAIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 20:08:51 -0400
Received: by mail-lf1-f67.google.com with SMTP id q26so10650194lfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2019 17:08:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h7bjlWA9RPjCrQknFfrxGmOZfe86lgEMXjZF4z0CIJc=;
        b=bIAM7qzLpTT2bPljytoFHucatac+DVOPU6tAIqiOnOFz42+JyY7xkr9jMVmiOH5sOO
         /GeIz8yRphzaXtytTvqf7/lvgqbcGa4WyWPn9lT40kuViIPMMxtT3r5DvPhkw2cuQHPW
         YYKKa7GKBys+Sk+I4pKA7EEtmGCW/LXI3hrn/OaH/hxX4ktiWDg3jM+e0IwEAAlkDRIR
         9+FYNMa2N9BC/kr5LEoGvKPNPx5ykaPbgEWJLOL98vfODZujbsB8BPYpjQOrhCLXDV8q
         Af9xggicVLYj3JoAmTRCyjwV1RKi9Njm166S0VJdPsOSAx8iXskFq/nzpi89DrSGoc6B
         c3RA==
X-Gm-Message-State: APjAAAWDJ37C67SbXJgZFBcjg85BeSGE0q+lfuaAUUlgOzd7Ezjugd05
        oNkSMokEnNYCbXh9aJ/YM3Z6cLRZYzuRsaJmiQGE6g==
X-Google-Smtp-Source: APXvYqxFzgjcCWfgMQCGnFILHZZZFt+K2PbIk6ee1UmnlWOWCRs6XovMn177R/Z1IbC6Jj1CsbPXegUVXlXEWHtGkDc=
X-Received: by 2002:a19:ed07:: with SMTP id y7mr41426226lfy.56.1560298129355;
 Tue, 11 Jun 2019 17:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190608125019.417-1-mcroce@redhat.com> <20190609.195742.739339469351067643.davem@davemloft.net>
 <d19abcd4-799c-ac2f-ffcb-fa749d17950c@infradead.org>
In-Reply-To: <d19abcd4-799c-ac2f-ffcb-fa749d17950c@infradead.org>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Wed, 12 Jun 2019 02:08:13 +0200
Message-ID: <CAGnkfhyS15NPEO2ygkjazECULtUDkJgPk8wCYFhA9zL2+w27pg@mail.gmail.com>
Subject: Re: [PATCH net] mpls: fix af_mpls dependencies
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Ahern <dsahern@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 1:07 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 6/9/19 7:57 PM, David Miller wrote:
> > From: Matteo Croce <mcroce@redhat.com>
> > Date: Sat,  8 Jun 2019 14:50:19 +0200
> >
> >> MPLS routing code relies on sysctl to work, so let it select PROC_SYSCTL.
> >>
> >> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> >> Suggested-by: David Ahern <dsahern@gmail.com>
> >> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> >
> > Applied, thanks.
> >
>
> This patch causes build errors when
> # CONFIG_PROC_FS is not set
> because PROC_SYSCTL depends on PROC_FS.  The build errors are not
> in fs/proc/ but in other places in the kernel that never expect to see
> PROC_FS not set but PROC_SYSCTL=y.
>

Hi,

Maybe I'm missing something, if PROC_SYSCTL depends on PROC_FS, how is
possible to have PROC_FS not set but PROC_SYSCTL=y?
I tried it by manually editing .config. but make oldconfig warns:

WARNING: unmet direct dependencies detected for PROC_SYSCTL
  Depends on [n]: PROC_FS [=n]
  Selected by [m]:
  - MPLS_ROUTING [=m] && NET [=y] && MPLS [=y] && (NET_IP_TUNNEL [=n]
|| NET_IP_TUNNEL [=n]=n)
*
* Restart config...
*
*
* Configure standard kernel features (expert users)
*
Configure standard kernel features (expert users) (EXPERT) [Y/?] y
  Multiple users, groups and capabilities support (MULTIUSER) [Y/n/?] y
  sgetmask/ssetmask syscalls support (SGETMASK_SYSCALL) [N/y/?] n
  Sysfs syscall support (SYSFS_SYSCALL) [N/y/?] n
  Sysctl syscall support (SYSCTL_SYSCALL) [N/y/?] (NEW)

Regards,
-- 
Matteo Croce
per aspera ad upstream
