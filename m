Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68629C432C1
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E1A20820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 22:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+jaxj2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390513AbfIWWH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 18:07:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39310 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbfIWWH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 18:07:26 -0400
Received: by mail-pf1-f195.google.com with SMTP id v4so5408268pff.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 15:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2diU/S3ttsPJL07skRAlLasheuTaJLyuG6UizryUnNw=;
        b=K+jaxj2XUkWomvy4yMBPjq5KlDDiUf8op+dK7VFSyLxOXEiJCYaKllzMFIYF9EskU4
         6OArTnS5jT7JDUOV9/LWQr5uiph9xOojl3PyTfrDxzK3N8NMgJ3JKdOP6LbMQap7oTSL
         cDB4WgwqFRWQT8VZeks2UIgF7CnzRzCtIdWhctmTjaX2/MALhFm/HYRChg9AkQwO1GU/
         yAmwWczpM8mO+3SXAlWwopYmTqXm8Wx7WkTrZJD7EQES8hMpMUUR4ZDgQJ4i3RC2gAJ7
         zYUr+oj9+SfTw3vaU9YrJeRdcy8H5YC8nbsdQ2jaq/3/OLEQZoVdhiETcIhviSdEOF+K
         2d7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2diU/S3ttsPJL07skRAlLasheuTaJLyuG6UizryUnNw=;
        b=ggfPIOqLyQVEfF6f2ulDECgNcSDtsH2q/CkK94tatsiwFQZf04S7REOnibJArrJyKL
         6tTY6Isdp3+gdcGKdOaD4Xl1Zo7L3pknwL4caPyz56Pk6Zaas03joVvY88UORvKfBYWp
         2pfLuRAfjrU+O6ApmPvowUtTYmQ6/PV7tRmzV8T8HG8sLNKck9SiG2weu2M6kDAmLrnl
         29nzh79dVeXICwbMApV251GcC5XIMO1Jgi6uKlR7A7RVGgpZ1/qo5SXlqllxbD4EC0TI
         ed4UyC3rLdjzvj5SmOYK4o2P6wnApTzrhhHl+dDMO7P5MvXftdTULutRtpF38OqUjJFX
         t/AQ==
X-Gm-Message-State: APjAAAW0B4PBqUcTlLiJ1eNX/Y3ybX6vKOdEy8xoXtgKY5/vSDrKJNQy
        DCcbVaWheNMDa7D1sJga7WxHCFIvMaanbaEZZTjz4A==
X-Google-Smtp-Source: APXvYqyQYq+yQbDmYyeiFjRrzvwNedBwZ5wJJDmELSmW4Ys2S5y3bwXL2o23kwlkLLnuBWPkfXI4Orvsiy/h/87E6TY=
X-Received: by 2002:a62:258:: with SMTP id 85mr1969618pfc.165.1569276444993;
 Mon, 23 Sep 2019 15:07:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190712085908.4146364-1-arnd@arndb.de> <20190712174142.GB127917@archlinux-threadripper>
 <CAKwvOdkhe=WMMTevMd7m_URjuOcjAkHc8zBibUD2_gX79U+p3g@mail.gmail.com>
In-Reply-To: <CAKwvOdkhe=WMMTevMd7m_URjuOcjAkHc8zBibUD2_gX79U+p3g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 23 Sep 2019 15:07:13 -0700
Message-ID: <CAKwvOdka1bSOrS6t-L=J8AYWe-NzpxqvrpSiXPqRwnM9mBEL5w@mail.gmail.com>
Subject: Re: [PATCH] xen/trace: avoid clang warning on function pointers
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Petr Mladek <pmladek@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2019 at 3:06 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
> Steven, Ingo, would one of you mind picking up this fix, please?  See
> for multiple reports:
> https://github.com/ClangBuiltLinux/linux/issues/216

Sorry, https://github.com/ClangBuiltLinux/linux/issues/97 is the link.
--
Thanks,
~Nick Desaulniers
