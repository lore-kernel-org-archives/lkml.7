Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA9EC004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6E0D20656
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 20:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557261207;
	bh=x0o38Rvxc6JNcjz0kbM39sSF2a0p/3Lhnk+wdw7FL5w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2fB9RR9pzMf3RQKX3Ru11YYVQp8PcTL8x+n4G6GWBeWjdb8MpBZv3+T5oYmhcYzlw
	 sOHAKOBy7bCuRBLhyVgemQvg56szxRFZtTeJ1ZjNHli9dAb1QrhnR1suxYxvhRUlHt
	 lL2rOlaHOFjptkZ9TZfZOxlk+gRJaQ9AeJqgf+Rc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbfEGUd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 16:33:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38493 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfEGUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 16:33:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id y19so5261948lfy.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwOWrdjQnMEu1uy7KkVWTLmIn/O6jKGpZOEzU4R6ZiQ=;
        b=V+ldPyFPJsh0EzBs7Q5P6t6eRuhwd2Ek6kLnmwqNlQOn8NUqVWxfGfhPQQqq4J/djQ
         A7C8uCUMIFAoLahIHJIACf5KgxJDeC4GCUvtrKUfbQbUOQ721S3SuX+KLBiRwSK2uP57
         oZvvllEFipC7USVFAHRebaOzsml54iB4snRdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwOWrdjQnMEu1uy7KkVWTLmIn/O6jKGpZOEzU4R6ZiQ=;
        b=hgnyO6odUG7/UECzb7jD/1i9t9sQeJAXpBTN8bkbKpWd40+CTozjdwAlNaa4/9vHLg
         HfBcgqs4cb5ztcqxg+rU5WY/oOZipm0EFkH6o04133ntV1gfK7JRQOSWZeXYycsiK+/W
         skWr4ipnveqGXXr+ULzCXRwFVaIj2EyrgK3QugGX4uLxdbnRFtBAahQ2C7/psaaW7IAW
         XnavUO235TIWJ6WuRYmC9NE1EzLix3usIu+bDkJ9GvNJVDHNxvWk6W4n9C9ZKsV3FjfS
         7SQgKmTyiFc8GsyCILpcQQMVU8v0gr13fBeOgjAsp59m7DUwSYXuUc0tR/xfoh+BrWCl
         qYbw==
X-Gm-Message-State: APjAAAV8i/PXcCm4AeviZigMIt2TEw1iI0RH6S3min3kiphAfehsiYPo
        zIcQ1N+WWBfLd2/eFdkXIE4pX09imvU=
X-Google-Smtp-Source: APXvYqx35cJaPm3HUqSot/psMDAVQsyyFV9rYDdEWXN1IKScGD+RVfsPxwo1FE1HjS/R6Gho0hiHaA==
X-Received: by 2002:a19:ec07:: with SMTP id b7mr11977781lfa.62.1557261203953;
        Tue, 07 May 2019 13:33:23 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s16sm3330039lji.61.2019.05.07.13.33.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 13:33:23 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id n22so5294519lfe.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 13:33:22 -0700 (PDT)
X-Received: by 2002:a19:ec07:: with SMTP id b7mr11977699lfa.62.1557261202165;
 Tue, 07 May 2019 13:33:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190507175853.GA11568@kroah.com>
In-Reply-To: <20190507175853.GA11568@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 May 2019 13:33:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg+w5+vAo1DQrprSG8APptZ5-Kek4NL_mnr9p08vFyQrg@mail.gmail.com>
Message-ID: <CAHk-=wg+w5+vAo1DQrprSG8APptZ5-Kek4NL_mnr9p08vFyQrg@mail.gmail.com>
Subject: Re: [GIT PULL] Staging/IIO driver patches for 5.2-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        devel@linuxdriverproject.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 7, 2019 at 10:59 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> All of these have been in linux-next for a while with no reported
> issues, other than an odd gcc warning for one of the new drivers that
> should be fixed up soon.

Ok, that's truly a funky warning.

But since I don't deal well with warnings, particularly during the
merge window, I just fixed it up in the merge.

The fix is to simply not have a bitfield base type of "unsigned char",
and have it cross a char boundary. Instead the base type should just
be "unsigned int".

Of course, I couldn't test my change, but it shuts the compiler up,
and it very much looks like the right thing.

                Linus
