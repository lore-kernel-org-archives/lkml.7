Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AF5C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA132082C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 07:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rLNYb7ev"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbfFRHjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 03:39:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44703 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 03:39:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so11992426ljc.11
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 00:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tRX0G9tlBQsjku3tZENDJhsv+P6TNGsiwcvysnjW0hg=;
        b=rLNYb7evXLxlMU81yvH6qfN0LrIGI9RFVJq/+9NJ80GDshTJhbKFG4kX7SUI4JF+nM
         SjtDxEZZzwcJU+Tsrk7OzpLa6ZdiC7t2FvzrJw5L9CURfj0SE/rANJH44Gl2oPy9sdk6
         +BAXXbejf0h9kJf9V+rssiEuLExEqpntLiYcr5NoqAP8Hn//W7AUyoc9oJt5y2rxm5nO
         0A/197TtS9mlvXEodm1ZcaqrLJIENX5lgV6YAd0RlvAqSb3bUogb3oRcpascNV4yE+PZ
         kKoSx995fazxSsmgB6oHFslGAe+OYZT70NfOxi4vyrno1rBV0a/OXZRCHI/2t6+nvOWm
         0r2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tRX0G9tlBQsjku3tZENDJhsv+P6TNGsiwcvysnjW0hg=;
        b=UGpdIW1weJguOY4HXs0wigP+dXQw4HeMbfjoapx2/9Cz3gwxksvrY2SstYLIOcSpX6
         OByObaV49is9asnk8eCVMi+p/ur/Y6mELudjcKcr1T2DHo/owCbhWMvARYZsUeLLUHbd
         i31r+TjK7F3HgQ+CT7I7wNb07d0W1uX+3VjoSpyRTxYEVvmV+xeMoh382vqwLHcM3zs/
         mM0hi73BShiVnxNlfcQlSJpUKJ0S0n1U02fb2tPRNbixS4UMGlENCLuZB7iejDANqT0H
         y27fN6TlG1y7LZI02YHOBWCReg0R5SRYO9ndB+u4OFSaABevW8ZVGzLJDk4VwUcft8R2
         C5Ww==
X-Gm-Message-State: APjAAAULWkXA/gJj6aNRUHruA7MwubLG3uzkH7sIoyfC9Ymv3XcinG6Q
        YSg6CKc8ip49aBvnJqyX9jSPyJ69YEmeHbHfCH+pfQ==
X-Google-Smtp-Source: APXvYqyZE8EqEx/xmYcLpIOSRy1F6u+RHTKQ8684iqe3UbdIPIlYBKj9R7Dw5YkFZmJKic+1cRfhd66PYrWsrQdcBUQ=
X-Received: by 2002:a2e:8495:: with SMTP id b21mr20733212ljh.149.1560843591554;
 Tue, 18 Jun 2019 00:39:51 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYsr_YW7PSoP+ew60TfNOj885y6j-e2weuWBuU1ccKcAAg@mail.gmail.com>
In-Reply-To: <CA+G9fYsr_YW7PSoP+ew60TfNOj885y6j-e2weuWBuU1ccKcAAg@mail.gmail.com>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 18 Jun 2019 13:09:40 +0530
Message-ID: <CA+G9fYvEK4F8PbvjeRK3+6WeEFXExQpQ3MS2CE2gD6phV+Q5dg@mail.gmail.com>
Subject: Re: kernel/workqueue.c:3030 __flush_work+0x2c2/0x2d0
To:     Hillf Danton <hdanton@sina.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sgarzare@redhat.com,
        Daniel Borkmann <daniel@iogearbox.net>, kafai@fb.com,
        jakub@cloudflare.com, lkft-triage@lists.linaro.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hillf,

On Tue, 18 Jun 2019 at 09:40, Hillf Danton <hdanton@sina.com> wrote:
>
>
> Hello
>
> On Sun, 16 Jun 2019 19:30:27 -0700 (PDT) Naresh Kamboju wrote:
> > Kernel warning while running kernel selftest bpf test_sockmap test case on
> > x86_64 and arm64.
> > The kernel warning log pops up continuously.
> >
> > Linux version 5.1.10-rc2
> >
> > Steps to reproduce:
> > Boot stable rc 5.1.10-rc2 kernel on x86_64 or arm64
> > cd selftests/bpf
> > ./test_sockmap
> >
> > [   37.600406] WARNING: CPU: 3 PID: 57 at /usr/src/kernel/kernel/workqueue.c:3030 __flush_work+0x2c2/0x2d0
...
> >
> >
> Only find this; wish it may be paving a brick perhaps for those looking to fix the
> 3030 warning.
>
>
> Hillf


Thanks for looking into this problem,
There is a recent patch fixed this problem on 5.1.12 stable rc branch today
and AUTOSEL on current stable review.

bpf: sockmap, only stop/flush strp if it was enabled at some point

link: https://lore.kernel.org/lkml/20190604232212.6753-12-sashal@kernel.org/

Best regards
Naresh Kamboju
