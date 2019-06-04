Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6EAC282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331DD24AE7
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/1BYv8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFDIj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:39:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35429 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfFDIj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:39:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so8059532plo.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 01:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9jjhf1qdL2MafkChBuP3uS+RTNrDWf6uQ5f116KCA2c=;
        b=R/1BYv8OoEAUiLPx6NI4JKkrBSSi/SSZ5etYBe7bvAN6vIDmwNO+lHDRdqjVBNQjin
         H+9WJUbycCX09ft7jeo1RwSbBmS/JbGjhw2h0nRODdNdmH2j8+p3X5/IqSREmbTVYdKh
         jYtr0D6CiWKVJUltZDsvR7Li9ljJdTLEdRCN5BAtnMAw5NgyzB/DuLTgAPN63NPEUBGG
         oyiGOxYJMfgKa5dqaxEUCGya8yjW1QQeKvcqk8RrenqYLcWWqMxyupGv5nxxmdXsdigZ
         8blPkPcHVDXb3yCSelTiJssCWLyxfOWrMfblAEJgCmw7bgfdpkELrwDmK6oQxpemZ4Wi
         6nGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9jjhf1qdL2MafkChBuP3uS+RTNrDWf6uQ5f116KCA2c=;
        b=JVS+a2G++tPU9YrWaa/IMe2UGayJR39iF2XIerlgoOIqlZ8CbF/HyScgKgffoIyWlG
         /N/GCxfrnt/mF8nuxvZMb9SSLdNo4rB8dAepPSNOq6S2O0S+tY9E26Pii66u7xiAiq+y
         4xotFeuOlCZqU51xwYZTry75Q6uryJY6e2Ljxz14D3ONM+dA8GpXuJvxmYSaspttTojT
         pZYrmj9fA0P/DKfA2wRfYHZdRkyAZgP80sZDapyVx/VCO9MEUcQ5EB3wYyj3KcDqu4gg
         nXzYf+fmrGtM/42zGlaNEUh34e/pgWP1UvRD/DOGnZlNvRTqKuMkLILdVeFstEaviXI4
         tlxA==
X-Gm-Message-State: APjAAAWQ48Rx8c1qF8XptrPVNsDRa5VjCmyU79eRyiixX+3u2g8s90FO
        nX3Uq5M3WGhwaMMpff4Nsqz8AQ==
X-Google-Smtp-Source: APXvYqwTQEAPd18gZqeEmzC2WFCpS0mvDpNCW4MkbXVyYBl0A48wQeEqLgL0pHs3OD8tbWfxvM6LQg==
X-Received: by 2002:a17:902:7591:: with SMTP id j17mr35215640pll.200.1559637596920;
        Tue, 04 Jun 2019 01:39:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id z17sm4656763pfn.44.2019.06.04.01.39.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Jun 2019 01:39:56 -0700 (PDT)
Date:   Tue, 4 Jun 2019 14:09:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Drop 'const' from argument of vq_present()
Message-ID: <20190604083954.wf2q4h75uhx525yb@vireshk-i7>
References: <699121e5c938c6f4b7b14a7e2648fa15af590a4a.1559623368.git.viresh.kumar@linaro.org>
 <0adbeaff-bb5e-54cc-292e-62cb9f73cf50@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adbeaff-bb5e-54cc-292e-62cb9f73cf50@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-06-19, 09:30, Marc Zyngier wrote:
> On 04/06/2019 05:43, Viresh Kumar wrote:
> > We currently get following compilation warning:
> > 
> > arch/arm64/kvm/guest.c: In function 'set_sve_vls':
> > arch/arm64/kvm/guest.c:262:18: warning: passing argument 1 of 'vq_present' from incompatible pointer type
> > arch/arm64/kvm/guest.c:212:13: note: expected 'const u64 (* const)[8]' but argument is of type 'u64 (*)[8]'
> 
> Using which toolchain? My GCC 8.3.0 doesn't say anything.

I haven't updated mine since a long time it seems :)

aarch64-linux-gnu-gcc (Linaro GCC 4.9-2015.05) 4.9.3 20150413 (prerelease)

-- 
viresh
