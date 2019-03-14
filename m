Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C2CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B6E2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 21:10:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtjkYYrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfCNVKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 17:10:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39340 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfCNVKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 17:10:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id h8so4830523pgp.6;
        Thu, 14 Mar 2019 14:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=lCEel2xqxxP+/B/4iR5BE+LjeT6mwhkh3NosGaFxHNQ=;
        b=JtjkYYrFOmJw+YpPybCywD5PfdYjcqRl64k/bVXElM3YJ8IbzNV8Z1CXTJO453dbw4
         PbSReFxWOesFhlwAy2TOsJoE+M6BjfJJhZuL5UOJYeFTubyS8GAzjeJSkoKpEUsGJ7MG
         j7Dm18H+CQxuuUNWFN2EEMuEIV19yVCGDFcQqljJLRli51Pz+FduBAmon7XMOVLQmIQe
         35eewiNdxWejCU3uPBD78oyv/KWcMJQrXsXaXTe4B7THTODgFwMwAnIZMFtMGmmeM8za
         2siFfr40UqT6a4cT1z9S8HJcPO923fGQBbU1HFCIwdjTk62NagrzIXYhsKlfJT4pxTSH
         c4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding
         :user-agent;
        bh=lCEel2xqxxP+/B/4iR5BE+LjeT6mwhkh3NosGaFxHNQ=;
        b=mI+P+QgYG447CFX5pklOX/MmU2N4V4KZepMCov4AX+AoaGKSyWqGAS73yBZLnLaSk/
         ln7ZbNY7PUUY8TgFfloxSmo6YHB3DfmmWRiePLahEdEVdrAj/Ek5J3L7a15fpjR5Wvww
         l4diFo/18Dxq6GmNyRGhwfeCeL+r0oprrNkty6IH4IVs1kspHj7HtBq0PwkmT6pMK9Cx
         uYNyBliq3UOAMYDdRbNpkMyurDLwKXBIsEYvZ067o0sDe71jrqQ6ZbOqQ1mrEVskJ9XC
         REciW5+qjFGNI9tzwLfxLGDGMtOVwq/ocuckzP09xVJOOIEZSHKcWdjOo50r/15ksqQT
         IT0g==
X-Gm-Message-State: APjAAAXn452AsmCjwTACGESXf7UyC7jTMk4qdQ/T9Ev+7NeVglgNjDrC
        Ady04n/REml9HP12OLbB8z8=
X-Google-Smtp-Source: APXvYqxBNJvSw8ZbjPXRa7GmgTqTs9lNIHbHTZ+eprUCPJKERsS64GO/puiSRdCmCjQ4GfLi11CoXw==
X-Received: by 2002:a17:902:622:: with SMTP id 31mr383414plg.31.1552597816522;
        Thu, 14 Mar 2019 14:10:16 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm16728pfi.95.2019.03.14.14.10.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 14:10:15 -0700 (PDT)
Date:   Thu, 14 Mar 2019 14:10:14 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] perf/x86/intel: Make cpuc allocations consistent
Message-ID: <20190314211014.GA25646@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 05, 2019 at 10:23:15PM +0100, Peter Zijlstra (Intel) wrote:
> The cpuc data structure allocation is different between fake and real
> cpuc's; use the same code to init/free both.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

With allmodconfig-CONFIG_CPU_SUP_INTEL, this patch results in:

In file included from arch/x86/events/amd/core.c:8:0:
arch/x86/events/amd/../perf_event.h:1036:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
 static inline int intel_cpuc_prepare(struct cpu_hw_event *cpuc, int cpu)
                                             ^~~~~~~~~~~~
arch/x86/events/amd/../perf_event.h:1041:45: warning: ‘struct cpu_hw_event’ declared inside parameter list will not be visible outside of this definition or declaration
 static inline void intel_cpuc_finish(struct cpu_hw_event *cpuc)
                                             ^~~~~~~~~~~~

With -Werror, this is fatal, and I think it may be buggy (should it be
cpu_hw_events) ?

The patch has been applied to stable releases. Any idea, anyone, why
this is the case ? It doesn't look like a bug fix to me, and reverting
it from v4.14.106 didn't seem to have a negative impact.

Guenter
