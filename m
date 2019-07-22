Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09354C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D68A12190D
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 19:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Xb5UwnBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfGVTZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 15:25:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40560 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727363AbfGVTZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 15:25:20 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so76455807iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 12:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rf8ryiSI7gM7VW/mCBLHJLZdnlhJlIXGezmFbO+mcVw=;
        b=Xb5UwnBHkO/b7wAi1N5yXMS813VTh/5G24EzGuW5yJgQJgkjhUeKrTPSDkIp1KfUd6
         Iv3pWmtQA4mpIFFovuwl6FoaHQR+QSADg5v7gsjVpmHM4SI31heH50S/PkRTLaYA9lce
         +01E1ByorK9WOcBiaZz1FUtb3mjsV1xoqE6F7D9Yu4CWdB1e4XcdnZ0wBUR1TvQCcGr3
         ckF18v2qRvhL6FFsnkyEXeWtWu9RH4YwxumHUnoMed1uigXSdgTxN3sMKYU/ijspqfyX
         VfcYR7l9OaMGtYoRIf9WRepYgUU+N0FLHXUuyZvPMCKyhk68ZrFYinGWON2Tbg1EenkL
         KhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rf8ryiSI7gM7VW/mCBLHJLZdnlhJlIXGezmFbO+mcVw=;
        b=WBZn5kLr6M1brqlBTfAyG3vY3ZFIt5eFNF4q25UxRW+2jAIywEGl2EnRmFcUmB8QpZ
         oo0pjur0HBlqKAnWTaS+Uq8acSYD9595FKBtSQJCY2eb5VhHw/QECmafVGcz+7XBEOls
         tq1JQvDWbKpbCbgidYnXDgXo19NDo2OSFnu0aVvJJHnWGO44SrjRvvZNxpmDrrOunr/c
         g5KultyyEdgiEul8IMVaA6rETbhDUfmpIN0ZAt45ZFvZ1FG79fcC1xqmQMQ6NMLcoCTJ
         arV9A81bQY5z+dxsEKOxd4CUXIxoYaUoANFzDIG4xxF1QC3x/kqPHk3zzBXcgClU1PXF
         R1aw==
X-Gm-Message-State: APjAAAWguTL7osUzgGft7VA3yIc6ue7OCbsn1w/aVzkU+GnnXh9TjAsC
        dDjtYwAD/O/Q5JZwq/P0ukMe5G00ZoI=
X-Google-Smtp-Source: APXvYqwYUcpO+JDt/loIDZQbYbOA1X6JHoiG+W3zU6bs1mBiztsz8Q1eqm+2GIS51glKmkkHqpFvIQ==
X-Received: by 2002:a02:cd83:: with SMTP id l3mr39191324jap.66.1563823519409;
        Mon, 22 Jul 2019 12:25:19 -0700 (PDT)
Received: from localhost (67-0-62-24.albq.qwest.net. [67.0.62.24])
        by smtp.gmail.com with ESMTPSA id n2sm41584533ioa.27.2019.07.22.12.25.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 12:25:18 -0700 (PDT)
Date:   Mon, 22 Jul 2019 12:25:17 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Atish Patra <atish.patra@wdc.com>
cc:     linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Otto Sabart <ottosabart@seberm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v8 0/7] Unify CPU topology across ARM & RISC-V 
In-Reply-To: <alpine.DEB.2.21.9999.1907121012050.2267@viisi.sifive.com>
Message-ID: <alpine.DEB.2.21.9999.1907221224170.23563@viisi.sifive.com>
References: <20190627195302.28300-1-atish.patra@wdc.com> <alpine.DEB.2.21.9999.1907121012050.2267@viisi.sifive.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Jul 2019, Paul Walmsley wrote:

> On Thu, 27 Jun 2019, Atish Patra wrote:
> 
> > The cpu-map DT entry in ARM can describe the CPU topology in much better
> > way compared to other existing approaches. RISC-V can easily adopt this
> > binding to represent its own CPU topology. Thus, both cpu-map DT
> > binding and topology parsing code can be moved to a common location so
> > that RISC-V or any other architecture can leverage that.
> > different config for the architectures that do not support them.
>
> Once v5.3-rc1 is released, let's plan to get these patches rebased and 
> reposted and into linux-next as soon as possible.

These CPU topology patches are now queued for v5.4-rc1.  They should enter 
linux-next shortly.


- Paul
