Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F1CC7618B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A383F22ADC
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 06:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XvHsNPAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbfGXG5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 02:57:05 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43449 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfGXG5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 02:57:05 -0400
Received: by mail-lf1-f66.google.com with SMTP id c19so31140553lfm.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lIeQTvI/rg6NP5pdb+z1gNA3SOY2YpC1Hgmcxc3rkBA=;
        b=XvHsNPAm5IN+GhcuAdEYiRH4EL+PM7TsT3AShmzzKbaACCQNRMOb3sxWIIRVvLOZzc
         uGFM6N+//dbgF8afPKqmbDhRfg3HTCucaxwp/EFvHcfBDAUZNfBg7Li618O+Hu2tm2fx
         NVFMlgC4EMmsiAb6sqXX8cHOI6L3XvvnYqQGEYFPqIuoPt1Vl2TIvLrVatOq4C+lHz9U
         v/n2B712j5PO+bQZe5UUvvvKI5dnI/8Hejz2Q2rtp00jtnE4wEaU+OcwfL2tJIjjjiGW
         yH4hMw3ABo0GhqQrNMlVOwhAqjS2pprrwf4x6kBJR/qpxAUzptQGms3F4RwJo1CEe9Nw
         gvcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lIeQTvI/rg6NP5pdb+z1gNA3SOY2YpC1Hgmcxc3rkBA=;
        b=rmTnV3ZwnnhDUAa33B/HSZnE5UQGPfNhdvuz6P5bSTq7oYrhxrooN3Fdt6Ms7Cdjr5
         qo3wchwLgORO0BvVvUn0bgb9FEW8TRAQYtR3LT2Fi1OSfs4f+WUznN1qG0DCR1c1X0j/
         w7VufC8Ffl+e9oazs7rPu4xkRU8KlFaxo/Bs5pwyaCGrfWpYB2oU1mSXTzuGcC9keHBW
         uFofRR+gxYFCmqrOny714MdEY/Abfe8psQeC4MaAAGYBI0ZMx0geYjucNXPimjutBmUQ
         W14XSLvsY4EILpnZs2EL4Sdh89xtcAU1yyP4ks6HqW8efrCr9dBbYoKz1iheHqtUhrL9
         wvFQ==
X-Gm-Message-State: APjAAAWM2sJkHUkHq01XvfikhW/gxJzUQm20YyHDRm/uepaPT5Pp8Bl6
        Twqe0s6mZkIGD64bFjjh1Bk=
X-Google-Smtp-Source: APXvYqyC+fWp50RlGQnF/y2fkdwpSxZiYSYr30oAzPz7E2yG5a1ENppjsn8lupjuQnQywyKOldpSVw==
X-Received: by 2002:a19:c80b:: with SMTP id y11mr36579654lff.81.1563951423019;
        Tue, 23 Jul 2019 23:57:03 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id f24sm7750223lfk.72.2019.07.23.23.57.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 23:57:02 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C438A460775; Wed, 24 Jul 2019 09:56:51 +0300 (MSK)
Date:   Wed, 24 Jul 2019 09:56:51 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sys_prctl(): remove unsigned comparision with less
 than zero
Message-ID: <20190724065651.GJ4832@uranus.lan>
References: <20190723094809.GE4832@uranus.lan>
 <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563934308-20833-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 10:11:48AM +0800, Yang Xu wrote:
> Currently, when calling prctl(PR_SET_TIMERSLACK, arg2), arg2 is an
> unsigned long value, arg2 will never < 0. Negative judgment is
> meaningless, so remove it.
> 
> Fixes: 6976675d9404 ("hrtimer: create a "timer_slack" field in the task struct")
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Cc: Cyrill Gorcunov <gorcunov@gmail.com>
Acked-by: Cyrill Gorcunov <gorcunov@gmail.com>
