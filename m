Return-Path: <SRS0=4CSQ=WG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9335FC433FF
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D98F2086A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Aug 2019 19:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565466283;
	bh=qQKVgiVk/W4h9r2gMehfGL+wCqx7ZGS1By+L4dEH6CA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eHWegBn4DWT1B0JQryhFcxkUXNlP8uodaqjoZg+LSHV8UMgjFcLmkgP2gALneRTLy
	 A2Xx8H/EksuN1RAc+4HXW5oU4OnlFbJh0sQyuOfvKL9q20mAjdRJNX2Xu/kpmwGU/l
	 wd51SGohBxJq+chydQ7L44ZuNKW6P4qbMxlUBOlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbfHJTol (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Aug 2019 15:44:41 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:32850 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfHJTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Aug 2019 15:44:41 -0400
Received: by mail-lf1-f65.google.com with SMTP id x3so71930376lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OPIxIxlXR4jJGuIF0yAsFePRYZ0EHIx7iO6Jaj/MzSc=;
        b=gpuUg2rYdjLp6GT9zzRgL/Gslma9+5I14Ll7SY3jkoQLBWF0rQG52K1JAB90EodK6s
         qUPOAio+csuR+rnVXmuLufDwDwGB0/Aaq6szkK+UNgF9kFcH4vGtdTgmmR7MaqhAq0T0
         z4o0KdbVP32LcAKxLY1y9ruTeSrIO2AoHLL4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPIxIxlXR4jJGuIF0yAsFePRYZ0EHIx7iO6Jaj/MzSc=;
        b=Pln7C7EmjJx5FoYUqB51YSQbnV6QVI8PfYkuz2yzQRJ5ga14OEi7Z/hm8hE/3GSAxl
         fvQw4/Sthf0C11tMEa4s2+i1NXbO/whZfnWKj9BZ15PSefrS3w2owbpjUU3hTQu3ei0f
         5LME5B91qtmA1mPwpOonpLedTpu4YuXJRal0JFcCNDF8YfYQ2vHQD0IDc1WvxUTL1qy/
         fVWCgPRigwHnTKWvEqhuWHIv9lYd7Kj2u32sMQl8J1BPOa2nXxNzO/EGxr9A/wA9W1bW
         /zbktNmBt1KgmSBaiLDU4k9qHkRNRurxgGWMdI+SfVs4Yb0dcZTxp35X8YrDqDd2wGUc
         PxAQ==
X-Gm-Message-State: APjAAAWY013F0d9/rgOebsa2OrXxa+txHEFUM3WXLmJE3I9N3IdLHoq7
        emhqmeS9DvFP4f926PeueWQYot01QJM=
X-Google-Smtp-Source: APXvYqz+NdwC5M9C8DvCSeK3BHaFD6N8/1AWECbV2yOvpxzn5Uq3/rikgCoSRYcDjnRcpt/Addk9AA==
X-Received: by 2002:a19:c150:: with SMTP id r77mr16937286lff.76.1565466278451;
        Sat, 10 Aug 2019 12:44:38 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id n124sm18194116lfd.46.2019.08.10.12.44.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Aug 2019 12:44:37 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id a30so8756473lfk.12
        for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2019 12:44:37 -0700 (PDT)
X-Received: by 2002:ac2:4c12:: with SMTP id t18mr16185578lfq.134.1565466277273;
 Sat, 10 Aug 2019 12:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <c0005a09c89c20093ac699c97e7420331ec46b01.camel@perches.com> <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
In-Reply-To: <9c7a79b4d21aea52464d00c8fa4e4b92638560b6.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 10 Aug 2019 12:44:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
Message-ID: <CAHk-=wiL7jqYNfYrNikgBw3byY+Zn37-8D8yR=WUu0x=_2BpZA@mail.gmail.com>
Subject: Re: [PATCH] Makefile: Convert -Wimplicit-fallthrough=3 to just
 -Wimplicit-fallthrough for clang
To:     Joe Perches <joe@perches.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 10, 2019 at 12:32 PM Joe Perches <joe@perches.com> wrote:
>
> What does it take for this sort of patch to be applied by you?

The basic rule tends to be: "normal channels".

For example, in the case of most of your patches, that tends to be
through Andrew, since most of them tend to be about the scripts.

In this case, I would have expected the patch to come in the same way
that the original Makefile change came in and follow-up fallthrough
fixups have come, ie though Gustavo's tree.

I certainly do take patches directly too, but tend to do so only if I
feel there's some problem with the process.

I pulled from Gustavo earlier today to add a few more expected switch
fall-through's, I guess I can take this Makefile change directly.

               Linus
