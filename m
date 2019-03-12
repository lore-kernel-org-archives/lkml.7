Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6C9C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43A5206DF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRmqf3xU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfCLRcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:32:55 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:33093 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfCLRcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:32:52 -0400
Received: by mail-vk1-f194.google.com with SMTP id r189so862005vkb.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 10:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=/pPUMtfX/4zWH4Kp77wi1isN2gX7JePTBEKndEfTuR8=;
        b=kRmqf3xUTPhfN+Y4X2Oo5FK1/8m5JYYD50moV/bNApvEJCZ/sDUciH6CpD2l695ScV
         rZqgBlAsMPvz3J0GW80Z7PyAPLjbbrNDBPIwQcGIfy6G+MCBG/yqKbUvCQPUI8t4jIcP
         LVZomsvGm1yGU+4cK6WynWC7amQP7zr+Lyi473q7ui9lOh6Q323Vvc0H7RBb/i8Vulal
         J6HqT+o5jQ9jpfBamYTlqK2/fE9HCZkIPKdoT1asFw6SQsKTLwcGWNKTa4XuPsesREb2
         laJIjFtME90mHVD1+Z3XzZDN3vW4x/pLvyQZjBYZAqnYWIdkSmkcpQORIbZk5NEBHOyl
         O8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/pPUMtfX/4zWH4Kp77wi1isN2gX7JePTBEKndEfTuR8=;
        b=Yxp9j6jSoT6ICNtmMFjLAf1duTApKgEC/DexIeoPHbdAab39EiodTekCc0QL3KTKqB
         AAq9SfNajB4Ip47cn/8sQsLV4F683MODMc6fMUgsP0dyVxjmnZypbCMY6jYFGAgHbVPo
         x2IzyjNABU4oX+RRFWnzx5L4Sc8JEFV9uBzA8WYwKAX9YUv5ICFGpXbdRL2tlgRUGorC
         5uRgaRhi5Ap0n628tfWn3HbqluaWjgZ6lZ0vBfJIYXVfRQPgKAWRWsTLHR3J9jSy7+0O
         g+OnyxXWcFCnfleSWXBIG5FR5QgcwQZWrPDqhOifk1oSQtP+DIzEQjGgxaXuqXS+E1Gw
         o2vg==
X-Gm-Message-State: APjAAAU9sV9l2LWphtbJSQ7WV+mDBkWqM9HNAr8oNWvX7qkhZAvEZW+P
        KUb98G9yVPHEjSQ+ixn6P9BITQiSdmrjosy5Bma0LSHe
X-Google-Smtp-Source: APXvYqzCjYb85oLsfm4fj/JjPvMFJWKwvkla9EZq1v57VRJysd2CaaKRkc2bo1qFzuvZInX8hsLOChvrIkkC7XdqTxI=
X-Received: by 2002:a1f:2bd5:: with SMTP id r204mr20685415vkr.19.1552411971228;
 Tue, 12 Mar 2019 10:32:51 -0700 (PDT)
MIME-Version: 1.0
From:   Pintu Agarwal <pintu.ping@gmail.com>
Date:   Tue, 12 Mar 2019 23:02:40 +0530
Message-ID: <CAOuPNLjtSgejRZtg7eRvsfjrkYfsgs-rJA-YnXBEnqDKRQUPrw@mail.gmail.com>
Subject: Building and cross-compiling kernel source on Mac OS
To:     open list <linux-kernel@vger.kernel.org>,
        kernelnewbies@kernelnewbies.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Mac Book Pro with macOS High Sierra 10.13.x installed (with
Mac OS Extended (Journaled, Encrypted)).
I also have the Xcode installed so I can compile a C program using gcc.

Now, I wanted to build linux kernel code (cross compile for arm or
risc-v) on Mac OS.
I know this is possible, but I am not familiar with the steps.
If somebody have the step by step guide, please share.

If this works, then I don't need to use Virtual Box inside MAC to
build the kernel code.


Thanks,
Pintu
