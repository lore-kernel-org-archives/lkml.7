Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65A6CA9EC9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:38:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B5320848
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 21:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMgSst2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfKDVin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 16:38:43 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44487 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfKDVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 16:38:43 -0500
Received: by mail-vk1-f193.google.com with SMTP id o198so4162214vko.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 13:38:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=erA0+CgO32nkALAW/U97P1GwaRL1ou+VA5YnrGmuWIY=;
        b=AMgSst2hoIv0GZSG/6Hv3sj7G4QTMHoXZaK+uecCN92VkYk2ZpXGLlGKNE7LaQkMOV
         GALbiSTH4QXZuxCs4vXVQ+PvBEvuBmB7k5aqf+G9gnmvHWB5/Y+uNebLr8WkNd+bS+Ov
         /XXES1wI9li/uMeZkpl2e89se5snh4JkYGrWHWMFeboxhZVboLE1Ab4qQKsBrgjgaJ0Z
         TPALZl6SFGfHwCWeRXmzVYpIwJ+aRCFQbHaYCGtjIRAIEY7ObGDK19pVPN3DP2bzseFq
         kO3Sq+THrsVH8U3L8DmX49sKk84SksyJMDaTiPQHmYPUwA9Od1QsJS2NmYqwVYjSpzCB
         i+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=erA0+CgO32nkALAW/U97P1GwaRL1ou+VA5YnrGmuWIY=;
        b=m7+UgB7d4QreXovQvMQoyfhQmEXPx79SdsdHwmiELN6hfcsYKhYPLeG/Wg+Z2B0mw8
         Ml+W+vSMdlwt7JHOZsbKOmcdKAuvDQIl+QklLv76R7uC5DVspG1V7VhGphSqg8PGZ4Ew
         Zc2bkZVdPKIuZ/8xcea4UOBxNFz0Lr/hrCnGReqfsPnw2TY5l05JkuyxjysNiDR+SpNT
         tGOMCRpZTJ6RZ7Jur/oOP7S4bEOZqs4ddkFTPSb+PlX3LIIotrX93KuyCsUBrULO2nEl
         2/2be1522xr+FB7pY/WEb45xxinL7q1w45ijAVtX6pCN92tGkOfdwo6qZpHn/FmKVjj+
         vIIw==
X-Gm-Message-State: APjAAAXZzFxUu1ds231j5DBvzKltHNyZvPH4dYNzuOfM2EPB3ItVj04M
        XUXQZGJ6hzX66sv5dCiB27Cp8OhcBGI8H9Cp56cQeg==
X-Google-Smtp-Source: APXvYqwHIA8tjMB/idsGTHUTWfDb2R4/Q6AYLqiE/ovPTmnmanOsh2FI1AtdGkwKNIfH3EsSyXxnypTSqw/H2MHfj8Y=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr12696794vkc.71.1572903521740;
 Mon, 04 Nov 2019 13:38:41 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-14-samitolvanen@google.com>
 <02c56a5273f94e9d832182f1b3cb5097@www.loen.fr>
In-Reply-To: <02c56a5273f94e9d832182f1b3cb5097@www.loen.fr>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 4 Nov 2019 13:38:30 -0800
Message-ID: <CABCJKucVON6uUMH6hVP7RODqH8u63AP3SgTCBWirrS30yDOmdA@mail.gmail.com>
Subject: Re: [PATCH v4 13/17] arm64: preserve x18 when CPU is suspended
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <dave.martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 5:20 AM Marc Zyngier <maz@kernel.org> wrote:
> >  ENTRY(cpu_do_suspend)
> >       mrs     x2, tpidr_el0
> > @@ -73,6 +75,9 @@ alternative_endif
> >       stp     x8, x9, [x0, #48]
> >       stp     x10, x11, [x0, #64]
> >       stp     x12, x13, [x0, #80]
> > +#ifdef CONFIG_SHADOW_CALL_STACK
> > +     str     x18, [x0, #96]
> > +#endif
>
> Do we need the #ifdefery here? We didn't add that to the KVM path,
> and I'd feel better having a single behaviour, specially when
> NR_CTX_REGS is unconditionally sized to hold 13 regs.

I'm fine with dropping the ifdefs here in v5 unless someone objects to this.

Sami
