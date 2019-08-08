Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958BDC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685EA217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 09:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoAMv3De"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388822AbfHHJJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 05:09:27 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43039 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfHHJJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 05:09:27 -0400
Received: by mail-yw1-f66.google.com with SMTP id n205so33712479ywb.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 02:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=30SazUA7Tq8vOLew/Q0ozPIJ6UITJfx6OSiQFokXt+o=;
        b=QoAMv3DejUjfnhb+6oRokGpixiiFkdSEwUMfIfWbE6OX7L2QqcKZDYpsVwpgwGt0Xk
         gznDPs2eCQSu+Ggc2KcoJCA0UdzunKgwi8hiTkLY+ZHSFkDOl1zUGU2gyauNO+35qNsp
         kOwUFaWA5dDE0XeEaTNpCZhgnTj2tFJ2LW3zQ8yymhoVryuAUaO6vk4vwuh8h+YQAoJi
         Owph5vWtqqGKlpcP8gxCftLVd4t68yaEHLI2r3anufZwM+CkEeaZRxVRjJcy6dqaTrRW
         n1JgFKH0jZOf0AvisfXH1BJw411XGuGYF7JGcYpFv4hjSmhazYegG1xn0LEBVT+LZNGq
         fPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=30SazUA7Tq8vOLew/Q0ozPIJ6UITJfx6OSiQFokXt+o=;
        b=P82tZyMZxkNqdeo73iscI7DkvI/Y0WZ+LiwGrT3dL0LJHMRU70bj+tpL9yAM+eui4W
         6rT9oUw1E5LenpmlSLN+k/J/vx5+LxP09HIKQR9cl58YUoLe6MHNoPo8f2MKSiBONM/k
         4e9NSxTH4XuHCnkLuQZSpGsM/qnss3W+Vs+cHjV94k8Kw38AHFMrz++D4Z656YzPBnz+
         Cb8sMzOX1HD72gbzV9t4CZqPRENy1n3HffeyM4MYYGMIsMoLsJIrkJ5mng0Ffr2Ov3ep
         3sfZD6ndgf34wl2otkdKV3Gs5Vis3zXLaOJX085rNwZjo8HRDv85+LGigFDw4KYYOpl1
         3PbA==
X-Gm-Message-State: APjAAAXUAcYTEczZ6Bqji0hTkK9NnpmGfC9zXo1OhqyhgslHzB1Ohnr/
        05dJZqUV1BCsNXiM7yhUK8aNMQ==
X-Google-Smtp-Source: APXvYqydeeI1ncc96UjZdrxAXhHgXZE1BP0vhmCGoDri//M4yZCIqo84HVJCeE6X+NfJt2l/kTMFsg==
X-Received: by 2002:a81:3646:: with SMTP id d67mr9291114ywa.77.1565255366232;
        Thu, 08 Aug 2019 02:09:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li1322-146.members.linode.com. [45.79.223.146])
        by smtp.gmail.com with ESMTPSA id z9sm21277603ywj.84.2019.08.08.02.09.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Aug 2019 02:09:25 -0700 (PDT)
Date:   Thu, 8 Aug 2019 17:09:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2 0/3] arm/arm64: Add support for function error
 injection
Message-ID: <20190808090913.GD8313@leoy-ThinkPad-X240s>
References: <20190806100015.11256-1-leo.yan@linaro.org>
 <20190807160703.pe4jxak7hs7ptvde@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807160703.pe4jxak7hs7ptvde@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 05:07:03PM +0100, Will Deacon wrote:
> On Tue, Aug 06, 2019 at 06:00:12PM +0800, Leo Yan wrote:
> > This small patch set is to add support for function error injection;
> > this can be used to eanble more advanced debugging feature, e.g.
> > CONFIG_BPF_KPROBE_OVERRIDE.
> > 
> > The patch 01/03 is to consolidate the function definition which can be
> > suared cross architectures, patches 02,03/03 are used for enabling
> > function error injection on arm64 and arm architecture respectively.
> > 
> > I tested on arm64 platform Juno-r2 and one of my laptop with x86
> > architecture with below steps; I don't test for Arm architecture so
> > only pass compilation.
> 
> Thanks. I've queued the first two patches up here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/error-injection

Thank you, Will.

Leo.
