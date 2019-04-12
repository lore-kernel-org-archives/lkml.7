Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD5C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F1272171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 11:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g/aRvsYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfDLLJ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 07:09:28 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43686 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfDLLJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 07:09:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id k17so6736461wrx.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 04:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YyEzS7TnsOqr9o50OG+w7r/r1TOsp7qz+hz4A5W9UhI=;
        b=g/aRvsYHYxdDXh4EFWk3cHFPNoT1owBzdPzk65Ho2obrGgDlUuHsJN909XD4g96DVR
         /A2ryI8/UEcWwJT+UFMnwpWxt0CKE/PWtxmIEnxIt3BjAMpBpbstX6L/qq5HkR+/EBiz
         VAwHNONebhC9DAfDQWbuap2YPG8NDprS7x2hmHzoCbaUr3ADXRIdIWCnPiWQEMVtSky+
         5hl045zUGh9OajbYPLT0CBYwHfDmsW4b6vhhVnl56zu34O/CkKeV23ycpG2MgWDEG9uK
         L1vOvmv+lkP5ALmENlwXC70ApLUwbqBo/F0lUQBE6GKeQnYpLAtvY4bvEAwwI80h6hPI
         97fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyEzS7TnsOqr9o50OG+w7r/r1TOsp7qz+hz4A5W9UhI=;
        b=RSEMCtkZrVplwnMcyqvX9CZ/16xpFgnK67lcLb3D0Kf+Y2xGhA/P8ucpqnz6keqf3/
         0nyHk28hVlBf2DylwhNHadWx3b24i5jNPO9vzdq/OT7zTRUndrEsE/wh0PyH+AN5OH1C
         fVmW2lNUhhZj8iTQdFQAUgP54Ai7hTRlRsrAPOdhrwyQ6wOLsFJMVzWEKDvV8QCdaolo
         2jxt+NK+QZosg/uSH82hO84GxsEAqGCrpOF0XiaWH3/Yr5Z/S1Usbovm8tOps1oniAm2
         EURR7uB2sCwwx6tNFMS/EHzT9kWIkUSxRD0IXO7ZLpWK2gfVaXkUTkr31OBveJe2Vt1N
         mOng==
X-Gm-Message-State: APjAAAW2HzsH8RVm6uf9HnIKFPm3DwnRhBHzB3bqnRW3TL97RmKh5XIH
        Q4llNRzdjrg20amz+ZngkbPWMg==
X-Google-Smtp-Source: APXvYqyg+2Vsd6MyYFRrNVeyhQctKH3otR0j3E06DdXzOCaVgn1/7XurzAIyJ+ahPr2scYB2QWW6TA==
X-Received: by 2002:adf:d081:: with SMTP id y1mr36515373wrh.283.1555067365789;
        Fri, 12 Apr 2019 04:09:25 -0700 (PDT)
Received: from [192.168.0.44] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id 7sm137426268wrc.81.2019.04.12.04.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 04:09:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Bugfix and cleanup the timer driver for Milbeaut
 M10V
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>
References: <1555054611-23566-1-git-send-email-sugaya.taichi@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2b6c5bad-485e-657d-e5fe-17fb6281041e@linaro.org>
Date:   Fri, 12 Apr 2019 13:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1555054611-23566-1-git-send-email-sugaya.taichi@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2019 09:36, Sugaya Taichi wrote:
> This series fixes a bug and cleanup code about timer driver for
> Milbeaut M10V.
> Since it is difficult to separate, it is integrated into a series.
> 
> Changes from v1:
>  -Add "Fixes" tag.
> 
> Sugaya Taichi (3):
>   clocksource/drivers/timer-milbeaut: Fix to enable one-shot timer
>   clocksource/drivers/timer-milbeaut: Add shutdown function
>   clocksource/drivers/timer-milbeaut: Cleanup common register accesses
> 
>  drivers/clocksource/timer-milbeaut.c | 66 +++++++++++++++++++++++++-----------
>  1 file changed, 47 insertions(+), 19 deletions(-)

Series applied for 5.2

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

