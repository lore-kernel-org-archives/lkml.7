Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053A8CA9EA9
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5B7B222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 17:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olkgjhwO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505599AbfJRR4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 13:56:19 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:41508 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502168AbfJRR4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 13:56:18 -0400
Received: by mail-vk1-f193.google.com with SMTP id 70so1558970vkz.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIsMVriT4AZEDHIxtRQpfA6TPy6WxstpPPQy/ZvUwbM=;
        b=olkgjhwOKrpksh8vSJf+BJb84VfRZZ5qdUP2pzmiiZqrTACZC/i9cIiYRJgmne3ziR
         ko66mflPJkhk5jRiXb4zXEhdS1luvFe71S6s42yUYccUIDR8gcNMfCwXyOIkQ0Gko0RV
         9DDeaxIiSdr21FNjzVaFcXZqf9tjWZCrcL3qRov3yEgYNBhQlxpD7Y0HCFIxH9vXebne
         d7Vy0l+kXyB43SqiIgm7oTgLYpW6N+mFXKF9Zj9op9b/+csye2MIB4a6S4IXkCsA5zcb
         Kzwwm71iR1gVBxrHRBPCIqcw4pJfaGoi5yVhy4PX7/KiLlr7HDA6C7r7OOtLcEsTVBPf
         YuXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIsMVriT4AZEDHIxtRQpfA6TPy6WxstpPPQy/ZvUwbM=;
        b=fMB1X2zryDxDTkCC7hXEBezuBHieAPH+SkfnUW4IH3HZSX0FqHqvWIddZsu2T6m0+j
         qCUzdpNQrQ7TsvRM4StdaQXl4F6SK416w0AuwhjK/iyatLnAEa+EKCPolB5w+3itn8J1
         ihmEy2ow29YS95bnLMtSD+zY4N0OW1rsGA/Xw0D2kYk+M8uMA7JDiYNu+tp7hz+YSGAj
         tFrApst5Xht+dOrmXCKUMasp/eys9kB1rwSu/vyX3BXVv9L6W0gXli39RcunFF5++avv
         WyvzpOL1HYsApQFqWH9eY60zzB5I7O/zcb2ikFDnZr1oaZcsFsUtQXOUfhq+O9qjy//K
         zZlA==
X-Gm-Message-State: APjAAAVEVXSS3gOm6WVUUQ7sZ2U0UxkUY7pxzQkm4k9oxewg7sQ03fO0
        BU1fyUOE44l8Yx8LkDUVGwyMdYMn9PEFlcp1/Gu4Gw==
X-Google-Smtp-Source: APXvYqyC2iv6T46643JVohCL0ZO6S+yxoXkbTD3puL0IDt0JZj5qGElfVp/07Oy94Ct1iZ+6cOvAdXJjbpJUq0GhLYM=
X-Received: by 2002:a1f:b202:: with SMTP id b2mr6023283vkf.59.1571421375752;
 Fri, 18 Oct 2019 10:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191018161033.261971-7-samitolvanen@google.com> <CAG48ez30P_Af-cTui2sv-YVUY5DdA1DXHdMmAW1+KpvjEPWUOA@mail.gmail.com>
In-Reply-To: <CAG48ez30P_Af-cTui2sv-YVUY5DdA1DXHdMmAW1+KpvjEPWUOA@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 18 Oct 2019 10:56:04 -0700
Message-ID: <CABCJKuf7KsgkzqHGMAVjyS5Zo_ix8a2d6vsRT6OGSUgVLuJ70g@mail.gmail.com>
Subject: Re: [PATCH 06/18] add support for Clang's Shadow Call Stack (SCS)
To:     Jann Horn <jannh@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2019 at 10:42 AM Jann Horn <jannh@google.com> wrote:
> (As I mentioned in the other thread, the security documentation there
> doesn't fit the kernel usecase.)

True. I'll add a note about it here too.

> Without CONFIG_SHADOW_CALL_STACK_VMAP, after 128 small stack frames,
> you overflow into random physmap memory even if the main stack is
> vmapped... I guess you can't get around that without making the SCS
> instrumentation more verbose. :/

That's correct. In our testing, 128 stack frames is nearly twice the
maximum amount that's been used (on an arm64 device), and for many use
cases, allocating a full page is simply too costly despite the
advantages.

> Could you maybe change things so that independent of whether you have
> vmapped SCS or slab-allocated SCS, the scs_corrupted() check looks at
> offset 1024-8 (where it currently is for the slab-allocated case)?
> That way, code won't suddenly stop working when you disable
> CONFIG_SHADOW_CALL_STACK_VMAP; and especially if you use
> CONFIG_SHADOW_CALL_STACK_VMAP for development and testing but disable
> it in production, that would be annoying.

Yes, that's a great idea. I'll change this in v2.

Sami
