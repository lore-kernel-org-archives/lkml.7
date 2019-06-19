Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F71BC31E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 218EE206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 18:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560969446;
	bh=95Ds7C2wKCMMw0fd/HdFqLE/x2khbNigM8ixnjFhKJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lejK3EqkGOi1zIszU3jsT7VeG80ofbhQr0Ph9hHd90ZaE+bFSCz8PiWuA9qr005xk
	 LBeCtOOUxsL2/bgV9E5eV9RwwB3zjsimvjU2HfjUSCeGF+AHTg5oXzybzqj21IFtfA
	 VIWqVUJvUgib28NUVi5QHKs7J3b0cFK8ERVbRaOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730475AbfFSShY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 14:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbfFSShY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 14:37:24 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 436512166E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 18:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560969443;
        bh=95Ds7C2wKCMMw0fd/HdFqLE/x2khbNigM8ixnjFhKJ4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wO4aGZI4+hS2AaLZ1361JwG+pUMS/03SPBq7ttY1RY0Ns8gtFYkfOfcV5QZicC9oR
         tuwVqKRDu9Fvpz2oeRqFQnTYFI3pjY72IY0eAD3gaQccyGHIom5l7/xzFQtci7bMRU
         C8vGgwAp1kEzJ9g4RhBWGL17KlBD9+HfVSDd1LOc=
Received: by mail-ua1-f48.google.com with SMTP id o2so429198uae.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 11:37:23 -0700 (PDT)
X-Gm-Message-State: APjAAAX6Y7Ylw2/o/TNCjhtGvRB7kgFW5a5U/IXBPvZhT8IdxwjEkjSQ
        +rABpbToTevHhcccKgGJsqClDzVPtWf9tP4VqTs=
X-Google-Smtp-Source: APXvYqz4qoLmngiblq9f8JGM3uWaEAeA7oqqArdc0nb6oPoYl1Njc6DMqGw5VDUHJPM1zF9JjvGjCvBVTi3QrbYy7dk=
X-Received: by 2002:a67:f482:: with SMTP id o2mr3877942vsn.129.1560969442452;
 Wed, 19 Jun 2019 11:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <502d5b36-e0d0-ffcc-5dd4-35db9d033561@computerix.info> <20190609184013.GA11237@probook>
In-Reply-To: <20190609184013.GA11237@probook>
From:   Ross Zwisler <zwisler@kernel.org>
Date:   Wed, 19 Jun 2019 12:37:11 -0600
X-Gmail-Original-Message-ID: <CAOxpaSXKXRcZi0KnQz_6SxajZ6Nv61Bjm5xmG0Ydw3Madv0-tQ@mail.gmail.com>
Message-ID: <CAOxpaSXKXRcZi0KnQz_6SxajZ6Nv61Bjm5xmG0Ydw3Madv0-tQ@mail.gmail.com>
Subject: Re: [PATCH] x86/build: Move _etext to actual end of .text
To:     Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc:     Klaus Kusche <klaus.kusche@computerix.info>, keescook@chromium.org,
        bp@suse.de, samitolvanen@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@google.com>,
        Ross Zwisler <zwisler@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 9, 2019 at 1:00 PM Johannes Hirte
<johannes.hirte@datenkhaos.de> wrote:
> On 2019 Jun 09, Klaus Kusche wrote:
> > Hello,
> >
> > Same problem for linux 5.1.7:
> > Kernel building fails with the same relocation error.
> >
> > 5.1.5 does not have the problem, builds fine for me.
> >
> > Is there anything I can do to investigate the problem?
> >
>
> Please try linux 5.1.8. The problematic patch was reverted there.

I'm having this same issue with v5.2-rc5 using an older version of gcc
(4.9.2).  If I use a more recent version of gcc (7.3.0) it works fine.

Reverting this patch allows gcc v4.9.2 to build kernel v5.2-rc5 successfully.

You said in this chain that you were reverting this patch in stable
kernels.  Are you going to revert it in tip-of-tree as well?

- Ross
