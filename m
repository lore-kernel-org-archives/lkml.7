Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F491C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6F992087C
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 16:09:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g4o9eUlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389465AbfHBQJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 12:09:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39412 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfHBQJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 12:09:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id b7so33862269pls.6
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 09:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vIcQA2KA1u1cJzPna8nM9BSUnuzFAzAZtGdtd+N8hs0=;
        b=g4o9eUlqyL0gwki7sXdFt6IvjZR0q6OtGR+upFq7aVv72eKM6R2OrUg0QjsX38NiY3
         evHtDhmwET/2VhSa9MwC93J6kW+RFULYUWMg5rIgX6ROfRRwHrlYBTFIFz6n2f6YAQTZ
         6MXVyzuc3YEWtsKaHdVnnOGAptV3yAX9C/ilc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vIcQA2KA1u1cJzPna8nM9BSUnuzFAzAZtGdtd+N8hs0=;
        b=OYN4doUSAXGkPNEprxI9P0urE7ctZ3O032Zpy/OHPnN2BB7O2pfHZnfLJg2U2tu9DW
         BRtiWsw+pkB1gjFJQ47y8UFtLPMdp7dk3Ezwoklx4DqGIoAVK+VUOfFuEPkp04jgtyZb
         F+H64x1AF81B1mrSVZz6KEIKjbQH9yLAm5lFF5a5tN2YPWSR0XlPz5zKbajLeQw/WxY4
         AiG4qdWZ8+QPuMCId0XkeXIELcUvNnakVLZoXCGlTR37O5zp1C4w86IU0W4gisI2TmZM
         pZy2/JkIFl6P21fPNHDdYMy+ufxusegFOZ/mu/9I5oVNH9LOiktlPgZurEUoR3m+bXf1
         FlrA==
X-Gm-Message-State: APjAAAVmHf8Ek3lS6WS10Jer/CYQwrcsT5RlnAmK9ZVhkuEGzZBeuW6b
        laB3LSCcxIa66wqUmYNQAA+bcw==
X-Google-Smtp-Source: APXvYqy8uiREkCLirNdJkob3wNATvXUMFhZyqSAyZ/FMLG7Sp71cjltngrB6lS31sQ0QKjHhg8f9eQ==
X-Received: by 2002:a17:902:704a:: with SMTP id h10mr128810027plt.337.1564762161303;
        Fri, 02 Aug 2019 09:09:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f7sm74037399pfd.43.2019.08.02.09.09.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Aug 2019 09:09:20 -0700 (PDT)
Date:   Fri, 2 Aug 2019 09:09:19 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Neil Horman <nhorman@tuxdriver.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Perches <joe@perches.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Shawn Landden <shawn@git.icu>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] compiler_attributes.h: Add 'fallthrough' pseudo
 keyword for switch/case use
Message-ID: <201908020907.4E056142@keescook>
References: <765E740C-4259-4835-A58D-432006628BAC@zytor.com>
 <20190731184832.GZ31381@hirez.programming.kicks-ass.net>
 <F1AB2846-CA91-41ED-B8E7-3799895DCF06@zytor.com>
 <CANiq72=s1nu9=R9ypFwL+J4NGT_yUkwahpgOOOXzezvNfDrx5g@mail.gmail.com>
 <F2529DE6-B500-44DC-AE72-45A304AD719B@zytor.com>
 <20190801122429.GY31398@hirez.programming.kicks-ass.net>
 <0BCDEED9-0B72-4412-909F-76C20D54983E@zytor.com>
 <CANiq72kg+duBe_srpcco-P17=3OC2c1ys=rGMVY8Z9FxZ69sdw@mail.gmail.com>
 <20190802110042.GA6957@hmswarspite.think-freely.org>
 <20190802123418.GA3722@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802123418.GA3722@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 02:34:18PM +0200, Pavel Machek wrote:
> I like the "fallthrough". It looks like "return" and it should, no
> need to have __'s there..

Yeah, it would have the same feel as "break", "continue", "return"...

The only place I see this already used is in net/sctp/sm_make_chunk.c,
as a label, which would be trivial to adjust...

-- 
Kees Cook
