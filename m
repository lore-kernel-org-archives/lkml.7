Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73421C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44EF2205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:36:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxJvlV4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfCKQg3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:36:29 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51891 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbfCKQg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:36:27 -0400
Received: by mail-it1-f195.google.com with SMTP id e24so8319912itl.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2019 09:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5bujM85Y0scj/fEZwrlnYcayj7i0rZlLHknj8BGgmlQ=;
        b=ZxJvlV4hegE8DN0DV3FW4178aEMDeHea8IXp0fzUZM97n9Kop92Wf2mzwL7uHNnhHb
         BzTTzMqzWDeeQZiRmtcN1aBt3HclJ2/oErULNL4pRjtG/MgtkTALWT7c312yZQdBPAoE
         B49BYNsYSCjKU2E1LGMKWXjXr8tvh3dtNBALdDSUY4nyM/AIiSX3fA6NC1YeSogrNQzI
         2U3b6DBO7oCA0WNfUUGcbQNfzcNSh8ahfpLN9OJFCae+dbToC4OLhIKurpRI4PraFrQ8
         Cv/TSyuoFDP/lH08wSQEwlP4OMjTyfApoeGnqeSqSnkvFJlKOUjNEPiDXLhwLERfDDJR
         ImdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bujM85Y0scj/fEZwrlnYcayj7i0rZlLHknj8BGgmlQ=;
        b=Nube9lxKNCLBPY1TBLdvm4utkPox2cPXZSTAipvPKv/MObOIGHFF8/CvJbCdJz7O1s
         KFFtOq/gz9IFIjv2XCS268k8yeOzUy1WexXYoiUjiZ//eSfSrVj2zpjmmH5Lp67apvoF
         PUY2cbDWFF4XpclylS8ttrMiMeeawHtM0K3GYNgvamZ5JoUHrhAode+2/rnyTJEAdopa
         J1jasy1espw4CR7bRx67HHSAlJxYHbpeP2HEN/GGBhnXiq/ur69GM8EpqIdJMibmghq8
         nNUaPjXHriQ4s1rEDCAwYdxsHmR2KbsKVpC3UT59mXS5iwPH2CjKpm/0dCrR8Jq+1B3f
         cmwA==
X-Gm-Message-State: APjAAAWkSrhm6zG3L0WZGBl3h/qcMueWz+chm+LgHes4B7j1tJ6yudvM
        PExSuBkN0L4gCUfI7Jf7yf0VHWS6bVsi2zdvax1MVJAt3JU=
X-Google-Smtp-Source: APXvYqylhJso83eUpkLgcTRmqSkUgn+uTBfrquEyBEepmT3VJYrGK/ro99ZaL1Ky/cYbH3iMAjbhbT4FcbajY65wCJ4=
X-Received: by 2002:a24:1947:: with SMTP id b68mr308858itb.121.1552322186149;
 Mon, 11 Mar 2019 09:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190307091514.2489338-1-arnd@arndb.de> <20190307091514.2489338-2-arnd@arndb.de>
 <CAKwvOdk=9j2HvtWOpdOEw9sm0Nh2oU3c1c6+hJJ5WMweAM=4EQ@mail.gmail.com>
 <20190307234850.nsbpkfcit3lnmytu@shell.armlinux.org.uk> <CAKv+Gu9VM2Vs3Q8+bPLsnt08dOmba6j54gnhiHkk=AHRzG8tVA@mail.gmail.com>
 <20190308095308.hjjrzdp4fzbbtnnv@shell.armlinux.org.uk> <CAKv+Gu_szWgw-KJASLYGJ6hJXh5K8WxnUn+UQkm7jUup=rqG6w@mail.gmail.com>
 <20190308103429.ycasmpt6tcpsoqps@shell.armlinux.org.uk> <CAKv+Gu_9=G3U6Yaw8fLfTP3QT38WdwrFaC-BqLTCr2NihWA2ZA@mail.gmail.com>
 <20190308105835.tovswk5rwxusmxdu@shell.armlinux.org.uk> <CAKv+Gu-Od+hBosThTWFooz9FMKnu3g0oNh_2hmidetbB-_YyjQ@mail.gmail.com>
 <CAK8P3a1ECw_g1AqsVavD8hhVEGqNk6Kcx_U0L=0d29eu561NhA@mail.gmail.com>
 <CAKv+Gu8qgsnPV=uWR2jkJ5bsYihekkEvWNuw4whLdLrbBa7gnA@mail.gmail.com> <CAK8P3a0QCgLbXpztUQXAhWLp=ArJUqmtcuXNZUeXZBH+N1QeaA@mail.gmail.com>
In-Reply-To: <CAK8P3a0QCgLbXpztUQXAhWLp=ArJUqmtcuXNZUeXZBH+N1QeaA@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Mar 2019 17:36:14 +0100
Message-ID: <CAKv+Gu__jgnm00ou+3FsqRBZWeDFy5Qi+1eiXeMKqc+hVSXomg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ARM: futex: make futex_detect_cmpxchg more reliable
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Mikael Pettersson <mikpelinux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Martin <Dave.Martin@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2019 at 17:30, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Mar 11, 2019 at 3:36 PM Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
> > On Mon, 11 Mar 2019 at 15:34, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Fri, Mar 8, 2019 at 12:56 PM Ard Biesheuvel
> > > <ard.biesheuvel@linaro.org> wrote:
> > > > On Fri, 8 Mar 2019 at 11:58, Russell King - ARM Linux admin <linux@armlinux.org.uk> wrote:
> > > > > On Fri, Mar 08, 2019 at 11:45:21AM +0100, Ard Biesheuvel wrote:
> > >
> > > My first attempt (before finding the original patch from Mikael Pettersson)
> > > was to change the probe to pass '1' as the value instead of '0', that
> > > worked fine.
> > >
> >
> > Which probe is that?
>
> diff --git a/kernel/futex.c b/kernel/futex.c
> index c3b73b0311bc..19615ad3c4f7 100644
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -3864,7 +3864,7 @@ static void __init futex_detect_cmpxchg(void)
>          * implementation, the non-functional ones will return
>          * -ENOSYS.
>          */
> -       if (cmpxchg_futex_value_locked(&curval, NULL, 0, 0) == -EFAULT)
> +       if (cmpxchg_futex_value_locked(&curval, NULL, 1, 1) == -EFAULT)
>                 futex_cmpxchg_enabled = 1;
>  #endif
>  }
>

Ah ok.

That explains a lot.

Can't we just return -EFAULT if uaddr is NULL? Or does that defeat this check?

Note that PA-RISC has

        /* futex.c wants to do a cmpxchg_inatomic on kernel NULL, which is
         * our gateway page, and causes no end of trouble...
         */
        if (uaccess_kernel() && !uaddr)
                return -EFAULT;
