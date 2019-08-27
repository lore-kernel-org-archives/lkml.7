Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2EEC3A5A6
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C97821872
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbfH0Mgc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:36:32 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63256 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728702AbfH0Mgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:36:31 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18277524-1500050 
        for multiple; Tue, 27 Aug 2019 13:36:28 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAMuHMdUk9G22rDfUrX3CZ=st3_bSehyaW_URtCk0ZfJqFTmLuQ@mail.gmail.com>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
References: <CAMuHMdUk9G22rDfUrX3CZ=st3_bSehyaW_URtCk0ZfJqFTmLuQ@mail.gmail.com>
Message-ID: <156690938679.15406.15977840485564172260@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: dma-buf: Add selftests for dma-fence
Date:   Tue, 27 Aug 2019 13:36:26 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2019-08-27 13:30:04)
> Hi Chris,
> 
> When running the new dmabuf-selftests on two different systems, I get:
> 
>     dma-buf: Running sanitycheck
>     dma-buf: Running dma_fence
>     sizeof(dma_fence)=48
>     dma-buf: Running dma_fence/sanitycheck
>     dma-buf: Running dma_fence/test_signaling
>     dma-buf: Running dma_fence/test_add_callback
>     dma-buf: Running dma_fence/test_late_add_callback
>     dma-buf: Running dma_fence/test_rm_callback
>     dma-buf: Running dma_fence/test_late_rm_callback
>     dma-buf: Running dma_fence/test_status
>     dma-buf: Running dma_fence/test_error
>     dma-buf: Running dma_fence/test_wait
>     dma-buf: Running dma_fence/test_wait_timeout
>     dma-buf: Running dma_fence/test_stub
>     dma-buf: Running dma_fence/race_signal_callback
>     thread_signal_callback[0] completed 28855 passes, 3929 misses
>     thread_signal_callback[1] completed 28846 passes, 3918 misses
>     thread_signal_callback[0] completed 37179 passes, 37179 misses
>     thread_signal_callback[1] completed 37184 passes, 37183 misses
> 
> and
> 
>     dma-buf: Running sanitycheck
>     dma-buf: Running dma_fence
>     sizeof(dma_fence)=64
>     dma-buf: Running dma_fence/sanitycheck
>     dma-buf: Running dma_fence/test_signaling
>     dma-buf: Running dma_fence/test_add_callback
>     dma-buf: Running dma_fence/test_late_add_callback
>     dma-buf: Running dma_fence/test_rm_callback
>     dma-buf: Running dma_fence/test_late_rm_callback
>     dma-buf: Running dma_fence/test_status
>     dma-buf: Running dma_fence/test_error
>     dma-buf: Running dma_fence/test_wait
>     dma-buf: Running dma_fence/test_wait_timeout
>     dma-buf: Running dma_fence/test_stub
>     dma-buf: Running dma_fence/race_signal_callback
>     thread_signal_callback[0] completed 3423 passes, 2148 misses
>     thread_signal_callback[1] completed 2360 passes, 9 misses
>     thread_signal_callback[0] completed 4028 passes, 4028 misses
>     thread_signal_callback[1] completed 8080 passes, 8079 misses
> 
> Unfortunately it is not clear to me if this is good or bad?
> Perhaps the test output can be improved, e.g. with a clear PASS/FAIL output?

It's communicated via the error code, along with failure messages. For
more complex persistent selftest modules, we use an modparam to report
the error code.

See igt/dmabuf for the test runner.
-Chris
