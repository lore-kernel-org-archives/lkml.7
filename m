Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E3FC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BEB2183F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 12:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnQR4gKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBMlI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 08:41:08 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33219 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbfGBMlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 08:41:07 -0400
Received: by mail-ot1-f66.google.com with SMTP id q20so16990410otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 05:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q3d2uVGgar8aJnCM9NISkpoH5GB88E6BUU5dyE7CfSc=;
        b=AnQR4gKjvlfra9r4U22xdnqBWCLqaeDfbfO3DFnC7u3cR4dvI/9H/GaN7PtzVcMIb0
         D4gsPvhEdywks5rm09wnaqvmAgSYdbp4knPKvNT7UNFelLG4XtpqJpA4Nkc7545MoH73
         TUEbHvvEWX+Ce86nVv7wiz8LfiwNJNsHeypGVwV2n+GjrRBxZyMHsbxDWhhd7EdYb85p
         dB0omSFR735q1Oi76Wgca+SCbg/pdl5+ScxAkTT2s1miusemD1OHaz4+OmqIQ2l7Z0N1
         cHAlCt8ZsenLAGNMTqDMAi+ukLtCB/if8F2dKm2st0W+wbjtjtgMCNi9CR3uNZFRoUku
         OAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q3d2uVGgar8aJnCM9NISkpoH5GB88E6BUU5dyE7CfSc=;
        b=l3BrvrVY63+wHmAyA48eN7eBCrcY10HjpbXvBn9TKFaiQ0fSeQPF8MG6mCJF801s1N
         PpLuIt9XZQBjyjz+aplvjFQyS2UYRxeb83ksT9neON2wCdH2Pa440NwRMaINOSWguWcO
         pvkHFlhx6zEJgorch6WZW7xflQofyJldbY/nYPeRg21fwQcM9Z7pqN2oeo970imcE2Fx
         +n+XOq3mPTXW3lDIpXCyGgyAapNIChC92GrW57aAVItHmRz5dmSx/RpHPLZwW8fBMTiW
         gyBkA8t3+gfey5TE+rF61v3uJpDNcPuLc+Ge2oGk2ZYq1Y4LegYAQgSKBEQAwYC0Q595
         6NOg==
X-Gm-Message-State: APjAAAV7Gu47N00zdutmx9iAIc6PBRI3FGPzNqczif2yaLT85XUZOzDV
        IZVPi3bN+6h15ZB6svBUE9/34Z0f1Z1g1IEc+Fc=
X-Google-Smtp-Source: APXvYqztUsddo/7fSNKF3gmOLDRP3q+d0mchRHkkjLx3+Zn8quzFaqWzYCR8YsRlIq4fsNiyKsybv6H9499E8yiRee8=
X-Received: by 2002:a9d:67cf:: with SMTP id c15mr22927046otn.326.1562071266955;
 Tue, 02 Jul 2019 05:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190630075650.8516-1-lpf.vector@gmail.com> <20190630075650.8516-4-lpf.vector@gmail.com>
 <20190702122321.GC1729@bombadil.infradead.org>
In-Reply-To: <20190702122321.GC1729@bombadil.infradead.org>
From:   oddtux <lpf.vector@gmail.com>
Date:   Tue, 2 Jul 2019 20:40:55 +0800
Message-ID: <CAD7_sbFQgkyTDfePp4FROdJc+UB3zqF8DiTosmi-JPUJsgBfWw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm/vmalloc.c: Rename function __find_vmap_area() for readability
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, peterz@infradead.org,
        Uladzislau Rezki <urezki@gmail.com>, rpenyaev@suse.de,
        mhocko@suse.com, guro@fb.com, aryabinin@virtuozzo.com,
        rppt@linux.ibm.com, mingo@kernel.org, rick.p.edgecombe@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 8:23 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Jun 30, 2019 at 03:56:48PM +0800, Pengfei Li wrote:
> > Rename function __find_vmap_area to __search_va_from_busy_tree to
> > indicate that it is searching in the *BUSY* tree.
>
> Wrong preposition; you search _in_ a tree, not _from_ a tree.

Thanks for your review, I will correct it in the next version.
