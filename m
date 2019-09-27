Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4BEC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAC621841
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 15:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="f2mV2a37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfI0PnX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 11:43:23 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:22701 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfI0PnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 11:43:23 -0400
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id x8RFh5SZ030066
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 00:43:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com x8RFh5SZ030066
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1569598986;
        bh=BOiQAs/dycY1kmUyfLZPC/1iqRvlu59B1uaBvrLInIQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=f2mV2a37HZIvCuV52P5lsI4T0Z82x6+Xzl3HQWFVGlcQQatHtWv6jZmThewB+YWV/
         B73rlEt0zFRZN/FV1mBITxfZmlTz5B6a4GdchQFUqrHsMuHQfQDOOsbkqWCR4DAVNl
         6CLQwkcDqIAeKuI98cQE8/Ar9SKBpD2PwOQRi4Gm/KHA5DyWAFksP+DycdhR7vfTHU
         2JSHvC0eko205huQV9Wbst2D+nhllx/TYcHS4Yvq7JFGgqn/U/vjYHwQjMViwaqyka
         MITcruRVhISNpLg+qgBi2c6lwu5QJGSjHFD33xnZo0k6eMiP4zXr4/1Tkbdlk0S65r
         9oTPKCd7epAMA==
X-Nifty-SrcIP: [209.85.217.44]
Received: by mail-vs1-f44.google.com with SMTP id s7so2178073vsl.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 08:43:05 -0700 (PDT)
X-Gm-Message-State: APjAAAVvhverQ2MhdRfNFZpkWJ/TJ1g0mQX4L1qEanRX5N5BVJHe8KY5
        EKn+RKgumNvLVZ6l8wrJ/CC+zjMZAtRUgBi5A5g=
X-Google-Smtp-Source: APXvYqwkNoNEMoLL6oiDxCtnBGkU64XbEwk2O5nrBGrE81SFfOK7SPXJSCBaMz3ihfZM9tsTi9MUdGW1MR7bd4saTsg=
X-Received: by 2002:a67:1e87:: with SMTP id e129mr2906177vse.179.1569598984837;
 Fri, 27 Sep 2019 08:43:04 -0700 (PDT)
MIME-Version: 1.0
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-8-yamada.masahiro@socionext.com> <20190927132726.GB187147@google.com>
In-Reply-To: <20190927132726.GB187147@google.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 28 Sep 2019 00:42:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
Message-ID: <CAK7LNARQZ49jvPOK5Dg3B7Nog7+zHsAn5=1oHH6hz9ZzJ=S+xA@mail.gmail.com>
Subject: Re: [PATCH 7/7] nsdeps: make generated patches independent of locale
To:     Matthias Maennich <maennich@google.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 10:27 PM Matthias Maennich <maennich@google.com> wrote:
>
> On Fri, Sep 27, 2019 at 06:36:03PM +0900, Masahiro Yamada wrote:
> >scripts/nsdeps automatically generates a patch to add MODULE_IMPORT_NS
> >tags, and what is nicer, it sorts the lines alphabetically with the
> >"sort" command. However, the output from the "sort" command depends
> >on locale.
> >
> >Especially when namespaces contain underscores, the result is
> >different depending on the locale.
> >
> >For example, I got this:
> >
> >$ { echo usbcommon; echo usb_common; } | LANG=en_US.UTF-8 sort
> >usbcommon
> >usb_common
> >$ { echo usbcommon; echo usb_common; } | LANG=C sort
> >usb_common
> >usbcommon
> >
> >So, this means people might potentially send different patches.
> >
> >This kind of issue was reported in the past, for example,
> >commit f55f2328bb28 ("kbuild: make sorting initramfs contents
> >independent of locale").
> >
> >Adding "LANG=C" is a conventional way of fixing when a deterministic
> >result is desirable.
> >
> >Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> >---
> >
> > scripts/nsdeps | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/scripts/nsdeps b/scripts/nsdeps
> >index 964b7fb8c546..3754dac13b31 100644
> >--- a/scripts/nsdeps
> >+++ b/scripts/nsdeps
> >@@ -41,7 +41,7 @@ generate_deps() {
> >               for source_file in $mod_source_files; do
> >                       sed '/MODULE_IMPORT_NS/Q' $source_file > ${source_file}.tmp
> >                       offset=$(wc -l ${source_file}.tmp | awk '{print $1;}')
> >-                      cat $source_file | grep MODULE_IMPORT_NS | sort -u >> ${source_file}.tmp
> >+                      cat $source_file | grep MODULE_IMPORT_NS | LANG=C sort -u >> ${source_file}.tmp
>
> I would prefer to have this set throughout the whole runtime of the
> script. Otherwise we likely see a followup patch. So, either as an
> export at the beginning of this file or as part of the command that
> calls this script.


I prefer to keep it close to the locale-dependent code.



If I move it to somewhere else, I need to add a comment like

# make "sort" command deterministic
export LANG=C

Otherwise, people would have no idea why it is needed.







> With this
>
> Reviewed-by: Matthias Maennich <maennich@google.com>
>
> Cheers,
> Matthias
>
> >                       tail -n +$((offset +1)) ${source_file} | grep -v MODULE_IMPORT_NS >> ${source_file}.tmp
> >                       if ! diff -q ${source_file} ${source_file}.tmp; then
> >                               mv ${source_file}.tmp ${source_file}
> >--
> >2.17.1
> >



-- 
Best Regards
Masahiro Yamada
