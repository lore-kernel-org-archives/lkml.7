Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0AC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86FAE206C3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hrUWYPl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbfECRCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 13:02:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46900 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfECRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 13:02:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id j11so3154072pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2019 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e71LeW3j52z02CfoTglw12Lmjisq73YxcosFVCbh53o=;
        b=hrUWYPl6ix6lmEUT+7gmZcFzhb63MdRST9wYPDOIVDmC/LzaxdIO5YqMR9VHPo0Bm0
         82stpci7nJLYQd5BJl4soh4Z123TLPBWd09ZiRFMLpvEXvCMb061QG9scqw6rKtpjh1E
         kkX/N5wtLrWsHL4J8i87lISK1gdR2s5yYRrwWyERLEcyPvXTU/sq2szATYe2giWY1Voi
         xegRCJX/tNYrsRrlMBUOoE/lSVvaj9xedR/ofO78sPnsVcn8prsnDB5Yr6LyCqUE5WTv
         mbWGCLv9qzSIZdmyGpriTFfAh+bRHrqHP2qnfunh3CTdkyZihHHjTUToVuOGOkc6JjZe
         6jDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e71LeW3j52z02CfoTglw12Lmjisq73YxcosFVCbh53o=;
        b=DEfy5oIsk0Tv2YYShWMafHDOA8bedjXSv/6UvNqdxvZZUvC/xRiVZdY04CeEc1WKBO
         V4iJO/SmtHNJulqEKRgb8k5RqrjjFwrcD5gcrwA2DEqX4a6hO7ti6rjKNVoj/nmJAhMi
         b40gYf8LVWeocqNYWGrdIDy89h1SOVpHpnWQoa727nd/aJUUPJusRzya1Vs5w67WtY7G
         UY70LTb7nZydq6/L8gKFNLqCjmMLMagoflujBQNx/syOfbPy/HSsMJ0usJNkK9qih8aE
         z93NgnXXbVX7O1c1V7X68Imv5iMto3etfU1z/TcNBWBd823IQphgov5mQtdBD+0NMtzI
         /8sA==
X-Gm-Message-State: APjAAAVExfsPmPaB3y4CAzOnEs97lPBg2ofAryxdYSqxpo81Gw9uSP/3
        cNFgD4j6vn0gejXeitlZ0A9jDA==
X-Google-Smtp-Source: APXvYqyTK6cg0M1/C2OXTAJ465eNh4Ogi4rZP6tl1I9CMzK8OhQ3QscAC72wbWMwk3C+thhafvr1Sg==
X-Received: by 2002:a62:5fc7:: with SMTP id t190mr12168728pfb.191.1556902968531;
        Fri, 03 May 2019 10:02:48 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id j7sm3380683pfh.62.2019.05.03.10.02.46
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 03 May 2019 10:02:47 -0700 (PDT)
Date:   Fri, 3 May 2019 10:02:42 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: use the correct function type in
 SYSCALL_DEFINE0
Message-ID: <20190503170242.GA211922@google.com>
References: <20190501200451.255615-1-samitolvanen@google.com>
 <20190501200451.255615-3-samitolvanen@google.com>
 <20190503102128.GD47811@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190503102128.GD47811@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Fri, May 03, 2019 at 11:21:28AM +0100, Mark Rutland wrote:
> Generally, this makes sense, but I'm not sure that this is complete.
> 
> IIUC this introduces a new type mismatch with sys_ni_syscall() in some
> cases.

Thanks for the review. You're correct, sys_ni_syscall needs to be fixed
too. I'll include this in v2.

> We probably need that to use SYSCALL_DEFINE0(), and maybe have a
> ksys_ni_syscall() for in-kernel wrappers.

Why would we need ksys_ni_syscall? It seems something like this should
be sufficient:

  asmlinkage long sys_ni_syscall(void);

  SYSCALL_DEFINE0(ni_syscall)
  {
          return sys_ni_syscall();
  }

Sami
