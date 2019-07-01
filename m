Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A95C5B578
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B52B5206A3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 04:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YVFFkZJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfGAEeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 00:34:03 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39505 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfGAEeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 00:34:03 -0400
Received: by mail-qt1-f194.google.com with SMTP id i34so13257169qta.6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 21:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j4LijnemKoLKQMl/B23h/AFjsTibtIxnLw1/ziD/okk=;
        b=YVFFkZJj/CNI+ghOb+Ya0Nzz514913rZbQ1YwSPyXWJG0iedMSqToFMHZSnvnPuPT0
         O8cxNkk5ThpOsJF6gBM/kMDq+25cqP4doJFO4stISlZcxnEC15ROlJ6RTv+tUb36RMUP
         oJiNOHbUBSYf7k9M2h1kSEXdcBrPmOJGKebzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j4LijnemKoLKQMl/B23h/AFjsTibtIxnLw1/ziD/okk=;
        b=gN2IW6dPviHTo72TR5D4JuCBigjs+A0pFP9pA1tryHvr8TSpssn3Ym9GdAKBofh1sh
         ZDkadzM8TQrOMGZCWcU/XKRml33i0xZ03RS79R14SLOYUHCS20xHpGGb9OT+DZEIZ4bZ
         IJkSTebcsOdJIgF3WCRpVxDJARi/TOnFl512Uy9r1tLU2I5x1xF4KpLs1vYRyn55kiac
         4mBXkgrb2H4V3Zxa9tg4DvfrEPWirsx3i8CnGS/D5GMp6sJuKM7nOS9t2e8gk1ba7znK
         a+r5oF0VtOI+lTHJ9YWpvsAJ893RfLijG7HPcr1Gi++nd4iw3puaxoBChg1//okTf85p
         Uo+Q==
X-Gm-Message-State: APjAAAU+0fFjedUPs+yzWQ3FQyo/TSHphXNoI8MszSeA0ja6MGsxiAu8
        1vdUEPPRwjmPNlghLSKWD1IEGXVu6FIFOZL1UlV0PA==
X-Google-Smtp-Source: APXvYqxyxJ+qsb/SSss0UK1hGoxcUxWom7jpMAM+lCcXcmwPccZYE52XG+D0cY4RU1de6kdV4cOwi/jxIN29tjlaZDo=
X-Received: by 2002:ac8:4601:: with SMTP id p1mr18877187qtn.181.1561955642169;
 Sun, 30 Jun 2019 21:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190612043258.166048-1-hsinyi@chromium.org> <20190612043258.166048-4-hsinyi@chromium.org>
 <20190628094251.GC36437@lakrids.cambridge.arm.com> <CAJMQK-iRKkOS9q-qGVj-3o6BVMeANrBoF_4MWQ1g-=4_6HRdbw@mail.gmail.com>
In-Reply-To: <CAJMQK-iRKkOS9q-qGVj-3o6BVMeANrBoF_4MWQ1g-=4_6HRdbw@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 1 Jul 2019 12:33:36 +0800
Message-ID: <CAJMQK-g66_G3M9j1b2fBiMQrr5H7w4WQ5ZVy+aDdsmjb4A1==Q@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: kexec_file: add rng-seed support
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        James Morse <james.morse@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 7:47 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:

> >
> > If the RNG wasn't initialised, we'd carry on with a warning. Why do we
> > follow a different policy here?
> >
(Sorry, please ignore previous comment)
I think this part should be same as kaslr, since they are both adding
random seeds:
If RNG isn't initialized, we won't be able to set these seeds, and dtb
can't do anything else to deal with this, so carry on with warning.
If fdt_setprop failed with no space, create_dtb() will try to setup
dtb again with more space.
Other failures are setting fdt's error, so returns invalid.
