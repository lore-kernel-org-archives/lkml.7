Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F9BC606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46910216C4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 16:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW8RQCXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391572AbfGHQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 12:52:08 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43409 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732764AbfGHQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 12:52:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id cl9so8547209plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 09:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7J75IjUlVRUhuaNNPo9Ipgx69MtKDspwKECQeExp82M=;
        b=UW8RQCXtp/S+37WliHJNkYf0tEdGA9WliIuwmJAtSxpVsPCZ2vWttD/8U+ykPhxs7i
         yZARhp7BxL3hOwVybmL0bkBqZ7RpOp+sJ0tXHELzzjxUOBub+bX7Un89CbujX/5dB9vK
         Wl2zQzXVUfeX5Qeea08Zq62Hve+yFBzR4ERDFoSXWa0id188ZL+i5ofm5lQo6b1kgfe+
         M4LDO47Ib48dGjYxwkuXcNFy76gBTYQBKoB0AvHkhEkxnbMXIegALVkZyTBZQBzcvCry
         QUG99XubmNxuWJuVRqgQHNKTWP7ARooCFjd2zfmK14s/7kqZjRffqzwmF4nnOcDZDdX8
         ELWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7J75IjUlVRUhuaNNPo9Ipgx69MtKDspwKECQeExp82M=;
        b=D3gmJ0YjhrDcug+3vyRuKOAsPwxwogkhh/5IA7MfCSRnIEVvrQesXpC/2vKMTkPCHL
         TyeEyqWAqOO/vELx1RQ9dE+t+4+YRGqlhBNtnR1XUpwBDf2iBW5/tEN0h/0GSHW3tBxV
         p4NXjkL0Ahmr1TvGv9f0HM0CojGq3NQsYwD0u1uopQTVdZM+mM0z4V5xGUY7ct+dxEfI
         iTW9XSc4+arrbvo3mnY3gjUuqQgKAJd518895d39yvYUim9phZf1nbG2byOKDkuFwc2t
         NL4Q3Bii09ClXqyX+vPHLBXs91ZTELBsu8qNEVPht1ifzm0mEMOXiPdb2VyGl6ypwRoo
         s9TA==
X-Gm-Message-State: APjAAAU+vOTf4YPBtlgIPCaiXJVDSKeLGG6DHqVBBJailmIkBkkn+kSd
        NJ2HhNuLlX91vrMRA4JtEgF6ZAMAAVyVgFYRFiI+VQ==
X-Google-Smtp-Source: APXvYqxZC/RbOPzH426d+AJ7hk6yz9LlEDD0UGKSQ4VMbe6CPTsw+qVU6PTMA1mI+yI0fR24oB7KfcIVEZiOuq1IbMs=
X-Received: by 2002:a17:902:4aa3:: with SMTP id x32mr25318366pld.119.1562604726692;
 Mon, 08 Jul 2019 09:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190705190239.8173-1-jeffrin@rajagiritech.edu.in>
In-Reply-To: <20190705190239.8173-1-jeffrin@rajagiritech.edu.in>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 8 Jul 2019 09:51:55 -0700
Message-ID: <CAKwvOd=wpJeBuQ9856+g53fMBgeZE-Pq0yFh1jTskGGGVriZOA@mail.gmail.com>
Subject: Re: [PATCH] Documentation: dev-tools: Fixed an outdated directory
 path in gcov.rst
To:     Jeffrin Jose T <jeffrin@rajagiritech.edu.in>,
        Tri Vo <trong@google.com>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Tri (on vacation) for review

On Fri, Jul 5, 2019 at 12:03 PM Jeffrin Jose T
<jeffrin@rajagiritech.edu.in> wrote:
>
> Fixed an outdated directory path inside gcov related documentation
> which is part of an example that shows the way in which the gcov
> command should be used in that context
>
> Signed-off-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>
> ---
>  Documentation/dev-tools/gcov.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/dev-tools/gcov.rst b/Documentation/dev-tools/gcov.rst
> index 46aae52a41d0..e3d262d8c7de 100644
> --- a/Documentation/dev-tools/gcov.rst
> +++ b/Documentation/dev-tools/gcov.rst
> @@ -8,7 +8,7 @@ To get coverage data for a specific file, change to the kernel build
>  directory and use gcov with the ``-o`` option as follows (requires root)::
>
>      # cd /tmp/linux-out
> -    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel spinlock.c
> +    # gcov -o /sys/kernel/debug/gcov/tmp/linux-out/kernel/locking spinlock.c
>
>  This will create source code files annotated with execution counts
>  in the current directory. In addition, graphical gcov front-ends such
> --
> 2.20.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20190705190239.8173-1-jeffrin%40rajagiritech.edu.in.



-- 
Thanks,
~Nick Desaulniers
