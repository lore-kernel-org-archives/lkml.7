Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B20DC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCD620652
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N8sEa3rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfCHAWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:22:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43515 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHAWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:22:36 -0500
Received: by mail-pg1-f194.google.com with SMTP id l11so12600288pgq.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 16:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KQvHXXNU8qWgcIvXd371KSdjFHWj9gbG8PA/hc6EM/Q=;
        b=N8sEa3rrySl5VZfvQ7lqou2c9QqsgOZLU9hBMWrH8R3mkV6S135FiJ87wgYi5r98IR
         QEaFAi8GFW5d0eeAGsqkM/vFtQ1zA5iQyoFqzAMPANXLdjLWv3uphX+l3FxEBt3kcl0H
         ysGLm4Lsy9usl8B3Cw8KYZel5JJeMni8z+amN6eaiXQj7q5aSlXmvI51tZ1cCgmVIFq1
         51aqiPXg01eLidDlZdC/Y4CY+BVQ6z0hKxZTjuy2zTrP3++JDhIouJ83xMpdwp9l2G2J
         v6jE8H8TbBuKDW53v2KxhG1fgdr1o8/l7L7LhxnrtN78RR0LLgbbkZKn9Y2mfEVFJKbE
         EqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KQvHXXNU8qWgcIvXd371KSdjFHWj9gbG8PA/hc6EM/Q=;
        b=dlx07yCKDIT3/yV477oTtsTV0ftmWLZJwWPal6MrzinamcsMkD6xTVtwXtSGhsBkUM
         AAJJSANBY53+a4sybQUklq8oCOObcdD+e1iShzMLM8zEaGmBJUyAM+eYUJad6m3cBDJk
         sZu6Eu7SnxVfpvw0HKjg7mxjiqd7UEmTKhyWEXEJ5ywr0gqXii5ZSgzHq9M2c+tlbGCJ
         MvBCJCkQ+tw+Wt29RpOMwQfaHRpZPqIUm+Re47Yf9+lEnd/xK9hezHxC/pwPDVrMtWou
         7b8lmRFXYrut/nvi9dAlKMWeCDPnhXKTujfqhfead4YBu7kr8vhhzBDQDv+Q0oV5r8yI
         kJCA==
X-Gm-Message-State: APjAAAX1SbB98kdpVTDwfrGOOdwPV6RLHCBgtxdxrw7/Bdde84HhRb6g
        1slPPlPtTEXAW2qQBSxfWU1C8xC7uL0a4jDDI4UtRQ==
X-Google-Smtp-Source: APXvYqyWQeKiS7a3Zl1nsO4xiN/9LN1oVsXUoC5MfR7WpVDJYS9jjrFV5O5aXqmSPonCCJ8+S+/bBYesbhDUcKeCwQQ=
X-Received: by 2002:a62:398d:: with SMTP id u13mr15471582pfj.32.1552004555214;
 Thu, 07 Mar 2019 16:22:35 -0800 (PST)
MIME-Version: 1.0
References: <20190307091218.2343836-1-arnd@arndb.de> <20190307152805.GA25101@redhat.com>
 <CAK8P3a2fuD-UBJET_OBKekCxrTDpnAxb0Bpu2LCCXaVT3pXTMQ@mail.gmail.com>
 <20190307164647.GC25101@redhat.com> <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
In-Reply-To: <CAK8P3a2FU55-7wQnLXDAmRCgiZ-W+2rY6p7CrTiKNe0wda-Hsg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Mar 2019 16:22:24 -0800
Message-ID: <CAKwvOd=nyhM72CxdO-YYSsXr7rh3LUALn_ezVNzyiBaOD7KZkA@mail.gmail.com>
Subject: Re: [PATCH] signal: fix building with clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 7, 2019 at 1:45 PM Arnd Bergmann <arnd@arndb.de> wrote:
> I'd have to try, but I think you are right. It was probably an
> overoptimization back in 1997 when the code got added to
> linux-2.1.68pre1, and compilers have become smarter in the
> meantime ;-)

How do you track history pre-git (2.6.XX)?
-- 
Thanks,
~Nick Desaulniers
