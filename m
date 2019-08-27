Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFBFC3A5A4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E38E206BF
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 12:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfH0MaR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 08:30:17 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:35179 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbfH0MaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 08:30:17 -0400
Received: by mail-ot1-f48.google.com with SMTP id 100so7681607otn.2;
        Tue, 27 Aug 2019 05:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=aQgUrji3JLkWxgHqWnOkvsVYptayYJD4EEVcvouCxbo=;
        b=Zl/FXfOrb6F4m/6ElfLObflx9UxbIxCoFeOjmlT7xuTvJBxED6U7auJakymz7hCRP5
         mTMor/1ZqX9seccYMUVpfzmBMBNHctNQ6zChhk2pzCz+eXFj72AbfF4VJQkEe/Pi1OEM
         5u0+m7VnCc1mMdqxfvHFDqvcqvVj29+HSqkWdrQcl1/uQGqAWO3YbvZHd/5Y9a1MGSNw
         U9shXm8rCEQ/14KRfGz06z6PaVF5xzLE5APYr1BDptUBfGkVpncdxLYb0F8QtWKp8Ik8
         AxYf1ovRf6oICJfjDTJhaw29RbvhaQg2pFlDHFfLK0tImMqyyuLv/WV5dZz9t+bjFNg6
         8NjA==
X-Gm-Message-State: APjAAAUROdIgau3XMruHA2pQNy2LAxB1z4guvMZVsgFEDsUyfTDoW/AL
        +RQyWCmo8aXIoXE+w6o5fZrv/il9SCyvMukUPD4=
X-Google-Smtp-Source: APXvYqwDLK91nxUQtfrupsXHNL40ooDa0Xmq08hAP8hA9d+dDHMLcXvtPb/j/0H7WP45CRJV0yHH9X1Mu10Yr2XLcGI=
X-Received: by 2002:a9d:7a90:: with SMTP id l16mr19835500otn.297.1566909015712;
 Tue, 27 Aug 2019 05:30:15 -0700 (PDT)
MIME-Version: 1.0
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 27 Aug 2019 14:30:04 +0200
Message-ID: <CAMuHMdUk9G22rDfUrX3CZ=st3_bSehyaW_URtCk0ZfJqFTmLuQ@mail.gmail.com>
Subject: Re: dma-buf: Add selftests for dma-fence
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

When running the new dmabuf-selftests on two different systems, I get:

    dma-buf: Running sanitycheck
    dma-buf: Running dma_fence
    sizeof(dma_fence)=48
    dma-buf: Running dma_fence/sanitycheck
    dma-buf: Running dma_fence/test_signaling
    dma-buf: Running dma_fence/test_add_callback
    dma-buf: Running dma_fence/test_late_add_callback
    dma-buf: Running dma_fence/test_rm_callback
    dma-buf: Running dma_fence/test_late_rm_callback
    dma-buf: Running dma_fence/test_status
    dma-buf: Running dma_fence/test_error
    dma-buf: Running dma_fence/test_wait
    dma-buf: Running dma_fence/test_wait_timeout
    dma-buf: Running dma_fence/test_stub
    dma-buf: Running dma_fence/race_signal_callback
    thread_signal_callback[0] completed 28855 passes, 3929 misses
    thread_signal_callback[1] completed 28846 passes, 3918 misses
    thread_signal_callback[0] completed 37179 passes, 37179 misses
    thread_signal_callback[1] completed 37184 passes, 37183 misses

and

    dma-buf: Running sanitycheck
    dma-buf: Running dma_fence
    sizeof(dma_fence)=64
    dma-buf: Running dma_fence/sanitycheck
    dma-buf: Running dma_fence/test_signaling
    dma-buf: Running dma_fence/test_add_callback
    dma-buf: Running dma_fence/test_late_add_callback
    dma-buf: Running dma_fence/test_rm_callback
    dma-buf: Running dma_fence/test_late_rm_callback
    dma-buf: Running dma_fence/test_status
    dma-buf: Running dma_fence/test_error
    dma-buf: Running dma_fence/test_wait
    dma-buf: Running dma_fence/test_wait_timeout
    dma-buf: Running dma_fence/test_stub
    dma-buf: Running dma_fence/race_signal_callback
    thread_signal_callback[0] completed 3423 passes, 2148 misses
    thread_signal_callback[1] completed 2360 passes, 9 misses
    thread_signal_callback[0] completed 4028 passes, 4028 misses
    thread_signal_callback[1] completed 8080 passes, 8079 misses

Unfortunately it is not clear to me if this is good or bad?
Perhaps the test output can be improved, e.g. with a clear PASS/FAIL output?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
