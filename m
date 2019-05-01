Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F19DC43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47F9221734
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 05:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jk3uZai7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbfEAE5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 00:57:53 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:38874 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfEAE5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 00:57:53 -0400
Received: by mail-vs1-f65.google.com with SMTP id v141so2549684vsc.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 21:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:sender:from:date:message-id
         :subject:to:cc;
        bh=P35e7lRyscrNykmykjGORtzoqMJ17nJ+ZLBUjZaf8W8=;
        b=jk3uZai79rictqwRVoY5gVykyQX0rWp6GdiDrCKWKzfZ4vsvSxpOEhFSoxnRtgJDeU
         q5Opb8dbwtHsOX53YvBfMezNSGEQ8MqWkffC4vtjqTAhKh+nHxjrn/xZn+yydAKDkEw6
         Z1J9ctz4jOk0r6sDeSQZLs8PLgc44OyDzKxpmCnWI2ADv1+madbSWR9yp4THp9lQcF+Z
         eNte0ic17ursuxPZekHtbHpl88XHHwzCYFsq/q66mrEKR+w6V6K/05AFdpCvSLNW4Gel
         zRe9VzOz52AUx/XwQLJvDHJkczICRgSunDQtDqa9ib2s9I+77V+fdUMMXTzEJrXO5oS8
         /eCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:sender:from
         :date:message-id:subject:to:cc;
        bh=P35e7lRyscrNykmykjGORtzoqMJ17nJ+ZLBUjZaf8W8=;
        b=SJqBdrGc4m4X2djORuwfUgHq1xlaRUXFSNahliQ1EzvxXtfOg1AQbSZGHHVYNHyJBk
         u6cw83NIVztdGR03IDJc9QJ2VI82NBFpA2CZC456esYK2wG6AqHzdyCRSwhd8m/HojZ1
         dDJlhue4LBohNg86h9fzo6DX1d/SBKCvqH/DHvUxIr+bRWK6gEhzl3mJqzq/tcjohoxR
         b9i2HgGkdNwSoUpEf425WWO1CytbEKFkXbJCiFlQv5nooN+g22ROiZdNZXXDh/wxe2AH
         DSn3YSvwgVQbMrB/5FMHWf9mHjN5oa8eHbpVb+BU8MwhDuVKjcHVGHhV8quoXlh5dDYg
         Dqew==
X-Gm-Message-State: APjAAAWKm9OIe1o8iSzCWKLaURJZNNmLX4ipCVjciF4EG0K7JWn+goEb
        VG6ZjAXV+bkRdejsH/yF2l2zieGZ1WdBjJHqmm8=
X-Google-Smtp-Source: APXvYqzEnB4DoeQEjRUTP7Rrb9UtV8lh5NMof5rUud2cq+tj+Q8YHXzKJgoWfF0WXAVfSYHdvgCImZvT9GBs+RmBqoM=
X-Received: by 2002:a05:6102:119:: with SMTP id z25mr9470996vsq.145.1556686672284;
 Tue, 30 Apr 2019 21:57:52 -0700 (PDT)
MIME-Version: 1.0
References: <1556620535-10060-1-git-send-email-arunks@codeaurora.org> <20190430110624.GB16204@fuggles.cambridge.arm.com>
In-Reply-To: <20190430110624.GB16204@fuggles.cambridge.arm.com>
X-Google-Sender-Delegation: getarunks@gmail.com
From:   Arun KS <arunks.linux@gmail.com>
Date:   Wed, 1 May 2019 10:27:41 +0530
X-Google-Sender-Auth: p5VwC2BvVDMs0Em29d4QJN7nPsQ
Message-ID: <CAKZGPAOprkJfBXeMqx+ipVh4xqMUCbZdoS=mjBzLO9=LQniU9A@mail.gmail.com>
Subject: Re: arm64: Fix size of __early_cpu_boot_status
To:     Will Deacon <will.deacon@arm.com>
Cc:     Arun KS <arunks@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 30, 2019 at 4:39 PM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Apr 30, 2019 at 04:05:04PM +0530, Arun KS wrote:
> > __early_cpu_boot_status is of type long. Use quad
> > assembler directive to allocate proper size.
> >
> > Signed-off-by: Arun KS <arunks@codeaurora.org>
> > ---
> >  arch/arm64/kernel/head.S | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
> > index eecf792..115f332 100644
> > --- a/arch/arm64/kernel/head.S
> > +++ b/arch/arm64/kernel/head.S
> > @@ -684,7 +684,7 @@ ENTRY(__boot_cpu_mode)
> >   * with MMU turned off.
> >   */
> >  ENTRY(__early_cpu_boot_status)
> > -     .long   0
> > +     .quad   0
>
> Yikes. How did you spot this? Did we end up corrupting an adjacent variable,
> or does the alignment in the linker script save us in practice?

Rite now there is no adjacent variable. But I was adding one and it
was getting corrupted.

Regards,
Arun
>
> Will
