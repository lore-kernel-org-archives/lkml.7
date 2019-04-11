Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51FDC10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92EFD2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 16:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555000314;
	bh=YJPWy3dln1rkRw1/ZV4vmOoPTSkh7453uXPO17J5UoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O3y0ez4ogOJgfjgo+acqjjmU8V9G3E9BgjeoXYAe7jsw3pEvmh/D4AwO7FOylhY4h
	 uamn3/0HITm24WEWboiVbjiam/pxvW26PnqrFS3FM+LisD/smfdE3TxlfMZSwvoJvD
	 EAwer80uZEWZj8rhzBWbLIiJA9kb/s0qkr+pzcjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfDKQbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 12:31:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40494 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbfDKQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 12:31:53 -0400
Received: by mail-lf1-f65.google.com with SMTP id a28so5201128lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCcoTX4LA8KS8bEnxZSQEThX2XzJhm+CUEnju1IZcJE=;
        b=dSxDuqKXO11vfHoLgMscdpgmSzxdUelG1gZPVBcGPVJIcPHTuKyAIDUFmyTPOAm5hM
         6rlxfnGo8omW/oCDwQ5ywL/Mj58VMIWixN5Z5EdOzEWYHVOtKLawg3KksgUSsoMxzKsZ
         LQpjGm3cbEu/osYjKoehbnG1lPUPqziMhw1XY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCcoTX4LA8KS8bEnxZSQEThX2XzJhm+CUEnju1IZcJE=;
        b=AM42JrXwwh0HZt1AfQWpjnvzgXyhDtMxi/FmkSOcg+UNB3W7tW291+cDGOdCs8Oduf
         rgzYdJQBKNs2SIKiB0tifyzYp1+OQLJdUvJEyNM8GXEcr408IDtX6iRW6rwaWcgDYRQA
         h3Cn+ijnUzaRmnh3taFbuaNabZa7Qdry4LvqVI672s1kBYGVWVraRg96NjpZhysQPGQV
         2xJ9auqGYaXNjQSQ0ybAhToVUIGwQQ37UJc8TLUeJcktB6I5iKb3KXEdgblICmVtZ+Ew
         yN2GAXBlxCDhcNIigER69Z03N2pSorHJJLfKwUYoLzup/Adx9Xn8AHA7uiYd43gtzXUB
         hzZg==
X-Gm-Message-State: APjAAAWfkjOaTIvDA79Yh8gxF/0kkCHi7LJFyKBslQfuLiy/STO6Ew0u
        Ip/vHUXgr+x0IutIUO0zGS5Do6f4NI8=
X-Google-Smtp-Source: APXvYqyXzCrw81/nn1Qp8BgoU33RyPLDkWMS5rUUFUAjgqoTKHvSiknl17a9iPwafFW7m2bVTwUmQQ==
X-Received: by 2002:ac2:59ce:: with SMTP id x14mr9676038lfn.69.1555000311025;
        Thu, 11 Apr 2019 09:31:51 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a17sm668719lfj.24.2019.04.11.09.31.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 09:31:50 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id j11so5218222lfm.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 09:31:50 -0700 (PDT)
X-Received: by 2002:ac2:44c3:: with SMTP id d3mr26089713lfm.14.1555000309362;
 Thu, 11 Apr 2019 09:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190410220301.2332-1-louis@kragniz.eu> <c8e4bd0958e7c58465a2535cb10b2ee994334045.camel@perches.com>
In-Reply-To: <c8e4bd0958e7c58465a2535cb10b2ee994334045.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Apr 2019 09:31:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com>
Message-ID: <CAHk-=wgoxnmsj8GEVFJSvTwdnWm8wVJthefNk2n6+4TC=20e0Q@mail.gmail.com>
Subject: Re: [PATCH] afs: use correct format characters
To:     Joe Perches <joe@perches.com>
Cc:     Louis Taylor <louis@kragniz.eu>,
        David Howells <dhowells@redhat.com>,
        linux-afs@lists.infradead.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2019 at 4:01 PM Joe Perches <joe@perches.com> wrote:
>
> I really think this clang message should be ignored.

Agreed.

> It's really unnecessary as every vararg argument smaller
> than int size is already promoted to int.

Exactly. It's a pointless warning, making for more complex code, and
making people remember esoteric printf format details that have no
reason for existing.

The "h" and "hh" things should never be used. The only reason for them
being used if if you have an "int", but you want to print it out as a
"char" (and honestly, that is a really bad reason, you'd be better off
just using a proper cast to make the code more obvious).

So if what you have a "char" (or unsigned char) you should always just
print it out as an "int", knowing that the compiler already did the
proper type conversion.

                             Linus
