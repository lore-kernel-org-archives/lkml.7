Return-Path: <SRS0=AA30=TT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2687FC04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8B220675
	for <linux-kernel@archiver.kernel.org>; Sun, 19 May 2019 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TXz8mklJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729682AbfESSYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 May 2019 14:24:25 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39991 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbfESSYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 May 2019 14:24:24 -0400
Received: by mail-it1-f193.google.com with SMTP id g71so19652071ita.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2019 11:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C+DlauQ+0YDeQ9hpa7miHNz0JB22ujJpGsz1lZ3FnHs=;
        b=TXz8mklJRncCXd+yICCPibA/REO9Zf9MWiDvZOVxPLwLS1YhAE+ayCpQmznYoF71K/
         MYJFnvpPM4q7hrnSknx4T68RGqbNoZtbPMS0l6kcdHdJETJMP1aq1tTAMBpA4AN0kHl1
         fK9zVEBgUgIVBxyfdPQFA3VGynvIBkWsu8F4564sQ1I6dt1Lpj1+scWFihYMjvRMrXaF
         OdPuC/qJN8T2WUN65sH+E/KaNxDAS+URqFc4jomKZ6/XaKTKJqawGQJa5S10wgzjMqyp
         BbOOgBfLsdQ4o+uW08z3j8K7CYA2iC4GShEtoaxV2VT1Ss7lFAHT/f61D5jXEp3iJNmf
         aoDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C+DlauQ+0YDeQ9hpa7miHNz0JB22ujJpGsz1lZ3FnHs=;
        b=KuwrQ6/rUifUJqz4pwi7349634/WgZ3Yy26PbCcG1c+pOvAqtM6Ti2JaEnFf80vxIO
         GhEK40ayp5pfXuzXeE3u8Z0LZwXiScpxuSKB8RqKD9FAW05JmZ9Y/z7xiwxvb63YsRyf
         ohbLRfirSuKst2RtFMlq00YX3Dcy8FwUicSVnFPaTa/L5+ZaIbSO+OzOhF7S6Bg3C8WD
         0O2G0QMESkGQUbMnT7qFZntpOf+x3RPVmDFHHBVKMRqR/XZCh4eKOTHB0WzFcODx2tGp
         i4iC5AtGsmcKiJOW6fqFvQ1uYjf9noyIEQyYcIh+1k3nEUoY7eGXdyNkFgS5Hti1vyr0
         NUGQ==
X-Gm-Message-State: APjAAAUDcqBjDDZgO/2l4erTEp1GSTfdpoqm8IrDMos2bgSLEIq/y7FU
        fF0zTkceC2LplFMRI7rjhGQVma7jmeA=
X-Google-Smtp-Source: APXvYqyZrAB83RtBUG5r/o9WgBzpueGHylDo9jY4WrgM39PWjf+vB72Itw8yjHyRRhKOfFaLM9jYwA==
X-Received: by 2002:a24:aa42:: with SMTP id y2mr11505586iti.23.1558290263973;
        Sun, 19 May 2019 11:24:23 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id 202sm1451053itw.2.2019.05.19.11.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 11:24:23 -0700 (PDT)
Date:   Sun, 19 May 2019 11:24:22 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Joe Perches <joe@perches.com>
cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] scripts/spelling.txt: drop "sepc" from the misspelling
 list
In-Reply-To: <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
Message-ID: <alpine.DEB.2.21.9999.1905191108180.10723@viisi.sifive.com>
References: <20190518210037.13674-1-paul.walmsley@sifive.com> <201b9ab622b8359225f3a3b673a05047ffce5744.camel@perches.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 May 2019, Joe Perches wrote:

> On Sat, 2019-05-18 at 14:00 -0700, Paul Walmsley wrote:
> > The RISC-V architecture has a register named the "Supervisor Exception
> > Program Counter", or "sepc".  This abbreviation triggers
> > checkpatch.pl's misspelling detector, resulting in noise in the
> > checkpatch output.  The risk that this noise could cause more useful
> > warnings to be missed seems to outweigh the harm of an occasional
> > misspelling of "spec".  Thus drop the "sepc" entry from the
> > misspelling list.
> 
> I would agree if you first fixed the existing sepc/spec
> and sepcific/specific typos.
> 
> arch/powerpc/kvm/book3s_xics.c:	 * a pending interrupt, this is a SW error and PAPR sepcifies
> arch/unicore32/include/mach/regs-gpio.h: * Sepcial Voltage Detect Reg GPIO_GPIR.
> drivers/scsi/lpfc/lpfc_init.c:		/* Stop any OneConnect device sepcific driver timers */
> drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c:* OverView:	Read "sepcific bits" from BB register
> drivers/net/wireless/realtek/rtlwifi/wifi.h:/* Ref: 802.11i sepc D10.0 7.3.2.25.1

Your agreement shouldn't be needed for the patch I sent.


- Paul
