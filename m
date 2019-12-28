Return-Path: <SRS0=tgXE=2S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699FDC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 06:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A6A20722
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Dec 2019 06:03:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="dosrMYBm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfL1GC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 01:02:57 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44623 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfL1GC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 01:02:57 -0500
Received: by mail-pf1-f195.google.com with SMTP id 195so14849715pfw.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 22:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=02OgeYXQzBdT2lFGeruc0qE3qRxj/P1vmd+xB2uVOWU=;
        b=dosrMYBmKsUI90ww5BizFf2HLD+EuoUVW2b7uMSItr1MnNX46QglnrkuO1hTcjwxr9
         MF0uS5UBy8rJPBKsMHiwaYBAL5BwG8DzYMTgNo6RwKGSH2OAd9b/NwSGC2Zk8wMYk0Lw
         dI82ngPt6gbjLR7oCAZLZTP6i7bEIUXKv3C55m1foXdFFYo7rgeEpGHxGEhZohP216fb
         /xKFuLbi00poxkQIJbd9nn94VzusyE+Up23SWXxRxRnZkQcDT8KaSBUU7x+RHx5O4ddu
         TOSldNHQ1teeLsSE3Pxc4dLqjZZxwzJmCjfG3b7ecOWu8Oge0vved4uc7GHvNgQANMaQ
         Lj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=02OgeYXQzBdT2lFGeruc0qE3qRxj/P1vmd+xB2uVOWU=;
        b=EPScO8mbGp7xwRTgnb1MWN06DSHXikNOUAj71IFs8zVGNLoIIU5b2llgoYmJP1GfzJ
         aJ4JE8RUM0CkRn6RTxY7YG/hurH8f0SbYCUTJFlPIzC9TfA96INk0ZUsybq/xgZq6JEt
         30OVCNVnNV2FkVHV4S1NgSgY1vRbj+cKARNfBIrgOokuwaaN1Uxy2DTiAcw9mbcstsSv
         mbJgzoeNsy0fIF0US7iKiS6jS3hKG8z5MNtMHu6/GizyeF7f+0XFY7IUemFUr41+Jf2A
         s7ks/+aZkqhbZmK4u/0/YeOp8xHfMLlKCA8HPcehwrf6gICXXS5EfbGFrDD71upObz9B
         GkGA==
X-Gm-Message-State: APjAAAXRHmH9m5ZNjNXn6q8nPt1KR+CEE21c76zi5nbiri9ZdXj7r/Dl
        cA131Un66CpR7MWMhCKgLw4AzQ==
X-Google-Smtp-Source: APXvYqxAjVLo/sSKKhyMBHbUx32270yRWvdM/quLSvk9dZ0cErgGQcZ8rJCWkNkFThlKnxQEmfcU/Q==
X-Received: by 2002:a63:6704:: with SMTP id b4mr60478145pgc.424.1577512976320;
        Fri, 27 Dec 2019 22:02:56 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id j17sm15348961pfa.28.2019.12.27.22.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 22:02:55 -0800 (PST)
Date:   Fri, 27 Dec 2019 22:02:54 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bin Meng <bmeng.cn@gmail.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: reject invalid syscalls below -1
In-Reply-To: <20191218084757.904971-1-david.abdurachmanov@sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1912272201270.194339@viisi.sifive.com>
References: <20191218084757.904971-1-david.abdurachmanov@sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Dec 2019, David Abdurachmanov wrote:

> Running "stress-ng --enosys 4 -t 20 -v" showed a large number of kernel oops
> with "Unable to handle kernel paging request at virtual address" message. This
> happens when enosys stressor starts testing random non-valid syscalls.
> 
> I forgot to redirect any syscall below -1 to sys_ni_syscall.
> 
> With the patch kernel oops messages are gone while running stress-ng enosys
> stressor.
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@sifive.com>
> Fixes: 5340627e3fe0 ("riscv: add support for SECCOMP and SECCOMP_FILTER")

From the thread, I couldn't tell whether you were happy with this patch as 
it stands or not; the thread seems to have petered out.  So this one has 
been queued for v5.5-rc; let me know if you didn't intend for that to 
happen.


- Paul
