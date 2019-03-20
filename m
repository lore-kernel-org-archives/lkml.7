Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45FDC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B3D21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SUGkr8+U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCTUOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:14:15 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:33538 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbfCTUOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:14:14 -0400
Received: by mail-vs1-f41.google.com with SMTP id z6so2347092vsc.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1zZeT05whuybyDrapIV48mjlbNFtb37A7qCqc56yIGc=;
        b=SUGkr8+U8A+feG+he2GxGRPbRli9k4Lhvgdv4UNdAn+BCYrH5B3S63+f/E6Lig0jaM
         r00scBwv/I0DzUltES4SZEQtSaNqC29J0eY7D6geCUAx9nsBaauXBr20uLsd0hEMxcEL
         Vay7kVd8DQQsYp7UzkNgtAcM14pklSRg/umAUagtAoz92ul0FaLcZ4S6MVjzDU+k5oa+
         wf7Lwp2oGoMc2clGMZV0T8xyYoiwPtmTYmbWPfJGQCUTA1TBUv1AK2M5/txBZesOA6hJ
         d4KZ+Hl0VsZfFQeIAV8lBCYCWEJbLGP5WkgeM6y2yqGwcViZLoIVoauwdZZLE+Tpmcnl
         woCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1zZeT05whuybyDrapIV48mjlbNFtb37A7qCqc56yIGc=;
        b=ThO+SvFWm9qaFkKHGfCVmP7HClC27EVetyemZO8j7wrVJnbCsXDEkaeBdXcK1LWE9A
         gOW7xT4EjqawrQMcM9Lpz/gu7dEQmQgUJJzmgSebalBMV4XWiDHntK1L9kxsUMDv6atr
         +cXsIU4HsplJ4X8tt1x9ZPIKRNyfoquhFcUan7N3I8jd/sOvj7GB0daWQLczBZUsHIoX
         WDZCfDbyEqFEtciSjRKEJQ/6YEidYaMQ5M9/FduSOIEHfKjDkAc5FI/SCRwO7L/YWDcY
         7M+mo+xPMuZX3KJdy6bzuXd0IAjzITDha08ZitSvGxYEaZSa9VChtvtWaXxJvMnvKVmh
         tr+w==
X-Gm-Message-State: APjAAAXAOhAXLxQOghBwVnYV2BpYuq5S5XlQjzcXW6i0T2WchUK1j7if
        901fvy0ZPFNR/edBxhHPutLIiz/zVTGquCCR14wj9A==
X-Google-Smtp-Source: APXvYqzCKV4kWTMTbPXuuKqt9OegK7bxr5tEfXXQ98F+iCM1BgVxys2D/Rv4dbV9SeGGjIRcQihGVz+sVqqVnfCMSx8=
X-Received: by 2002:a67:f353:: with SMTP id p19mr6248659vsm.114.1553112853311;
 Wed, 20 Mar 2019 13:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190320200702.GA27111@avx2>
In-Reply-To: <20190320200702.GA27111@avx2>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 20 Mar 2019 13:14:01 -0700
Message-ID: <CAKOZuespjOTbaTDbgQLo=7PXTE-nYCLy7k=s+RJh_GpZ_5gwgg@mail.gmail.com>
Subject: Re: pidfd design
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 1:07 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > What would be your opinion to having a
> > /proc/<pid>/handle
> > file instead of having a dirfd.
>
> This is even worse than depending on PROC_FS. Just for the dependency
> pidfd code should be backed out immediately. Forget about /proc.

We already have pidfds, and we've had them since /proc was added ages
ago. Backing out procfs is a bold proposal.
