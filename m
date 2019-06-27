Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C02C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D692189F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 04:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="Al8t9Ovv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbfF0E4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 00:56:08 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54196 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0E4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 00:56:07 -0400
Received: by mail-wm1-f68.google.com with SMTP id x15so4266805wmj.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+8atdZXcP26doj8gcmpkPizKujo7rTZABpJLivd+l/g=;
        b=Al8t9OvvZ+xRpBu862DxLn2RyIAoI4BpdiwOst38nWRc7z78jeXonDgzrkCfBcNzcA
         iTaLpPNA8eHJXrQipyG6IEFSEl6a146SbFTv7dApD8s3dmi/cLyPXSxs92uJ1x8wco68
         QsvBjYxL0JYrrNzBXc20B4utdvwI95Zwojm3nFHtmJYwKOYwYrYR7rbmqvgao/wQhodY
         Hvr/qT2Fv2NIgVOBnVNxZq1M0ZXOAs8UhBUl/+HDQQ0sUU1LRqz+FrXtz05Tmy4LrP8/
         8Lvl0JV2gIsNgLM+jd+0XCUyzfEBLwyLPJSkXns/u671anTr0BdKUKFxEef1dDezGAcZ
         A2XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+8atdZXcP26doj8gcmpkPizKujo7rTZABpJLivd+l/g=;
        b=sFnXy2EDWQi9kljlo63uLBMJI99PvzGIK6jwEFfcLhj5aIFNDdBwlBG/2aEirXCZZX
         9W1X5tknQ1WLxexN+5Gooq6y6eSeRcpIFQv6k6Le7zaXrEeqMbDDdJeU86gLBVfdduv6
         vFsUi1Taq7B0FnGn8F9B8lSD4Zzu7HlPUD1s408bqdjSZAiuOicwUHOY4k4AO/yhCJC0
         koOxE6g01swk/yw6df7N1LbJMtUW7QdfNNbXNkKUGI64RB5e5qmoqw96KFl/W6pFR3Vi
         hpHck3fRMDXvS8A6/nthQSnt+FgxP9/BasMPQqmLm8X++rCZ3/lnGQWnfqwc1vcCHLhU
         VZfg==
X-Gm-Message-State: APjAAAUi4I07+nnRUWi8dEJIOtIjmkPgrnnsRpuoYYf62N3VJBTyhMD7
        lYalhXMFaVvOHQ/pVml+S4rE0/HcTnYU5A==
X-Google-Smtp-Source: APXvYqz1m3a2TbnplJx7nYo9bbjJS2sXbm2gOlY2m5pZNQjtNAf/U+H1t6zR8Yk7ya4XjgqGfgC/uA==
X-Received: by 2002:a05:600c:c6:: with SMTP id u6mr1561236wmm.153.1561611365093;
        Wed, 26 Jun 2019 21:56:05 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id w7sm2689028wmc.46.2019.06.26.21.56.04
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 21:56:04 -0700 (PDT)
Date:   Thu, 27 Jun 2019 06:56:03 +0200
From:   Christian Brauner <christian@brauner.io>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, ldv@altlinux.org,
        viro@zeniv.linux.org.uk, jannh@google.com
Subject: Re: [GIT PULL] fixes for v5.2-rc7
Message-ID: <20190627045602.pqv67qxjj7ooaqir@brauner.io>
References: <20190626140733.21538-1-christian@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626140733.21538-1-christian@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 04:07:33PM +0200, Christian Brauner wrote:
> Hi Linus,
> 
> This pull request removes the validation of the pidfd return argument if
> CLONE_PIDFD is specified:
> 
> The following changes since commit 4b972a01a7da614b4796475f933094751a295a2f:
> 
>   Linux 5.2-rc6 (2019-06-22 16:01:36 -0700)
> 
> are available in the Git repository at:
> 
>   git@gitolite.kernel.org:pub/scm/linux/kernel/git/brauner/linux tags/for-linus-20190626
> 
> for you to fetch changes up to bee19cd8f241ab3cd1bf79e03884e5371f9ef514:
> 
>   samples: make pidfd-metadata fail gracefully on older kernels (2019-06-24 15:55:50 +0200)
> 
> Userspace tools and libraries such as strace or glibc need a cheap and
> reliable way to tell whether CLONE_PIDFD is supported.
> The easiest way is to pass an invalid fd value in the return argument,
> perform the syscall and verify the value in the return argument has been
> changed to a valid fd.
> 
> However, if CLONE_PIDFD is specified we currently check if pidfd == 0 and
> return EINVAL if not.
> 
> The check for pidfd == 0 was originally added to enable us to abuse the
> return argument for passing additional flags along with CLONE_PIDFD in the
> future.
> 
> However, extending legacy clone this way would be a terrible idea and with
> clone3 on the horizon and the ability to reuse CLONE_DETACHED with
> CLONE_PIDFD there's no real need for this clutch. So remove the pidfd == 0
> check and help userspace out.
> 
> Please consider pulling these changes from the signed for-linus-20190626 tag.

Al has another patch that removes the use of anon_inode_getfd() for the
sake of anon_inode_getfile() + fd_install() to avoid the use of
ksys_close().
I'll put it in my fixes branch and send a new PR with all those fixes in
a few hours.

Thanks!
Christian
