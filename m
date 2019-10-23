Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267DCCA9EB6
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA95B2173B
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWHGBEjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387835AbfJWSFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 14:05:33 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46570 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727309AbfJWSFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 14:05:33 -0400
Received: by mail-pl1-f196.google.com with SMTP id q21so2391539plr.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 11:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tBfEWV8k73MV4Qw3DAmfxqW3sxBZePe885VokyL+kFI=;
        b=XWHGBEjZONbK9+JQ40gwN6YVXCRHMMzdlxxNu9JFSKH+O0LdlUyrZ1J9HxXGzbPdRW
         UDpsyBDLJHHvNx9x7qlmPdYbgbgJLrAGaJ8oOhp+3L3Zk5qaGQQCLPVMu88NfVw2L8aB
         nbuY2rgGUYTX7RNLwlGNfPZ9o2G8FRYhBAh6fLvuLzJVXoUg/nDQWNEAniYYSMJ2wGjg
         rRHNObfKrqxrrx+EAlPuxs0jd3PaWcA+7ApQcUVGCU75aCMTtTY5RcIzYJYH+C+2dw0I
         xr7J7YH6pc4jRa6lb97Sv5EyaRIslGU/UhWEQ4PmyGrf6rxqTkeXzCtzJz+rxmyohyBU
         Mitw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tBfEWV8k73MV4Qw3DAmfxqW3sxBZePe885VokyL+kFI=;
        b=ZdrHFwKH2Q+yHJiCR0bQ9mnoySnkMKVTbXajvy48rOgdHwcFgrD+dq+/xnCq1yddeI
         6dGwJoC+QSh6AcMcFICCrNocnpGvlViU8QjytAiftODRvKP7+0zGnu9WoerzwVe0Xovg
         Q0xy7OXgySrrEEsZFE+8MDxzSrPcpI0KUoC04vP1DaoNSHA5FWZdrIAxTu97puJr1k3n
         1ETu7CvirIfOG9yzpgrXh4WzrCMmEYfxo+zwMa3bmH9LCHXqW9ooHArglgM3PwpRPhGP
         gCKpZEKE3FfW/e5zzgQPt1GH5nQ5jfF3q7iN92dHu3ropzjfjrlIr3lnkqZ4KV2B32h9
         jTRg==
X-Gm-Message-State: APjAAAUlKjyD/pm2Cv6Ck5purGR2v+9eLKPDjHCBhl92KMluMv8zvnhW
        Q6efvf/cqhssWkJ2KJIfUDQ=
X-Google-Smtp-Source: APXvYqyCMGw0T2zCZa6pHPm8qUAqG0zHuEiZ9EUqlMTNIBUNJv5pgfDK9+JEj31tAbaTq9O9zFUsYw==
X-Received: by 2002:a17:902:8348:: with SMTP id z8mr11343624pln.12.1571853932584;
        Wed, 23 Oct 2019 11:05:32 -0700 (PDT)
Received: from wambui ([197.254.95.2])
        by smtp.gmail.com with ESMTPSA id d20sm25278968pfq.88.2019.10.23.11.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 11:05:31 -0700 (PDT)
Date:   Wed, 23 Oct 2019 21:05:21 +0300
From:   Wambui Karuga <wambui.karugax@gmail.com>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Julia Lawall <julia.lawall@lip6.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v2 0/5] Remove typedef declarations in
 staging: octeon
Message-ID: <20191023180521.GA5220@wambui>
Reply-To: 20191023174304.GD18977@darkstar.musicnaut.iki.fi
References: <cover.1570821661.git.wambui.karugax@gmail.com>
 <alpine.DEB.2.21.1910122034390.3049@hadrien>
 <20191023174304.GD18977@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023174304.GD18977@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2019 at 08:43:04PM +0300, Aaro Koskinen wrote:
> Hi,
> 
> On Sat, Oct 12, 2019 at 08:35:19PM +0200, Julia Lawall wrote:
> > On Sat, 12 Oct 2019, Wambui Karuga wrote:
> > > This patchset removes the addition of new typedefs data types in octeon,
> > > along with replacing the previous uses with the new declaration format.
> > >
> > > v2 of the series removes the obsolete "_t" notation in the named types.
> > >
> > > Wambui Karuga (5):
> > >   staging: octeon: remove typedef declaration for cvmx_wqe
> > >   staging: octeon: remove typedef declaration for cvmx_helper_link_info
> > >   staging: octeon: remove typedef declaration for cvmx_fau_reg_32
> > >   staging: octeon: remove typedef declartion for cvmx_pko_command_word0
> > >   staging: octeon: remove typedef declaration for cvmx_fau_op_size
> > >
> > >  drivers/staging/octeon/ethernet-mdio.c   |  6 +--
> > >  drivers/staging/octeon/ethernet-rgmii.c  |  4 +-
> > >  drivers/staging/octeon/ethernet-rx.c     |  6 +--
> > >  drivers/staging/octeon/ethernet-tx.c     |  4 +-
> > >  drivers/staging/octeon/ethernet.c        |  6 +--
> > >  drivers/staging/octeon/octeon-ethernet.h |  2 +-
> > >  drivers/staging/octeon/octeon-stubs.h    | 56 ++++++++++++------------
> > >  7 files changed, 43 insertions(+), 41 deletions(-)
> > 
> > For the series:
> > 
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> This series breaks the build on MIPS/OCTEON (the only actual HW using this
> driver):
> 
> $ make ARCH=mips CROSS_COMPILE=mips64-linux-gnu- cavium_octeon_defconfig
> $ make ARCH=mips CROSS_COMPILE=mips64-linux-gnu-
> [...]
>   CC      drivers/staging/octeon/ethernet.o
> In file included from drivers/staging/octeon/ethernet.c:22:
> drivers/staging/octeon/octeon-ethernet.h:94:12: warning: 'union cvmx_helper_link_info' declared inside parameter list will not be visible outside of this definition or declaration
>       union cvmx_helper_link_info li);  
>             ^~~~~~~~~~~~~~~~~~~~~
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_free_work':
> drivers/staging/octeon/ethernet.c:177:21: error: dereferencing pointer to incomplete type 'struct cvmx_wqe'
>   int segments = work->word2.s.bufs;
>                      ^~
> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_open':
> drivers/staging/octeon/ethernet.c:463:30: error: storage size of 'link_info' isn't known
>   union cvmx_helper_link_info link_info;
>                               ^~~~~~~~~
> 
> etc.
> 
> Probably all these patches need to be reverted.
> 
> A.

Aaro, thanks for the heads up - I can try cross-compiling to see if I
can fix the errors.
wambui karuga.
