Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD5AC43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E710B2087F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbfEBVqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:46:20 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36310 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbfEBVqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:46:20 -0400
Received: by mail-ot1-f67.google.com with SMTP id b18so3548944otq.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7W7UsXuybX/u7xiEaLpzHaF64Gims0rzvAjtvjprn0=;
        b=sd5a3yzYpinMVovQqG6ETpsL6/SetgBg3OJ4POw3pDle2U1lcqyMQaqWjWRSG2iCsW
         ukLr8CMCC29KGO+6+VvHM2xSfZPlTxKjG2FlXgwW5ZroCXHAhtu4jGfF2t2AzpqOhDi9
         st2I6pFr4phfXMQ5jkZNzbZBOqIAlZ03kgHzmhVfIiduUzQtz9ZmdFRbzzvGe1u/LXeA
         QtLUfoQcUuzg534HTO25DkaU5CTrZCd5ylbcgu/XYIrAsoES43jQ6VT71LZOfJMLRxs9
         2xXwXxa6ArFy2xcp8pyDWrdpk4UnjO6xMxKRrontfIQhyimHkH3LL3+mU5/fwUthIu9J
         34kQ==
X-Gm-Message-State: APjAAAWPe/Lb7NubmzM9Qn0xIx0n0ezHTtugaR7v7JeRgcdw1ILReZaW
        v6k4afBFHuLCS8Zeo5SyWt4Avd90wb+M0P7AmKL2+g==
X-Google-Smtp-Source: APXvYqwNGXOQBuwF6AXZWl2Z7PP/WrsDl9tIKsqJqIhlsid6gHJld9bouUd4j+TrmHQ7J1QgBe3oORm/ibcfZN0jCT8=
X-Received: by 2002:a9d:1ee2:: with SMTP id n89mr3308164otn.241.1556833579525;
 Thu, 02 May 2019 14:46:19 -0700 (PDT)
MIME-Version: 1.0
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <1556830342-32307-2-git-send-email-jsavitz@redhat.com> <20190502210922.GF2488@uranus.lan>
In-Reply-To: <20190502210922.GF2488@uranus.lan>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 2 May 2019 17:46:08 -0400
Message-ID: <CAL1p7m6eC3-99oFEyp0F1xn7qN4Vx+s-kHQXh14cMUWoVFqbWw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kernel/sys: add PR_GET_TASK_SIZE option to prctl(2)
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Micah Morton <mortonm@chromium.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Jann Horn <jannh@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Rafael Aquini <aquini@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yury Norov <norov.maillist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Won't be possible to use put_user here? Something like
>
> static int prctl_get_tasksize(unsigned long __user *uaddr)
> {
>         return put_user(TASK_SIZE, uaddr) ? -EFAULT : 0;
> }

What would be the benefit of using put_user() over copy_to_user() in
this context?
