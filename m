Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982C5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6695E2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 20:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="fccWifxu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbfC0Uzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 16:55:42 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44562 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbfC0Uzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 16:55:42 -0400
Received: by mail-ed1-f65.google.com with SMTP id x10so15255317edh.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 13:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UI7XT2SO91dh/DnPrNX1cqD9ewNmS2q+vEBrSQ8zO8I=;
        b=fccWifxubnP9KpMTgZidwHWmG7XEEzpPmpuMLMTpOsTN7VOaQhsNxhNs50AxVjt5tc
         cxnd8f22zorsgDilgWdK+jYUDTmUD4N9lkSQJu48Z3F1om0lC3LXxigpiRo23Mh6ug3Y
         MffmTV025Pnh00DMWjsd2W2WNaIENocnuui+DWwUsF9je50B4O4lbJ+TVPVvlTqrDhGV
         F2ceL7JuutO8SxGW56dXep7/PXmh03zYPRbhJJn3jZ9kvhpAoIozzb6+0JYh5t8PYttZ
         Ch+bhBFOLhvZ49AK9zQZxeRftftxtSCzRKM9eHdNEBvBOqXxIYTZGwM5wJGnmlVPjkZP
         CxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UI7XT2SO91dh/DnPrNX1cqD9ewNmS2q+vEBrSQ8zO8I=;
        b=IBasSKmHDz6sv1XCOm69+FlIXGGlNeT4VTEsLLDvsBjhBfp+wu91DvTOQSV/d8l0fz
         O/0RDAUZh2hDBV5Ed2DXEh2NrSZbn+CQItVQHJPH6iaOWF5azK5rERK4rID9ImSJXltU
         msbfHlma5IxesxJwO+77Dq20oOr+NeBHDWkPIoU8hB5Nd6Xyr8KvSMwOoD1K63bso2pP
         r2LhTlWOXW3/uaf63Z6p48air4z0el4v2ODXUzkPdPT9UKr8dCOVbZ/8Tt+QCMzuVO+H
         go7PhBKrGLoe0OxpSkkyNUwXeoliukz/CLf9buDtPiDtNYEq8GhfPI25puYl08NFM7zO
         ob1w==
X-Gm-Message-State: APjAAAWCe2HQNAGbVFObiHNKd7A5qFhH6iWgB3Cp4QlJotqfFpbZBftV
        G/CvFQaVwEtcIvz2DdPX4bNNKg==
X-Google-Smtp-Source: APXvYqzg1sWCnuIgx5u/GsaZ67lb6wds88EZqNaQSp1dllug8DyFio+5H4jai5xhjYPJQ8HfguGvwQ==
X-Received: by 2002:a50:9ea8:: with SMTP id a37mr25463256edf.147.1553720140081;
        Wed, 27 Mar 2019 13:55:40 -0700 (PDT)
Received: from brauner.io ([2a02:8109:b6bf:d24a:b136:35b0:7c8c:280a])
        by smtp.gmail.com with ESMTPSA id d14sm1814394edn.6.2019.03.27.13.55.38
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 27 Mar 2019 13:55:39 -0700 (PDT)
Date:   Wed, 27 Mar 2019 21:55:38 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Andy Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>, bl0pbl33p@gmail.com,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        nagarathnam.muthusamy@oracle.com, Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Colascione <dancol@google.com>
Subject: Re: [PATCH 4/4] tests: add pidfd_open() tests
Message-ID: <20190327205536.xa47wrwgwfqqnocg@brauner.io>
References: <20190327162147.23198-1-christian@brauner.io>
 <20190327162147.23198-5-christian@brauner.io>
 <CAGXu5jL-3XbFzT-1qzEiXE+DTPi_xi7dEtyAMTwBJU0BqrFeKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jL-3XbFzT-1qzEiXE+DTPi_xi7dEtyAMTwBJU0BqrFeKQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 12:36:46PM -0700, Kees Cook wrote:
> On Wed, Mar 27, 2019 at 9:22 AM Christian Brauner <christian@brauner.io> wrote:
> >
> > This adds a simple test case for pidfd_open().
> 
> Thank you for the tests. :) It might be nice to see more extensive
> negative testing -- making sure pids aren't reachable from mismatched

There'll be more tests for sure! Once people say that they are happy
with the design I can put in the effort to expand the tests to more
elaborate scenarios. :)

> pid namespaces, etc, but this gets us basic regression testing. Also,
> you might save some copy/paste code using kselftest_harness.h's
> interfaces.
> 
> -- 
> Kees Cook
