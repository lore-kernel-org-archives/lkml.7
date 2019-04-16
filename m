Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC24FC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B31F02075B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 04:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ebdoGELB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfDPEDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 00:03:07 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45217 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfDPEDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 00:03:06 -0400
Received: by mail-ua1-f68.google.com with SMTP id c13so6262539uao.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 21:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4Hi2EDpByuuaTOj5JqRIJr5mBTbxyLqBywD/dBt8gQ=;
        b=ebdoGELBjqvkVlsWe7n7m/Mu2PyOKUXB+BAg5QBJOCtxizroZxIsIT1iJW3T1T6tuJ
         pMSBIRxKS5jb0R8r4BvL2FEBW+7hjlFIImBtLKB6OusOlHm37YbAnJOjI/mVRstmoMTV
         13w2MfqekU8ZrSVRTidvGqSBHsqioV05ciC5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4Hi2EDpByuuaTOj5JqRIJr5mBTbxyLqBywD/dBt8gQ=;
        b=FRQ/zVtrkip0ixsetvG3VoXK7Ayg8V7yMZ8ioA6dVcVpr9C4MNYOXHutFcyXHt01rL
         albSuQMRLfpJHFyi8wfzNvNTFoeZjOt0zYeBtchgOPKmh+5g030W79IVdKA13A5KUnQG
         wA0V5DLFVUn5j2ANewrvvC7chxNfhAfvouofSx7api7pK5I6mbFbbj7jQePr9hc3erpP
         jMd0q4EsHoXIKzYSqGyO00zP1e9jJ1G/4yCItfZMaprh5lvSZBjhQG4Eb3hOnRTxSCCV
         vcn+6VnRwT8DeCb8ou0YLMIqQbOEjrbRy/IcTxasdlZ0dpEHO/l4t/WWWcFV7asSIw8X
         Sw6g==
X-Gm-Message-State: APjAAAUH+r/uLPloeb31srqJlk06SJ9uI+n4V38lS1qDqokIF3dMVMmg
        gocdye6sCuUl2RhW/gUjRf83kzRQR3w=
X-Google-Smtp-Source: APXvYqyvGA83tcZn0JySS3Dz9AEn9qEbatoRQqkbKwQoa4X6ptPgPOTQRmbuD2utZVpSRWqw6Bqj9Q==
X-Received: by 2002:ab0:5384:: with SMTP id k4mr33707496uaa.11.1555387385999;
        Mon, 15 Apr 2019 21:03:05 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id r21sm5407433uao.12.2019.04.15.21.03.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 21:03:05 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id s80so4129495vke.6
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 21:03:05 -0700 (PDT)
X-Received: by 2002:a1f:264b:: with SMTP id m72mr31777915vkm.43.1555387384831;
 Mon, 15 Apr 2019 21:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190411180117.27704-1-keescook@chromium.org> <20190411180117.27704-2-keescook@chromium.org>
 <947dbe9a-3444-6fe4-9f79-f8f210da8960@linux.com>
In-Reply-To: <947dbe9a-3444-6fe4-9f79-f8f210da8960@linux.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 23:02:53 -0500
X-Gmail-Original-Message-ID: <CAGXu5jJTM=pdAjsC63Z6T=HaztTqSqUQQ8=GN=tqv2n6CKc3nw@mail.gmail.com>
Message-ID: <CAGXu5jJTM=pdAjsC63Z6T=HaztTqSqUQQ8=GN=tqv2n6CKc3nw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] security: Create "kernel hardening" config area
To:     Alexander Popov <alex.popov@linux.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Sandeep Patil <sspatil@android.com>,
        Laura Abbott <labbott@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Emese Revfy <re.emese@gmail.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 11:44 AM Alexander Popov <alex.popov@linux.com> wrote:
>
> On 11.04.2019 21:01, Kees Cook wrote:
> > Right now kernel hardening options are scattered around various Kconfig
> > files. This can be a central place to collect these kinds of options
> > going forward. This is initially populated with the memory initialization
> > options from the gcc-plugins.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Hello Kees, hello everyone!
>
> After applying this series the kernel config looks like that:
>
> ...
> ...
> CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
>
> #
> # Kernel hardening options
> #
>
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> CONFIG_CRYPTO=y
>
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> ...
> ...
>
> What do you think about some separator between memory initialization options and
> CONFIG_CRYPTO?

This was true before too:

...
# CONFIG_DEFAULT_SECURITY_DAC is not set
CONFIG_LSM="yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor"
CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=y
CONFIG_ASYNC_MEMCPY=y
CONFIG_ASYNC_XOR=y
CONFIG_ASYNC_PQ=y
CONFIG_ASYNC_RAID6_RECOV=y
CONFIG_CRYPTO=y
...

Perhaps crypto/Kconfig's comment line could move to the top of the file?

comment "Crypto core or helper"

is what generates the separator...

-- 
Kees Cook
