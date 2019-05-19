Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BCFC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A3520449
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="he4EegSm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfESSUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:20:20 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33341 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfESSUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:20:20 -0400
Received: by mail-oi1-f194.google.com with SMTP id q186so1759316oia.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
        b=he4EegSmAY2zYl4r6S9HGzKLVkT8LcOlIiHygVYp7zaifYHKTOnLMI3o86dBf9LnbA
         hNpn27eEyN+qjhPr4EWsh41NZcuWKx0QV/Lm3hbJvmg4w/a4SM3A6yP64JFNN7ArzrWN
         LmBZN1YUxjOCOk3FCPXXbnD3ysP2yAjgaksZCoteXGH8VH61lmvwvYl8cSGa8tPvrlXr
         xPan3agZZxXKJmJ5Js9Nz6/gSEQCRSxaaZuflHI0xI3I3tFi+kBW1X+kpQ85pzisWSZk
         tKdYRCV0JX/Fq5SKy2oGR4hlkUeMEXHgWn14Ltr+Tbi08WwF6ZAeblRmiNNtO42MgwiT
         kfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gj9Btx/jtZWCRzYf1e68GHq9hnNL+Ogbx99PZIgoB74=;
        b=qTd0Rf2xh2SHPyHWSVkS//kxGZNk9FDHOXm64JhKCbb1G0Nkj3/qiLa4sHcM3LYxat
         lne4QRoEE42cnKyCGC/leqmfFDu+roPDe/inHicseOpGfoNVjJuyMJK5IRvpR28bUcM6
         NEEleILLonIaDQlFD+4j+7QRYan22Ny20U8PZFqzG5zyUopsJKdZ6mru85buqoUILax1
         CTp6wnbgLcgYgCBc/u9unW6feERKqX1DDMkNvINeH6O7JIdADhda/OktcJELjBh6Czsc
         wcOkXBvHU2BTvooJMs/3ZUnS/0+j1PQO3N8UTuIZFDDoU6sYPpDqq6a9tXzRubB2fpvb
         bu/A==
X-Gm-Message-State: APjAAAW4FgkMKfWmTzfzdNVJjv3zvKby8S3iBFxXykoN7cAf2bVwgRb6
        NR1FQcxQePJRS3ZKzc4aGOeTlk4gRRkZVfB4Hw2atFsk
X-Google-Smtp-Source: APXvYqzKuIF7DjE9geOB0iP+nbKCvx7yts/nthzaKm8X4SzrLuLauoovdM83byX6mPO6HfMrjjhanslT2cwm2r59jc8=
X-Received: by 2002:aca:ab07:: with SMTP id u7mr2335808oie.73.1558241173924;
 Sat, 18 May 2019 21:46:13 -0700 (PDT)
MIME-Version: 1.0
References: <155805321833.867447.3864104616303535270.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20190517084739.GB20550@quack2.suse.cz> <CAPcyv4iZZCgcC657ZOysBP9=1ejp3jfFj=VETVBPrgmfg7xUEw@mail.gmail.com>
 <201905170855.8E2E1AC616@keescook> <CAPcyv4g9HpMaifC+Qe2RVbgL_qq9vQvjwr-Jw813xhxcviehYQ@mail.gmail.com>
 <201905171225.29F9564BA2@keescook>
In-Reply-To: <201905171225.29F9564BA2@keescook>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sat, 18 May 2019 21:46:03 -0700
Message-ID: <CAPcyv4iSeUPWFeSZW-dmYz9TnWhqVCx1Y1VjtUv+125_ZSQaYg@mail.gmail.com>
Subject: Re: [PATCH] libnvdimm/pmem: Bypass CONFIG_HARDENED_USERCOPY overhead
To:     Kees Cook <keescook@chromium.org>
Cc:     Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>,
        stable <stable@vger.kernel.org>, Jeff Moyer <jmoyer@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Smits <jeff.smits@intel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2019 at 12:25 PM Kees Cook <keescook@chromium.org> wrote:
> On Fri, May 17, 2019 at 10:28:48AM -0700, Dan Williams wrote:
> > It seems dax_iomap_actor() is not a path where we'd be worried about
> > needing hardened user copy checks.
>
> I would agree: I think the proposed patch makes sense. :)

Sounds like an acked-by to me.
