Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD840C32751
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B36922067D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 05:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruSq86Az"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfGaFGm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 01:06:42 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37847 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfGaFGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 01:06:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so31127708pfa.4;
        Tue, 30 Jul 2019 22:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=53yI7Du1C5Yx/YRSxqXhFzT/SrFWtr19Gyuzv74WSFc=;
        b=ruSq86Az/hFA1XRLRxfJyTZjcMfIoQfBDAttrtDRZPfP1MKoEEyjhIxZ8D1cpfR3Jl
         jo0gowfvgCshqSkP0+AJQpG3JDdWIjmEI62mLCtom40mAsCiqyxsbmEEzwpA/ThzF1GA
         duR8tz3RDdb+oZDAyU0TFEtF56c93lblyqJCg9qteuX33OZX9IcmSpuC9dhjF1GzkMvz
         dvOVCeT5igfWCULM/XPeGQSxR/2r46CyEhBSD7FVKBT7uCB7JjyH1SnfQdcryYOUbEuy
         bxwiJyO286zRKbVy3qYmr/CmWAj/EUy3mAOs5QucHbS9zy31PvVGVR0mvmNSat3KaLVu
         gdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=53yI7Du1C5Yx/YRSxqXhFzT/SrFWtr19Gyuzv74WSFc=;
        b=G1hoAcO/5FLf0GX4fTTQk4uVEN+TS02LbYAFSx2AxRuIQvoZ5LfMLtgY15pEEQXZcw
         /UVuptPXPzbieaa+E0YLpbbKBsPDl/eOfEkeByzc4PGsxNEZNWQxhMDdk2Cuqu2iF7v0
         wbzSzINnAoNHzJ/kGBHgCbkBG172PgA1paGSzBQFT+JJtCDfqjJcPwCqjJXe0e8nWun7
         ICjD3NUZjh3DgDtBLrmmRd1h0Wdh9MS1ICiMT2HQTzLod9BNz/cZuHNRpuS0im1GFm5E
         aqwt4DLn9gcZlEmxQA+rhjkx2nO+OGGGLOfYwHNTVwPBqHLY4opz3S1IHtdckgHCxozW
         kZAg==
X-Gm-Message-State: APjAAAUXLsfJ5uyFLO+P414jgS0f7AkbvHdQ57DzdOFsT2r+7Iu1BRK8
        NRi1m+V0/Y/KDw1PPPUEqg4=
X-Google-Smtp-Source: APXvYqwexjdM5l5GUaSS4GsireUeJxxKKZJLOsfIAjCjOwWtwohPQzIWtWFobhYBd71kDZKQTsMrGw==
X-Received: by 2002:a63:fe52:: with SMTP id x18mr111728847pgj.344.1564549601367;
        Tue, 30 Jul 2019 22:06:41 -0700 (PDT)
Received: from mbalantz-desktop (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id y23sm69012441pfo.106.2019.07.30.22.06.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Jul 2019 22:06:40 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
X-Google-Original-From: Mark Balantzyan <mbalantz@mbalantz-desktop>
Date:   Tue, 30 Jul 2019 22:06:37 -0700 (PDT)
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Mark Balantzyan <mbalant3@gmail.com>, wim@linux-watchdog.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        andrianov@ispras.ru
Subject: Re: [PATCH] watchdog: pc87413: Rewriting of pc87413_wdt driver to
 use watchdog subsystem
In-Reply-To: <59b298ec-028b-7585-3477-ff4eabb27b80@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1907302202420.106416@mbalantz-desktop>
References: <20190731032204.78951-1-mbalant3@gmail.com> <59b298ec-028b-7585-3477-ff4eabb27b80@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all, Guenter,

Thank you for your email. Unfortunately, on my end, the indentation is
straight and perhaps through protocol transfer there was stray
modification.

I've made the other changes as indicated that I'll submit in a v2 patch 
shortly. Is 'v2' permissible to include in the title in this case? Not 
sure, but this will BE a modification...in that case I should have been 
v-ing my patches since.

No, the compiler did not complain about no 'return ret' as part of the 
label code block. The function does 'return 0;' at the end, by default.

Thanks + regards,
Mark


