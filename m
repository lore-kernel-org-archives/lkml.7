Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD70C3A5A1
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2F652339F
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 21:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566509380;
	bh=4mCTf/YMc7uLJWwtQlQ8SwMozynVGioIXfvvNvxBVjk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wWkcToUxvo41UBUtw5RQ2QWaGaSPJOMcycWoW02e1Z9I7iYkox/P0Ow80rOcwz55F
	 DQuajLdu1WUbxLAITf87gxyJqXNY2F3BOZvfuP6zh2N4GGBG436Jvhk7nh98AjmwXX
	 ASo1vgPQHTDjDHKvWjOQO0IZpqUIjJTTIklFu0Qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390306AbfHVV3j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 17:29:39 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:37457 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728104AbfHVV3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 17:29:39 -0400
Received: by mail-lj1-f174.google.com with SMTP id t14so6942351lji.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fS+5NiIBvdct0VjclwamoBpBG6dKC44mUuBwDfUw2D4=;
        b=MP9hAWayJfCwqRyESr8IozbkfAYF/PFq2y/4RL+vBXU2y6uYRRCJkCFxh27ome1tE2
         r05Ks1U/mjRzFMEmhfKg3VM2tJkZ/87slWoQM+c4oNqV4jcrkcxE6XTmMtc7ADZOO63U
         iqfnUz6oiLq2XUY6iCMTeryyeT2TsSMB48yrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fS+5NiIBvdct0VjclwamoBpBG6dKC44mUuBwDfUw2D4=;
        b=rmQDK3jSgk1mXIsVhOTRF8qZZsHMfv3IHLOX/1A2bvwuwrj8C37VV5jaj4nRZinHx4
         buXH0WIEfTGUX0cdP7cxkmJBH2ED0q/eex6mnGuvfLGEttGOAcqcATlRUkTm+QuaoGfM
         b1ThgrV9dmhsoUJZjGN7pUlGeiwj4UjhEq3LMiIXiUv0YNf5bv1c6BnOFjSEk4//2roK
         oV63zFGItLCqVV6TW4R3pzpeQ4UZ9PIGQQyK8j09WccRX73QgXQc8fnwD+4C9dFE6BR8
         esOp1oV3u2FopjTrLdw47tGwinjGvjsP6JC/Q7+axK0AmRfE1ZESD6kfAGh2ZG+i/tVM
         sKJQ==
X-Gm-Message-State: APjAAAU+uMiBlyigf72Ru3nScr8uMEXtsgnKfXNO0Ob1tvYNcT6PX8wF
        HkkkdHx91CDd/golkRyw8sr8p32NAmY=
X-Google-Smtp-Source: APXvYqzhhWbi6W/k+p4InSNJojmO7LzYJWfCY6k8WWPGBYXmwocwsA0zzgnEJkBZmxK1H584Lc+Fag==
X-Received: by 2002:a2e:875a:: with SMTP id q26mr813844ljj.107.1566509376818;
        Thu, 22 Aug 2019 14:29:36 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id e11sm205037ljo.19.2019.08.22.14.29.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Aug 2019 14:29:35 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id x3so5595022lfn.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2019 14:29:35 -0700 (PDT)
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr685171lfp.61.1566509375347;
 Thu, 22 Aug 2019 14:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <1566338811-4464-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Aug 2019 14:29:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whK4d0cO+98mEcTfb+Cpxt7W8dpdux9KJc_h6AO6PXtcw@mail.gmail.com>
Message-ID: <CAHk-=whK4d0cO+98mEcTfb+Cpxt7W8dpdux9KJc_h6AO6PXtcw@mail.gmail.com>
Subject: Re: [PATCH] /dev/mem: Bail out upon SIGKILL when reading memory.
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ab2d0f39fb79fe6ca40@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 3:07 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> -       while (count > 0) {
> +       while (count > 0 && !fatal_signal_pending(current)) {

Please just use the normal pattern of doing

        if (fatal_signal_pending(current))
                return -EINTR;

inside the loop instead.

(Ok, in this case I think it wants

        err = -EINTR;
        if (fatal_signal_pending(current))
                break;

instead, but the point is to make it look like signal handling, just
with the special "fatal signals can sometimes be handled even when
regular signals might not make it through".

              Linus
