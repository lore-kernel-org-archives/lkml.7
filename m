Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D848AC4321A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A982F20859
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="TvZtoqZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbfFJVJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:09:27 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42727 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbfFJVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:09:27 -0400
Received: by mail-oi1-f195.google.com with SMTP id s184so7313219oie.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RnqJvuP47eygGAcCI6o0uHW2YRUzwdS2mc5Ld3Nd0qg=;
        b=TvZtoqZbjQpegfCVWww5yb1sIBQbI2vFCZ+2g/WKSDMnmvZ7g0ZUr1jH24/VG+adbt
         tM9pqVnaK4zqgDgpNiyWwa4cEHXWwAp1chnHNbhAIUs07Qt5KYFTVN0nS4aCMdPawYsw
         aAb1LlawIeJ07zDUJjNasfCU3TsOb2pFCowJNfwtH1ikerpLpPE0WNtfBMJGmg9bty+G
         Jsg5ptgyzc5FnTmBZ3OW6xvqGcK6ISzYlCsc4x0mi+q+ZgbumcSsciozDCUvacAm8Pw9
         lqndUJduHc226pY57AjtHpEypNWUKzc/Kfkwq8kOnpExipVG+uoUE+aKXZj9g9ZvFuV9
         PT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RnqJvuP47eygGAcCI6o0uHW2YRUzwdS2mc5Ld3Nd0qg=;
        b=BQYKxY0GkaCpRjZw+CNVlhjvU2vtYDNwoOZqFVMaPYLWUcMWxdoEi2OpiuC9mKI1SY
         pJ64w497rUxmYk6LqtcVNk3nj0RsVLWcAd/pw909GcJL2TtFbIL5ds/gposjgshs78UR
         7ipeKaXvjVAW+GkgrJCcvT0SecgGIMvupp8KbaCMd/GBLPcbmuX6yp8z3tazVo3gbzXo
         i82zAe2ELIqSwKGhWIBVehtd0A9vvfVpUVVCBSL4ViIsR9kA2heJ/BgnvhCYPiErDZ4v
         LTHfpI8JXs2Bf0IzT8Gx9R/Nlf03B/DHzrs47n49Oe5yKB+Fo4c+4CV7+rzQyQxhIpuc
         aVeA==
X-Gm-Message-State: APjAAAXmL8L1gnsuuv0x950KG+3XhEMiTR4MyYFBwdPu4e+jeiUpgQvs
        aKSl0cnm9K+RPZywcg8TKd34BPefCzY=
X-Google-Smtp-Source: APXvYqwnuhu+6dREhWSI2u5WQL/rb2YVC1KZBNsqmNu3b/EdFqjhrLwLZW3wlRwcX2xiUvRViX0q/Q==
X-Received: by 2002:aca:318c:: with SMTP id x134mr12789946oix.125.1560200966914;
        Mon, 10 Jun 2019 14:09:26 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id b62sm4392772otc.9.2019.06.10.14.09.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:09:26 -0700 (PDT)
Subject: Re: [PATCH 1/7] signal.h: Define SIGINFO on all architectures
To:     Arseny Maslennikov <ar@cs.msu.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Cc:     "Vladimir D . Seleznev" <vseleznv@altlinux.org>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190605081906.28938-2-ar@cs.msu.ru>
From:   Rob Landley <rob@landley.net>
Message-ID: <43d9e091-7f7c-1175-dca9-06c5e547803d@landley.net>
Date:   Mon, 10 Jun 2019 16:10:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190605081906.28938-2-ar@cs.msu.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/19 3:19 AM, Arseny Maslennikov wrote:
> This complementary patch defines SIGINFO as a synonym for SIGPWR
> on every architecture supported by the kernel.
> The particular signal number chosen does not really matter and is only
> required for the related tty functionality to work properly,
> so if it does not suite expectations, any suggestions are warmly
> welcome.

This was the problem I saw last month: 32 bits worth of signal numbers already
defined, gotta alias something.

> SIGPWR looks like a nice candidate for this role, because it is
> defined on every supported arch; it is currently only used to inform
> PID 1 of power failures, and daemons that care about low-level
> events do not tend to have a controlling terminal.

/dev/console isn't a controlling tty so ctrl-T wouldn't send SIGPWR to PID 1 anyway.

> However, on sparcs SIGPWR is a synonym for SIGLOST, a signal unique
> to that architecture, with a narrow set of intended uses that do not
> combine well with interactively requesting status.
> SIGLOST is not used by any kernel code at the moment.
> I'm not sure there is a more reasonable alternative right now.

The fact it's already _been_ aliased once says it's a good candidate for it. The
easy solution is don't support SIGINFO on sparc until the sparc guys figure out
what to do there and add sparc support in a follow-up patch.

Rob
