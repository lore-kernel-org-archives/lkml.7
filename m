Return-Path: <SRS0=GkzU=Y7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36707C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08B98206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Nov 2019 17:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSsGkd2z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbfKGRGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 12:06:54 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37396 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfKGRGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 12:06:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id p13so1915446pll.4;
        Thu, 07 Nov 2019 09:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zFenQO1uO033OtRYRFVT+RuzXPzATz6f1SyjAS7X/Jc=;
        b=VSsGkd2zRXqf4yGpuJWJoOLrDNdS0XCJmzix9IMI22/1qiHzi08puucdhcdYA7zMQX
         xZLzWEopV1llt2xUiHBGbtkILyLWfAxWXi4DzZqUYzDwgpKU0ByQ99HlmFH1xI6ePRxF
         L7ljyAyw+0q+9RB6muIeZAooXhdeBQ2PeyAfiFhoWS1aqegqRgqJB3OYN/5Aa5x71Xip
         IZklkXPoBT09zMgqXSo5Mr5cmZjKqbMLWtuun5IE8deiVUDt0YDbgRna4G9fjMk6C9Rb
         rZYMd+snfMOQEiBW16LuKgLbkq1i+3qutnjVevY3BdysTtpil3eZS7iiyrKaWl6eHcTh
         AbHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zFenQO1uO033OtRYRFVT+RuzXPzATz6f1SyjAS7X/Jc=;
        b=LisbYoj/LmUwJLNwfNAQRs1LGjOgcGPfqPsWkQA7nRufgdcRc5yYzkC1WmOhq1eHTM
         R10t04uJlQKy2G+aE18kHv85ZOGUR4arW7oRYiXNyFHgJneSz8KRkdluW6lWZV6K0Y2G
         WwoQUFDfGcHiW3cbrvq5S1JWRK7TiqQl4K6tTjz9xYKcyDs0hdDBAH0+pF4o8+CGaJNE
         jiW7JbMfDCq2Upq70nZ7S4/Ft1o/Y0jh9gTbZcHCd01L+9SACdH3wu9zbc/ACQsQ448T
         XHzpS3o06x24ji72EzPGtMfqKEJjhf4VycPydN0OS9btMAJHNlAHXVHlYJNkrSen0MQt
         Uyng==
X-Gm-Message-State: APjAAAU+2OT125X3tDFFNWvQJaXvRvHnsiiGtHRNcys6XFcHBE25L/4W
        y+uY1g5yURuXo7ZvkbdLjMBB6PAdt9ZsbQZkWGg=
X-Google-Smtp-Source: APXvYqw6fl5teTYOVb9yiqAIgldG8eE7YH++BStjhnp5fFwGzMFX/LjS71YQz/AY1msiDKKkujUjm+jLuoxBusynTfU=
X-Received: by 2002:a17:90a:d102:: with SMTP id l2mr6690436pju.132.1573146412872;
 Thu, 07 Nov 2019 09:06:52 -0800 (PST)
MIME-Version: 1.0
References: <c090302a-da38-5764-2a84-399ed6b333f5@siemens.com> <16119dad-9597-ecdc-a0e7-e386030659ce@siemens.com>
In-Reply-To: <16119dad-9597-ecdc-a0e7-e386030659ce@siemens.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Nov 2019 19:06:42 +0200
Message-ID: <CAHp75VfBS9tjDSaoN2AoBshyQR+x781Zyw61bVSKheNVtNi8rg@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: pmc_atom: Add Siemens SIMATIC IPC227E to
 critclk_systems DMI table
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Srikanth Krishnakar <Srikanth_Krishnakar@mentor.com>,
        Henning Schild <henning.schild@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 4, 2019 at 6:21 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 04.09.19 08:42, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > The SIMATIC IPC227E uses the PMC clock for on-board components and gets
> > stuck during boot if the clock is disabled. Therefore, add this device
> > to the critical systems list.
> >
> > Fixes: 648e921888ad ("clk: x86: Stop marking clocks as CLK_IS_CRITICAL")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > Changes in v2:
> >  - fixed cut-off subject line (local tooling bug...)
> >
> > Should go into stable as well, down to 4.19.
>
> This one is in 5.4-rc now (as ad0d315b4d4e). Is it also queued somewhere
> for stable kernels? IIRC, it's generally the privilege of the subsystem
> maintainer to propose formally to stable.

Anybody can resend for stable putting maintainer to Cc as long as the
original commit is in upstream.

Nevertheless, I just resend it.

> I've received reports from users down at 4.14 with the need for it (4.9
> is unaffected). And the same applies to f110d252ae79 ("platform/x86:
> pmc_atom: Add Siemens SIMATIC IPC277E to critclk_systems DMI table").


-- 
With Best Regards,
Andy Shevchenko
