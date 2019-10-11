Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D161C47404
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9922084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 22:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NtE/nU2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbfJKWLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 18:11:36 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44821 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbfJKWLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 18:11:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id w6so9251477oie.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2019 15:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iYAYC3wS5kKgW3tJiDPUFQyWjg/Hppq/ySaf6EhAiPM=;
        b=NtE/nU2k1zFWLS8Z4FDgsjYbX5WCZ1ArXUPUCPvpWV8kwc3Dh7NQ7req7s1attiFtP
         b0qhInWtI3gB+KYBMIPR+WGpEqpCAYvqUduOs2NcQLIyG32CJ36fZXgDO3nv0OKQxhiF
         D3iuM1mIQiITP0fwnHdSpg1rfXsR0RJmvmioSlsrfQ/oOz+T8y1y2pp/PAE4KpeNjLM7
         wMAXjp+nPX3q2tJQ0GgWG/R/9ACmwDTDo3o6Bepti2xnthNrpeSksnTVn9MOWwC8b5NT
         2FpmXC7KnJ+izV1W9YfFAFHWY1vRy7YTKsQHFuwpnrP8M9SNN4WPKSVFTOoE9VbCnvzR
         sFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iYAYC3wS5kKgW3tJiDPUFQyWjg/Hppq/ySaf6EhAiPM=;
        b=etB2MJ/jNEJzIaG02/E0w1hpbBPXcMeaDnRQECkM6AomDvOaw1U7JD3i5rb3DQnlvf
         wxl6CmZDkuCMaTq4aQT5Vu3WNc3UF3Oi6aFceVKMNBrdULG15QJqBHhge1GFEiJhVEcV
         G0jj8hWa/Ho6a4e7NCAv0Mpk9g0V4owTsowZPblLZVpJmzdFkUp0iegbh0nfkq03/aLJ
         4zCHTCIOS8sUMK+QR5MSpXvlm2GRVRDg/+0O16YZKkWHVU6rkDLi5AH5msWLnb9C6a7e
         KLUyzVEj6xrG/pvFQ+a06af23Xfbe+nO/2IvOw0GWy6hzUyHMDSDkshWMYtpQ7xWBcVU
         IWVw==
X-Gm-Message-State: APjAAAUyyomG4InNUQs/H2fVwSXtjNo1Q/je5jwYHesN38WS4lc0Lomf
        4Ix1qczEm01P74pRbNjxd/xxJGRr/vzu8vyQ0USlmg==
X-Google-Smtp-Source: APXvYqw57ERR6jnxHxAcPEFRpId1CnpeEXFS8Ct4nKyEDiRjVs5RN2xj9/cw9gxKlH7YLTtxPz9545qZlVs3A5XrOJw=
X-Received: by 2002:aca:cd4d:: with SMTP id d74mr14539387oig.157.1570831894397;
 Fri, 11 Oct 2019 15:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190715191804.112933-1-hridya@google.com> <CAG48ez0dSd4q06YXOnkzmM8BkfQGTtYE6j60_YRdC5fmrTm8jw@mail.gmail.com>
In-Reply-To: <CAG48ez0dSd4q06YXOnkzmM8BkfQGTtYE6j60_YRdC5fmrTm8jw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Sat, 12 Oct 2019 00:11:08 +0200
Message-ID: <CAG48ez2ez1bb=3o3h1KSahPU6QcdXhbh=Z2aX4Mte24H4901_g@mail.gmail.com>
Subject: Re: [PATCH] binder: prevent transactions to context manager from its
 own process.
To:     Hridya Valsaraju <hridya@google.com>, Todd Kjos <tkjos@android.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        syzbot+8b3c354d33c4ac78bfad@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2019 at 11:59 PM Jann Horn <jannh@google.com> wrote:
> (I think you could also let A receive a handle
> to itself and then transact with itself, but I haven't tested that.)

Ignore this sentence, that's obviously wrong because same-binder_proc
nodes will always show up as a binder, not a handle.
