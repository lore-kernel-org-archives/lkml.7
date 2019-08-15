Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4051DC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3DE20644
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 21:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565904839;
	bh=Q3KKgF+ty8JeYJLWsebBHdTZ5ep/QONHohuKsMgV9kI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ddZ5oQKIdGXxUV5YkGhoRumdt3d3huTtzyzQirvURRGn2WftpXzSI1i8IYQeD745L
	 I+v9+NQW3BRaceqhUEVFsedmUmeEUzOLS4jvxMT2k2Nw4RNsyaKbCyahmImTBI3R8J
	 bOioGzXzVy+5YEbfoN0KqcMPfhjTmfrgTzBIV7Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732759AbfHOVd6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 17:33:58 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41547 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbfHOVd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 17:33:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id 62so2623432lfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 14:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNmCV0iorJaJ/4B9x9ItjW/vosEJYPNXmEbrNDaYkR4=;
        b=L+KglY9k08E6DLTAvhzP71uPOvFH0ftX6F+VX6R+6Jsi2p0IcQc8kW9P6CTAdz+ndG
         2kHE25Y449pIcxNGVW2Op3sdiMJJ9RxY3h2rJ0z0jJaXhD3+gB6DpMdtXJ9CF9GYMiqO
         DsQMqEq1Yqt+5nFrJdaikQRam9z2lK0MBPn2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNmCV0iorJaJ/4B9x9ItjW/vosEJYPNXmEbrNDaYkR4=;
        b=oSf2hKvzmuTQA/O4ttKwx5ArwPqcXAnaKVgyDZ/xG2QTQ1nhMPoK/xSK4GNvy+GTSA
         29T0f46jfS9zst53oXTSY3giEc1RsivMGaLiZAoI+3IwRuN+ubXkHlmDX48rxhj27gK7
         DxkyCr6PF9uiHMkRdftty1PQEzfG9/arc+Nq0poc8h5PtWvRIFjpu/1IKYVDzW12EJrs
         rDOEhKNLFdhvcdp9GraPxtNcH9mUEKRvPjgHNifO+CdJtEx/lp8BwrpsGSAkRX2DFwMV
         /pLX1D6EbWMxPUw4dG7eRUKspqm/rlfctq13GdTmK8QMmFJI7NpRKUegn/0wZXwCZoLo
         6Fng==
X-Gm-Message-State: APjAAAV+WBbqg7sbZIeqHjcsVXHiHqLwRYWPdolQabFUAcYV6BbZSvbY
        Ww9PdWifdBKuY/d9TjWWaGyWcsbaMok=
X-Google-Smtp-Source: APXvYqzbWmu7tctBlvhbjVZs7xGalYK2HWUUF2Gcoql04BSQKnj9FtKuxFpL/n8oEtL9D1h3vExaTw==
X-Received: by 2002:a19:4f42:: with SMTP id a2mr3382475lfk.23.1565904834434;
        Thu, 15 Aug 2019 14:33:54 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id o8sm667940ljc.49.2019.08.15.14.33.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id z17so3519044ljz.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
X-Received: by 2002:a2e:9702:: with SMTP id r2mr2870914lji.84.1565904833142;
 Thu, 15 Aug 2019 14:33:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190815171347.GD15186@magnolia> <CAHk-=wiHuHLK49LKQhtERXaq0OYUnug4DJZFLPq9RHEG2Cm+bQ@mail.gmail.com>
 <20190815200534.GF15186@magnolia>
In-Reply-To: <20190815200534.GF15186@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Aug 2019 14:33:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJm9OEfJ1gL66jzXsavhXxJCmu9g9jWCCeQPcsFVSO7g@mail.gmail.com>
Message-ID: <CAHk-=wgJm9OEfJ1gL66jzXsavhXxJCmu9g9jWCCeQPcsFVSO7g@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: fixes for 5.3-rc5
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 1:05 PM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> FWIW I've wondered off and on if the VFS syscalls should be generating
> some kind of audit trail when something returns an error message to
> userspace?

I don't think it makes sense for any random errors. ENOENT / EPERM /
EACCES / EISDIR etc are generally part of normal operation and
expected.

Things like actual filesystem corruption is different, but we haven't
really had good patterns for it. And I'd hate to add something like a
test for -EFSCORRUPTED when it's so rare. It makes more sense to do
any special handling when that is actually detected (when you might
want to do other things too, like make the filesystem be read-only or
whatever)

             Linus
