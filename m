Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA30DC282E3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756A1218FE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="1pMiJS4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbfDXPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 11:20:09 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:43747 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730827AbfDXPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 11:20:06 -0400
Received: by mail-pg1-f180.google.com with SMTP id z9so9528657pgu.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 08:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E9qkLBGCDRzuLJUlze/rabSNC/gT4ZSQ5pV/MvHU5pQ=;
        b=1pMiJS4OcpwbaIwCiOWRc+JpT+oAeUGqMAu5cxVGeZIZ/nShn9Y1HKTT2py+sHlyD1
         CV68C61S0MnIQZgWv56q6zQYzYpNjQr++bVso2n/853msE5se+ndU0yT43jJmJq2zDoV
         6K0ObAHLMl1vZ52mU/GJVZWoxtFTz+AO4Fq+aD/ujI79KS314NWgHaDUMKBW/gzXRSUh
         1QGRb9ahRDk/kw/KFKuPY11bK4f1PrOBbxe2RDQBiTcSEhEMSHjjGlGA/Dt7A8ltyXMJ
         BhLGws5h+FtzNfIomq79Fzn3f35DR2ZRYwuSEnMZh4zcf99GzZCWhvEKF4PS44GLe8QM
         bw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9qkLBGCDRzuLJUlze/rabSNC/gT4ZSQ5pV/MvHU5pQ=;
        b=IWWrj5UKY6XgQChne7MPKuQK1kDoS8KJsgdGeL5eB7R0Kc6qGmShZJr0/zDTgDbm16
         viqt/go71vze9yx9Dc+JZHHdJUCQ/kijau6G5SQyQDVwKNeIG9Ol4T9Z250p8pedZ5/T
         laPAlMFYSH8MS9ZG9AcMeP/8FfqnpYFsL/dexbvAfPVpl8F0GJQVixHxwIgHR05zJipB
         NgdlBHvNSnf+lszMhwgR++5MAkHS4elVXu6A4TSlJcwaddAFiLTvMm/xgAT8sDCxz/IM
         ++TZ9BJ7N2mHPeUlPFDydxXPHYhVSKRRdlmT1heH3Zy+NSqdpg0F7YQQEnrBJ8rzRlMW
         pTgw==
X-Gm-Message-State: APjAAAVYeEt1aGMCqWOJb+vWg4ygi81zHTBkl22Fjcd5Sj700JJ26tRH
        Fm06vIk2DBtVibKBcfhS39idmiYIXy6pvw==
X-Google-Smtp-Source: APXvYqzSQCOyERmgvvj02ps+Sh6aw7wF9Fc82eOcJ/wQ0lCMSNw3tSSgutbWujC7Z1uzKu9bfxEA4g==
X-Received: by 2002:a65:64d3:: with SMTP id t19mr31687928pgv.57.1556119204691;
        Wed, 24 Apr 2019 08:20:04 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:7136:cebf:c0d3:8091])
        by smtp.gmail.com with ESMTPSA id y10sm28305726pfm.27.2019.04.24.08.20.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:20:03 -0700 (PDT)
Date:   Wed, 24 Apr 2019 09:20:01 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     keescook@chromium.org, luto@amacapital.net, jannh@google.com,
        linux-kernel@vger.kernel.org, stgraber@ubuntu.com
Subject: Re: SECCOMP_RET_USER_NOTIF: listener improvements
Message-ID: <20190424152001.GL3758@cisco>
References: <20190424150423.k3embc2vkho2kixp@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190424150423.k3embc2vkho2kixp@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 24, 2019 at 05:04:26PM +0200, Christian Brauner wrote:
> Hey everyone,
> 
> So I was working on making use of the seccomp listener stuff and I
> stumbled upon a problem. Imagine a scenario where:
> 
> 1. Task T1 installs Filter F1 and gets and listener fd for that filter FD1
> 2. T1 sends FD1 via SCM_RIGHTS to task T2
>    T2 now holds a reference to the same underlying struct file as FD1 via FD2
> 3. T2 registers FD2 in an event loop and starts listening for events
> 4. T1 exits and wipes FD1
> 
> Now, T2 still holds a reference to the filter via FD2 which references
> the same underlying file as FD1 which has the seccomp filter stashed in
> private_data.
> So T2 will never get notified that the filter is essentially unused and
> doesn't know when to exit, i.e. it has no way of telling when T1 and all
> of its children using the same filter are gone.
> 
> I think we should have a way to do this

Since the only way we ever allow creating a struct file * that points
to a struct seccomp_filter *, if there is a notifier attached, the
number of tasks still being monitored by a particular filter should be
filter->usage - 1 (assuming there is a notifier attached). So we could
augment __put_seccomp_filter() to check for this and send out a
message with a SECCOMP_NOTIF_FLAG_DEAD flag or something.

> *or* alternatively have a way to attach a process to an existing
> filter.

I also think this wouldn't be too hard, since the struct file * has a
reference to the filter. So I guess the question is: which of these
makes more sense?

Tycho
