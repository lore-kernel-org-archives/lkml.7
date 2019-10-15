Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC991C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B77121835
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 05:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gImz5ixe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbfJOFI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 01:08:59 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43460 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728156AbfJOFI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 01:08:59 -0400
Received: by mail-yw1-f67.google.com with SMTP id q7so6889057ywe.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 22:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6t9RMGHc/zO7LCeOmHD7XR3AZ36qNLpZlad/3/Z52E=;
        b=gImz5ixetP5a1/XCuyRvVC57azoCau3LhWfW90lMeWH+kidkAgUDL7Q/Bj1LJMHQAm
         KwL78FnQ4MgNvuTxWLeG5AEueSM7pVPnrMXV3vNok3qgWGzxkYwSbf7HT5qkT0ovJ999
         6XgCpq5zOoTMOTzhA8lWz5N8QwSfo0WXsf9ZIlkcZgNW3hgg72eHWRXW9ql4u9Frms6c
         ZzGJK8KeKlkRGTfkcxGzwmmaKooEEFZj6Njm+1qI1oHiV3hCvZ9F4+URj2yBVlaJJl3o
         yWfbVh7INl9P+x5Qt/K/KbF8Qp38VYiC1BMcqMy6IrC8ySDcKJnhartsscPR8uzKO24t
         BxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6t9RMGHc/zO7LCeOmHD7XR3AZ36qNLpZlad/3/Z52E=;
        b=BPld4q2vN+WWoM69KS93KSb+fyDBEmvugCqPlmaCAUKTz8AKpoOcsVVSNR7/dts5c+
         3ttf+WgrV3BvfEm+UEUwtipnwwdP0NbTpqHiXLtF3UyqMvHzYnmyFJrYTqA5JJCa+i/8
         EpBa+VCMLv9lXIqSOrrQt43BhKmh1Pr7dTrFwMkTIw3zZC7BD3UqmtzLxmRH08xOj7lt
         joR9gmfP9nG+S3s8GjxzOEO4cSWtM0H/C+vPQ6nWTYTyupvaFOVaJdBgkrhH4Xs9wWxW
         FQLRXLaAlAc4it6y0APbgLGK0szrdotOYijyjspxuKmwT878FLrR8O3xUZfO6jBN+V4B
         rQMQ==
X-Gm-Message-State: APjAAAXAK1XjqReJeKbqgnksSzxvYayfC/W38Sc+wYZ1YI0hUyHnpRLx
        /iTnphyY7WLDr9opjb2q7z6t6gdipdFzZgUURh/FgA==
X-Google-Smtp-Source: APXvYqyOf36U4JYLmpD+zBZJagaUOWQD78IUIjFNdhcSp+w0sH5Aw+2VNHgL8vXsipTrwpRu05jU/7Uw9jZCsC/Zu2M=
X-Received: by 2002:a81:996:: with SMTP id 144mr16039071ywj.57.1571116137749;
 Mon, 14 Oct 2019 22:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191010073055.183635-1-suleiman@google.com> <20191010103939.GA12088@rkaganb.sw.ru>
In-Reply-To: <20191010103939.GA12088@rkaganb.sw.ru>
From:   Suleiman Souhlal <suleiman@google.com>
Date:   Tue, 15 Oct 2019 14:08:46 +0900
Message-ID: <CABCjUKAprLkXb4Mw0VAY9ODRD81sV0VyPZYFkuxKajcdqf67vw@mail.gmail.com>
Subject: Re: [RFC v2 0/2] kvm: Use host timekeeping in guest.
To:     Roman Kagan <rkagan@virtuozzo.com>
Cc:     "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "ssouhlal@freebsd.org" <ssouhlal@freebsd.org>,
        "tfiga@chromium.org" <tfiga@chromium.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>, konrad.wilk@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2019 at 7:39 PM Roman Kagan <rkagan@virtuozzo.com> wrote:
>
> I wonder how feasible it is to map the host's vdso into the guest and
> thus make the guest use the *same* (as opposed to "synchronized") clock
> as the host's userspace?  Another benefit is that it's essentially an
> ABI so is not changed as liberally as internal structures like
> timekeeper, etc.  There is probably certain complication in handling the
> syscall fallback in the vdso when used in the guest kernel, though.
>
> You'll also need to ensure neither tsc scaling and nor offsetting is
> applied to the VM once this clock is enabled.

That is what I initially wanted to do, but I couldn't find an easy way
to map a host page into the guest, outside of the regular userspace
(ioctl) KVM way of adding memory to a VM.

-- Suleiman
