Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049A7C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C1C21901
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 16:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556124073;
	bh=sfNGY3QtekIS0zaSK7OyVBjzfP8oPNpNYbTTyU0FPVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sI/TexBHU9OdS8YQ3Nnsj4zzVAqgqzH658QOGcgKg/C1Cy9WrlxEN+RAGpEw/xhLx
	 6hXKQesTJxuoIU2bC9CscIYtduji4gb6rRb/ZQKlOoFeD3MdAZm5HH/NMgDj4a3Njc
	 qzbO0qPy1x8fLzpwk1uSQy4KNF/WtstvR3I9iJyA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbfDXQlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:41:12 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:43594 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731700AbfDXQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 12:41:12 -0400
Received: by mail-lj1-f195.google.com with SMTP id k2so3273616lje.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCoX70JfB4ACFvt5K3pBAOQV8oj+2wKMHuS1gyK5cq0=;
        b=cokZLCtyD6tc0NVIwuZ6X4LqY1bpeWDXEDhlYU7qjgH+9KJBrSNWtMBzOtxerCjohJ
         OgkmgUHj96QfSCVhJ+qxe87LtuTD/hVNyaFtxbZCkhdU2Kcc53EHFv5VM5IMIQCsX0M6
         nzETZrz2K/d+bSMSR4+U42pj1sp3G1iAbovXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCoX70JfB4ACFvt5K3pBAOQV8oj+2wKMHuS1gyK5cq0=;
        b=UWiIzHdyKxZj3r3ZMD2SlYrANYSKcRhy4+GNzYBOHfD/Vhmh8UjzEQPDz4pn8GQh3+
         HUMDJaEQ0ApAk6zVX7C13ej9Fsd3O92uTd3ToWqFtBtTUN9WrFs/IjVciSgTunKtDVpG
         FkjjAO1ZfXkilBFpwMxgbFtkd0p4Qht/MkqXSARYyMmKjRQ8IJBHUxjzabbBW0n2yLR4
         j0jnPeErP/FKQBOGH48XsDMiaui5uyNrnshjKZWkAPEJZUmwMeMwgZ9/AW+wDnNjUoI4
         xoodZqlLwBudNRiMhD0uU1lDkbHXNrnxLVNXZLsStbD4boLpGowKW7Ebju3EXxN2lQBa
         PwYg==
X-Gm-Message-State: APjAAAXuCQRejXUruSvZqIbY649/NZKtIk0NuCNj3aWP36ihLRv/bhjK
        xN4RBMu5YquIuEPdPf/TiQNPsTSrsFc=
X-Google-Smtp-Source: APXvYqxqGUlAqYKzLLm7ZHJiZnb8R+MeAD/s9cXQAXjsbB5pOCUN6u9mBNVzeDeoAuFYHuimMSRo5w==
X-Received: by 2002:a2e:5dd2:: with SMTP id v79mr18454333lje.22.1556124070304;
        Wed, 24 Apr 2019 09:41:10 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id w12sm347192ljj.11.2019.04.24.09.41.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 09:41:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id t30so15199900lfd.8
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 09:41:09 -0700 (PDT)
X-Received: by 2002:ac2:598b:: with SMTP id w11mr18810110lfn.62.1556124069191;
 Wed, 24 Apr 2019 09:41:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190424143341.27665-1-sashal@kernel.org> <20190424143341.27665-59-sashal@kernel.org>
 <20190424163415.GB21413@kroah.com>
In-Reply-To: <20190424163415.GB21413@kroah.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Apr 2019 09:40:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
Message-ID: <CAHk-=wjEOyba5As1PEMk6RitNVOJH9oJ_Jbg4y=5B0fcX1iKGw@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.0 59/66] fs: stream_open - opener for
 stream-like files so that read and write can run simultaneously without deadlock
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Kirill Smelkov <kirr@nexedi.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yongzhi Pan <panyongzhi@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        David Vrabel <david.vrabel@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Miklos Szeredi <miklos@szeredi.hu>, Tejun Heo <tj@kernel.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Nikolaus Rath <Nikolaus@rath.org>,
        Han-Wen Nienhuys <hanwen@google.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 9:34 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> I think there is a follow-on patch for this one as well, that adds the
> proper "stream open" logic to all of the individual locations.

That bulk one hasn't been applied yet, and wouldn't be appropriate for
stable anyway. It's 5.2 material.

But...

> But even with that, I don't think this is stable material, it should
> just be for 5.1 and newer kernels.

We likely *will* have a fuse-only patch that uses stream_open() and
_will_ be marked for stable, but that hasn't actually happened yet
either. But if/when that happens, then this infrastructure patch will
indeed be needed in stable.

                  Linus
