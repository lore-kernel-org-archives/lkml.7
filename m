Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76ACECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B90A4206BB
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 15:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSNQSZgT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731544AbfJIP4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 11:56:43 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39589 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbfJIP4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 11:56:43 -0400
Received: by mail-lj1-f193.google.com with SMTP id y3so3031425ljj.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2019 08:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFlHeCQkLJIGXl9Y3KrukrQID/Wna2DJQv+XBSRue9Y=;
        b=XSNQSZgTy/3vmdQhLFPTjXXYD6ObdqSRS6amglcHznGRfnkPseJTLpqG9mOCmXl20O
         yIHDn/sAzQOKTJcW92jhNrq38uA1AW8FAVMp/p+RDlfrBN4jSNPVGjVxOBCnDbl/9fqj
         QjQNcNQbugzH3odS4wlSIae/lZolrXDPU0cZgOqJvTvBAKVVPfzbZvyNNTEiRf6lTwwU
         E8jvNcw8MbQjm91OZL4ozM0rTDsPxu0yEFfUSHLkFsc8VwjVv5uY2+mcMpXAeidrfPSi
         ckhYDlIvrUpEaplYaM3oIpnshhIrYknkLUi3TStf4taJX64c439wzauU2hee+gtVbzf/
         Itxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFlHeCQkLJIGXl9Y3KrukrQID/Wna2DJQv+XBSRue9Y=;
        b=bJInqtD0Xo080viSuzXZ0A7u0VB42KCZ0xphTIhNcgmt3LynXlSpE6LcPFWDFqskIC
         SRUbFP1FskuOlIdshiBfTGmb9sJG1RENca30MMgAJadCEESrj9Pkwr1SU1smqBStxH6+
         03WpcvS4LoClxqlgkn3VhB9xfVEnovXeBPIYlKjyj6cbYgTWi3cY9JGrakcIEvXaDLAc
         XahOaKiQWyB+7oQlT3KMWgmese+3ukwEQnGv6Rai6RrpIOaO8CNWAOp6LxYFBzK7W8zK
         JFf2TIcwyVjH+IE4rj/iVwVU4Fh3B5rAqzagiaJYt54sxq0+d5tmBr8Ls5HscC4BbyD6
         yNlQ==
X-Gm-Message-State: APjAAAU1lPPq8ZNHXi1XHp9/OhaPdsiiwuQZt25otkO7Jt2uwBihMjzZ
        famrlytng1pEoqAXK9g/TdyzXmpZCxawBEZkvCw0Aw==
X-Google-Smtp-Source: APXvYqwLxpC/TiGljRX1NvHEZ/6aqwkZ3/aGIm6AEuP60itEXeqeP/1veKDYHWpVrchgY89b5qCCjN0JGRYZm6lQc50=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr2924621ljc.186.1570636599381;
 Wed, 09 Oct 2019 08:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez14Q0-F8LqsvcNbyR2o6gPW8SHXsm4u5jmD9MpsteM2Tw@mail.gmail.com>
 <20191008130159.10161-1-christian.brauner@ubuntu.com> <20191008180516.GB143258@google.com>
 <20191009104011.rzfdvq7otkkj533m@wittgenstein>
In-Reply-To: <20191009104011.rzfdvq7otkkj533m@wittgenstein>
From:   Todd Kjos <tkjos@google.com>
Date:   Wed, 9 Oct 2019 08:56:28 -0700
Message-ID: <CAHRSSExAL3fQMP9x9p34qF8dnFKLSp7EzhZ7Y5y-qbzExCRo1w@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent UAF read in print_binder_transaction_log_entry()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@android.com>, Jann Horn <jannh@google.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        Hridya Valsaraju <hridya@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 9, 2019 at 3:40 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> On Tue, Oct 08, 2019 at 02:05:16PM -0400, Joel Fernandes wrote:
> > On Tue, Oct 08, 2019 at 03:01:59PM +0200, Christian Brauner wrote:

[...]

> >
> > One more thought, this can be made dependent on CONFIG_BINDERFS since regular
> > binder devices cannot be unregistered AFAICS and as Jann said, the problem is
> > BINDERFS specific. That way we avoid the memcpy for _every_ transaction.
> > These can be thundering when Android starts up.
>
> Unless Todd sees this as a real performance problem I'm weary to
> introduce additional checking and record a pointer for non-binderfs and
> a memcpy() for binderfs devices. :)
>

I don't see this as a real problem. In practice, memcpy will be moving
< 10 bytes. Also, by the time this code is in an android device,
CONFIG_BINDERFS will always be enabled since this is how we are
removing binder's use of debugfs. So a micro-optimization of the
!BINDERFS case will not be meaningful.

[...]
