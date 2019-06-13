Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E76FC31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D81C521473
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 15:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qc01olia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbfFMPSn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 11:18:43 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:38217 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732154AbfFMNFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 09:05:16 -0400
Received: by mail-io1-f68.google.com with SMTP id k13so16651893iop.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 06:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=COMq1DZp1tUFDOVJCz+Oc5oRle5W+TVy2bbvRpSIdF4=;
        b=qc01olia4cmwrnoPTe2ZFrmw8g/xeegnMkBjI6b5n3TIdaetazObaCuOVxxJGxztfx
         UWxdZDvZDFYmTfiHnlGPUNiNlz24GdHLSttZMTJdYvj6tFmu3BtHAev5gqLNhXvSPYnM
         NsXWoj0lkbckrxBeZEJgG5KoxPDrFhBmupApL0hfeJS3hCMIKbbkjYDoZCw2sNnAkwZQ
         6cKSZeJReF8wUT0bqEHGB7mByLnj/TeKWcvCjWas4NwnEgzQpNFuh3wA5GgvZBs88li2
         oNEgWYm244rN1o23TzoBUZ+n2kFqLpUW00bU/764tbCeMtdqKf/ChMz/FSj1569Oj9Ra
         UQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=COMq1DZp1tUFDOVJCz+Oc5oRle5W+TVy2bbvRpSIdF4=;
        b=jzoOy0UQB5naT6aqhyQXp62XrPg+0y9+927v+ZN+34fZE29XlyrmIRy7srGjBNjgj+
         FNskKsL3yZtz6fYa6K5PQ7eI9pK2PsB1iFWUghAeiJeshSuTFBn4l7DorRbh4MtwQe1R
         hXB9oBZrc4CxCq2m2duhStjW95hUqcaPHnPeHBS5WpZ65tU6rwLPDkuLOZ7qao23G46L
         Ir6t/vT7+sP9gMLxlG3YScXm6et0iIvkf9zfR+OxL0bt4qGrPpWG2rOzpmIU56SHv/WJ
         m0plRY8dtxIS9JFA2vN7LhrVuY3bTMG2fGZAWtYtAmQ23XOzAcuH5Aak288svKNc69jH
         jn5A==
X-Gm-Message-State: APjAAAWiMjD88QzRQL86CpNBByp8HrBywLY/WjrkGyg6Oglono/808r9
        IQyaYvzymfKjscD17OlEpQx4TWcnP2BPh0qSOLmwpQ==
X-Google-Smtp-Source: APXvYqx+Wyo9dQ01vmbb1QVMUlNB4LxKek/Z4JsplxvhFxRKIXJWRUTg5jAa3SaPJ4zJ8mK/k/T7Pj1+pIKN6neeKaQ=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr6100497ior.231.1560431115386;
 Thu, 13 Jun 2019 06:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190613081357.1360-1-walter-zh.wu@mediatek.com> <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
In-Reply-To: <da7591c9-660d-d380-d59e-6d70b39eaa6b@virtuozzo.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 13 Jun 2019 15:05:04 +0200
Message-ID: <CACT4Y+ZGEmGE2LFmRfPGgtUGwBqyL+s_CSp5DCpWGanTJCRcXw@mail.gmail.com>
Subject: Re: [PATCH v3] kasan: add memory corruption identification for
 software tag-based mode
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Walter Wu <walter-zh.wu@mediatek.com>,
        Alexander Potapenko <glider@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Miles Chen <miles.chen@mediatek.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 13, 2019 at 2:27 PM Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 6/13/19 11:13 AM, Walter Wu wrote:
> > This patch adds memory corruption identification at bug report for
> > software tag-based mode, the report show whether it is "use-after-free"
> > or "out-of-bound" error instead of "invalid-access" error.This will make
> > it easier for programmers to see the memory corruption problem.
> >
> > Now we extend the quarantine to support both generic and tag-based kasan.
> > For tag-based kasan, the quarantine stores only freed object information
> > to check if an object is freed recently. When tag-based kasan reports an
> > error, we can check if the tagged addr is in the quarantine and make a
> > good guess if the object is more like "use-after-free" or "out-of-bound".
> >
>
>
> We already have all the information and don't need the quarantine to make such guess.
> Basically if shadow of the first byte of object has the same tag as tag in pointer than it's out-of-bounds,
> otherwise it's use-after-free.
>
> In pseudo-code it's something like this:
>
> u8 object_tag = *(u8 *)kasan_mem_to_shadow(nearest_object(cacche, page, access_addr));
>
> if (access_addr_tag == object_tag && object_tag != KASAN_TAG_INVALID)
>         // out-of-bounds
> else
>         // use-after-free

But we don't have redzones in tag mode (intentionally), so unless I am
missing something we don't have the necessary info. Both cases look
the same -- we hit a different tag.
There may only be a small trailer for kmalloc-allocated objects that
is painted with a different tag. I don't remember if we actually use a
different tag for the trailer. Since tag mode granularity is 16 bytes,
for smaller objects the trailer is impossible at all.
