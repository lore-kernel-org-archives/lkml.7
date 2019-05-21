Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D996C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2340C2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 16:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IexpasiR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbfEUQx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 12:53:58 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:37697 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfEUQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 12:53:57 -0400
Received: by mail-ot1-f68.google.com with SMTP id r10so17002252otd.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2019 09:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3f7mHmRjk7fLWcBIYMRJs7xMo0wDV6TbfEsmzCjNuX4=;
        b=IexpasiRg+Bb7Na8aIfMp4uMnKTIcQpKXn6m8U8PPT7pxafFono+NZVqxQql/np9E2
         uVV6nA0U7vA3OW1s18+qiJxODFopSpD0GbWPjQHmofSJH0LBwukRLM1K/3IGMaPrbbo9
         +Us7mESrsAZ/WC75Jjfk330nEuV/GmPChlwqBs0SCg3bo6kg+FcxWkpySkBlBwqrarfE
         dsqzHSmpv+WAUeSCfdOJctkthdw/8BOS2rUHZDSgrTBdQSa4I/7lOvnw5ZZucmu2QbTT
         hy749+PCiUxMl5TUHJX7V2sM/A0O2MKc5BSpocUfJcbKSf/Jz6t8qMcX9Kd/JcIWbK34
         UeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3f7mHmRjk7fLWcBIYMRJs7xMo0wDV6TbfEsmzCjNuX4=;
        b=OkeB0htRPy3xHhuBDT5Vf4vL9O23EFYcbFwOrKwogEF3KCIjtcVhZn2nZTnozl3ri6
         gE9TsThL8WZmVRVdpfMJQlYEsxDDdKDAZJJuW27h0jL0Wm5J6EFEsig3bOJ/OkTRc+my
         qeBhIA2jn9YyK6v5PLFbc3Nh+tQQAiAOr4HYH2bSFm3NZIGxY5thMlGTvhq+ZeDXyf1V
         BJfZYssUsMo2QVpksEb3vSARNoutyddRYiqG6mgKs9fXYo7jJxs20bTws8Sy216VOW55
         y3secGsLd+eo3mPZgylle1y0R6goJu1b34dnlF9B2B2tpkdaHkJfH8tkvpa66QYvRPw6
         vGUg==
X-Gm-Message-State: APjAAAU/Uf0y8nLzyGhINWw/YLB33A8N/D8gWLG/Ql06zbEvQB+RLkUf
        roSP5z1PhswV8MbVeADUyFEw1Dc9rAOjLSnhJ+Y=
X-Google-Smtp-Source: APXvYqxWCvUByFG2A9trYQwGtggkpf6EvuOWMVhfCbHUQTZERoRJIl5MIYzVfUQfM1QDA7Nzr1VvoJ74I8AXO/wfTuU=
X-Received: by 2002:a9d:68c5:: with SMTP id i5mr5230452oto.224.1558457636794;
 Tue, 21 May 2019 09:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190521145116.24378-1-TheSven73@gmail.com> <20190521151059.GM31203@kadam>
 <CAGngYiXLN-oT_b9d1kRyBrrFMALhKO-KnuwXB0MjVq0NFc01Xw@mail.gmail.com>
 <20190521154241.GB15818@kroah.com> <CAGngYiU_iK5=swD_DA5PcOeYFT0zTrdQ+30Db0YrahuEukEP_A@mail.gmail.com>
 <20190521162451.GA19139@kroah.com>
In-Reply-To: <20190521162451.GA19139@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 21 May 2019 12:53:45 -0400
Message-ID: <CAGngYiUSgtAXL+utPHz79OEbvrL6_TD9Wfkc6396E9vwQHCFKw@mail.gmail.com>
Subject: Re: [PATCH] staging: fieldbus: anybuss: force address space conversion
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2019 at 12:24 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> what is so odd about this code that makes you have to jump through
> strange hoops that no other driver has to?
>

Basically because it creates a regmap which accesses __iomem memory,
instead of i2c/spi.

This was done because future hardware in the company's pipeline will access
device register space through spi, instead of through a parallel memory bus.

The lower driver just has to create the appropriate regmap, __iomem or
spi, and pass it to the
upper driver, which does not have to know about the exact way the h/w
gets accessed.
So regmap is used as a hw abstraction layer.

The issue here is that a regmap context is a 'void *' yet the parallel
memory base pointer
is 'void __iomem *'. And so the two are incompatible.
