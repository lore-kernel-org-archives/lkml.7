Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC31FC3A5A2
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1CB21726
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 02:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="K8uOXFGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfHXCMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 22:12:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38218 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfHXCMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 22:12:48 -0400
Received: by mail-pg1-f193.google.com with SMTP id e11so6782816pga.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 19:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0c5tfxW9T0sPTgy4GO92lU2NgowJCnI0ylQa6hGZSJs=;
        b=K8uOXFGilp6oBlpfOcagQsAr2a890kFdDxu90+Bwnwy1TM7vRzjya9Y8uy2ZgX1WaV
         4vO1FhPoq7YAiN3QQXnJ4lBxl0c7+8ZztsWjBkEsb99iu/ofNAO2sgv6CUd5CfNnFoCK
         EdPIAq0KrFtJllq8Z5uSUlGILQHZ0AphnU3XDnKEBmQQDuTsqUl+JaURdHZyAFX/dEcP
         7y/kzMWKj3hPXIzojWEkxNkEJHSPcl/y7GhQXSlFTBwFKGC387KQgw7aKc+SqjXkAuH9
         rkI0J9c4TvQIu11znISg++soMJvMtwLvWQ7j+RzADhIntYu0bgTN+h/n7jzPF38VGPE3
         cjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0c5tfxW9T0sPTgy4GO92lU2NgowJCnI0ylQa6hGZSJs=;
        b=CxkVtjVZ9KpbkZOJMcCGrEe3cLu1reFWrNzAtW0YCy3hL8qDmq2ikMOlw/rsGOD/7D
         iXvvCM0ws2odGQo6ROwkTjuIBq8lNVukSje2gMVFRrltsf2GK1OhaYiLgyD/e3WyTFk5
         Osq5KK/ueG+lmSfOCnrr73jdQN5zQf3D/dWI+WzjvsS2QLzuiOslWOjdXiO94/OIg8m0
         2Bj4QjD2wNmKFmC+hkeGrRyK2m5C3mPD/qdmkMhPdTatIjXzYSf8ZUI68bsVtbG7DCGc
         L4sVSakonMCn6VrHa3X6ojLMXPOM0rxVBEJAsumLGMiBgeh5GtI52QeEK8JH4zMUkYQE
         DgDg==
X-Gm-Message-State: APjAAAVyJq6UKWRZ8MAqdrYzGZ6QqAneovImNhzfpd+mZuDlO+NjmYRt
        HLZIEBTtE1tOB8tEYTXz7zGGL7BdDP8=
X-Google-Smtp-Source: APXvYqydseqCd8Js0RvYeeRbvYtJr8JsPj86P5GpJZKq53yiQcob6PjeZkw1lnzOmp37dOCz1PY5nQ==
X-Received: by 2002:a65:68d9:: with SMTP id k25mr6503622pgt.337.1566612767443;
        Fri, 23 Aug 2019 19:12:47 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id x2sm6513191pja.22.2019.08.23.19.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2019 19:12:46 -0700 (PDT)
Date:   Fri, 23 Aug 2019 19:12:45 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        christian@brauner.io
Subject: Re: [PATCH V3 0/3] riscv: Add perf callchain support
In-Reply-To: <20190819105618.GA6377@vmh-VirtualBox>
Message-ID: <alpine.DEB.2.21.9999.1908231910350.18210@viisi.sifive.com>
References: <cover.1558081981.git.han_mao@c-sky.com> <alpine.DEB.2.21.9999.1908161008450.18249@viisi.sifive.com> <20190819081758.GA15999@vmh-VirtualBox> <20190819105618.GA6377@vmh-VirtualBox>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Mao Han wrote:

> PS: I got some compile error while compiling glibc 2.30 with linux
> v5.3-rc4 header. vfork.S include linux/sched.h(./include/uapi/linux/sched.h)
> which has a struct clone_args inside, added by
> 7f192e3cd316ba58c88dfa26796cf77789dd9872.

Noticed that also.  Probably the sched.h uapi kernel header file needs an 
"#ifndef __ASSEMBLY__" around the struct clone_args...


- Paul
