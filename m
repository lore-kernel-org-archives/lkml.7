Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC52AC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A569021726
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 18:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="koypC5t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfEOSbj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 14:31:39 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45260 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfEOSbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:31:39 -0400
Received: by mail-pl1-f195.google.com with SMTP id a5so264135pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 11:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eWVCL7OypAquy1b5ylX9pvAMoDWzSqxqQFZHT0qTIdQ=;
        b=koypC5t4enO9uQ8XhLdUSK/1pgFdw6sXAVq8AUA9TdvrsCP25bSA4Xz2YrAdC5UAo3
         0xHiGs9gkC65I4B2wRbQSceLCeWly/DLMQ5tLxyS5nIdqFCwHbxeeTksVYzVJHkFBszD
         rnjPJK0qEZBgpMWbiCafDo1MzEvrbQUbg3NMw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eWVCL7OypAquy1b5ylX9pvAMoDWzSqxqQFZHT0qTIdQ=;
        b=ng2Y6fjNq9EsTxPoJEXkdT/s4lHv5WD6hq30DEI51QEDuk2uoH/OKXA4ii3r3jCqZp
         yFXWwOD64MfDAkDarKmsL3aODl85Q0XwPeiNnlm0o74K8D/FP8BrQQ5OAwspIpeLXruJ
         E5o5iLBQZLutGcbOHgb79Pe9R1b21MLxdNzrjv28WvW5L1ajNnC+om4x9wK9xaoVL6lE
         WE7KcrQIzmnOKtR8amIKt2Uw6iCo/9VWEigH6wZrmH4cO2/YY7rpWiR/UI3ssIFB564M
         2qjde01nxxLs7o2Bivqr/eXR5sQU2tqIwckYmH0DFNu03QXqGr+CANFHzogiVITqjq8V
         Zudw==
X-Gm-Message-State: APjAAAUcxtlHolZfxFQQvpS7Xl6uml9a5v4vWwtdX8zVtYmekvLMYO5f
        FxcxvwsBAfAal/1DvST2scGpKI3zwZk=
X-Google-Smtp-Source: APXvYqxyfYKFAM4hHNcGb800CnTIP2ssp1PDdIuNqT7dnA9HC4eklExLzdnU0ostMN4RnQp4HklHDw==
X-Received: by 2002:a17:902:2a:: with SMTP id 39mr45044493pla.64.1557945098375;
        Wed, 15 May 2019 11:31:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f36sm1875919pgb.76.2019.05.15.11.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 11:31:37 -0700 (PDT)
Date:   Wed, 15 May 2019 11:31:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] kbuild: check uniqueness of basename of modules
Message-ID: <201905151130.87CDB73C0@keescook>
References: <20190515073818.22486-1-yamada.masahiro@socionext.com>
 <CAK7LNATUvPMqt93iwzNud0mxk99Si=CEBDyjA8BLEXM_tcTBfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNATUvPMqt93iwzNud0mxk99Si=CEBDyjA8BLEXM_tcTBfQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 03:07:54AM +0900, Masahiro Yamada wrote:
> On Wed, May 15, 2019 at 4:40 PM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> 
> >         $(Q)$(AWK) '!x[$$0]++' $^ > $(objtree)/modules.builtin
> > diff --git a/scripts/modules-check.sh b/scripts/modules-check.sh
> > new file mode 100755
> > index 000000000000..944e68bd22b0
> > --- /dev/null
> > +++ b/scripts/modules-check.sh
> > @@ -0,0 +1,18 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +# Warn if two or more modules have the same basename
> > +check_same_name_modules()
> > +{
> > +       same_name_modules=$(cat modules.order modules.builtin | \
> > +                               xargs basename -a | sort | uniq -d)
> 
> 
> I noticed a bug here.
> 
> 
> allnoconfig + CONFIG_MODULES=y
> will create empty modules.order and modules.builtin.
> 
> Then, 'basename -a' will emit the error messages
> since it receives zero arguments.

You can skip running it by adding "-r" to xargs:

       -r, --no-run-if-empty
              If the standard input does not contain any nonblanks, do not run
              the command.  Normally, the command is run once even if there is
              no input.  This option is a GNU extension.



-- 
Kees Cook
