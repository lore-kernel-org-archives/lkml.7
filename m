Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_MUTT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CDFC04AAD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:32:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55ED620675
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 18:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9pn7hTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbfEGSce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 14:32:34 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34317 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfEGSce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 14:32:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id n19so541924pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 11:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L9NP0SdsXX0ATQ7hd4FjxeMY66WC5qCBDhcE03wlMhQ=;
        b=n9pn7hTy9KeLWgCDSYDl8ehIiuebJ7aO3nNdFBbXLH37I+1VGfxYiaqMQIEpUnpIPL
         OOQdkHsKxGosIIg1Ojsclp7fzclPx5QdLp0tpD6V2MRTelH82w79OrWA2Wru3n5SWnjJ
         btm1yoHLX7jisUvqex0E8XlrfqNKCSXawfT107h9rokUwhcSdHHa1zskeKwDGCDBun08
         1dUDRURl+9pcBmyQ7DyV+pOf3nHd9GcXo6wRSEwO50Ispp5PBZuDlVtlSzts/22JsuCq
         XGOJ5e390VuNE0Qr73SMTMoPyf3dRQ2C3U+4rBMnkzQWgyvLmtUKwmKsYgRgFAovdbO1
         EONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L9NP0SdsXX0ATQ7hd4FjxeMY66WC5qCBDhcE03wlMhQ=;
        b=DxWMuzwy2bbvciGUgP79MAC07QsZiCrOZsKZbIlU1aib9vEaAIWAv+1gHKQQyjj9Kq
         QEzt7iR24bmnfJC6dGD1IrudonkDYwlOo8ObRYPsbYtoVADY3e6RkqAumSZ72iuGXfYo
         Pq+XwXLe3+IewXnFS6d8fVpBXGozRJWVowOd3HYlk83mfr7YTnh65iNC8P/OLH0vp9co
         shPCdiAbf5eyvxsYsK/4bjoXlK/t6/hFgXu+pp0k/lqo8/F7DiG2hoMzu59Nx+hd2Vuw
         xTkGeCZt4TwXRc1Fg3dsQ2S8MUUJJt0Aq9A3XTdUV76zrirx3oI31ypESYble+Sj+haC
         EJ+w==
X-Gm-Message-State: APjAAAUJUba05ePabn53bbbvEki1akH7y/gqU1BY2wn5hkNMX4iRg6XM
        fUjLsLW8RXc/ErsdR+9E3U+Rog==
X-Google-Smtp-Source: APXvYqzbS5T0pyt5oyrebrwGtITwJcnl5essJwblVvuBYtzglREQxvzkfbjLim3A//WXRWpXvS7Z3Q==
X-Received: by 2002:a63:1654:: with SMTP id 20mr41908345pgw.166.1557253953236;
        Tue, 07 May 2019 11:32:33 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id f15sm16524993pgf.18.2019.05.07.11.32.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 07 May 2019 11:32:32 -0700 (PDT)
Date:   Tue, 7 May 2019 11:32:27 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: use the correct function type for
 __arm64_sys_ni_syscall
Message-ID: <20190507183227.GA10191@google.com>
References: <20190503191225.6684-1-samitolvanen@google.com>
 <20190503191225.6684-4-samitolvanen@google.com>
 <20190507172512.GA35803@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190507172512.GA35803@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 06:25:12PM +0100, Mark Rutland wrote:
> I strongly think that we cant to fix up the common definition in
> kernel/sys_ni.c rather than having a point-hack in arm64. Other
> architectures (e.g. x86, s390) will want the same for CFI, and I'd like
> to ensure that our approached don't diverge.

s390 already has the following in arch/s390/kernel/sys_s390.c:

  SYSCALL_DEFINE0(ni_syscall)
  {
        return -ENOSYS;
  }

Which, I suppose, is cleaner than calling sys_ni_syscall.

> I took a quick look, and it looks like it's messy but possible to fix
> up the core.

OK. How would you propose fixing this?

Sami
