Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC97C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67F242081B
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 15:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569686060;
	bh=8OtagyjgKuanIX+fZ9vW1EwyIcimDCJ40sf2gaKDTJs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sbpz44POKcB/ADqvdvFU+1Fc4HvTnWZkska5fi2dFdwQxEGKMWNgdbxnpPewsVmgv
	 j6zGYy9/ciVhzOzheDq3TRNkGs6NUpfMw5hYj2GqoCp9nk+DrNmD7FdFBWzEuAfpJ2
	 a+amUgxohq94wUJN5GdMVJSUiWTbeyQmccJRauBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbfI1PyT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 11:54:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33109 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbfI1PyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 11:54:19 -0400
Received: by mail-lf1-f65.google.com with SMTP id y127so4064002lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8T238MUDL4113LkTajENXs+VpX+RgbW801Zuroll2s=;
        b=gymVBvAsRB2Ub4vGq1nY66bYrZvJ5qgn5kJMlZ4CPZkZXu97A8ex9TnljNZlH3BnpL
         98xBkSkyGma49sQaAHQPjVoft2weY/moz59SqB+u2zOEVMNBau7Ylt7BtHvDjyMNUom3
         2jccrp6mN+X3TEontHNfMcPG1DL40IAEM3byk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8T238MUDL4113LkTajENXs+VpX+RgbW801Zuroll2s=;
        b=jE3m1AtuLF4TlWglakvUDCAWczYCfnkCIh5JyRRBakOJOOzl69YFg91f/Bs+RzkMp1
         hzv15DbJLy8U1IWtAKOKr1NF1I/RyLtwIIhpWwfQ6USr41vDsIeOFLqoE0a6q7G6Ioje
         TQus+C7OqndQRFA4zK8kJpfAsWR0hm005O85Y+GcyFnWl4joKp6YMj/vcnxqLwnZ7D9t
         HZ7JlDNPlDZ/9s6ib9GC23bfjIWaK0D6Cj3cVlMaEDFi8JT7PdqyyY6tU1gfy51hfS20
         IqOls4hfBikFKBOZ6YWIm+S1zehZk3Qp6ExwKjcU2bLXPdCCqFDKZV0s6SWTO63gME5w
         QkNw==
X-Gm-Message-State: APjAAAVj5sr0dDXnTOED8e0htiKjqqdT4lWZHLHtJyv9b6pofUyAzKbL
        kyhU4MYxUId/nuCx60uiKxBkn0YHRbw=
X-Google-Smtp-Source: APXvYqxtqRqzzI6nk5d1/HhAAGLqxSYPPfzzlywEmh/oVO3s/BetxAgvwwDmWkhdnbLeWHsC9c4a5g==
X-Received: by 2002:ac2:5504:: with SMTP id j4mr6515814lfk.186.1569686056848;
        Sat, 28 Sep 2019 08:54:16 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id b10sm1380533lji.48.2019.09.28.08.54.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Sep 2019 08:54:15 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q64so5279070ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 08:54:14 -0700 (PDT)
X-Received: by 2002:a2e:3e07:: with SMTP id l7mr6544992lja.180.1569686054663;
 Sat, 28 Sep 2019 08:54:14 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LRH.2.21.1909101402230.20291@namei.org>
 <nycvar.YEU.7.76.1909251652360.15418@gjva.wvxbf.pm> <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
In-Reply-To: <CAHk-=wjYz8UQkzBX_1h3cqzDHKEWwyXjnbCoHYWnjn=9RPVOeg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 28 Sep 2019 08:53:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=7y82dJYeLzQeup70CHBT7MpCC155d85cPFctNsxUYA@mail.gmail.com>
Message-ID: <CAHk-=wg=7y82dJYeLzQeup70CHBT7MpCC155d85cPFctNsxUYA@mail.gmail.com>
Subject: Re: [GIT PULL][SECURITY] Kernel lockdown patches for v5.4
To:     Jiri Kosina <jikos@kernel.org>
Cc:     James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 11:19 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> This is one of the pull requests that I have to go through commit by
> commit because of the history of this thing.
>
> And I've yet to empty my queue of all the _regular_ things that came
> in this merge window, so I haven't had time.

I've emptied my queue (well, in the meantime I got new pull requests,
but what else is new..) and went through the security pulls yesterday
and this morning, and found nothing objectionable.

So it's merged now.

                Linus
