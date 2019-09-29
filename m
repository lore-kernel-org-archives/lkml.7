Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1EFC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B244214D8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="NLybHHBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbfI2BbX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:31:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:28324 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728569AbfI2BbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 21:31:23 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x8T1V3WX002731
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 10:31:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x8T1V3WX002731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569720664;
        bh=hTzswXoVvRMq0HEW4oc27Djtr+jRVat/fCYdbK8jNqY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NLybHHBXa6PsV8OtEkGVEB2sZ1z4iTpMktSwO6VtCNmAdNq3rjVtP4N9/KLvkC4ci
         bR3kIqe6G5ev9XUGkfyNjA2v6Kj5cvLHVdJGwYUJoyQ7hmQCB094iOtTFbLGdMji4d
         FcGkCYhwxbFZQrLD5j/Z1S81bIIQ/46GCu14y8SG0AOviNALE90qCk3DDVElMMRdai
         dqZUay+fvBoeurEjo+wrsIgj6cMFCxX+VuEBm4tZZ0S9VU3laP/npkunm4UiDxbCSb
         R1u8mhBkwcXjDRoA0sDM60wglpAdh/I7yE3UW6lLLInXji7bAqy4zPr+op8vEhPNne
         T+ILcU/dM8Ryw==
X-Nifty-SrcIP: [209.85.217.42]
Received: by mail-vs1-f42.google.com with SMTP id d204so4406327vsc.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 18:31:04 -0700 (PDT)
X-Gm-Message-State: APjAAAW3m9TFi3yaW4BxeZt+CJp789FYVX913Hh0NCY4/MZV2qGc9UA2
        jDCxUj8vJhKFcmA5u0nr08f1QUb9UuvC6MXu0Kg=
X-Google-Smtp-Source: APXvYqwxaZKVYP4Z8UDUJfTlvCF7qoLHOVKPlJtBfUib3KPRj+2L0xCeJD2oDWOtMfxai9r0jIcPA3ZFbsqguhvCgIo=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr6765861vse.179.1569720663296;
 Sat, 28 Sep 2019 18:31:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com> <20190927132726.GB187147@google.com>
 <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
 <20190927181414.GB1804168@kroah.com> <CAK7LNAQh12iuAk5aoeHhZ=iGcYraWFfsei-+VqwALbOPrrjWdg@mail.gmail.com>
In-Reply-To: <CAK7LNAQh12iuAk5aoeHhZ=iGcYraWFfsei-+VqwALbOPrrjWdg@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 29 Sep 2019 10:30:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7QwfMRKwc1DwaRQW3GA-tBHhSv=yVq+xR_YkpYAnc6w@mail.gmail.com>
Message-ID: <CAK7LNAR7QwfMRKwc1DwaRQW3GA-tBHhSv=yVq+xR_YkpYAnc6w@mail.gmail.com>
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 10:18 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> On Sat, Sep 28, 2019 at 3:14 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Sep 28, 2019 at 12:42:28AM +0900, Masahiro Yamada wrote:
> > > On Fri, Sep 27, 2019 at 10:27 PM Matthias Maennich <maennich@google.com> wrote:
> > > >
> > > > On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
> > > > >scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
> > > > >tags, and what is nicer, it sorts the lines alphabetically with the
> > > > >"sort" command. However, the output from the "sort" command depends
> > > > >on locale.
> > > > >
> > > > >Especially when namespaces contain underscores, the result is
> > > > >different depending on the locale.
> > > > >
> > > > >For example, I got this:
> > > > >
> > > > >$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
> > > > >usbcommon
> > > > >usb_common
> > > > >$ { echo usbcommon; echo usb_common; } | LANG=C sort
> > > > >usb_common
> > > > >usbcommon
> > > > >
> > > > >So, this means people might potentially send different patches.
> > > > >
> > > > >This kind of issue was reported in the past, for example,
> > > > >commit f55f2328bb28 ("kbuild: make sorting initramfs contents
> > > > >independent of locale").
> > > > >
> > > > >Adding "LANG=C" is a conventional way of fixing when a deterministic
> > > > >result is desirable.
> > > > >
> > > > >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > > >---
> > > > >
> > > > > scripts/nsdeps | 2 +-
> > > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > >diff --git a/scripts/nsdeps b/scripts/nsdeps
> > > > >index 964b7fb8c546..3754dac13b31 100644
> > > > >--- a/scripts/nsdeps
> > > > >+++ b/scripts/nsdeps
> > > > >@@ -41,7 +41,7 @@ generate_deps() {
> > > > >               for source_file in $mod_source_files; do
> > > > >                       sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> > > > >                       offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
> > > > >-                      cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
> > > > >+                      cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp
> > > >
> > > > I would prefer to have this set throughout the whole runtime of the
> > > > script. Otherwise we likely see a followup patch. So, either as an
> > > > export at the beginning of this file or as part of the command that
> > > > calls this script.
> > >
> > >
> > > I prefer to keep it close to the locale-dependent code.
> > >
> > >
> > >
> > > If I move it to somewhere else, I need to add a comment like
> > >
> > > # make "sort" command deterministic
> > > export LANG=C
> > >
> > > Otherwise, people would have no idea why it is needed.
> >
> > A comment is fine, it documents why it is here and it keeps anyone from
> > having to remember to add it to anything else that changes in here.
> >
> > thanks,
> >
> > greg k-h
>
>
> Huh, people who live in a country with English as mother tongue
> cannot understand the i18n because English is the
> only language in the world?

I take back this comment.
I actually do not know where you live, or what native language you speak.
It was used to exaggerate things, but It is not important to
the point of discussions. Sorry.



--
Best Regards
Masahiro Yamada
