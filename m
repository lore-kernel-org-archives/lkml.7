Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81852C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C022206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 22:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+fdZHMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730513AbfCYWfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 18:35:14 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38277 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYWfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 18:35:13 -0400
Received: by mail-oi1-f195.google.com with SMTP id w137so8371409oiw.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIwyJBY7jqhwgkMqrMKc5DWE6V6mT+V+4ohM/Kva0go=;
        b=J+fdZHMHSixLH+jAJgI3M+sQct8MJBhBGRVM8ipW2yoGUYlKgN3agwTMB3Bk7kn/5d
         o/9h4lvMgI7vbyj3I10/EyIrxVPZX294AQuYSi4cW7s0ZbbXI5O/nrGy9VIbffH1hQxC
         w5WAj86yr1a2U66sd18npZ7njlaYiXLUfmJFjhXCbivSZ10O35qWJKSJ9kTf3YM9zsu5
         48pBDJC9xI7FuoZHWDalGAzJmXE8fOPRcG0WOGdnN8idc4xXQ0RE2fnIYzCpV0t5fgAm
         L2d5lG98oID05Pg5JrOCJvziw2ub7m/P+peYTCywjIlFeGFQeUjuyopUvLGtLc3IhFp/
         dwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIwyJBY7jqhwgkMqrMKc5DWE6V6mT+V+4ohM/Kva0go=;
        b=RA8vy1jOkSejaoJ//mpC4UM9iCnsheuCoLLIHYNj0i6m2buFr0cdRb5tBqRri67kgq
         /ue4joGppNsNBpfLiBvPjInKpQBkmm4rbJdC0szxwIc8Do1Z68ioLZ7yloHTWLBnn4wg
         siGUDipnMmBcZK7IaSboyzNl7kpah7MYBs09p6c3KMpFv9/u0bxnPKi2s5SiKmMxjTXW
         TtyocyPAFnU7pMbz93jc4u3ldqCDrVOr7f/iEssWtzJ/hGWXtQFetpoM+IH+osk9r/XK
         kw78ibqUKZxkE5i6Xvnzkn0NsT51JUF1OjgfYBKkGISmpx18GTDfTcQXwCQhzpymiPh9
         CsJQ==
X-Gm-Message-State: APjAAAU6Aij1/T+ZYWxmqx37PmKuQMvGzM3LTFmRW/nIUWYh6jXNDxIU
        dl1h6kDNWBNRgGFHvRk3eTjED+cpGlSzxQOg3/k=
X-Google-Smtp-Source: APXvYqyVjv3SPlnScgw0Apb4m9HrXCOXJgsN1wiEqGA+X8EdkOGqRhsr/RdVT/MQ7mOEfmHdr+9pkYTPuS9LACPDKBA=
X-Received: by 2002:aca:ea54:: with SMTP id i81mr13741763oih.44.1553553312970;
 Mon, 25 Mar 2019 15:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190325211325.21411-1-sudipm.mukherjee@gmail.com> <CAHk-=wg+3Hrg=2BLd0kVN6FjDCB6K1sMY0pYBxq3gFzdiYUe1w@mail.gmail.com>
In-Reply-To: <CAHk-=wg+3Hrg=2BLd0kVN6FjDCB6K1sMY0pYBxq3gFzdiYUe1w@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Mon, 25 Mar 2019 22:34:36 +0000
Message-ID: <CADVatmMUUmjPmh3ko9uUuB9ONYqz2_3AF+RX_nD1QB=rn-kzxg@mail.gmail.com>
Subject: Re: [PATCH] parport: daisy: do not try to load lowlevel driver
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Michal Kubecek <mkubecek@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Mar 25, 2019 at 9:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 25, 2019 at 2:13 PM Sudip Mukherjee
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > We do not need to search for ports and bind the initial list of ports
> > to daisy driver as daisy driver is always the first driver to use the
> > new found parport and we know when the parport bus is registering the
> > list of parport will always be empty. So, proceed with the daisy_drv
> > registration even if the list of parport is empty.
>
> This is completely hacky and senseless.

I admit its hacky. :(

>
> The problem as far as I can tell is that the daisy driver shouldn't
> register early at all, and shouldn't be a subsys initcall. It should
> just be a driver initcall, and happen naturally after the parport
> subsystem has been initialized.

yes, but the daisy driver has to be the first one to register even
before any of the ports have actually registered and then it will try
to load the lowlevel driver. In x86, parport_pc will register the port
and then announce it. When the port is announced daisy_driver should
check that port and this happens even before the port is added to the
list. So, we will always be in this situation that when daisy driver
registers the port list is empty.

>
> This patch just makes the code even *less* understandable.
>
> I'm going to revert that problematic commit.
>
> If you can get it working without that incorrect and senseless tie-in
> of the daisy driver registration with the regular partport init
> sequence, we can revisit this.

I will find a better way to do this.


-- 
Regards
Sudip
