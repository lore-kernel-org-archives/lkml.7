Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443BC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F4D208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 22:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQSXo4Gx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfEMW0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 18:26:19 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44398 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfEMW0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 18:26:19 -0400
Received: by mail-pl1-f194.google.com with SMTP id d3so7161781plj.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 15:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bKp8g3OLs2Z5yLWjvW5yUPSvLIANIoFUyVrmmCHqTls=;
        b=qQSXo4GxkgQAE+tVCwHm3khP8eYH7Lc5EjnFpHuQ2vIbQ3bnQiCfOqbxk/QCF4jjpY
         rFDz1d3R1hGjgAq12yViGMMNy7ewGg7JUAclPpujLQk+xMg/PbwSUuAPcAAQ7RAih6To
         mwv3w5e5VEqOIQfUJawTjeh+gW4EowZwZVPpUtQHpmnLtaXFmMRK7ZSpRkiHZiUtA6/5
         xut0qVgobT0yFgrUuOoSYb/AtucK0U+UejB1dU57TRBk/v9r8PUy+FgdmSTVzABJ0S6U
         PYtJs2z9MycEGUHcq9FJtLIfpW6uMwu92wI9xl3FrwEDrbNmZ5OAtHwUog2BMicRzJiG
         BwcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bKp8g3OLs2Z5yLWjvW5yUPSvLIANIoFUyVrmmCHqTls=;
        b=Er35fRFff9W44/ugtY4Hvm72xwDtrR5mlrnOK9mIvKhpnW9zFOdf9T2wGhuOiBGUrk
         NlLVyVtBg3BI6y5Gg+60HliQH+q6Y6oBrdT8m0elk8hNnZMO6TGDPcJmBmHx5u8dfLMc
         TNzvsC32gOtMERJnX/o3cR2szPWvCdoYw73M2iYntISTQhM8xI92GGLakL36nLUAx52L
         pJqA5GEKUIl4fNJha5zReho/ce0ijXSuTj+P+LY8SkuFahhvfRRXLbflOjF172MZBV48
         Y3AuRLUXg8a+bGWQ0BqmiauJ3o6/T/G3nN8xap7ZqwBAihM33wDjK/NpkFt3BcXVHl2q
         HCrg==
X-Gm-Message-State: APjAAAU4qmgmUOdjkhGlqzd0v6jcT/w/fzTGFhXNglzzzOv3LGlb/Lg+
        y6IF1KwGMmaVkMwbNA9tArxd+BaEDSMdZh0ce6WT3Q==
X-Google-Smtp-Source: APXvYqzE83ChiuwKJY3dwQ3D8Sh7ZUaHNawLBO1AJMBjeEqiBEEM/m3tmr4ntBLB9b7rUjDJPU7ly9cJlmqwH8qYsxk=
X-Received: by 2002:a17:902:2ba8:: with SMTP id l37mr12782892plb.229.1557786378435;
 Mon, 13 May 2019 15:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190513222109.110020-1-ndesaulniers@google.com>
In-Reply-To: <20190513222109.110020-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 13 May 2019 15:26:06 -0700
Message-ID: <CAKwvOdmOZZxZYCeVzJbdMMdstsvquXEWpUvPsxVtXVQqi2q_Eg@mail.gmail.com>
Subject: Re: [PATCH] lkdtm: support llvm-objcopy
To:     Kees Cook <keescook@chromium.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <nathanchance@gmail.com>,
        Jordan Rupprect <rupprecht@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2019 at 3:21 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> With CONFIG_LKDTM=y and make OBJCOPY=llvm-objcopy, llvm-objcopy errors:
> llvm-objcopy: error: --set-section-flags=.text conflicts with
> --rename-section=.text=.rodata
>
> Rather than support setting flags then renaming sections vs renaming
> then setting flags, it's simpler to just change both at the same time
> via --rename-section.
>
> This can be verified with:
> $ readelf -S drivers/misc/lkdtm/rodata_objcopy.o
> ...
> Section Headers:
>   [Nr] Name              Type             Address           Offset
>        Size              EntSize          Flags  Link  Info  Align
> ...
>   [ 1] .rodata           PROGBITS         0000000000000000  00000040
>        0000000000000004  0000000000000000   A       0     0     4
> ...
>
> Which shows in the Flags field that .text is now renamed .rodata, the
> append flag A is set, and the section is not flagged as writeable W.

Probably should've been:
Which shows that .text is now renamed .rodata, the
append flag A is set, and the section is not flagged as writeable W.

-- 
Thanks,
~Nick Desaulniers
