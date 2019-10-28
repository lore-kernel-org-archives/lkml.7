Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B8FCA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 198AE214B2
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 19:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O0yZqC1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfJ1T5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 15:57:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37459 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfJ1T5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 15:57:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id u9so2908098pfn.4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 12:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wOJCmH0g8vAxxe+FcShlh+2/nEo9CAjIamY0wkPKUQ=;
        b=O0yZqC1vKJdTDSM5n1ypj42P6mUYqFnfIcgablhmOvhVLjS1Ybl9gj4HXCMp/vZ/Jg
         IlXkNeniJ714HLUGdQmrikkPN3FAzyra+IIBoiYFS+hSOqqXECKH+9kL8TmBRqTz+il7
         BXn0qi51LmPYcG+sXB1pj3nora5+8WYXfasYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wOJCmH0g8vAxxe+FcShlh+2/nEo9CAjIamY0wkPKUQ=;
        b=IYW6XqtLWvuUi2C71U/uP5PMWXLRKsWsLfTuK7le/CkU9NHd0owd2ZeRevdSso5xMd
         00p7+rV0khsfhAXTWAQcKASfQCamqn4xO94L7CbMSasqZuC1dpW9rQ6nWg618r0S9ZNL
         O/LX6ak3oP8amGuOKLiRagYWmhgWBd12tfvLYlyZoJYLTTYB4l2FNvhFTjRP1M2HV6f+
         YufiAf+OREMzFhnqq2IgsaULcf6tmoGoZmS0xBEE6YvOLkQy7MEnKKxujY2dWtVwpkQD
         rd6Vku5kQknacxtDT6uhEUeVuACF3KFwfMW0k28T9AGoSrd/8qtlsAPKDuQMO7kK35d7
         6SBQ==
X-Gm-Message-State: APjAAAXvtM8i18wNfihxRw0mlW95keAIQkjkcZVN/pwPpwP+uUHm5mbO
        qYp9PASKCIA8BoYgS4PEYMrbHA==
X-Google-Smtp-Source: APXvYqyKAiln1b5mOZI7AcApDWWXQnpclGuce0+3km3MXnlFB0MT9wWVjjgen/Fg+kiLaMYGZZoRxg==
X-Received: by 2002:a62:e10c:: with SMTP id q12mr13396875pfh.248.1572292664956;
        Mon, 28 Oct 2019 12:57:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y129sm12883990pgb.28.2019.10.28.12.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 12:57:43 -0700 (PDT)
Date:   Mon, 28 Oct 2019 12:57:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/17] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <201910281250.25FBA8533@keescook>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com>
 <20191024225132.13410-6-samitolvanen@google.com>
 <20191025105643.GD40270@lakrids.cambridge.arm.com>
 <CABCJKuc+XiDRdqfvjwCF7y=1wX3QO0MCUpeu4Gdcz91+nmnEAQ@mail.gmail.com>
 <20191028163532.GA52213@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191028163532.GA52213@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 04:35:33PM +0000, Mark Rutland wrote:
> On Fri, Oct 25, 2019 at 01:49:21PM -0700, Sami Tolvanen wrote:
> > To keep the address of the currently active shadow stack out of
> > memory, the arm64 implementation clears this field when it loads x18
> > and saves the current value before a context switch. The generic code
> > doesn't expect the arch code to necessarily do so, but does allow it.
> > This requires us to use __scs_base() when accessing the base pointer
> > and to reset it in idle tasks before they're reused, hence
> > scs_task_reset().
> 
> Ok. That'd be worth a comment somewhere, since it adds a number of
> things which would otherwise be unnecessary.
> 
> IIUC this assumes an adversary who knows the address of a task's
> thread_info, and has an arbitrary-read (to extract the SCS base from
> thead_info) and an arbitrary-write (to modify the SCS area).
> 
> Assuming that's the case, I don't think this buys much. If said
> adversary controls two userspace threads A and B, they only need to wait
> until A is context-switched out or in userspace, and read A's SCS base
> using B.
> 
> Given that, I'd rather always store the SCS base in the thread_info, and
> simplify the rest of the code manipulating it.

I'd like to keep this as-is since it provides a temporal protection.
Having arbitrary kernel read and write at arbitrary time is a very
powerful attack primitive, and is, IMO, not very common. Many attacks
tend to be chains of bugs that give attackers narrow visibility in to the
kernel at specific moments. I would say this design is more about stopping
"current" from dumping thread_info (as there are many more opportunities
for current to see its own thread_info compared to arbitrary addresses
or another task's thread_info). As such, I think it's a reasonable
precaution to take.

-- 
Kees Cook
