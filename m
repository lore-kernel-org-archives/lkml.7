Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EABBC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEE42171F
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 15:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555083181;
	bh=WzX8XGkOY041LE4RUQ/RFMWNbG+GGbzcioro+MbFIBg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mK1r/izYnumvNNiu+8z0XTat+K+/iN7iKMPJ0phVGuknV/zIkj8MMMVXIwKtCdkl0
	 INv+UQXyXIbfFRTKcQmSYnI2wI6AVKLQwDUBtiiVel85rIKBmbd0x9sjkdHa6YwW3V
	 hBshRTOFpaMb2opXHOoM6gW7iAU8DhhkPATfCj/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfDLPc7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 11:32:59 -0400
Received: from mail-lf1-f49.google.com ([209.85.167.49]:32978 "EHLO
        mail-lf1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbfDLPc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 11:32:59 -0400
Received: by mail-lf1-f49.google.com with SMTP id j11so7842798lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXbKfjDtbjJTyw5Ef0Kix1bfyNOyzTYwEKpGgqOg0TQ=;
        b=b29dvSdD9cfYHQabi8DqTd65SPCA4obhIln3RU66IajZ136WcOn3NOWVgBFDYVDptF
         Pp2/5FS6XX6lmgEFeW+6w+62lN8PLub/YTGNvXWjkP9nQCUx99g1ArdD+fsyH0+QY+kM
         Dy3/6RufoCQqG8kSbDLFyrVvMcECFbfR4KUgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXbKfjDtbjJTyw5Ef0Kix1bfyNOyzTYwEKpGgqOg0TQ=;
        b=XYxI670BljsxMIgawK0srciRvoJOB+nHDbWu9kV+15IqVgv+3ZYafvJAUeZBrpgCYt
         bG65bEDrp/7qiJLsRYHj6zaq097cUj8RkYbmceWSCcZll4AXal+gcdjBD5XyU+RIVICp
         atf8kPyk9wWRREIFYZpv5cJHmSmgu3O5zitOhJT+j+SeAPannovbAdzO9GaAHqzjcrpV
         UCJBqPlMPRhKTbgBP9QwuELthGeb1KtIrjayV4jLJJWY7xKRmFqtd75CD/78GhMof9lZ
         Pg/AUTdMoOxAFWz9zvqZczWh5c6TADq43LEvrQ9O/NQqqtnd7eGzqU134Q+tKrED7gRs
         vYeg==
X-Gm-Message-State: APjAAAVjw9ZDNjZ+aAY/kJmBZr8Oxm+pm3Dk0J332cEB/IdDZCIrV0PL
        1acaAJK2sur3XszNdnPnwgIpGKWliqc=
X-Google-Smtp-Source: APXvYqyKKxlM4QaekPYCFKiOvdMUkzmUPtETBIVyQaKqZsp5KyPoZZuwcMvgb3TnQcqHY25ywqvPVQ==
X-Received: by 2002:ac2:518b:: with SMTP id u11mr14094492lfi.46.1555083176265;
        Fri, 12 Apr 2019 08:32:56 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id n9sm7896773lfl.35.2019.04.12.08.32.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 08:32:55 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id h16so9228314ljg.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 08:32:55 -0700 (PDT)
X-Received: by 2002:a2e:9a91:: with SMTP id p17mr30639609lji.127.1555083174727;
 Fri, 12 Apr 2019 08:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com> <20190411193906.GA12232@hirez.programming.kicks-ass.net>
 <20190411195424.GL14281@hirez.programming.kicks-ass.net> <20190411211348.GA8451@worktop.programming.kicks-ass.net>
 <20190412105633.GM14281@hirez.programming.kicks-ass.net>
In-Reply-To: <20190412105633.GM14281@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Apr 2019 08:32:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
Message-ID: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG:
 KASAN: stack-out-of-bounds in __change_page_attr_set_clr
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 3:56 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -728,7 +728,7 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  {
>         int cpu;
>
> -       struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
> +       struct flush_tlb_info info = {
>                 .mm = mm,
>                 .stride_shift = stride_shift,
>                 .freed_tables = freed_tables,
>

Ack.

We should never have stack alignment bigger than 16 bytes.  And
preferably not even that. Trying to align stack at a cacheline
boundary is wrong - if you *really* need things to be that aligned, do
something else (regular kmalloc, percpu temp area, static allocation -
whatever).

           Linus
