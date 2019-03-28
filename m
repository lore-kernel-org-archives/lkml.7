Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57C12183F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="by03zao+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfC1RmM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:42:12 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46964 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbfC1RmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:42:12 -0400
Received: by mail-wr1-f65.google.com with SMTP id t17so3244568wrw.13;
        Thu, 28 Mar 2019 10:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Mr1gDTF1rFGSHTeB5TYFuVHt5sbfmlprOnMBT4r3oc=;
        b=by03zao+NKexwhTus4FVKlegqNELcobCS08towfRQZ868qX8Ac4Nin/DklDAhy7u5V
         cFO8AWN/nDAhow0kD7JUsWqhNj4VNrC6G2R3n7MHkl4GfkOT29UN7/cPWdcCEqcTETYz
         pCBp7Ohrsmx35iNFaf6yDVOzNLfih7nMmPl1UbYXLmfnTOdYPWuyB4vSjReRZr6RW6k2
         eXDWpWhxVco+SVUf1NzyXuNgwQEeIlvMPswvWFhHcJp1dz2hYZV5y+4WLHia/jEmmawF
         Kz3/rJTmlhIxvNZ1FGEkuU6PbgBlCCrTZwsYh6m38xIhNO62FaoRWCtn710e2qoKeWmU
         TfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Mr1gDTF1rFGSHTeB5TYFuVHt5sbfmlprOnMBT4r3oc=;
        b=d9w4Ac/bqz76Yp2UP/CoCCom3Hk+pKUEqz3RPOOa/k92mmNDV4e7xLeLxAaDwnsSRA
         /okwjZ74kYjwrrdk+TUlDwO3SxmvpaEtXggRZH48meO3dzzmd2h3+PCdKqlXUcYtxJQI
         y+w+WcHpn/s8HxrNKxcPDbtQGTja/j24lRiPpWtZMx8eUWbawLRXigrpsMmldpcGLx5t
         oXsBaqgB3r59wr4jDS8Hy5H4Ym+EEu4uhjaKYumQPKAyds1E2GznjeXwbVunjF/ifbWs
         3PtS3GkcWMG0zlrz/rssQKtp07P8ITA3xynN/Pc4zDCIz88VYD3d8c2Sa3k0h9VvosMR
         X7Lw==
X-Gm-Message-State: APjAAAUtN08Q+xbrAwT/ALTZrXKBUHLlLNytO8Z3OzEJfUCfRL6OPeHO
        tzgs1I5q40YgTkXZQMVLh0cPQIwgLlhb2Vglz60=
X-Google-Smtp-Source: APXvYqz5Mq9hZxh5rsiNOSgBCrXmIx+0ScyAyLZvgUCXBgs46ZB4vd+jCeXlvOThB59ahS3qDB+kSXkqysn93864T7Q=
X-Received: by 2002:a5d:6681:: with SMTP id l1mr6825990wru.186.1553794930258;
 Thu, 28 Mar 2019 10:42:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190315101013.GN8455@Legion-PC.fortress> <CAK7LNATsm23e_CuyfFw7_CR8xZQ3HnwNHCXhEm_zQZU2PUGK5A@mail.gmail.com>
 <20190326172411.GA15936@Legion-PC.fortress> <20190327154025.GB23293@linux-8ccs>
In-Reply-To: <20190327154025.GB23293@linux-8ccs>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 28 Mar 2019 10:41:59 -0700
Message-ID: <CAKi4VA+14kihzGFbMT623BwMbZEzgYU6+jz8MpR9jqoC059oog@mail.gmail.com>
Subject: Re: [RESEND PATCH v1] moduleparam: Save information about built-in
 modules in separate file
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Alexey Gladkov <gladkov.alexey@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-api@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Gleb Fotengauer-Malinovskiy <glebfm@altlinux.org>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rusty Russell <rusty@rustcorp.com.au>,
        linux-modules <linux-modules@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 8:40 AM Jessica Yu <jeyu@kernel.org> wrote:
> >No. There are definitely not all modules. I have a builtin sha256_generic,
> >but I can't find him in the /sys/module.
>
> Yeah, you'll only find builtin modules under /sys/module/ if it has any module
> parameters, otherwise you won't find it there. As Masahiro already mentioned,
> if a builtin module has any parameters, they would be accessible under /sys/module/.

Could we please change that and add the sysfs entry regardless of
what's being discussed
here? Not having the entry there simply because we don't have
parameters for that module
always annoyed me.

Lucas De Marchi
