Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F90C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 203FE2081C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 21:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfEBVXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 17:23:02 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46124 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfEBVXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 17:23:01 -0400
Received: by mail-oi1-f194.google.com with SMTP id d62so2825243oib.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2019 14:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eh7eFFyB0HQb1lR7o0UQPw6FHH5Ibk2DbD5EA3uCJyo=;
        b=qamXOEo52ZBydKbnoJUbVXe1f72B4EDbOI7jmFyF08LkrZHOSAqpzvqzWDJALugN50
         X97jbJ27sHOjHm8yoXVN87Z5TCXAO8cJ/PCtNB8obbrBixG/uRSslxf6AyC2ArofM3xS
         9aEUHddrEFm2L2TK7oG5GA8ClQLwH0qPCW1knRq5BK//zbEiq4qZEV17hC7rfmfXi569
         /Mh9/s4wQ8cM9p7eX411KJU1C6mrWdyZVNziiZ3T+JGeFLbQn0PdfHEm9RaEZBDdtQrS
         Go9FK6f6GTCaPEmRfsKR3SCJkOVrkG9DdYZgoxLw2cLuvmM54hI3nUb0FIgXm4SkF0Ma
         //Ww==
X-Gm-Message-State: APjAAAXDZPUhQnovN1xPiC+B15sR6G3d+lRzy37IQEOAuUW/GMB8L+h7
        CAFnSe4lU8n4p9gYZiPtI7RvhEaNeVQX3pEr39mP3Q==
X-Google-Smtp-Source: APXvYqzPE+5s3E218kA4ibERd8m1jKU0kNB7UTuhXMRDgztZjzSNHuqtbV9gndViYi3xu8AwrtERg636SnVLBM4j6xA=
X-Received: by 2002:aca:5582:: with SMTP id j124mr3900701oib.129.1556832181100;
 Thu, 02 May 2019 14:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <1556830342-32307-1-git-send-email-jsavitz@redhat.com>
 <8bb9fe29-65d3-e977-1932-4a2f17ead333@redhat.com> <20190502211002.GG2488@uranus.lan>
In-Reply-To: <20190502211002.GG2488@uranus.lan>
From:   Joel Savitz <jsavitz@redhat.com>
Date:   Thu, 2 May 2019 17:22:50 -0400
Message-ID: <CAL1p7m6sYp_A4PB-K9gc8QKnPLHe92y2yMq7TqnUJuQPqR+MOA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sys/prctl: expose TASK_SIZE value to userspace
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
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

Yes, this the change, thanks to the suggestion of Yury Norov.

I also now explicitly mention the expected userspace destination type
in the manpage patch.

Best,
Joel Savitz


On Thu, May 2, 2019 at 5:10 PM Cyrill Gorcunov <gorcunov@gmail.com> wrote:
>
> On Thu, May 02, 2019 at 05:01:38PM -0400, Waiman Long wrote:
> >
> > What did you change in v2 versus v1?
>
> Seems unsigned long long has been changed to unsigned long.
