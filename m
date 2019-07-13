Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F68C742D2
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 01:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA3520863
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 01:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8AtATm5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfGMBqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 21:46:49 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:32847 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbfGMBqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 21:46:48 -0400
Received: by mail-lj1-f194.google.com with SMTP id h10so11022536ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 18:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YpQBVIzXh6maHmnk6CkzSIf8JtAzl5sL2cPmtNRfmXk=;
        b=K8AtATm5+VzKcjCh1t23FiisxnQ59lcDmayDKPzNLSACmY2usb4c4BiBeo+WS4EL/u
         6ymFl96lKJSvZK4VnUvz6ftqiORSOFYBPH+iqvhueUX2d7+6oUY2iYIvP51yPPPJ4KCp
         JxrjT03/3RhJisxpkJPXnyPccXkRiV7XpOTcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YpQBVIzXh6maHmnk6CkzSIf8JtAzl5sL2cPmtNRfmXk=;
        b=cmJTPqHaanTeVGYwb/yPR3yJVVwTmkYkXq0XJOG027y0EplyGuadp+aNJWECUxz+2I
         F/FDFXF0ChsItUrw3XBXrWny9c4XUyAO5viTOoj4bwCIwf5c4HMH6KgiHkRNqqYCqOwJ
         MVQJ2PoxO/cXrDS2HYlp5gOnTMKCr8xs/LIrg+vJ1y7bLiRDmCYLKg8Yy1tlYg8Q2QXb
         bbVf0WrAUyIrBdO32HxVj5UW0UYEzuGIy1b2PuTNcNsvMmJZEoRf/W7SZ4aDDjaRtPvn
         4PGR8VwCTjIRICIjSHx9wr1OTOtyRv8W2/uij/sWQN+xNIsif7J6LqZno2UTd2TK+bs1
         gF6A==
X-Gm-Message-State: APjAAAUJS6Xp0DL/Jws872tF6AxAZweKvY3k7dRKgXBeC0WmviwNkt2V
        fp402J87UiLonjY0nrlGqDM4jTFIceM=
X-Google-Smtp-Source: APXvYqwzVuEGKWMZJJeZfpuSyfPYyxz53oT8/7bI/S4ovvXMOkFkNtUNud9f4osufSLFtWCBhdGTsw==
X-Received: by 2002:a2e:b4e4:: with SMTP id s4mr6601315ljm.207.1562982405949;
        Fri, 12 Jul 2019 18:46:45 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id v14sm1728145ljh.51.2019.07.12.18.46.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 18:46:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k18so11011214ljc.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 18:46:43 -0700 (PDT)
X-Received: by 2002:a2e:b0e6:: with SMTP id h6mr7313053ljl.18.1562982402950;
 Fri, 12 Jul 2019 18:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190712010556.248319-1-briannorris@chromium.org>
 <CAK7LNARGNVfxexE616cQDs1fK7SzToKwHxO_T69+RShL6QVTCQ@mail.gmail.com>
 <CA+ASDXNGqYkBjMsjcRKAit+0cd0n7dwxKhezyYCXSh_HjucvQw@mail.gmail.com> <CAK7LNARJ=aAf-iG7RVDp=bs7DTScJ1GBpEpkqtKDFDJYHEekUA@mail.gmail.com>
In-Reply-To: <CAK7LNARJ=aAf-iG7RVDp=bs7DTScJ1GBpEpkqtKDFDJYHEekUA@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 12 Jul 2019 18:46:31 -0700
X-Gmail-Original-Message-ID: <CA+ASDXOOyd4-thctnHG06GXnouf6EuJ4QV5QM+3iNBYQF499uA@mail.gmail.com>
Message-ID: <CA+ASDXOOyd4-thctnHG06GXnouf6EuJ4QV5QM+3iNBYQF499uA@mail.gmail.com>
Subject: Re: [RFC PATCH] bug: always show source-tree-relative paths in WARN()/BUG()
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 6:50 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> GCC 8 added this flag.
> So, it will be eventually all solved in the GCC world.

Ack.

> Clang has not supported it yet...

That's what it appeared like. I've bugged our Clang-loving toolchain
folks to see if we can get parity.

> Trimming absolute path at run-time
> is no help for reducing the kernel image.

Sure, but that's not my stated goal. It would indeed be nicer though.
I guess if no one else speaks up with a favorable word toward my RFC,
I'll just see what I can do on the toolchain side.

Thanks for the help,
Brian
