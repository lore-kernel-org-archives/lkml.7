Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43154C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14DF02070D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:41:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g2OjfgZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfCZRlg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:41:36 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:33336 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729440AbfCZRlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:41:36 -0400
Received: by mail-it1-f196.google.com with SMTP id v8so3396943itf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 10:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fGhk19C79D/Fglm4iu0pJ8zGZlge81gvybMyxqkh4bM=;
        b=g2OjfgZDxc7c9OVnGQTEjyOWL1PlA9/Hg/PkRqv7Qaitsf7bYV4uAtc77HW8Eoq8ZP
         /sxX0SM2mO3AHkkjSxwFXW+iznPbS8tFddy8xKVFRFbbJ4kC3W2oKr8jPjKvzhWLqKPc
         wUUybPbiQQPJnpar2Vktx4rO1mtvDJendl69p1LyZf5MOzvVMgsp75Mi3Q+GNfeGCizH
         Eg/Cr0COb1s7Xd1kl9AsQgj9QVAZ1832m5OISeu57m+9IbayN5oehJfsyW0+yxl8C206
         s1jEZQ3fS9SwdP1wdYRP03YB9BoJDER1hcBaAQxMj1r3tVsnnibMlBdXEBIz3a+4n3j1
         wLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGhk19C79D/Fglm4iu0pJ8zGZlge81gvybMyxqkh4bM=;
        b=PP2uIqEr9+awvyIouta0oc6AC10XRE67bqS8Z9TcExk+mhWVg1OaWyALqAk4wOJydI
         6hqilOoDitK5BNOZk3eSuIqfhB07GdeFaH6mPItkmiDacyq0mf9B2A3SbBf9SdnxS21v
         XPblrwfwe0/f2qRmmXPQ6h3HZLXzKJ3SQSIN+RzsfeaXf2bDKfvkBVzFlIX4tPuzBPVd
         KhZJ9/lG5LRI+PBcwlovR6tNIJ+5S7PcqXwIjGCdDLVA22qHu1hhfrAs0nYtxuX+NC9X
         5NTdMjfuA2gqEeh6IQTbXjBxlb0vBT7lHCelQwpQORHICYKBJ5U9nti5nRwXkLftoh2u
         cUPg==
X-Gm-Message-State: APjAAAWRkZlp6B1ZF7v6O2LeuKaxoCJ5x6vy5WpTUOKdhnPzq/2Z+Bka
        dcWdE1D3Rkm4x0vv7qyQifLtGQbe1WaBv+0qHhOPiTurS1k=
X-Google-Smtp-Source: APXvYqxZ8nUtnrd6l8PDKYYlll4qu+TvOgd5haqcbV1rVfk+1sqtpM7quLDq87/FwgqhEd9mEt7NGBIxK3dWBRVYqso=
X-Received: by 2002:a02:3d84:: with SMTP id n126mr17158071jan.102.1553622095064;
 Tue, 26 Mar 2019 10:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-23-matthewgarrett@google.com> <20190326212957.f5b518990c14cf21262bfdcc@kernel.org>
In-Reply-To: <20190326212957.f5b518990c14cf21262bfdcc@kernel.org>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 26 Mar 2019 10:41:23 -0700
Message-ID: <CACdnJuss=NmcxS0UoTeopYzipt53ba5GTBwQ+YtJQXLj7_Q10w@mail.gmail.com>
Subject: Re: [PATCH 22/27] Lock down kprobes
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 5:30 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Mon, 25 Mar 2019 15:09:49 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
>
> > From: David Howells <dhowells@redhat.com>
> >
> > Disallow the creation of kprobes when the kernel is locked down by
> > preventing their registration.  This prevents kprobes from being used to
> > access kernel memory, either to make modifications or to steal crypto data.
>
> Hmm, if you enforce signature check of modules, those modules
> should be allowed to use kprobes?
> I think we should introduce some kind of trust inheritance from
> signed (trusted) modules.

Is there any way to install a kprobe /without/ it coming from a
module? The presumption in lockdown mode is that module signing is
enforced, so I'll admit to not being entirely clear on why this patch
is needed in that case.
