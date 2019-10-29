Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2737CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9918520717
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 09:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="lfdriDdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730611AbfJ2JDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 05:03:24 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34070 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbfJ2JDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 05:03:22 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x9T93GNt030462
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:03:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x9T93GNt030462
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1572339797;
        bh=EAEi1K2U344N90FciSKHHARW6VFalhrkblUys0k8F4s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lfdriDdTUiZJM5D69Z4ZfXrw8v2evzbYiJkBZZJcxN3igEL8QYDKV7aWO/3wH08GL
         vPb8ygyEzzZgM27ViIZwgXxrHSq+cSH2imNUAgwof1KfYcwwZmNxVGZ83ulU0RaeWr
         71frB5KH8qc5rH1kQqFSACD3L4YcskmcX2PzrcoNBRnt9lfscTtt1fPKTykkm9WZIW
         FEBgiVhfd9T/hgUFqHX5/prWNXe0U4D3gzKgiHr5fLsdW4I0orkB3GZRQrCNSBzxD3
         MCvd5SBqRhvImHfaJCT9MNPJXQAF+tmZ9vvjrDEKaFgTBMbwh4/AHrKEUYmpVtSq8C
         I226tWH91HXHw==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id k15so8264702vsp.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 02:03:16 -0700 (PDT)
X-Gm-Message-State: APjAAAWbigrM+cRbNjJcY6O7KgJ/Gw0OeZJ0cNWaU3Q4JxLv+87awXj8
        kzMPSr//XQ93tC/hR0xEbLxsR+LP2O8l6B0DeUo=
X-Google-Smtp-Source: APXvYqzhJe/yPQdN0tBDu6TBQc2K5WV2hMrLehNaG9v/mQdNrhhaM6o1wclLJNHU3Lmxj2DnZeGCs2BIox9cjEbnFao=
X-Received: by 2002:a05:6102:726:: with SMTP id u6mr982037vsg.179.1572339795525;
 Tue, 29 Oct 2019 02:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191028153334.GA25863@linux-8ccs>
In-Reply-To: <20191028153334.GA25863@linux-8ccs>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Tue, 29 Oct 2019 18:02:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQfeoPt1KApoa94RwVYo-LiPWxgit8=vzM2wfzHs+CajQ@mail.gmail.com>
Message-ID: <CAK7LNAQfeoPt1KApoa94RwVYo-LiPWxgit8=vzM2wfzHs+CajQ@mail.gmail.com>
Subject: Re: `make nsdeps` prints "Building modules, stage 2" twice
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 29, 2019 at 12:33 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> Hi!
>
> When running `make nsdeps`, I've noticed that "Building modules, stage
> 2" gets printed twice. Not a big deal, but a bit strange to see,
> especially since the second print is actually from the nsdeps target
> calling modpost again.
>
> $ make nsdeps O=/dev/shm/linux
> make[1]: Entering directory '/dev/shm/linux'
>   GEN     Makefile
>   DESCEND  objtool
>   CALL    /tmp/ppyu/linux/scripts/atomic/check-atomics.sh
>   CALL    /tmp/ppyu/linux/scripts/checksyscalls.sh
>   CHK     include/generated/compile.h
>   Building modules, stage 2.
>   MODPOST 3316 modules
>   Building modules, stage 2.
>   MODPOST 3316 modules
> Adding namespace USB_STORAGE to module uas (if needed).
> Adding namespace USB_STORAGE to module ums-alauda (if needed).
> Adding namespace USB_STORAGE to module ums-cypress (if needed).
> Adding namespace USB_STORAGE to module ums-datafab (if needed).
> ....etc...
>
> It's due to calling the __modpost target twice, once for modules and
> once for nsdeps. I guess we could have the nsdeps target just call
> cmd_modpost, but then we still have the MODPOST XXXX modules line
> printing twice. Is there a nicer way to fix this? Again, it's not
> harmful, but probably confusing for people to see.
>
> Thanks,
>
> Jessica

I can fix this correctly.
Will send a patch soon.


-- 
Best Regards
Masahiro Yamada
