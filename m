Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512FDCA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA0214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 15:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732199AbfJVPKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 11:10:03 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34068 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731453AbfJVPKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 11:10:02 -0400
Received: by mail-pg1-f195.google.com with SMTP id k20so10149117pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 08:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VpPZchWxBalhXenlomTdpWCrOTqc954uAKLWrxBCzwg=;
        b=A8VfciBbjlAUruZntO/G+9d/IcpIACqLMvhg0OGNs/nWsPgs9ycS3nE4e6nZKD8mtn
         BusSN8mY6DW39BT4XmCcCUYoXKv0Qu/mIQnx1dOG/z9eMJe60W5iHde1K3/Bhh0erikN
         g1Cxu178vACb0XmYeBjVaWeyh67Le4CqYmN6gfxJSSMy3ii2ff03R9unRxOm9s6VdODE
         JJIFFcVcNvUnyYD4eKfX58MsLAI/f+A1d7l6IBRDLmKaAFrLkpwzIkJGtCDAaXdmX6Z9
         kpIEnMNhL4oTaLQ3dX+bkzoXb2iRNNzbHQe2y2D6J1r1+FdzRBX2SCyvLSbd9LRSmQjS
         2Dag==
X-Gm-Message-State: APjAAAUjzAyOvmLCqUB74rFZH0wKp4lq9VhkyEUE51NBbtX30ZUWxLhz
        fJ9/0qRCQImr/KiAMrZf6/6Opw==
X-Google-Smtp-Source: APXvYqy/RH57lz78tmo+obFfGFFGPfZHogTmReh9YUV/QtsrPLBStlqA39MPr3GYs1lhDAYM+t/DZA==
X-Received: by 2002:a17:90a:a889:: with SMTP id h9mr5345232pjq.61.1571757000702;
        Tue, 22 Oct 2019 08:10:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id m102sm16867880pje.5.2019.10.22.08.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 08:09:59 -0700 (PDT)
Date:   Tue, 22 Oct 2019 08:09:59 -0700 (PDT)
X-Google-Original-Date: Tue, 22 Oct 2019 08:07:08 PDT (-0700)
Subject:     Re: [PATCH 4/8] riscv: ensure RISC-V C model definitions are passed to static analyzers
In-Reply-To: <alpine.DEB.2.21.9999.1910172138320.3026@viisi.sifive.com>
CC:     luc.vanoostenryck@gmail.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Message-ID: <mhng-8e06672c-a3e1-4dde-bbe9-ba1d8ab79645@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2019 21:39:29 PDT (-0700), Paul Walmsley wrote:
> On Fri, 18 Oct 2019, Luc Van Oostenryck wrote:
>
>> On Thu, Oct 17, 2019 at 05:49:25PM -0700, Paul Walmsley wrote:
>> > Static analysis tools such as sparse don't set the RISC-V C model
>> > preprocessor directives such as "__riscv_cmodel_medany", set by the C
>> > compilers.  This causes the static analyzers to evaluate different
>> > preprocessor paths than C compilers would.  Fix this by defining the
>> > appropriate C model macros in the static analyzer command lines.
>> >
>> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
>> > ---
>> >  arch/riscv/Makefile | 2 ++
>> >  1 file changed, 2 insertions(+)
>> >
>> > diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>> > index f5e914210245..0247a90bd4d8 100644
>> > --- a/arch/riscv/Makefile
>> > +++ b/arch/riscv/Makefile
>> > @@ -47,9 +47,11 @@ KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
>> >
>> >  ifeq ($(CONFIG_CMODEL_MEDLOW),y)
>> >  	KBUILD_CFLAGS += -mcmodel=medlow
>> > +	CHECKFLAGS += -D__riscv_cmodel_medlow
>> >  endif
>> >  ifeq ($(CONFIG_CMODEL_MEDANY),y)
>> >  	KBUILD_CFLAGS += -mcmodel=medany
>> > +	CHECKFLAGS += -D__riscv_cmodel_medany
>>
>> I can teach sparse about this in the following days.
>
> That would be great.  Would you be willing to follow up with me via E-mail
> or mailing list post when it's fixed?  If so, then in the meantime, I'll
> just drop this patch.

It's probably worth going through all our argument-dependent builtin 
definitions at the same time.  They're generated by riscv_cpu_cpp_builtins(): 
https://github.com/gcc-mirror/gcc/blob/master/gcc/config/riscv/riscv-c.c#L35 .

>
>
> - Paul
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
