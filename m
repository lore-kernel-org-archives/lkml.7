Return-Path: <SRS0=tewG=XJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A523C4CEC9
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA1E214AE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Sep 2019 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbfINTvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Sep 2019 15:51:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41648 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbfINTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Sep 2019 15:51:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id m9so14763627pls.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2019 12:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8/82Z+AFS9yEFav5otNjqZZTLkl6BS+MrGSlNauY50Q=;
        b=TnQukNEL6N8lgVIPqp4CJ4OcYQKejchIukyLEvyW3n7bqGqElPvDneJEVEKTu/paXe
         VFGnsNDZJ6kItyFVeumu3qt08PB+eILYNrMqiuxh8qNv2itZ1K3d4n7JAcEp7PRoEOtj
         yEwtUlNwVYPByCsyzqMLON1zHJolkp6DjKBLiSHxEIoerX/RtfkGVyeu6sTyYOUcgQ2U
         UYyshXl8+G51H6KiFhT4UCcGJkw/Xtst50k8tKY1ZjuioABr5mCfw7m/zmUV24CPBJIu
         uUMb+OlDyzycppl19XHSRyLkvr9cE5vT4i2TsAAhajR/elN3gKh2dGDNsEO63ISkFXGu
         gxyA==
X-Gm-Message-State: APjAAAVed9kDuHTWHrmngUY561qH9FOy0yAmhdIqtFhkW/jU1TV8cujc
        Wf6xhGSIp0xzksBkOPcdsvnWNA==
X-Google-Smtp-Source: APXvYqzPfbGU/elPJNGLdG9lRafcl5cXs4aUV0O4ip7XPxqZ5vaxWQW3kJO4utMNMCW3NW6nzo170A==
X-Received: by 2002:a17:902:4a:: with SMTP id 68mr50794588pla.196.1568490683065;
        Sat, 14 Sep 2019 12:51:23 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id x13sm34425177pfm.157.2019.09.14.12.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Sep 2019 12:51:22 -0700 (PDT)
Date:   Sat, 14 Sep 2019 12:51:22 -0700 (PDT)
X-Google-Original-Date: Sat, 14 Sep 2019 12:50:08 PDT (-0700)
Subject:     Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
In-Reply-To: <CAMabmMJ=QcH-529O6ORWbFwOrAnMKeWTvQ=WGYgnOoihqj9uFA@mail.gmail.com>
CC:     Darius Rad <darius@bluespec.com>, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     charles.papon.90@gmail.com
Message-ID: <mhng-a57ed8d7-08c6-4bd6-83c1-19925746ba6e@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Sep 2019 12:42:32 PDT (-0700), charles.papon.90@gmail.com wrote:
> I had issues with that plic driver. The current implementation wasn't
> usable with driver using level sensitive interrupt together with the
> IRQF_ONESHOT flag.
>
> Those null were producing crashes in the chained_irq_enter function.
> Filling them with dummy function fixed the issue.

I'm not arguing it fixes a crash, the code Darius pointed to obviously doesn't 
check for NULL before calling these functions and will therefor crash.  There 
is a bunch of other code that does check, though, so I guess my question is 
really: is the bug in the PLIC driver, or in this header?

If we're not allowed to have these as NULL and there's nothing to do, then this 
is a reasonable patch.  I'm just not capable of answering that question, as I'm 
not an irqchip maintainer :)

> On Sat, Sep 14, 2019 at 9:00 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Thu, 12 Sep 2019 14:40:34 PDT (-0700), Darius Rad wrote:
>> > As per the existing comment, irq_mask and irq_unmask do not need
>> > to do anything for the PLIC.  However, the functions must exist
>> > (the pointers cannot be NULL) as they are not optional, based on
>> > the documentation (Documentation/core-api/genericirq.rst) as well
>> > as existing usage (e.g., include/linux/irqchip/chained_irq.h).
>> >
>> > Signed-off-by: Darius Rad <darius@bluespec.com>
>> > ---
>> >  drivers/irqchip/irq-sifive-plic.c | 13 +++++++++----
>> >  1 file changed, 9 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
>> > index cf755964f2f8..52d5169f924f 100644
>> > --- a/drivers/irqchip/irq-sifive-plic.c
>> > +++ b/drivers/irqchip/irq-sifive-plic.c
>> > @@ -111,6 +111,13 @@ static void plic_irq_disable(struct irq_data *d)
>> >       plic_irq_toggle(cpu_possible_mask, d->hwirq, 0);
>> >  }
>> >
>> > +/*
>> > + * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>> > + * by reading claim and "unmasked" when writing it back.
>> > + */
>> > +static void plic_irq_mask(struct irq_data *d) { }
>> > +static void plic_irq_unmask(struct irq_data *d) { }
>> > +
>> >  #ifdef CONFIG_SMP
>> >  static int plic_set_affinity(struct irq_data *d,
>> >                            const struct cpumask *mask_val, bool force)
>> > @@ -138,12 +145,10 @@ static int plic_set_affinity(struct irq_data *d,
>> >
>> >  static struct irq_chip plic_chip = {
>> >       .name           = "SiFive PLIC",
>> > -     /*
>> > -      * There is no need to mask/unmask PLIC interrupts.  They are "masked"
>> > -      * by reading claim and "unmasked" when writing it back.
>> > -      */
>> >       .irq_enable     = plic_irq_enable,
>> >       .irq_disable    = plic_irq_disable,
>> > +     .irq_mask       = plic_irq_mask,
>> > +     .irq_unmask     = plic_irq_unmask,
>> >  #ifdef CONFIG_SMP
>> >       .irq_set_affinity = plic_set_affinity,
>> >  #endif
>>
>> I can't find any other drivers in irqchip with empty irq_mask/irq_unmask.  I'm
>> not well versed in irqchip stuff, so I'll leave it up to the irqchip
>> maintainers to comment on if this is the right way to do this.  Either way, I'm
>> assuming it'll go in through some the irqchip tree so
>>
>> Acked-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> just to make sure I don't get in the way if it is the right way to do it :).
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
