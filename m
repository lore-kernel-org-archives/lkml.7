Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C374CC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93ED121873
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 09:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxJdMBDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfFDJb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 05:31:57 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40401 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfFDJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 05:31:57 -0400
Received: by mail-pg1-f196.google.com with SMTP id d30so10008529pgm.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MimY8E6RzMP+Xm09/RStVcP0kJblyDIRLMNiKjGKR1U=;
        b=jxJdMBDIJRCbNIZuMnUELhdpEn41VADNgzlplcmAXJynP+m5d5YB4HbguZiv5hotqh
         l9w0GY8FrukKhQunBoGC3tAk0TlFur1DY+UTBOFMtEibcehQBzR0/478UnelnBdK/V6A
         civ0aWuPhTj2Lwrl6dlU8QQhiKIrTdiBTJx5LpmBsvNbpvea8RzLiWd+RM62SI1//lOZ
         yUk4JVITz3zKEWBmVqO8Y91afvJI7gLRH7sNlStVxUs/iSwo5FYEqRV3GrEhSEkLmf7U
         pI79hFjf/o2dlic8f0PYj/PwMYEMLQwYNb+R9/B1m1R3PcNiX5lysTh/prELjaTBLH7G
         7OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MimY8E6RzMP+Xm09/RStVcP0kJblyDIRLMNiKjGKR1U=;
        b=boxDhVcE6HTvqJUCCZtxBDBN3LKJQUD63dWcAHzv72f1RVS6EOIfHyHRFd15NW9wRA
         +5Q/Z2eKXQmpA8YKMtUQuwJpd7c50G0fsXV9VRKDm3RPq1xoYhgt/2SK4imLufQk5k8D
         ec7WTLrdEVv9sW9pUQfapFTUcAzDbmlzTxQcPq1eODhZknNAEJuxOrjp1H7caI0Ym2T8
         MDiFQ2KPc1Eh9olCSMKNfpNAa19bHCaocmcGLLbO1RyTTh5BKV6M0cuiv2IpT67lEIU3
         eJpwt2HhZu7F1peKrYs81qFsOnNMW/AFcnYqUbDAITQvPrZh5gAhQ5jh1ebV1bEnetwJ
         +5lw==
X-Gm-Message-State: APjAAAWKvt93IKZs2ZWanxJAJwTJxKWT0Oqa1xxT5m/3GQzL9G1Vt3dd
        dCmBQw2V7d0VbSJBCnZaXF+bTq0INkk=
X-Google-Smtp-Source: APXvYqzkBCd15WCdDavN2+OthVD2LAb86dzXlH0Ye+ZreCxe0UdK/8MuhKMRME3oQVp6Fs1Cw+s2oQ==
X-Received: by 2002:aa7:92da:: with SMTP id k26mr36714866pfa.70.1559640716355;
        Tue, 04 Jun 2019 02:31:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id b16sm17600287pfd.12.2019.06.04.02.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 02:31:55 -0700 (PDT)
Date:   Tue, 4 Jun 2019 15:01:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604093153.2pzv55knl6axugrv@vireshk-i7>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <20190604084349.prnnvjvjaeuhsmgs@mbp>
 <20190604085545.hsmxfqkpt2cbrhtw@vireshk-i7>
 <20190604092639.GS28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190604092639.GS28398@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 10:26, Dave Martin wrote:
> I'm in two minds about whether this is worth fixing, but if you want to
> post a patch to remove the extra const (or convert vq_present() to a
> macro), I'll take a look at it.

This patch already does what you are asking for (remove the extra
const), isn't it ?

I looked at my textbook (The C programming Language, By Brian W.
Kernighan and Dennis M. Ritchie.) and it says:

"
The const declaration can also be used with array arguments, to
indicate that the function does not change that array:

int strlen(const char[]);
"

and so this patch isn't necessary for sure.

-- 
viresh
