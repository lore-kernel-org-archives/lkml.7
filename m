Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE6C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3704F21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 21:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558647293;
	bh=e+c+pBKntl8VU1ZFYyZU4/8RVEW0+PnaaGvBjF5l/QM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=j6tpMYZQBavvUbipusvuq3Xx9kx9ER+FwkC4dxgB52sfWZHxNeQKg3S9Sy5aksjKA
	 ABrEJFaLAi39qQN3ySSR8HIZzXM9beX4AQ9Ub4v6htgb06CboNNqqVxiev+Httk/q4
	 GQFUe+H0B030VmE2+qnfmsOu1QkaqGlnlnv9fEvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388123AbfEWVew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 17:34:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43800 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387894AbfEWVev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 17:34:51 -0400
Received: by mail-lj1-f196.google.com with SMTP id z5so6823578lji.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jsp+xqBh3VOcvBT5H96/8E3FdbJHIyc5xxFW2dfP/m4=;
        b=dF/oF44gx9ScO79G+tsbRedT9Qx7Ab9VCyHwdrwLsKk3zJSxTaQBKRXHQ8Nc2fad2k
         0ejthuD+IVzTB9jnA6YnDhUn4oLApqa8MWbLQeI4oH2boDNSZBn/29NIcA0MO7emST+w
         uSAj0wFFuRSP8TpzfsclarSH7UZAqicwGdbk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jsp+xqBh3VOcvBT5H96/8E3FdbJHIyc5xxFW2dfP/m4=;
        b=hZKf8kP7lykchbc2mdn6dr7KTCGIIjOgJYNHnu7daQmpX7FFBhChWGeSg1Pv1sfVa9
         ryo9WMVWS3uTwQUZubxolvTmRNjgVpVzq3tc97z//p776Hh1X0IaJAXJSPgj4m0WE8ay
         ChVZK4Wh0+urdpEGpohxlLeFGRi3SpsOTy9sbWNFa4Y0HpE3AODyqEeLypl6nWXEnKh6
         +u+fYQzr8ZRBlHAkR7hL1u+u8uvQxpcsAF4SQM6pOhDJc2rISKAV15kOLSIlM5nHacxa
         B1jPqmtBzce92gNmj9qwQ1pZYxSc5riLL3SUwfFz+VgSGfYce3wAXdG75I2Zz9ALt/nS
         b7Tw==
X-Gm-Message-State: APjAAAWu1rOpdMeDWrDNuBChyWJRwt/eyetK9YZnZlcCHyCyJS5iTR7k
        aLjApQ0d1vzhhkdJ2WxEHSanwaPniUg=
X-Google-Smtp-Source: APXvYqwzfnweha4YwCNKK5XWKmIYIyq1ge10UdY8rySLUWXhqlmn2YQAKzx4o0r2Ao+pzZmFtEJxBw==
X-Received: by 2002:a2e:a294:: with SMTP id k20mr13539058lja.118.1558647288776;
        Thu, 23 May 2019 14:34:48 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id o7sm146310lfl.13.2019.05.23.14.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 May 2019 14:34:47 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n134so5456590lfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 14:34:47 -0700 (PDT)
X-Received: by 2002:ac2:518e:: with SMTP id u14mr11079489lfi.120.1558647287406;
 Thu, 23 May 2019 14:34:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190523182152.GA6875@avx2>
In-Reply-To: <20190523182152.GA6875@avx2>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 May 2019 14:34:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
Message-ID: <CAHk-=wj5YZQ=ox+T1kc4RWp3KP+4VvXzvr8vOBbqcht6cOXufw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] close_range()
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 11:22 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> > This is v2 of this patchset.
>
> We've sent fdmap(2) back in the day:

Well, if the main point of the exercise is performance, then fdmap()
is clearly inferior.

Sadly, with all the HW security mitigation, system calls are no longer cheap.

Would there ever be any other reason to traverse unknown open files
than to close them?

                   Linus
