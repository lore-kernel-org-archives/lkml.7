Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C42C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8391620811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 08:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbfCHI10 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 03:27:26 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:59747 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725789AbfCHI10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 03:27:26 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 15819001-1500050 
        for multiple; Fri, 08 Mar 2019 08:27:13 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <20190308012023.5709-1-natechancellor@gmail.com>
Cc:     intel-gfx@lists.freedesktop.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
References: <20190308012023.5709-1-natechancellor@gmail.com>
Message-ID: <155203363088.27405.11887329278848171622@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH] drm/i915: Zero initialize this_cpu in busywait_stop
Date:   Fri, 08 Mar 2019 08:27:10 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2019-03-08 01:20:24)
> When building with -Wsometimes-uninitialized, Clang warns:
> 
> drivers/gpu/drm/i915/i915_request.c:1032:6: warning: variable 'this_cpu'
> is used uninitialized whenever '&&' condition is false
> [-Wsometimes-uninitialized]
> 
> time_after expands to use two typecheck with logical ANDs between them.
> typecheck evaluates to 1 but Clang clearly gets confused with the logic
> that as semantic analysis happens early in the pipeline. Fix this by
> just zero initializing this_cpu as it will always be properly
> initialized before the comparison below.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/415
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 
> Alternatively, this can be solved by having the return value of
> local_clock_us(&this_cpu) be a local variable but this seems less
> controversial.

I'll just wait for clang to be fixed, as this severely undermines any
respect I have for its semantic analysis.
-Chris
