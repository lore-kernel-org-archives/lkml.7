Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18957C43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5602073D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 20:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="TBKwzP3r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfLJUJL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:09:11 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34658 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbfLJUJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 15:09:11 -0500
Received: by mail-ot1-f66.google.com with SMTP id a15so16710480otf.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2019 12:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=kognZ45tk4qO/P86hQbS96WxT6n71WykchkXlMFBnIA=;
        b=TBKwzP3rPMuiyrYGeU+8Gh1gU+oeYz7EGgcmGFtmp3RVEDItjmP2hYrWWig2KSTjx8
         YAVJwDK/ebiKeyKuOM+FxnV09DyEvdC/LqGYSNj1Op8gmbNmy1zeKDUNCLkB7jdBkc2L
         RaGklprLoUcMPg9RmoGOA/XPfuU2B1r5gCAgR3CpdDuHMZIND4AA+olWfvVuEsonX4AL
         ux5E5rABgwjDW3j8/Xbij9FlymvC4UE3k+LxIXlosNRbpn4zjgHGAcoOaohhdKB4dM0+
         jxsR2h/An8iwilkvvF4V53Koqf/uVu0dJ0g9oAIEkvhLdyo/NsjGvnwzvDx4X0APJOY3
         ayiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kognZ45tk4qO/P86hQbS96WxT6n71WykchkXlMFBnIA=;
        b=pInVNhDxK/NlwEeumbidXJL4u1V324Bl7EI3HlNEeD9OqqO85N9DMsWtyTYm1a9K2D
         HWLScXcN57G4z/01ZjXgwRwUTkyLBTz8+mkHGPq9z9QgJ2T27QmAbDchcteO+zPSLQL5
         bxJ+AB9ReC50H8XLqlUdiYjCY/jI2dgileRF+8L/fYiYsH28sjJF+4fm69TD+2sG+x55
         0yjXcaUSNXVo6/iZWE/ZgF8Vx5Jcn13UbfmsroUE4kircpeXPQQqMCaaj45070+vLjqu
         2d68Nf79iXChxDaE/7jqzOkDRVwzje01Yj3fXFw2RB4C2wqW5fpXlW7ILwxS64NTx3AQ
         dTUw==
X-Gm-Message-State: APjAAAW1HARld5pmzVFUPS/H4qSiFHYq2y4kOklZa7Jga04362goRNej
        xS71zLnBbpA5qUhZr25Qh7/nHpHYbQo=
X-Google-Smtp-Source: APXvYqwKGb/fK6fceHg9HEOEr1/bA8SL5OZxSoJpcdtzXMBv+Jtg/rxvkC1QcDp2W9mTiHTqwOHi0A==
X-Received: by 2002:a05:6830:1af8:: with SMTP id c24mr26196068otd.362.1576008550671;
        Tue, 10 Dec 2019 12:09:10 -0800 (PST)
Received: from ?IPv6:2605:6000:e947:6500:6680:99ff:fe6f:cb54? ([2605:6000:e947:6500:6680:99ff:fe6f:cb54])
        by smtp.googlemail.com with ESMTPSA id j130sm1751309oia.34.2019.12.10.12.09.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:09:10 -0800 (PST)
Subject: Re: [PATCH][resend] sh: kgdb: Mark expected switch fall-throughs
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Paul Burton <paul.burton@mips.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
From:   Rob Landley <rob@landley.net>
Message-ID: <35e63e37-6ec8-8a47-8e18-639c954732e0@landley.net>
Date:   Tue, 10 Dec 2019 14:12:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87o8wgy3ra.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/19 2:38 AM, Kuninori Morimoto wrote:
> 
> Hi Andrew
> 
> I'm posting this patch from few month ago,
> but it seems SH maintainer is not working in these days...

Again, I dunno where you're getting that.

(Me, I removed the -Werror...)

Rob
