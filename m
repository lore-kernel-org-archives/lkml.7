Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073AC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 306B22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 22:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558047205;
	bh=tCj5Fs5l8D//Ho2eVnzlrYvKvhC8lmC5SM4WAtXTXA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n6Avw2U9WnviDL6RhHBcvXJf3nzqY82o7UHarHSMeiICeW+Ns8Ux+vQu2JNBRgHv+
	 Yoh8pvxYD7SLRtUkomFy07Uy9vQCRnKyWdGYkaKAWk8v6RHnFWDMmvdDKMFzC0vg5e
	 0zsKmGzHXHdoXLx9xfpF4EWSfQjsiUYNIhgVvtFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfEPWxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 18:53:24 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36447 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfEPWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 18:53:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id y10so3915393lfl.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YtKHs6p1hkPZRuLpWntFvRSIJdzjPy+3GlRYlCY9zeo=;
        b=PFxJAbUY3oljE/GYUKOJwp4FCggishnUO3Kr6jDltu7PA3A8u0u/ym6rfr2ViThhyf
         snAprb5ZbShw7fxJV+WjFiVYyvsSwN6KlDq1LFL70+zila/YrmS+CWrB8dywWPYXjHJw
         GG7B856A9pjVxUOw3pMIT/ZpiMETNx79Gu/ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YtKHs6p1hkPZRuLpWntFvRSIJdzjPy+3GlRYlCY9zeo=;
        b=CroPwHdKMg1nGeADEIvXS2Qa12gGhcbrcZ1Y6jApuEbFxbkTBbIsp6SMPxDKaXMepw
         k3MccXXiUKLLW+LjMRITODQn0MOdwtJLdGrTpTbd7ISPq9NPMtFSaYVzIPeiac6iaP+S
         1c45dd1yi+2GRL4UbMC/rOXPNSoELKktpa9CXzV7N3bukfQQUBLZMVLylCnbB5W6fVfh
         AHa+Kg1i3mYCxFaYyAtzr/r+AQklkxzJb1sfIRW1XQzWqlU1aF/K0iK10+a2jXJT2Cbs
         cIkIPJyQaSjTTxuNvyfYuSNjeS7A/Gzj5dXrF2Iu54MRj1cAAKEX2Qn0d+6UJ+VMAusI
         tORg==
X-Gm-Message-State: APjAAAUQAAXLz7aVA1vRTGZGSOUnUCGpJfCPV2faxgjxnDNMgovRtY9O
        JiO4xaCbXePtrADOO6/uJ2S639dqzZg=
X-Google-Smtp-Source: APXvYqy59DW/r3T6Ish1mvLQjC3lx0rAodwq3CF1Rq3MPIKExytn2wAPhw6MV/k+MgwobKn+MogRJw==
X-Received: by 2002:a19:282:: with SMTP id 124mr25667838lfc.131.1558047201441;
        Thu, 16 May 2019 15:53:21 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id x2sm1104318ljx.13.2019.05.16.15.53.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 15:53:20 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id h11so3217687ljb.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 15:53:20 -0700 (PDT)
X-Received: by 2002:a2e:9b0c:: with SMTP id u12mr3756157lji.189.1558047200002;
 Thu, 16 May 2019 15:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1558036661-17577-1-git-send-email-cai@lca.pw>
In-Reply-To: <1558036661-17577-1-git-send-email-cai@lca.pw>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 May 2019 15:53:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjb-xSQq9XrQ2igYURkQ7+X+2+q5OoqQDkp8evgMmFcYg@mail.gmail.com>
Message-ID: <CAHk-=wjb-xSQq9XrQ2igYURkQ7+X+2+q5OoqQDkp8evgMmFcYg@mail.gmail.com>
Subject: Re: [PATCH] slab: remove /proc/slab_allocators
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, tcharding <me@tobin.cc>,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>, penberg@kernel.org,
        David Rientjes <rientjes@google.com>, iamjoonsoo.kim@lge.com,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 16, 2019 at 12:58 PM Qian Cai <cai@lca.pw> wrote:
>
> Also, since it seems no one had noticed when it was totally broken
> more than 2-year ago - see the commit fcf88917dd43 ("slab: fix a crash
> by reading /proc/slab_allocators"), probably nobody cares about it
> anymore due to the decline of the SLAB. Just remove it entirely.

With a diff summary like this:

 3 files changed, 1 insertion(+), 232 deletions(-)

I can not resist this patch, and have applied it. Thanks,

                 Linus
