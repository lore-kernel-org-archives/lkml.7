Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3FAC432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78466214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 18:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LZT8JPbg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409896AbfIXSGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 14:06:38 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:40274 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2409758AbfIXSGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 14:06:38 -0400
Received: by mail-pf1-f202.google.com with SMTP id b8so2051692pfd.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 11:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=TUzB4BV/01osUD6NgeQM+cXNRgz2sTC/G7TmIy4oA+g=;
        b=LZT8JPbgP33AsnQ4s1X2ZZAHl9DNv4fukDxTVOq5W4q7AO74tG+VteLJJkJfYkMGeH
         tjWPWWdQySJqPOQa5VJFz8OTIYZ7KcDD2AUQNGk7IsRVsynEtC3ZlUv2tkJoK6Wy99Uq
         SgBRuV5iAWBKh8mK2ZEi+vskUzga6BeiNGeM9F8KurPNKAmWQ4+oFQYNV3oOtSJxkgp3
         02q3a+ytOpeUzid0HG+gXk8wVoYFUapKy4MqyeKjahag6YC3pH7u7+kohCNBQTyldgbE
         sSSbLLDS3JqPY7VGIRZPNbCoVNwUoRGj8X5rk48XJ1LzthzWzQM1c/j68zt6dS4atzSa
         s1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=TUzB4BV/01osUD6NgeQM+cXNRgz2sTC/G7TmIy4oA+g=;
        b=tY6pXxlrLxe6+/Ca6Q7Em7h2HrVZvwD7c61fkGYRdxMwbim6XDm7uIfsp+JZlakdxs
         UFzSwdgDX2ph8BimDxRzcshE/GX67JmRtDcJBMgJKUzpTzVLdyvsJcNQED5Qb94BP9lm
         1+jqHyn8aHncMw424fztUCZ2sY9Bt/gjxKaw67SkahQ/o3ryyVfYULPJgQtnX7JyFxqp
         QzrwtlJsuHELX/5V+NaPL4McGzg3paIAQmsUe5QQ6j1Ag1aH5KAKSirg+lx02SuzKhNE
         y0/Mys2x6LvgGl08Ki+SRYkeC3zpk9WWSAIrSGC3IHR3zpoSxu8js2do1Pzh4KbT2iOL
         8lpw==
X-Gm-Message-State: APjAAAUk8FvHt6D5b7tHQ/KyBhfrMgBV+jX2XuO6JuoBmtMgF+zftSMK
        I9M53i/0ih9I1d3ArPyzc9s7o8tTMJOlfAOOv0k=
X-Google-Smtp-Source: APXvYqwAjBt9EvSR/D5AmaSKKJoZS2c5kqEtaA2qL9SWfAsZqWBL4puZK5KG2bR4PfyzwG3LvgabPYguUqqCXNQnwh8=
X-Received: by 2002:a63:354f:: with SMTP id c76mr4373721pga.410.1569348396987;
 Tue, 24 Sep 2019 11:06:36 -0700 (PDT)
Date:   Tue, 24 Sep 2019 11:06:34 -0700
In-Reply-To: <991e5bf9-6e15-1ca1-d593-8abe553ebe7c@arm.com>
Message-Id: <20190924180634.206177-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <991e5bf9-6e15-1ca1-d593-8abe553ebe7c@arm.com>
X-Mailer: git-send-email 2.23.0.351.gc4317032e6-goog
Subject: Re: Problems with arm64 compat vdso
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     vincenzo.frascino@arm.com
Cc:     ard.biesheuvel@linaro.org, catalin.marinas@arm.com,
        linux-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, tglx@linutronix.de, will@kernel.org,
        natechancellor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,
We also are having issues building the cross vDSO with Clang:
https://github.com/ClangBuiltLinux/linux/issues/595

It seems that `LINUXINCLUDE` in arch/arm64/kernel/vdso32/Makefile is including
arm64 headers in the arm part of the vdso32 build, which causes Clang to error
on the arm64 inline asm constraints being used in arm64.

I think if the issue Will described is fixed, it will be simpler for us to fix
the rest to get it to build w/ Clang.

https://github.com/ClangBuiltLinux/linux/issues/595#issuecomment-509874891
is the basis of such a patch.

Clang ships with all backends on by default, and uses a `-target <triple>` to
cross compile; so the idea of passing two cross compiler binaries for a compat
vDSO build doesn't really apply to Clang.
