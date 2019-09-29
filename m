Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE43EC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7864D2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 01:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RcgKCqBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbfI2BTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 21:19:44 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:25579 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728847AbfI2BTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 21:19:44 -0400
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id x8T1JR6K005224
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 10:19:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com x8T1JR6K005224
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569719968;
        bh=4yPJLL7texAUDBpAL8Bc7mm5wMMtuhCWLDO+NBR0H1s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RcgKCqBLHYW+Ctdonx2TyxJVOHIEjOqQYbJXxlWeF681kL543Fp2ILrZHLSfzV+NB
         ZwtuPazazw8w+sYZDTDB5CBTk61PAJ0Ys67kRzWXqLGoDmUYsAWtglBWDnjaqHnvYE
         5574mJ8W3iEQ0/sv3KURBli8AEJe/1bJkR5Oq3bpq7ghS3gPIg2hEXy+RZnLxtnmo+
         thkykifXPxSyNdaQ+W5PsPmiQ7XFT0DX//VOmvRm7GcNyRBMotMxlCuBujJh1mEaU9
         5F2RDvCpE+7UrYxveLOCdOta9h6/8JG3ieW9OvMUiFjm6LN1pjRhpGa7Qsu70ROY16
         JJv+317wfgcKA==
X-Nifty-SrcIP: [209.85.217.48]
Received: by mail-vs1-f48.google.com with SMTP id p13so4430792vsr.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 18:19:27 -0700 (PDT)
X-Gm-Message-State: APjAAAXi+yyn4ZKUoAmIwTtWU0M/4TW7HlLNoy3aO6liStfTDtcuwE8v
        JrrlIoMA0tD4nQHH4ibCjo3rGyEi0ZoGdcEK4u8=
X-Google-Smtp-Source: APXvYqxQSexiR2YeY61UDD+691IIzfSxQyWvVpnIBcnQpbPnTUctqKO9U1m2wtM65+ZZMtNU3TMOtnqZkU2chWqy04U=
X-Received: by 2002:a67:1a41:: with SMTP id a62mr6724527vsa.54.1569719966560;
 Sat, 28 Sep 2019 18:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com> <20190927132726.GB187147@google.com>
 <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com> <20190927181414.GB1804168@kroah.com>
In-Reply-To: <20190927181414.GB1804168@kroah.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 29 Sep 2019 10:18:50 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQh12iuAk5aoeHhZ=iGcYraWFfsei-+VqwALbOPrrjWdg@mail.gmail.com>
Message-ID: <CAK7LNAQh12iuAk5aoeHhZ=iGcYraWFfsei-+VqwALbOPrrjWdg@mail.gmail.com>
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Jessica Yu <jeyu@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 3:14 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Sep 28, 2019 at 12:42:28AM +0900, Masahiro Yamada wrote:
> > On Fri, Sep 27, 2019 at 10:27 PM Matthias Maennich <maennich@google.com=
> wrote:
> > >
> > > On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
> > > >scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_=
NS
> > > >tags, and what is nicer, it sorts the lines alphabetically with the
> > > >"sort" command. However, the output from the "sort" command depends
> > > >on locale.
> > > >
> > > >Especially when namespaces contain underscores, the result is
> > > >different depending on the locale.
> > > >
> > > >For example, I got this:
> > > >
> > > >$ { echo usbcommon; echo usb_common; } | LANG=3Den_US.UTF-8 sort
> > > >usbcommon
> > > >usb_common
> > > >$ { echo usbcommon; echo usb_common; } | LANG=3DC sort
> > > >usb_common
> > > >usbcommon
> > > >
> > > >So, this means people might potentially send different patches.
> > > >
> > > >This kind of issue was reported in the past, for example,
> > > >commit f55f2328bb28 ("kbuild: make sorting initramfs contents
> > > >independent of locale").
> > > >
> > > >Adding "LANG=3DC" is a conventional way of fixing when a determinist=
ic
> > > >result is desirable.
> > > >
> > > >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > > >---
> > > >
> > > > scripts/nsdeps | 2 +-
> > > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > >diff --git a/scripts/nsdeps b/scripts/nsdeps
> > > >index 964b7fb8c546..3754dac13b31 100644
> > > >--- a/scripts/nsdeps
> > > >+++ b/scripts/nsdeps
> > > >@@ -41,7 +41,7 @@ generate_deps() {
> > > >               for source_file in $mod_source_files; do
> > > >                       sed '/MODULE_IMPORT_NS/Q' $source_file > ${so=
urce_file}.tmp
> > > >                       offset=3D$(wc -l ${source_file}.tmp | awk '{p=
rint $1;}')
> > > >-                      cat $source_file | grep MODULE_IMPORT_NS | so=
rt -u >> ${source_file}.tmp
> > > >+                      cat $source_file | grep MODULE_IMPORT_NS | LA=
NG=3DC sort -u >> ${source_file}.tmp
> > >
> > > I would prefer to have this set throughout the whole runtime of the
> > > script. Otherwise we likely see a followup patch. So, either as an
> > > export at the beginning of this file or as part of the command that
> > > calls this script.
> >
> >
> > I prefer to keep it close to the locale-dependent code.
> >
> >
> >
> > If I move it to somewhere else, I need to add a comment like
> >
> > # make "sort" command deterministic
> > export LANG=3DC
> >
> > Otherwise, people would have no idea why it is needed.
>
> A comment is fine, it documents why it is here and it keeps anyone from
> having to remember to add it to anything else that changes in here.
>
> thanks,
>
> greg k-h


Huh, people who live in a country with English as mother tongue
cannot understand the i18n because English is the
only language in the world?





For example, in my locale (ja_JP.UTF-8)

I can see messages in Japanese as follows:

$ sh  scripts/nsdeps
cat: /modules.order: =E3=81=9D=E3=81=AE=E3=82=88=E3=81=86=E3=81=AA=E3=83=95=
=E3=82=A1=E3=82=A4=E3=83=AB=E3=82=84=E3=83=87=E3=82=A3=E3=83=AC=E3=82=AF=E3=
=83=88=E3=83=AA=E3=81=AF=E3=81=82=E3=82=8A=E3=81=BE=E3=81=9B=E3=82=93



If I added "LANG=3DC" to the whole of this script,
it would forcibly change all the messages into English.



$ sh  scripts/nsdeps
cat: /modules.order: No such file or directory




The impact on the locale should be really limited.
So, "LANG=3DC" must be placed immediately before the "find" command.



Nobody is asking to change log messages into English,
and offering what was not asked is just *pushy*.





--
Best Regards
Masahiro Yamada
