Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16ABC04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C72FF21743
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 15:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6Tfhl71"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbfEUPUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 11:20:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38202 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbfEUPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 11:20:10 -0400
Received: by mail-ot1-f67.google.com with SMTP id s19so16689171otq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 08:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A+8divkK1RJk885MhoBadHe7V0Gz6HXofpqqERzrJNA=;
        b=f6Tfhl718TNjdi17fhG7uFrVhiNMtt0eFnN88/vWM/iqLcrXdf0U78Tcw2BR4iQWh8
         BpO6NpBCYB8c7OHdo47JDGicRRFwC5/faPsW3qq7jO+OUHOxI/qbZhr00c10svQ7dwP7
         O+Wm4TvaOB0rOEgPyHxOKrauegQSRzVft+LE5BPSDPnwgfo7LybMTjqFdxQwlh1jw2pL
         067JIheUQAjveLhU0yumxM018uQkXYZiy8mb4De7QOb9L3SEYr2fAK3FhlsN7+wCGKqV
         XMKmaEaXTxZSutXnkwjOSQgeTSIl81ZRwkYcEcx3efybOKztMt+f8gRWrJUH60qGMMN5
         j8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A+8divkK1RJk885MhoBadHe7V0Gz6HXofpqqERzrJNA=;
        b=piVbL/8AWJxzMgjRAVQmxAZ/4JGhIkaczO0xH0d5gbEoThHIKooLZXmamWiUpyludj
         vHE6MilRj+LLGBltPhVG625Y6J/D0fo/g5CRahC74vxT6dcTWYWzpMUs4A9GdKR9r8IJ
         Ogt6ya8S2Ds9qTbYknKwTuh5ocpZmYR1qvx7rRjRbz0uJN1G/SDtfwVx40HSFNnUUA/Y
         vtpN/vcUfSlncKY1fiyqE3AiHoIWhRWxDUDBHzGqT8bbTuD6V7VhINouKubaxBP53dDe
         vkha1OJvWeX3o0aEWTTLWtYIduv7/10w62MCMBKaNL2AZohK11Tqrx5IBpwT3xCgxs6+
         6urA==
X-Gm-Message-State: APjAAAWSPThtGExHV8dZmtgdDiScUBaZtcunbTagdNUEJgcf9ze+1iMP
        raWOKLymaQKvtOLgXAU2OMXr6lA96Cugn47WifHgJwuJ
X-Google-Smtp-Source: APXvYqyNDKJ6GMe6x1bgirllN226UDaCKuo/V2cXOkEm0n2JojXasrFXk9uTVsfXh7oaX/38x3TpAHQkNYNRZQ6UWLk=
X-Received: by 2002:a05:6830:209a:: with SMTP id y26mr19927286otq.232.1558452009981;
 Tue, 21 May 2019 08:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190521145116.24378-1-TheSven73@gmail.com> <20190521151059.GM31203@kadam>
In-Reply-To: <20190521151059.GM31203@kadam>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 11:19:59 -0400
Message-ID: <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space conversion
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 11:13 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> There is no need to use __force.  Just:
>
>         void __iomem *base = (void __iomem *)context;
>
> For the rest as well.

Yes, that appears to work for 'void *' -> __iomem, but not the other way around:

+       return devm_regmap_init(dev, NULL, (void *)base, &regmap_cfg);

sparse generates:
drivers/staging/fieldbus/anybuss/arcx-anybus.c:156:16: warning: cast
removes address space of expression

Would it be a ok solution to use __force in this instance only?
