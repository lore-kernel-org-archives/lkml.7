Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B25CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B708C20679
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 17:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rPGbbUqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbfJ2Rpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 13:45:35 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:44698 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfJ2Rpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 13:45:35 -0400
Received: by mail-vk1-f194.google.com with SMTP id o198so3070334vko.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 10:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65YP9F0KitFD9legdxyLM59RAjKBzdRGrjI3L/m7ObE=;
        b=rPGbbUqAwVHq7Cm0rGfrw8aZKG5VrL44JQ4WF1AX8zOdwQI8rkKHDe3Opfeq0pYbYi
         ZvPBEVky5mJq0A1utYxoVfchIrzcrJxh4cYKqeEyKqh3F5ZpGjwR7FuS+45Wd+YvZTAR
         FCYHhGld6MAkj8PSSTu0jSSloZk6eBz34o6f90VAXFRXs/86osn7qCWlcHM8wNytg3QS
         uJNMarnDvny6K3ClI88qEsq5+XwNmoTiSipJzzK0eD0W9Nwi+d6vcizeA7IRNM1KW01T
         8D5hlGzbW/5Mpci+BoZWh8xm7HIZT8sr5w3L36adlm6C6pBdnby12ApWTEuM8rl7eyke
         UlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65YP9F0KitFD9legdxyLM59RAjKBzdRGrjI3L/m7ObE=;
        b=XXDYKpHc04U9KkXSAmHU2hnBqnG6/7YH3gX3AlTvAb97fiwjQpl01YNJKM2J5h5F0q
         47LkPvTgWji0CdWfQk0zFpE3RYvUD6hJy/1SFiH6LTaW8+Ts/SbG462OrgEW4S8AbWKU
         NzpT64lxzjW55EkNMS2gJ82OhgX8vgxnYZV6YFlzyaxq9kbH5drkPnpsUN56ov4uXtrh
         kY73ibSrQGqSiF8FZux5jizSOU+tmsR6SOBRZAc7NrgAw5hbDUJZsMrx7YWPRqTnQOgD
         yEBoMdr2IS3hUksvETlLEcyvg7rowpTdRXRJH34K1TFSxWnxvpOQXG3hyRhlVKDpTi95
         jHbQ==
X-Gm-Message-State: APjAAAWyDShHOaFysCzsRphAItz8qOV785zCFaLqHeAwDjj+Y6ADFuqT
        ikMQn7OBroxAGQJgKImtp7KCd73W+2ypiX/8OmK7ow==
X-Google-Smtp-Source: APXvYqyofjlHaKbwoCfizqOngvFU3/FN2jdIJr9xQCjuFQ8iVqA3V1NcHewQYwziFUY5XcE5H3ggNp7mqR1GIqnLUe8=
X-Received: by 2002:a1f:7d88:: with SMTP id y130mr12501967vkc.71.1572371133208;
 Tue, 29 Oct 2019 10:45:33 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191024225132.13410-1-samitolvanen@google.com> <20191024225132.13410-10-samitolvanen@google.com>
 <20191025110313.GE40270@lakrids.cambridge.arm.com>
In-Reply-To: <20191025110313.GE40270@lakrids.cambridge.arm.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 29 Oct 2019 10:45:22 -0700
Message-ID: <CABCJKud1xYEx_GVgfBHUuwNGKMxX+uVaE5TR6DEqo7CoSJJnNA@mail.gmail.com>
Subject: Re: [PATCH v2 09/17] arm64: disable function graph tracing with SCS
To:     Mark Rutland <mark.rutland@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
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

On Fri, Oct 25, 2019 at 4:03 AM Mark Rutland <mark.rutland@arm.com> wrote:
> I'm guessing it's difficult to always figure out the SCS slot for an
> instrumented callsite unless we pass this explicitly from the ftrace
> entry code, so we'd probably have to change some common infrastructure
> for that.
>
> We have a similar issue with pointer authentication, and we're solving
> that with -fpatchable-function-entry, which allows us to hook the
> callsite before it does anything with the return address. IIUC we could
> use the same mechanism here (and avoid introducing a third).
>
> Are there plans to implement -fpatchable-function-entry on the clang
> side?

I'm not sure if there are plans at the moment, but if this feature is
needed for PAC, adding it to clang shouldn't be a problem. Nick, did
you have any thoughts on this?

Sami
