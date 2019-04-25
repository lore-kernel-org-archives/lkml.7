Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921F4C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4887A20644
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 12:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="so+gKuUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfDYMqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 08:46:10 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:39834 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbfDYMqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 08:46:10 -0400
Received: by mail-lf1-f65.google.com with SMTP id d12so17408790lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpwgTt2BmSUg0ivYIfToBDS6B13YYAHn04kCE0XlNQA=;
        b=so+gKuURCeQFiWsv96S/x774uD3lKU56jKAnTb1iCRpqbFu/RQF2DjTQXdnbDAadmD
         iNopgteleUV6c/+3PQS5Pgf2TYgr63CQOpZwqTSuyRy0BMbzmj4sDHq5+zSV6hPUkG0M
         vtgMicXFjpj/AnZRWi5qG8b9pcZ17I3C+5JEFO2DpWkZ6nY7H5mFtV5JTP1w3mvhBrnf
         Y4BAkLbvUfUv3wTyZEl9fqwpTAW82V6YYapHUA30/3r9DalHVU9hMtjmemX7VY2NKBFI
         ilfNFVfdELUn2OrLNOCkdm/nsbbI+ZJrRRD0TmHZbhTNLqWFvn7bg3TbCex3EoUdRICp
         sKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpwgTt2BmSUg0ivYIfToBDS6B13YYAHn04kCE0XlNQA=;
        b=hKVVJ7aWtuWLqrO/7Rw+I30QUeiaKe4mqAt6S4Y3Ju4VBCRF8Uy8HwzdzP1/fpXbYb
         UEPfpQ7uZhmhCaChYdWct0CqLEwLrKPXLL7TxMSLVU/w/Zcjfo3KjNtumTeBF+1cDWJS
         GuCkUj/WrUvsG4QIL7R8qZUKrPsSpjyL4bPIDVpgbiF5F4Jvp99T5D74joUcCZ2tmCnL
         z+Hws1ACzGk8cQ/+hdO2tOg26iDwX3pzk3pGReD4WMZ6M7Rll9hkaBVB20iKT3tnn/QY
         UFt/LDNFKNiFr2oknLOh7OFhs0lSsvnTphS9UdtJfxn/C9ZypipzYB0isumdB06zxnrG
         O0KA==
X-Gm-Message-State: APjAAAWAjmp2ULUBBmuVmg7GWDrhzMD9jeHQX7lW+Sv48F59lkBcU2ZC
        shH/DtoxlpVxXrnTg35Zb23Ub3AkC0gbBmXdv7W2Zw==
X-Google-Smtp-Source: APXvYqzuoTf0P/U0e24cJr3dXU/imd2gKWcOCSY1H7Z89G6XPiWaw1RBBLSb+fT1GBwRyiIGJoFVaQtwG4ArvAZ4tVI=
X-Received: by 2002:a19:7005:: with SMTP id h5mr20392409lfc.143.1556196368332;
 Thu, 25 Apr 2019 05:46:08 -0700 (PDT)
MIME-Version: 1.0
References: <1555443521-579-1-git-send-email-thara.gopinath@linaro.org>
 <1555443521-579-2-git-send-email-thara.gopinath@linaro.org> <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
In-Reply-To: <20190425105658.q45cmfogrt6wwtih@queper01-ThinkPad-T460s>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 25 Apr 2019 14:45:57 +0200
Message-ID: <CAKfTPtBvY3xiDt6tcqF7GoZki3VihD4Tz7E5ctE8hNaNzL6NPA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] Calculate Thermal Pressure
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Apr 2019 at 12:57, Quentin Perret <quentin.perret@arm.com> wrote:
>
> On Tuesday 16 Apr 2019 at 15:38:39 (-0400), Thara Gopinath wrote:
> > +/* Per cpu structure to keep track of Thermal Pressure */
> > +struct thermal_pressure {
> > +     unsigned long scale; /* scale reflecting average cpu max capacity*/
> > +     unsigned long acc_scale; /* Accumulated scale for this time window */
> > +     unsigned long old_scale; /* Scale value for the previous window */
> > +     unsigned long raw_scale; /* Raw max capacity */
> > +     unsigned long age_stamp; /* Last time old_scale was updated */
> > +     unsigned long last_update; /* Last time acc_scale was updated */
> > +     spinlock_t lock; /* Lock for protecting from simultaneous access*/
> > +     /* Timer for periodic update of thermal pressure */
> > +     struct timer_list timer;
>
> Do you actually need the periodic update ? You only really need to
> update the 'scale' value when updating the LB stats no ? Nobody
> accesses that value in between two LBs.

Do you mean calling a variant of sched_update_thermal_pressure() in
update_cpu_capacity() instead of periodic update ?
Yes , that should be enough

>
> Thanks,
> Quentin
