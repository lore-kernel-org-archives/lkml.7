Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FCBC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F6D20645
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 23:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="P3pqAGBB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387595AbfDQXjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 19:39:14 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45989 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729079AbfDQXjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 19:39:13 -0400
Received: by mail-ot1-f67.google.com with SMTP id e5so146681otk.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 16:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwZ1yeOi33pxj7r4a6TdB0llsmTaierV6kg9OztFX38=;
        b=P3pqAGBBE/EdbOzi5Mt7OhL/roYgUDO8ApmcfA6+vzL3W3x+qXknBqmyLnT3F2/6yT
         ChzziSUvQZ4R3UXxJZ1Y4jKlVNnE2ScXAJN93WPqDkjHribAl4zZ46YfvfCdw0B4yDST
         9YVTQTfKgWh5mfNeQKzz8rm07Ack/DRJxEKnRXkFj/lGl+yh7EQTuGHZ0ShRMXEIjenG
         1fT21yYiNC98Hc6JO6cKNtuOOA5LAxqc49XyCgZh+pQizi98U6F9KoU4r3IWZkqaq9UT
         9vJV7kK2HW46Qz64d4abT9HKjqKxfX1VX7dfc8hgiuzcr99SxQiNsFBfCfHcddZD8cCV
         liXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwZ1yeOi33pxj7r4a6TdB0llsmTaierV6kg9OztFX38=;
        b=KKy/Z4yykZXLRAtZM4bPnKVutwhPrEMUro+b2hfSAdlT4rSzszn7cqEbsT5L7i5mqz
         oMeLDMB0zJn97bmdpMsscs7fdcL9xclh5fKslbNaoXlyOUM/ynubgLFygfBvbsMGOxvC
         8bZk4/kPVWR51MZJ1YlJSdjxQRRWVKaZByt3Z6P8U3Pk6wB2NEKIgZzsqXHXkhpkRRHX
         eWreWzyTlIfhU7ZsayoLHJtSSmaXUEF4P7WCYPwHzWoBNivlG4i6HRAuVs7v/NMq43Y0
         TZNz/soQ5PfRtOPwDLOkPryBdm52veaS9piMQlgjg/ZISnN2j4qnWj0ke2nod5njRKPJ
         w/Pw==
X-Gm-Message-State: APjAAAUdcUJfZk6DhQpgCnONBzZ/oL4o0SU7hUxP+Eyp/JgpLdff/q81
        dTZPFZ7FnljExFHiOBAcIBSP6CZ4UGZ2Ja1OcJR5dg==
X-Google-Smtp-Source: APXvYqxx4/eoq9hLp0rEirfHEsWga37+bePsMffhmG/+dimY9rxhJ/I3h1JF0407talJXAqiW+xHdihSBrXEW2JqXTI=
X-Received: by 2002:a9d:5188:: with SMTP id y8mr1805512otg.357.1555544352635;
 Wed, 17 Apr 2019 16:39:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190417225328.208129-1-trong@android.com> <20190417162139.2ca3ba78eab414b2fa854a07@linux-foundation.org>
In-Reply-To: <20190417162139.2ca3ba78eab414b2fa854a07@linux-foundation.org>
From:   Tri Vo <trong@android.com>
Date:   Wed, 17 Apr 2019 16:39:01 -0700
Message-ID: <CANA+-vDZ9VQ--aGGuTSL3ax5Njxm4G9ZqDfMsbmBUJR0dA52Ag@mail.gmail.com>
Subject: Re: [PATCH v5] gcov: Clang support
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Greg Hackmann <ghackmann@android.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Trilok Soni <tsoni@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Daniel Mentz <danielmentz@google.com>,
        Petri Gynther <pgynther@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 4:21 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 17 Apr 2019 15:53:28 -0700 Tri Vo <trong@android.com> wrote:
>
> > LLVM uses profiling data that's deliberately similar to GCC, but has a very
> > different way of exporting that data.  LLVM calls llvm_gcov_init() once per
> > module, and provides a couple of callbacks that we can use to ask for more
> > data.
> >
> > We care about the "writeout" callback, which in turn calls back into
> > compiler-rt/this module to dump all the gathered coverage data to disk:
> >
> >    llvm_gcda_start_file()
> >      llvm_gcda_emit_function()
> >      llvm_gcda_emit_arcs()
> >      llvm_gcda_emit_function()
> >      llvm_gcda_emit_arcs()
> >      [... repeats for each function ...]
> >    llvm_gcda_summary_info()
> >    llvm_gcda_end_file()
> >
> > This design is much more stateless and unstructured than gcc's, and is
> > intended to run at process exit.  This forces us to keep some local state
> > about which module we're dealing with at the moment.  On the other hand, it
> > also means we don't depend as much on how LLVM represents profiling data
> > internally.
> >
> > See LLVM's lib/Transforms/Instrumentation/GCOVProfiling.cpp for more
> > details on how this works, particularly GCOVProfiler::emitProfileArcs(),
> > GCOVProfiler::insertCounterWriteout(), and GCOVProfiler::insertFlush().
>
> checkpatch speaketh truth.
>
> Also, I'll change those Co-authored-by's to the documented Co-developed-by.
>
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: gcov-clang-support-checkpatch-fixes
>
> WARNING: Non-standard signature: Co-authored-by:
> #31:
> Co-authored-by: Nick Desaulniers <ndesaulniers@google.com>
>
> WARNING: Non-standard signature: Co-authored-by:
> #32:
> Co-authored-by: Tri Vo <trong@android.com>
>
> WARNING: Possible unnecessary 'out of memory' message
> #158: FILE: kernel/gcov/clang.c:90:
> +       if (!info) {
> +               pr_warn_ratelimited("failed to allocate gcov info\n");
>
> WARNING: Possible unnecessary 'out of memory' message
> #193: FILE: kernel/gcov/clang.c:125:
> +       if (!info) {
> +               pr_warn_ratelimited("failed to allocate gcov function info for %s\n",
>
> WARNING: line over 80 characters
> #546: FILE: kernel/gcov/clang.c:478:
> +                       pos += store_gcov_u32(buffer, pos, fi_ptr->cfg_checksum);
>
> total: 0 errors, 5 warnings, 663 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> ./patches/gcov-clang-support.patch has style problems, please review.
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> Please run checkpatch prior to sending patches

Thanks! I'll keep that in mind.
