Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B38C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C925E206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q6ZXGNHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391236AbfISQze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:55:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42948 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388051AbfISQzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:55:33 -0400
Received: by mail-pf1-f193.google.com with SMTP id q12so2682022pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 09:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vKHGVC2TBv+sLI5Edyli1ZnZuQJKo2XmgdaDIhIwBKQ=;
        b=Q6ZXGNHId7DBF16qRzWjOVrjjWMIk9gF2BlQ3nAW2OPUcTUkCsnk6/NyiCDdTnkbuQ
         MVylF1TZ86CAYhVM34nj3IVmzadWHImCp8eXVyaId7+4LfT61yxP+g6jb+kP20WEATgS
         oznxdzTHAqD9/Lokv9dqcPOfn4HLHjcWB3CW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKHGVC2TBv+sLI5Edyli1ZnZuQJKo2XmgdaDIhIwBKQ=;
        b=sVnmShh4vuqVmFavP7f/+5HH+ILrEoE2KSxLEeTq2fRJ2yYCBAClxsxCPtHnrdI0P4
         p/Xi5wJ9OW/F6KA4/nkRi6UpanhlNCzs3CfsdJTmCTKEGRzN/oVzLNeuF31GRFDp7g5i
         bucmBe8snVPm1A+6BIVae98AFIiKjBtD4GtvITCIFYQIv+4QRG/sAcFF4TsYCda8BZa+
         WvY8c8sz2DN4nzrcBMOlDCl4M9Ni2CoRWyC5CJ2e5D/rvsCuTvcL9z4pshINoObuBnrB
         PprSmNAZRCcyeMcQUCCqzRlNUzEpERadpTsH6OO1mpJQ4iUy5YYVCheKnF34sURu/8vu
         vldg==
X-Gm-Message-State: APjAAAVp5e5XZpnnx/Uri+zrex4/41zEQ3BsvLdQVG/GBEyEUfHUdQEI
        XgNznsBWYSOgT6+UJWwVURfS0fk3RPg=
X-Google-Smtp-Source: APXvYqw6zEHZKGyziOXSgqUJbbCCYyEPYuCqQ3kwb1DJ6hxrcEF9h2MB7qPcwFj2W56qe0ZKdQnWWg==
X-Received: by 2002:a17:90a:7347:: with SMTP id j7mr4863606pjs.88.1568912132371;
        Thu, 19 Sep 2019 09:55:32 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d5sm4872630pjw.31.2019.09.19.09.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2019 09:55:31 -0700 (PDT)
Date:   Thu, 19 Sep 2019 09:55:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Dmitry V. Levin" <ldv@altlinux.org>
Cc:     Tyler Hicks <tyhicks@canonical.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        luto@amacapital.net, jannh@google.com, wad@chromium.org,
        shuah@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] seccomp: add two missing ptrace ifdefines
Message-ID: <201909190918.443D6BC7@keescook>
References: <20190918084833.9369-1-christian.brauner@ubuntu.com>
 <20190918084833.9369-3-christian.brauner@ubuntu.com>
 <20190918091512.GA5088@elm>
 <201909181031.1EE73B4@keescook>
 <20190919104251.GA16834@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919104251.GA16834@altlinux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2019 at 01:42:51PM +0300, Dmitry V. Levin wrote:
> On Wed, Sep 18, 2019 at 10:33:09AM -0700, Kees Cook wrote:
> > This is actually fixed in -next already (and, yes, with the Fixes line
> > Tyler has mentioned):
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git/commit/?h=next&id=69b2d3c5924273a0ae968d3818210fc57a1b9d07
> 
> Excuse me, does it mean that you expect each selftest to be self-hosted?
> I was (and still is) under impression that selftests should be built
> with headers installed from the tree. Is it the case, or is it not?

As you know (but to give others some context) there is a long-standing
bug in the selftest build environment that causes these problems (it
isn't including the uAPI headers) which you'd proposed to be fixed
recently[1]. Did that ever get sent as a "real" patch? I don't see it
in Shuah's tree; can you send it to Shuah?

But even with that fixed, since the seccomp selftest has a history of
being built stand-alone, I've continued to take these kinds of fixes.

-Kees

[1] https://lore.kernel.org/lkml/20190805094719.GA1693@altlinux.org/

-- 
Kees Cook
