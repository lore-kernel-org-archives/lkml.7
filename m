Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C144C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A520217F5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 14:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="j121Y4Nc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729250AbfCOOLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:11:34 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:24555 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbfCOOLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 10:11:34 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id x2FEBGdx018065;
        Fri, 15 Mar 2019 23:11:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com x2FEBGdx018065
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1552659077;
        bh=snXwYgeZMmePnR5qJ63hymfyuZ8GrElTLc5lGijFS48=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=j121Y4Nc1MK/s9aWUqZCLP0TxeNv5zb4mXxz4EJl69RIHR5ChyknVnjR2+5vCaZ6H
         5JIyq4z4gQ1i73n4zQbympTdX8oZGQZYbPlzySshQsv0jTU30mZDP8hbpyOk8ZoVDH
         S9ssaWcL3TEpJozRFh48GM1qmeZycLj3Pl50mk3xzHu3TQ2wVPIImifyvmKzJK80R9
         MQ9Dnb5Dh4/HBtWrCZitUwpbtUDI6I0RXLxkN1smEvTi9IVIiBqrJGmeBQWquIV3tI
         mCpbvDgQFVD/VF5xSsoyt9Mt40qWQjG2Ag6dvK1q8b4GrO9snkAIMTRPVAvBBgOjiR
         WsD4+7SsqjbDg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id z6so5464771vsc.0;
        Fri, 15 Mar 2019 07:11:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUm3eV7y9KgwQsF8+og3jl1MlFqQlxJbPgpwf0uEDJ7SGmXUeU8
        02oB2Dz55nruNbQioKpwxniRgoYAtKVZZjqpa2k=
X-Google-Smtp-Source: APXvYqy4llbfwehUZjKEsyjMH0PELIv3pdzM/aNIZVAT84DAQuff3WCshGXjACJ3E4CXHnWzzTMxbn6ioECmHVX5dz8=
X-Received: by 2002:a67:7c04:: with SMTP id x4mr2051439vsc.155.1552659075640;
 Fri, 15 Mar 2019 07:11:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190314175705.11671-1-dianders@chromium.org>
In-Reply-To: <20190314175705.11671-1-dianders@chromium.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 15 Mar 2019 23:10:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNATvfVD8RfZN37fXGKJeEuawM_7BuVrJ4xw1pZmuz5f_aw@mail.gmail.com>
Message-ID: <CAK7LNATvfVD8RfZN37fXGKJeEuawM_7BuVrJ4xw1pZmuz5f_aw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: If the module stripping command fails the build
 should abort
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 2:59 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> If the call to strip returns an error code then it makes sense for the
> build to fail.  Currently we'll just chug along and ship unstripped
> modules.
>
> Fixes: e2a666d52b48 ("kbuild: sign the modules at install time")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>


Did you see this problem in the latest kernel?

Since commit 3a2429e1faf40b2aaa481aa4b001a74d222c7e8b,
$(call cmd,...) is run with 'set -e'.

Any failure in a series of commands will let the build fail.


If you have the problem in old versions ( < 4.20),
I do not mind this patch for linux-stable.





> ---
>
>  scripts/Makefile.modinst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
> index ff5ca9817a85..5d05c43c6f31 100644
> --- a/scripts/Makefile.modinst
> +++ b/scripts/Makefile.modinst
> @@ -22,7 +22,7 @@ quiet_cmd_modules_install = INSTALL $@
>        cmd_modules_install = \
>      mkdir -p $(2) ; \
>      cp $@ $(2) ; \
> -    $(mod_strip_cmd) $(2)/$(notdir $@) ; \
> +    $(mod_strip_cmd) $(2)/$(notdir $@) && \
>      $(mod_sign_cmd) $(2)/$(notdir $@) $(patsubst %,|| true,$(KBUILD_EXTMOD)) && \
>      $(mod_compress_cmd) $(2)/$(notdir $@)
>
> --
> 2.21.0.360.g471c308f928-goog
>


--
Best Regards
Masahiro Yamada
