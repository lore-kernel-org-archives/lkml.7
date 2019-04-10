Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD1EC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140CF20820
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 22:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554935367;
	bh=+Lf85JcThgYgpbalUBzZa3nupZ7TrpjCkHLZzWLUD7k=;
	h=From:Subject:To:Cc:References:Date:In-Reply-To:List-ID:From;
	b=k2bSKS5Cxbdm3nzjKaA2eKavYYb0b5LYgMQnwJjSq5SVYapTT+ENrZirtGlyi+7Cr
	 ioT4btFO6g8PqkPkgbc6vgCOiOamJl/Fwgl89xYEaarwL0qf1L7vyBOWoTbMhXJgiT
	 DK0S2EWfIPHaSY4VOSrpOMTEEZWF+I2OoHLqw6S0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfDJW3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 18:29:25 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:43115 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfDJW3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 18:29:25 -0400
Received: by mail-qt1-f195.google.com with SMTP id v32so4846412qtc.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 15:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jMcazFuxAtw5pRatKr3RUWliH4jcyfAJKZLKu69mNfw=;
        b=Z0B4R9JCoYNZnNZL0c3xqIEtswf86cj1KU513k+393sn+oAjbBu7XO9jcncUFoPBb8
         7HnC2achhZd+K84a+gI75jIrtbNhUfOJapT9e0QZULTGWGcyr764+z7VpSheSXa2IUJG
         6tYrByrwe4Kfu609ulkH68AEPW/kU429TMjVKfnfvTcrGlDdt5YUUSfvypyzX+dMfltb
         Y8NU4x52WhaDYxA22tEbi6is7h0vkld+C6uVa3ulA5KDGECNdQw7KxIALPel/Oyyd19B
         bng/yXNHFdM/1VZk87oj14XSLzbo5xcnHeYUq8WchecB/7T36Zr1sRwU5I2JkET3geji
         g9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jMcazFuxAtw5pRatKr3RUWliH4jcyfAJKZLKu69mNfw=;
        b=s1vGoK7pEx65H+Di7ipLXUhL2Q5RtyRQIRS0GqGuqUOpvVX3mbuxuFWjPVsO8RjbVK
         mtqHOhnZ/EwMqJyHXpWTZVplabGbNSlopIZHD4EauTIHYlAxRBUp87fnkyN7VVHFk6CN
         CXWDZKSb1B+JfL2xJ67RJce3Ltod/UFicK3IDNvv+kTBgN6TVOuH6Fa8XGM1zUOOZ/0J
         jm5FAMXBj+Z+Yhaout8WZ0Oz4pyZRrZPD+r3z8n0FYGc6PCRrGBogK0TC0Kwbr8Gl2jm
         gZOlY1pScQK+LNHnW0sWh+6b+1DjTeNoTKmlU5Q/yR5gql15zS62FrHI2zq9PCSDa+f5
         LqUw==
X-Gm-Message-State: APjAAAWJZrje2vtxAcf8fkS/URtjh0GU8MLKV6NdXC46IGtOFuidxZml
        aFOlJhqkvjqAA5tnFongqww=
X-Google-Smtp-Source: APXvYqyfIy+dSdFdvKrNtkUspS+ZkPmqIAhvEWs9xYry68mJSM0osbLYyTdpjolchI7mE588/mq56g==
X-Received: by 2002:aed:3e13:: with SMTP id l19mr39502666qtf.125.1554935364384;
        Wed, 10 Apr 2019 15:29:24 -0700 (PDT)
Received: from [10.84.150.60] ([167.220.148.60])
        by smtp.gmail.com with ESMTPSA id 27sm18427893qtp.49.2019.04.10.15.29.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 15:29:23 -0700 (PDT)
From:   Sinan Kaya <Okaya@kernel.org>
X-Google-Original-From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v1] init: Do not select DEBUG_KERNEL by default
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Adrian Reber <adrian@lisas.de>,
        Richard Guy Briggs <rgb@redhat.com>
References: <20190410212627.29514-1-okaya@kernel.org>
 <CAGXu5j+uBuPjDc+gGcxW_QoJJi7sQZ8m=Zg-Q2wKDxyTt7yGvg@mail.gmail.com>
 <a9508cc3-3385-256e-2f27-c1e0a770ba69@kernel.org>
 <CAGXu5jLPxUESH9eMm6rvaTVue_9rNEdx+9dcxiV11kgi03jUmA@mail.gmail.com>
 <ac8f52a9-30a4-41fd-50f6-65c8ae859675@kernel.org>
 <CAGXu5jLsdSsgVmAU57rpBVAYK6-KxEhzDKj-w5-z2c+dsofD-Q@mail.gmail.com>
 <a4896565-9586-981b-06ea-03b0b7c41476@kernel.org>
 <CAGXu5j+Qz4RTeXR8UYqoYnQtLf42QLn5duUue_OmdKQKq7MeZw@mail.gmail.com>
Message-ID: <81ef488c-ab39-59db-86e7-e36391caebd8@kernel.org>
Date:   Wed, 10 Apr 2019 18:29:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Qz4RTeXR8UYqoYnQtLf42QLn5duUue_OmdKQKq7MeZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/10/2019 6:28 PM, Kees Cook wrote:
> diff --git a/init/Kconfig b/init/Kconfig
> index c9386a365eea..7ce4a60ab3e9 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1188,8 +1188,6 @@ config BPF
> 
>   menuconfig EXPERT
>          bool "Configure standard kernel features (expert users)"
> -       # Unhide debug options, to make the on-by-default options visible
> -       select DEBUG_KERNEL
>          help
>            This option allows certain base kernel options and settings
>             to be disabled or tweaked. This is for specialized
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index d4df5b24d75e..6a9bc118b64a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -433,6 +433,7 @@ config MAGIC_SYSRQ_SERIAL
> 
>   config DEBUG_KERNEL
>          bool "Kernel debugging"
> +       default EXPERT
>          help
>            Say Y here if you are developing drivers or trying to debug and
>            identify kernel problems.

Got it. Thanks. I'll test and respin v2.
