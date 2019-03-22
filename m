Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100FFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22A521900
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553274907;
	bh=ZAh4cwuJavt2z9KTEO6p7hKKHwYKJaaWgEufMtMOppI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l8F2soa6A2u9Mw9s6Z+RYBMdMWJcmJTZRxManS11xMnVLBtJrf7wpEThxsI/YOQ6t
	 m8dlXQ009yhBBRFJ3vqkabHJHsJnqagTucaXyrlJFAAKmDysw/PyRRm3K08l78WLL/
	 Kggoy09XPGV1ORphXNrp6vLIxDKFok2+yGeS44bQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbfCVRPG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:15:06 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37779 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfCVRPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:15:06 -0400
Received: by mail-lj1-f195.google.com with SMTP id v13so2697031ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
        b=Xicmuh1ND+AZ9lc/udGkNvWbzi2Lu2j3o6M44sYQ0ZH2WsGeVBgW5f2xPJwNTxlY2d
         JaSMsr2SEVdWRDbZBYCXJ0vB1W1wIN3vVWqOMIiqWhD3oBYZFF9I7ROZZs9bJvkPzu9N
         HN8UN8zBc9zkjew06tZVB45+s5iWpvEon1EZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K5KpCUavpU6jklxItqvKr4mbyrohs/asqf5NX0BYYpc=;
        b=Eh5DYP/wr1ua05oYRgL3n0JqIgEjTSXnG5xg1U3bp8cWGzYP8746tsm8JLV4r6ZYAp
         GctJwoXSNA2FeYIMDAemMAiOKdJyDoIWa1olPHlPG/Zb7ZVBrlhgRr4WdYsGaPmw98Bv
         bSWAnZ3Kz4NXIctIYd123NKX6eh5bN75AUZ362ArODtYz2jqa4Ng0tSmIb6tuK1Ubo5w
         U86X6GN1hFwFMIQu4E4g9TKmkIvf6jhrA2LlS33Eu3AqfROtqVIqh54Krn0M2tY5oyCl
         LoT12idgF+wmtL1n6NnIazT+PONMaAShQUTmtEW+uHVQnuQyWWC1QPUofIvJMu9dJ2Gr
         pyuA==
X-Gm-Message-State: APjAAAWnn/r0F7mkg4kTjoSHf1DzaBU3HlcvQrQfvUbcBts95C6qTHyP
        1E4h0Sl8lUyTO/Le1qQ6V6qGoENke3Q=
X-Google-Smtp-Source: APXvYqxuQSEU3g1iz2HpL1L6aXd2NpDtsElifGmy025VGYVw3Ki3hM5VhLzlMBFev5iqFDHYVSJpkA==
X-Received: by 2002:a2e:9c09:: with SMTP id s9mr5849170lji.83.1553274903749;
        Fri, 22 Mar 2019 10:15:03 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id u18sm1841666lfd.15.2019.03.22.10.15.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 10:15:03 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id t13so2691087lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 10:15:03 -0700 (PDT)
X-Received: by 2002:a2e:9786:: with SMTP id y6mr5380150lji.79.1553274440270;
 Fri, 22 Mar 2019 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190322143008.21313-1-longman@redhat.com> <20190322143008.21313-3-longman@redhat.com>
In-Reply-To: <20190322143008.21313-3-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Mar 2019 10:07:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Message-ID: <CAHk-=wjujKK-Ey7DPnMExaEmphicuEDLmVn-9+W9VzFzR-Ts=A@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] locking/rwsem: Remove rwsem-spinlock.c & use
 rwsem-xadd.c for all archs
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 7:30 AM Waiman Long <longman@redhat.com> wrote:
>
> For simplication, we are going to remove rwsem-spinlock.c and make all
> architectures use a single implementation of rwsem - rwsem-xadd.c.

Ack.

               Linus
