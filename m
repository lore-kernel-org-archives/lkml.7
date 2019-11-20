Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E64C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07AD3223CA
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 01:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dCsxQGhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKTBOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 20:14:34 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33945 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfKTBOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 20:14:33 -0500
Received: by mail-pg1-f196.google.com with SMTP id z188so12479560pgb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2019 17:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XNg1tjP9INvmM/DeIAYa5hYUQZyQDSSg86vYo3TV7Ho=;
        b=dCsxQGhHkmzl0ml2pIeI752b4HtkmyA3ByI5TXA2lfq2sPe5YuX64IxdaxlSeJvBuV
         kJ6EnIRwzhwSfJvpkLNQRsmmQE2fm9FqizwJ4xHIjocMniRI3cXYKdwtD+bRfX5HTGYs
         De6B8bN45rbuhaRT3sau60ZO+OLcv8t39NXwOOw7DAA4V6iW7QcASdhZfpoSqqOlK+dT
         3eintlSrtwCHFK81GtH2KY50K6dzw0ZmyjuwdjBfCd0Ha4e0+WR7BvQcFRY7Te+Qx1XJ
         c1IVDQ5xqvETFTC7+BwVQ68dETVNW/DhzUKHCGLD+tnMkTTd74yNJt35d1tZr6sLaA3w
         Zoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XNg1tjP9INvmM/DeIAYa5hYUQZyQDSSg86vYo3TV7Ho=;
        b=KBlVAefn8vfN9CfLiWK851/3jf1KpqJAYpipvSk60XoNkX5gY/NYfwkqJRslUcWt4G
         Pdy3qcN+tdLASk25VG8m11rgiHREXTdWAFZPsIhCzgt+G8frkcApTMS1qlcAZdfeNsIX
         vpBL2tiVECUakIord53pgVNvZknxNLTLA37dQAwlOeaKiko4GyECLjyRNnfoQetTBLkO
         uK02cuKozl1+7QvWNGaXo5TL0ZbmYAXvMnDDQZI5IJbQqut+fCIUazDF8h7ebLoMxScG
         yjIcZkRTnR1vkPbaL2wpb17PhSSUdSQ4ooCaowX3I3FLXE67vi8Jx1kssk7ZlrsFHjKx
         tcJQ==
X-Gm-Message-State: APjAAAXJcrKJcJlAeHZ06A3DTair/JC2bc+lhjsGfLYiFnMJfGeuXz9c
        Nfrd/p0CNkHdULy57utrVXBszon9NZb974BmTIRqDQ==
X-Google-Smtp-Source: APXvYqxAkXh/yc2VcsZRwT1JGfFXlfbvmuoJtajYbRBOUk8rZUaOu5y1Dveu5HQDIG/KqwFiiTzNCFJIVyw3PhzaCGs=
X-Received: by 2002:a63:5163:: with SMTP id r35mr96501pgl.201.1574212471139;
 Tue, 19 Nov 2019 17:14:31 -0800 (PST)
MIME-Version: 1.0
References: <20191119003120.154041-1-brendanhiggins@google.com> <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org>
In-Reply-To: <4a3aada5-fe8f-9c82-dfd4-0494acf59334@infradead.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Nov 2019 17:14:20 -0800
Message-ID: <CAFd5g47+3TN4pOdeM0YmJpMP2uKnpJYUY_OXmqmZEn8OcVz6ow@mail.gmail.com>
Subject: Re: [PATCH linux-kselftest/test v3] Documentation: kunit: add
 documentation for kunit_tool
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     shuah <shuah@kernel.org>, David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 19, 2019 at 4:27 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 11/18/19 4:31 PM, Brendan Higgins wrote:
> > +How do I use kunit_tool?
> > +=================================
>
> Hi,
> I haven't tested this, but Sphinx (or some doc tool) usually complains if the
> underline length is not the same as the header text length.  (I.e., use fewer
> = signs above.)

Hmmm...Sphinx and checkpatch didn't complain. I wonder if it is a
different script, or maybe I have to use a particular option with
Sphinx.

In any case, thanks for catching this!

> > +
> > +If a kunitconfig is present at the root directory, all you have to do is:
> > +
> > +.. code-block:: bash
> > +
> > +     ./tools/testing/kunit/kunit.py run
