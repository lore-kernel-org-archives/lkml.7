Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7748FC04A6B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:39:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA842082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 17:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="La7fGjQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbfEFRjt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 13:39:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38741 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfEFRjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 13:39:48 -0400
Received: by mail-wm1-f65.google.com with SMTP id f2so11321839wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2019 10:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zyUOqcowBEJ2l4EmKaOqaodsfJOAPAaE+gwxfie0pw4=;
        b=La7fGjQN+Tpg654Ybjsk8nXf7jdW84uWIoMQaXu8pTlYA0Myq4YdTiSHebksnInCDo
         /V7cI5O49WZLtPVV6FYMvA9wON4PdzXSt7fxkc+ZDJ6yiuOeoyc4TN2bogyL02Q8mzDq
         Yci7sXQxTCv+FuegY4C05KNNZk64+CIykfDMLSC6/0Nh1oMETGYUbHeXV5+V8xxKk3Yl
         8NgSQ15TJqWs31GO1Sb2lajRQltIrAo806AjwfL393auq7UBb1qpKen0JMQlySzM+xqD
         RET9nrIzoW2oitxET50ZstzHqDWJY3iN7sLe4RYRBwzy/nlY36KyNMqR20pKaxB5g7C0
         0Lwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zyUOqcowBEJ2l4EmKaOqaodsfJOAPAaE+gwxfie0pw4=;
        b=VhFAo3Qp0ETj7cZkbAZKadI48Hj/CEbtrh1/OZV3+4fCa95wQswCTaq/ewexPm2tpq
         K8Xe+3TUvsN/JfhmTFDy8VKwhsPm/4QHyFxQxhBT8kABt98FAMr7Rr1Ddln7M6tjUxAO
         6AjB1HILAaJorfTyLjRpK5ZeMk5bGhVtK1joXJu13JaHdtDjkLVExnjN+JP2EQwNfSiL
         RT/l9qHyqLS/XgjyhESqSQOlTRx3NhZw/xZXxb0YiiKYxr/HywGbrZBi2Tw6sI22X0zi
         zV7jpXWLM+8mNFONFUWWVHLLmxdja07aRFABUGxaofBL1gq5d7JsKzDTNb2yvrTpt58T
         9nPg==
X-Gm-Message-State: APjAAAU2TrxrHZkK2GkEehsc74V4XDy2HYyhFrXERpXIbOVzY8fCgSmR
        BnFNsyn611sqRHOGlJhViWUj2A==
X-Google-Smtp-Source: APXvYqyf2cb8qXuGQGElB8nD4bTSPaG//hqg3L0nOyHcl3aEnxN38pPpVbUEQDPY9YPGpLFejjha4A==
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr18837542wmq.31.1557164385868;
        Mon, 06 May 2019 10:39:45 -0700 (PDT)
Received: from [192.168.0.41] (64.93.129.77.rev.sfr.net. [77.129.93.64])
        by smtp.googlemail.com with ESMTPSA id j10sm32918866wrb.0.2019.05.06.10.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 10:39:45 -0700 (PDT)
Subject: Re: [PATCH] Remove MODULE_ALIAS() calls that take undefined macro
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kbuild@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Lee Jones <lee.jones@linaro.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-omap@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
References: <1557163697-17882-1-git-send-email-yamada.masahiro@socionext.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6d8e2880-0cc0-a7d8-1d42-4401e15e3ac9@linaro.org>
Date:   Mon, 6 May 2019 19:39:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557163697-17882-1-git-send-email-yamada.masahiro@socionext.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2019 19:28, Masahiro Yamada wrote:
> These files do not define (USBHS_)DRIVER_NAME. Yet, they can be
> successfully compiled because they are never built as a module by
> anyone, i.e, the MODULE_ALIAS() calls are always no-op.
> 
> A problem showed up when a patch "moduleparam: Save information about
> built-in modules in separate file" is applied. With this new feature,
> MODULE_*() are populated even if the callers are built-in.
> 
> To avoid the build errors, the lines referencing to the undefined
> macro must be removed.
> 
> The complete fix is to remove all MODULE_* and #include <linux/module.h>
> like many "make ... explicitly non-modular" commits did.
> 
> For now, I am touching the offending lines.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

