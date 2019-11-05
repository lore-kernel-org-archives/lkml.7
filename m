Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DDC5DF60
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F142921D6C
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 20:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlrzHL7e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfKEUAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 15:00:38 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43908 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbfKEUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 15:00:38 -0500
Received: by mail-pg1-f193.google.com with SMTP id l24so15140948pgh.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2019 12:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ijT2GiWjIk0i5IPeCeqTo4IKLHUoxPnZNqQGZcLSsUM=;
        b=IlrzHL7ezty7NJqDoQVYCYZlgd5TLmozpoptOSResx7u8dduPfsVCwxetHhcwt9646
         G5tawFW78NnqVIQt8407pHG1e5zjGMrJqwSAl/oTDeue+ZI2bATAOFZnrvI5R4CrFfiJ
         n/6N9z9oo1SS6gVNC+qeZlwIfm5V4ROnhCdfuQ88aX5YBI34+oEw7Plr+gCPLfYF88Vv
         t5tkx9zp3H7o8W4fjZlCkI79/q3S/1dYYa3tpdlZAhUsRg24PXeyBp+HEkPn07uvN5Ub
         L9GkaFYee6+WNZPm2Nz3Y0BWrpxuapPuy18/e3w0kK2dmoGn0+nwp0yPpHzqG6gUGVPj
         itFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijT2GiWjIk0i5IPeCeqTo4IKLHUoxPnZNqQGZcLSsUM=;
        b=QAKbmGEeyx/Rx1+6lNKhvsI0cn3BnldYpEZb9YmcgV4RaUKvtcmHdVRKr8ovaooVC4
         MQx55IfrIBmRGnQ4uKnWKy4Q6Ckf+Ywo+jFQ22nJTqL36/pyGeVALlE7ZLjfkbrCokj7
         0Lhz07kub6VrnMszb1pNrSrlAga/AhF+RiFBhajw5nrGhg18GiOn7vn/zxin3eBvHxOV
         4YyEjbyM7o9qXc0smCajBfvGOxaUowxLwN+zmTXU55iP7+Qw60L95FPBw6EZWQzo+bvD
         SH5tXANx5ld1EMYPyAJU5iYj8ZgyZfo0pnjcUKTJG7i4EMffrqQO43Ezk76dThrcYbfI
         TfCQ==
X-Gm-Message-State: APjAAAWZx4Ne9Kamtikl9AfwoKvvME97r8hZwq4eMTaLiKQea6onfKfZ
        A+/OLpvuaT+UixBgEf+6CTbk+pmuxRdoEx6bSbiBewY4ckk=
X-Google-Smtp-Source: APXvYqyIFpCKniQqTsvrpnzyV0E86VzxTLXkPlxCMRfFt3g4qhjOa1M4benI/dNGWIb6R6YCFbVunWVoJWRhpBKoHRs=
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr1056137pja.134.1572984037414;
 Tue, 05 Nov 2019 12:00:37 -0800 (PST)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191101221150.116536-1-samitolvanen@google.com> <20191101221150.116536-12-samitolvanen@google.com>
 <20191104171132.GB2024@lakrids.cambridge.arm.com> <CABCJKufDnLjP9vA-wSW0gSY05Cbr=NOpJ-WCh-bdj2ZNq7VNXw@mail.gmail.com>
 <20191105091301.GB4743@lakrids.cambridge.arm.com>
In-Reply-To: <20191105091301.GB4743@lakrids.cambridge.arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Nov 2019 12:00:25 -0800
Message-ID: <CAKwvOd=3mEUaxMX7Q6n3DAMAdge4eB=KYdiQxn2tY77taCD1NA@mail.gmail.com>
Subject: Re: [PATCH v4 11/17] arm64: disable function graph tracing with SCS
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>, Jann Horn <jannh@google.com>,
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

On Tue, Nov 5, 2019 at 11:55 AM Mark Rutland <mark.rutland@arm.com> wrote:
> Similarly, if clang gained -fpatchable-funciton-etnry, we'd get that for
> free.

Filed: https://bugs.llvm.org/show_bug.cgi?id=43912
-- 
Thanks,
~Nick Desaulniers
