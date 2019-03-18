Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB93FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CBD720863
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 22:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfCRWIW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 18:08:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37123 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbfCRWIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 18:08:22 -0400
Received: from [IPv6:2607:fb90:8435:e408:e1a9:1fde:6fc9:a6d9] ([IPv6:2607:fb90:8435:e408:e1a9:1fde:6fc9:a6d9])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x2IM7p8E3152708
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 18 Mar 2019 15:07:52 -0700
Date:   Mon, 18 Mar 2019 15:07:47 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190318215605.GJ112750@google.com>
References: <CAG5bF+RvumzKK0E-GAT223jnBvkRe1RN_0J9cGpfPOqCBvfWyw@mail.gmail.com> <CAKwvOdnms16AC3jPcc_7MXD7QF43dKvHsi+aqmsz0wX-u1GTpA@mail.gmail.com> <20190318215605.GJ112750@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] Revert "kbuild: use -Oz instead of -Os when using clang"
To:     Matthias Kaehlcke <mka@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Behan Webster <behanw@converseincode.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Manoj Gupta <manojgupta@chromium.org>,
        Tiancong Wang <tcwang@chromium.org>,
        Stephen Hines <srhines@google.com>,
        clang-built-linux@googlegroups.com
From:   hpa@zytor.com
Message-ID: <0275C6DD-7F77-4D51-9C35-B25ECF61EB0F@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 18, 2019 2:56:05 PM PDT, Matthias Kaehlcke <mka@chromium.org> wrote:
>On Mon, Mar 18, 2019 at 02:47:13PM -0700, 'Nick Desaulniers' via Clang
>Built Linux wrote:
>> On Mon, Mar 18, 2019 at 2:10 PM Matthias Kaehlcke <mka@chromium.org>
>wrote:
>> >
>> > The clang option -Oz enables *aggressive* optimization for size,
>> > which doesn't necessarily result in smaller images, but can have
>> > negative impact on performance. Switch back to the less aggressive
>> > -Os.
>> >
>> > This reverts commit 6748cb3c299de1ffbe56733647b01dbcc398c419.
>> 
>> Does scripts/checkpatch.pl complain about this format (full sha, no
>> title)?
>
>Nope, for reverts checkpatch is happy with it, I suppose because by
>default the subject of the reverted patch is part of the revert's
>subject.
>
>> Not sure that necessitates a v2, but if so would be good to
>> mention that Clang generates excessive calls into libgcc/compiler-rt
>> at -Oz.  Thanks for the patch and the discussion/sanity check.
>
>I can send a v2 if 'needed'.
>
>> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
>Thanks!
>
>Matthias
>
>> >
>> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
>> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>> > ---
>> >  Makefile | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/Makefile b/Makefile
>> > index 9ef547fc7ffe..191f3ce3cb5e 100644
>> > --- a/Makefile
>> > +++ b/Makefile
>> > @@ -667,7 +667,7 @@ KBUILD_CFLAGS       += $(call
>cc-disable-warning, format-overflow)
>> >  KBUILD_CFLAGS  += $(call cc-disable-warning, int-in-bool-context)
>> >
>> >  ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>> > -KBUILD_CFLAGS  += $(call cc-option,-Oz,-Os)
>> > +KBUILD_CFLAGS  += -Os
>> >  else
>> >  KBUILD_CFLAGS   += -O2
>> >  endif
>> 
>> 
>> 

Would be nice, still, to have -Ok.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
