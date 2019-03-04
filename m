Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1087C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A76220823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 22:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HQzDnWK8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfCDW2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:28:18 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43743 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbfCDW2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 17:28:17 -0500
Received: by mail-oi1-f196.google.com with SMTP id i8so5215419oib.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 14:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Luf7+ev9jaFNEQGCAqiotJcyfrpRzjnbA9SqVIIqKkI=;
        b=HQzDnWK8fklexGL2gVGlxDPhGv1VmtP/AUDExHtR94xJDgPSMXLvkgpH8hNGPPv9lT
         KrnryKfrszLiUuY3IB1WfEfdoKxmUBofuVn99G4eZrO8SGJUsEfnNBlyra9ozLlwDyyH
         e15oIjPe22ETVjMTvYcQOYoHUW7ehPSlFt9GWQwBSG5RLjtxYVNyvUVDS+4MCDPMIGCr
         1UdVD7ZKeJ7EiK5JoPDejwaE4GbLqSl8Jmt9cOpHXIqlp4gwEDQ9Z5xbUY5gm0siEegU
         kLruoyEpOm11heSeO6HuhR+Gy+y0oaaHcbf8uH/WPzYnJ2PfE/xPD/le3+fXWwHVUs4m
         85Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Luf7+ev9jaFNEQGCAqiotJcyfrpRzjnbA9SqVIIqKkI=;
        b=D/05FLip3/AcdaJLQNr0c1LiLh4DEsEWjQTjeerpDHOsmUcK9ZKro88mNxkO8wdNKl
         kGvg+qeLNd2rTyZ28jWYO6CViy03VoVLycDj95XRIVYDO9mvvwQTwn8jLgAIkbnR7BeT
         turBwr/4Lnuo792db7Qg9zfcfUxekk0Cbsmv9qqeZXfGmFs1YulwZDxf1JAdYvtdXpLU
         V+1PNLVXuAU6LzC0Kk6t63EB8A+HVC5GfjPWRznH7okCnpJRaLLMYLmwNixabh/R34n3
         DmOhU1Uhk0OsjWmWr3P5ZEfyUwW8bkr5dx5GZp5wrjM6uSyX4kMLo3t0TT43qWNnxrPd
         zb0g==
X-Gm-Message-State: AHQUAubZCnKRUunQw13/9uRfksp0/1e/5HyYlwFSA+X/avde3Srw+GJ/
        +WoDGD4NEIdcLAGQNvXfxwjjhskgOvT4Gh9bIDXAEA==
X-Google-Smtp-Source: APXvYqwIG2jmn76687NQF0kiA2oGAHg2VS3OksDMnIe5zVykxXY0m+RpDKamk2xGt2Hr7HWqOSc8WtJ6cc32/IKz6Is=
X-Received: by 2002:aca:56ca:: with SMTP id k193mr13737402oib.59.1551738496317;
 Mon, 04 Mar 2019 14:28:16 -0800 (PST)
MIME-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
 <20190214213729.21702-9-brendanhiggins@google.com> <155121334527.260864.5324117081460979741@swboyd.mtv.corp.google.com>
 <CAFd5g46QCisA4PHQXo57-LC6sNdk=OUjBE0O1s4005uBz_Vo6Q@mail.gmail.com> <20190228135403.GD9806@kadam>
In-Reply-To: <20190228135403.GD9806@kadam>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 4 Mar 2019 14:28:05 -0800
Message-ID: <CAFd5g46iqZ6+r9BUzPLSrEmomJQfei=Bb0CH1Tb2ZDr3f1s0jQ@mail.gmail.com>
Subject: Re: [RFC v4 08/17] kunit: test: add support for test abort
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Kees Cook <keescook@google.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Rob Herring <robh@kernel.org>, shuah@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>, brakmo@fb.com,
        Steven Rostedt <rostedt@goodmis.org>,
        "Bird, Timothy" <Tim.Bird@sony.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        linux-um@lists.infradead.org, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Knut Omang <knut.omang@oracle.com>,
        devicetree <devicetree@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        Amir Goldstein <amir73il@gmail.com>, wfg@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 5:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Thu, Feb 28, 2019 at 01:03:24AM -0800, Brendan Higgins wrote:
> > you could do:
> >
> > if (IS_ERR_OR_NULL(ptr)) {
> >         KUNIT_FAIL(test, "ptr is an errno or null: %ld", ptr);
> >         return;
> > }
>
> It's best to not mix error pointers and NULL but when we do mix them,
> it means that NULL is a special kind of success.  Like we try to load
> a feature and we get back:
>
>     valid pointer <-- success
>     null          <-- feature is disabled.  not an error.
>     error pointer <-- feature is broken.  fail.

Thanks for pointing that out! Will fix.
