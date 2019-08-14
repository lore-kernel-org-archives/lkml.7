Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CB6C32759
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D707206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J/RX89Sf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728563AbfHNRfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:35:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40694 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbfHNRfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:35:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id c34so44302385otb.7
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fOFmALBZr12NwAFqPH4bz0Snzh0MYv/4Oy/ALTRaZDA=;
        b=J/RX89SfeoHR3tNRvGakoeZptZJRFt1aGCoCGLanpgjt6kzr4VpQHXuOeq/XIub7h3
         dtaz/Elri9LmCCrz1cJasmWNTs/t3B2DIMrEzFtcDd5S3T5Z7qW0x6VQtzyPUT8xX0Dr
         tpBoGVGOFhjt5t/gsPYut79dUKJV/zOUYBE0KuVDsrJAB63xmL9rkN5sW1B/mX17RfT8
         s7uhch2pStQ0Q6kOmXjpTKpW17nIDOPnBvNsIuNp6/qFxNyKoezYoApT9paR+P+AAJP+
         1YlKwUJfVlXI0OJvPm/r92hOejmHZfRewJNJIhMYRbj46Pt2aVShyKZOOJ23qQt+gnU7
         ycMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fOFmALBZr12NwAFqPH4bz0Snzh0MYv/4Oy/ALTRaZDA=;
        b=rgaMUP9K35WEsPcR9RBec7T6TbGr1zzCqcn637I8CLrK1F9D+NFtzYibj5ekc7Uv+4
         OkNyc32jmkh306pWfavqsWRK7Y26eacOnpdeHKspHMGH4pKZoomgFWyzrMkEpB7c5SAr
         2mrHHuzSh+7FTqPgqSFDP1VAs62SnxpxUNZKvPD+k5p50RzdKcwktdAl8XQWg2gyLy/x
         cc6jMRfJXE/jHUzb/MjsF1g9RESMCQiRoXjf32i5amB8DyFJ+LpsDBqh0LX+S3iI93Bd
         Kouqt89N+MfHuLZkv/wPo9nzjUPjyK4QAsnXI4A3EiGXRA9mUTyzTON4t854yNWz7ZRV
         8FTg==
X-Gm-Message-State: APjAAAUptoQFdFD/vU9t+jJTcwYsQ/OWHfeMtTXoEaZFPm87itxuUn87
        xbizE+aKGK3IwQIweCQIxsPmaX0FgV9/bQ7Ra3Cgtw==
X-Google-Smtp-Source: APXvYqyjolYUGNDko/RtbeKAldUB4mXc2vz0kBg/ilppWohKo/GY5H6usCosoBEpZ0JF43wMzvRMaDIYk6L2L/batEg=
X-Received: by 2002:a05:6830:1e0f:: with SMTP id s15mr177324otr.231.1565804120275;
 Wed, 14 Aug 2019 10:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180716122125.175792-1-maco@android.com> <20190813121733.52480-1-maennich@google.com>
 <20190813121733.52480-6-maennich@google.com> <CAGETcx_LQDdnaU+3JVGw+6=DJ8tRoQ00+3rD2gOiHHkWomt8jg@mail.gmail.com>
 <20190814125427.GA72826@google.com>
In-Reply-To: <20190814125427.GA72826@google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 14 Aug 2019 10:34:43 -0700
Message-ID: <CAGETcx99Xx7aRPS-2Pw8h7O5D_+3T+1hbqja=p-gLN2wXApaEQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] module: add config option MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
To:     Matthias Maennich <maennich@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, maco@android.com,
        Android Kernel Team <kernel-team@android.com>, arnd@arndb.de,
        geert@linux-m68k.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hpa@zytor.com,
        jeyu@kernel.org,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-modules@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        lucas.de.marchi@gmail.com, Martijn Coenen <maco@google.com>,
        michal.lkml@markovi.net, mingo@redhat.com, oneukum@suse.com,
        Philippe Ombredanne <pombredanne@nexb.com>, sam@ravnborg.org,
        Sandeep Patil <sspatil@google.com>, stern@rowland.harvard.edu,
        tglx@linutronix.de, usb-storage@lists.one-eyed-alien.net,
        x86@kernel.org, yamada.masahiro@socionext.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 5:54 AM 'Matthias Maennich' via kernel-team
<kernel-team@android.com> wrote:
>
> On Tue, Aug 13, 2019 at 01:15:44PM -0700, Saravana Kannan wrote:
> >On Tue, Aug 13, 2019 at 5:19 AM 'Matthias Maennich' via kernel-team
> ><kernel-team@android.com> wrote:
> >>
> >> If MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is enabled (default=n), the
> >> requirement for modules to import all namespaces that are used by
> >> the module is relaxed.
> >>
> >> Enabling this option effectively allows (invalid) modules to be loaded
> >> while only a warning is emitted.
> >>
> >> Disabling this option keeps the enforcement at module loading time and
> >> loading is denied if the module's imports are not satisfactory.
> >>
> >> Reviewed-by: Martijn Coenen <maco@android.com>
> >> Signed-off-by: Matthias Maennich <maennich@google.com>
> >> ---
> >>  init/Kconfig    | 14 ++++++++++++++
> >>  kernel/module.c | 11 +++++++++--
> >>  2 files changed, 23 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/init/Kconfig b/init/Kconfig
> >> index bd7d650d4a99..b3373334cdf1 100644
> >> --- a/init/Kconfig
> >> +++ b/init/Kconfig
> >> @@ -2119,6 +2119,20 @@ config MODULE_COMPRESS_XZ
> >>
> >>  endchoice
> >>
> >> +config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
> >> +       bool "Allow loading of modules with missing namespace imports"
> >> +       default n
> >> +       help
> >> +         Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
> >> +         a namespace. A module that makes use of a symbol exported with such a
> >> +         namespace is required to import the namespace via MODULE_IMPORT_NS().
> >> +         This option relaxes this requirement when loading a module.
> >
> >> While
> >> +         technically there is no reason to enforce correct namespace imports,
> >> +         it creates consistency between symbols defining namespaces and users
> >> +         importing namespaces they make use of.
> >
> >I'm confused by this sentence. It sounds like it's the opposite of
> >what the config is doing? Can you please reword it for clarify?
>
> How about:
>
>   Symbols exported with EXPORT_SYMBOL_NS*() are considered exported in
>   a namespace. A module that makes use of a symbol exported with such a
>   namespace is required to import the namespace via MODULE_IMPORT_NS().
>   There is no technical reason to enforce correct namespace imports,
>   but it creates consistency between symbols defining namespaces and
>   users importing namespaces they make use of. This option relaxes this
>   requirement and lifts the enforcement when loading a module.

That's a lot better. Especially moving the "This option relaxes..." to
the bottom. Thanks.

-Saravana
