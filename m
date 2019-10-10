Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 714CBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503ED20659
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 17:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VWVqLMSh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbfJJRo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 13:44:27 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46020 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbfJJRo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 13:44:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id 41so5609952oti.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKe45SUxB6hYFAJK4Hzzx9HwPC758qhlQpHJI3tZEIo=;
        b=VWVqLMShkk5AFXL8NAEgE0bqeZexDXkca5zP9VsCIHpGJGP655Ahj59j6PofdbF8yy
         zkXGLQUiQVY2NUUON+mXcdZoaZ16AEqOJUqMfJGAQSARITAkutR4PupxVfwgjhvHFnbd
         oWv1EFdvgCKVUXqmDGsUwNcxvGMa/a/TZNyHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKe45SUxB6hYFAJK4Hzzx9HwPC758qhlQpHJI3tZEIo=;
        b=deLbrWRSTU8kD6I1O/VcgBuFWgplLv8ecxlJ4xQ5GXGwPoGvVqcphiPFt212ckSVCH
         GnNJ/EWYDC+G9NIOnf9NSQfxkEXcqahNZ4lDDVUBeG0DLTgKls9mb+xS3wqeDmBc8UKP
         1lrg580u4GPxYDATvkDS0TqMETsZZ0kQW3PmovTiR60ZI/MBsus2c9xQfo6v9fOS6FfF
         kvHLuV7FefbHurmNN9pkQwGY0jLD7QXTCNRsCJnqUunf2QRwa7k83wTO8VokxQBxiPPU
         1rUNPr51+t2drn6cIwjgvBPxFwitnYXQvstEofu7wa1r8OaEJj75cTHhd2ekMlnLnc98
         oPwQ==
X-Gm-Message-State: APjAAAVe/bQUzGYY3XF/G/9VD1J0ehYd5jWPjp4nFtyKg9QaubRfQkEy
        i8vIaU5h4J19NgWoO7gCHSOQtc5+Jpk=
X-Google-Smtp-Source: APXvYqwND1BhH1EMwdNhOdEYmm+TET3s5M06sDj8vQS0u9L+w0Lt005WivL4VYWCABXeV5gPRwzK+w==
X-Received: by 2002:a05:6830:11d1:: with SMTP id v17mr2296568otq.41.1570729465949;
        Thu, 10 Oct 2019 10:44:25 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id w13sm1786284oih.54.2019.10.10.10.44.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2019 10:44:25 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id c6so15517019ioo.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 10:44:25 -0700 (PDT)
X-Received: by 2002:a5d:8991:: with SMTP id m17mr12301165iol.52.1570729464667;
 Thu, 10 Oct 2019 10:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190906060115.9460-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20190906060115.9460-1-mark-pk.tsai@mediatek.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 10 Oct 2019 10:44:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vxdnecw2SnUeFpa8Rqq0DSTTeoD_bE1GXk4q37usZ9-w@mail.gmail.com>
Message-ID: <CAD=FV=Vxdnecw2SnUeFpa8Rqq0DSTTeoD_bE1GXk4q37usZ9-w@mail.gmail.com>
Subject: Re: [PATCH] perf/hw_breakpoint: Fix arch_hw_breakpoint use-before-initialization
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        jolsa@redhat.com, namhyung@kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alix Wu <alix.wu@mediatek.com>,
        YJ Chiang <yj.chiang@mediatek.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 5, 2019 at 11:01 PM Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
>
> If we disable the compiler's auto-initialization feature
> (-fplugin-arg-structleak_plugin-byref or -ftrivial-auto-var-init=pattern)
> is disabled, arch_hw_breakpoint may be used before initialization after
> the change 9a4903dde2c86.
> (perf/hw_breakpoint: Split attribute parse and commit)
>
> On our arm platform, the struct step_ctrl in arch_hw_breakpoint, which
> used to be zero-initialized by kzalloc, may be used in
> arch_install_hw_breakpoint without initialization.
>
> Signed-off-by: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Cc: YJ Chiang <yj.chiang@mediatek.com>
> Cc: Alix Wu <alix.wu@mediatek.com>
> ---
>  kernel/events/hw_breakpoint.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Stable should pick this up, please.  It landed in mainline as commit
310aa0a25b33 ("perf/hw_breakpoint: Fix arch_hw_breakpoint
use-before-initialization").

* I have confirmed that it cleanly applies to and fixes a kernel based
on v4.19.75, so picking it back to kernels 4.19+ is the easiest.

* I have confirmed that my test shows that hardware breakpoints fail
on my arm32 test machine on v4.18.20 and on v4.17.0.  They last worked
on 4.16.  Picking this patch alone is not sufficient to make 4.17 and
4.18 work again.  Bisecting shows that the first breakage was the
merge resolution that happened in commit 2d074918fb15 ("Merge branch
'perf/urgent' into perf/core").  Specifically both parents of that
merge passed my test but the result of the merge didn't pass my test.
If anyone cares about 4.17 and 4.18 at this point, I will leave it as
an exercise to them to try to get them working again.

-Doug
