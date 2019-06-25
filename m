Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D81EC48BD4
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7216208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxFQm0f8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfFYQ1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:27:04 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:33856 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQ1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:27:04 -0400
Received: by mail-pf1-f176.google.com with SMTP id c85so9754003pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=80CMW1CXgixxE6sp3uxeNp/J1zOPF5jkUw1uJmN2ooA=;
        b=DxFQm0f8lcGNUUfWeI9tVAbwKiHoayrI4J2XSYTYvcWV8ZVs6z6dxn/PIOWMqNZiOs
         NJYi0KcOk5FnNh/DsltqF1SaqzZUP/kNGSd4rYx3o0Mu9UksrNXcRozu+Hl7aCK3dKLV
         kT/Vy4k7fSqvWuSuElS1wrItFrs1fs4YtHfMdflWHkMX/geaIMcPN8tQwpvrcoYDoLEo
         uLSPMv+awtDaYfwIvNNyWGv21bY3vOA4ftH6pjK32fN2yOznmsTfIv6ViRAreYpYbDIj
         PmPcWs7zeoIJOf+p+af2jzElTSzCr1sSRyvW+67Mk9T54byLqHXae8dI606kjHKINAkA
         DuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80CMW1CXgixxE6sp3uxeNp/J1zOPF5jkUw1uJmN2ooA=;
        b=sOkltesvwM8QOq3ak7evG19EKNbyvYQQ6BpMgV7e197xRjgO7HG8C7G+heXNVaTiNy
         Et8pevJbfXkQhbS7uATPXbPjKJxRXnUj2rDQy4vQcOqQVBQpOq2FNrI+zCK+Wc191mcP
         uctWTqU1+FwkHwwYkKD26IIfy3vAzXnMj2KU2tyzMo/+t/khxPFInAjQIoq7tC952yjz
         tXsCWdlznFIg16aarPaz+WaSxrsNcol/49wEhiJrYJvQhuPWspNBSEgW/SE9b0ZNZAod
         DL0hId93cpK9MeqxBBoBWsI8/k3oreMwjltnOIsegMrff/Kk2itlcGGAdYIFNnlLca8o
         zHDQ==
X-Gm-Message-State: APjAAAVHabzA1O96DY0ZwTkV2VwrMP6Jk2aNh+Bo9bsZkMGFtl9zV3Up
        0Sue6Uf0BBseZhCwChVMsY8/TWOCqDuO1yMMXlMCqg==
X-Google-Smtp-Source: APXvYqyvmLAzpcjcizKNCO7b7pIAiexKr3wyd2w+TQPA1OgLRCokBKxEK4jllbhIN8ExEmTZ+xPB7+/+eRRtHo+9qQ4=
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr33384070pjq.134.1561480022872;
 Tue, 25 Jun 2019 09:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <1561464964.5154.63.camel@lca.pw> <e86774e4-7470-5cb2-fc3e-b7c1f529d253@arm.com>
 <1561467369.5154.67.camel@lca.pw> <00a78980-6b9c-5d5b-ed01-b28bb34be022@arm.com>
 <1561470705.5154.68.camel@lca.pw> <5113362e-1256-6712-6ce8-9599b1806cf1@arm.com>
 <1561472887.5154.72.camel@lca.pw> <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
In-Reply-To: <668bbe72-b32b-8cee-ccad-d1f6110c6728@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Jun 2019 09:26:51 -0700
Message-ID: <CAKwvOdmCFjunXRbninTdqoDGPNJ6b7npgXLAPYGqFZas5ofNjw@mail.gmail.com>
Subject: Re: "arm64: vdso: Substitute gettimeofday() with C implementation"
 breaks clang build
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 7:54 AM Vincenzo Frascino
<vincenzo.frascino@arm.com> wrote:
>
> Hi Qian,
>
> ...
>
> >
> > but clang 7.0 is still use in many distros by default, so maybe this commit can
> > be fixed by adding a conditional check to use "small" if clang version < 8.0.
> >
>
> Could you please verify that the patch below works for you?

Should it be checking against CONFIG_CLANG_VERSION, or better yet be
using cc-option macro?
-- 
Thanks,
~Nick Desaulniers
