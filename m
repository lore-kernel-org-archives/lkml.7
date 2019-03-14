Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C66C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60A852063F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 11:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bYkokGkV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfCNLDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 07:03:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33258 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727421AbfCNLDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 07:03:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id i19so3596469pfd.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtAQ8UbQ0o7FE5sm4dVG/zV+8XO4rSbLaabGJwbfjAQ=;
        b=bYkokGkVHQr6wqH/oT0LL5vDA/514B+Q9+wYbx8i4o8adrx86fFeze7c62GG2etmt5
         AIm/yZlADgT4QX6LLLNVh3H8xtDANju9X8qGmlrNa+73RWtREBaMp4d9NbQvZRsV2oTg
         R8LXRPkTl9wIuUy+0rRoqHxh1ewhqUq43bYsGBXOZNLbstBdeJPQksxcFvhuYD6SJqw0
         eJHFdnDW7YDqsDnDkDNi6RXagVJmPzYwpH2ThWn8L3FRdz9V7oMJAZBzCj2C9VUpO48N
         MW+uoneSP0n9wCazSgWAp9/tFcQFJlr8j21sZmw5D/N7c58Zb9p9EECCdGAh6jqXcEHA
         C4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtAQ8UbQ0o7FE5sm4dVG/zV+8XO4rSbLaabGJwbfjAQ=;
        b=JSN05XORtwQCDhJ80SuNFJZOHYgZJFZVXAaE4KtE6Rl+97hu7vyC9Va8mPlxnDnkGv
         KdGdfWZBPHLyHOdVW+3C8e9X/luUlpR23w4360SQ8Sz3+3Vqhn14dAxM6xt03TttQd5t
         lEATcC+lrpERh0/WyHlPiDU2+Kxd4eM7L8E5SOfQ0IpcIHM3rwvEguekL1YwA4HN2xOW
         WtNRZFeJsKu36dxN2M7v36morCM5lBA5YpcsryV4ffkhkvONkJapWgAyTUE9rb/LlWYX
         4HsNK7hShDJKK8bsbYvaoJU4Q2IgaXTjDVjBOj3K6exkDyzIFnEoYpM3E/niqRBXYP7D
         5COA==
X-Gm-Message-State: APjAAAXbXLEbrMs6G5hf72j09YL2hR7B0JZyLhPNKiwlPJLgRqGD1Mye
        F27PsbmcoyVMQqLBicAKbWppFg==
X-Google-Smtp-Source: APXvYqy5bLSSih0xBolWw6NAOR1aDN7OqFmwiEhtPcjfXIl+iJ/pSXuHoFJ+SVozO/Z5jINfsSCOGQ==
X-Received: by 2002:a17:902:6b8c:: with SMTP id p12mr51460057plk.282.1552561401856;
        Thu, 14 Mar 2019 04:03:21 -0700 (PDT)
Received: from localhost ([122.166.134.37])
        by smtp.gmail.com with ESMTPSA id 70sm36588296pfr.43.2019.03.14.04.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:03:20 -0700 (PDT)
Date:   Thu, 14 Mar 2019 16:33:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kvm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 0/7] cpufreq: Call transition notifier only once for each
 policy
Message-ID: <20190314110318.on5bfau32tjsxnuz@vireshk-i7>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
 <CAJZ5v0gER+aJaQmk89VSVBtHgQ+WPDdAxUW6eJ4JCB=emC85dg@mail.gmail.com>
 <20190314101606.2aodwz5mzvstau6c@vireshk-i7>
 <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jiumt_nvhc3Bv_b94Xq22h5vTwDPeM1qo+6bzChn58FQ@mail.gmail.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-03-19, 11:55, Rafael J. Wysocki wrote:
> On Thu, Mar 14, 2019 at 11:16 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> But some of them need to combine the new cpumask with
> cpu_online_mask() to get what would be policy->cpus effectively.  That
> would be avoidable if you passed the policy pointer to them.

Right, that's what I also thought after your previous email. Will pass
the policy pointer instead.

-- 
viresh
