Return-Path: <SRS0=fSNO=YI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4A0ECE59E
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AE72064A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Oct 2019 21:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571176045;
	bh=wX2Gd610RR+o4v1zQ+phdkvWmzCDRKxs5U22xbN6EcI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IozGIVNzpYMJnGsHjjfgJ6EsDmJnIV4dnvFOhYojLHizS3BKLbulgAgXdA67s11XP
	 a2k4tx0XFigD2moSNDpgBWhBsRkmDVgFA3DYO11sIj5ZH8PZct0PS7arK0nNHsS3uF
	 HV8UIXATYr0ERv+QC6J6uiYGjg6M44+nidJd5czQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730605AbfJOVrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Oct 2019 17:47:23 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37870 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730498AbfJOVrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Oct 2019 17:47:23 -0400
Received: by mail-lj1-f195.google.com with SMTP id l21so21848053lje.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iKBAZQ4xjT2H3VBhqEDygDjsoO3OrXWHV1qvzKsg6h8=;
        b=eRTA7Y2CR106ubYgppU9AiKB36JGkMp2b525X7AN3j/XcF7eLbUaKXlFv/rViWY6ix
         ZyQP1ASnR5/wN6NVGyHLurSLBElwdONMtqPjyJIbyjjzlfJcbS2XG9xoqv9aty4Tx4RT
         C2KiiZ6vvkn0YO995uPMfi4p9S9yGM/cCoFHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iKBAZQ4xjT2H3VBhqEDygDjsoO3OrXWHV1qvzKsg6h8=;
        b=Rgw6lpQLjbFWJ+S1aEPqzdi6EElqYt6HhDD21Mk5yNHaAqIMsw1RaTMIMIMI//hsRi
         C6nKE/ryPVjL+7sKtjI0dJm5JRjGPfN+YLJxuQUToSsoilAkEXNrOmjEYWng1+t7MSya
         uUo1RoVe8fHUPnwrKOdFKnjlMxKNcHzZvioyD8EhHo8LinMz/DORxLlW54MpyN26lAnz
         O2wD89zQxI/wOJJ6f/ciP1K0e4786keyLenj9j9rkCYT+e6rrXNFXeCNZrFgHr605Rv3
         PueGpiXtfjUX04F1fEKoSTsltAsZ+XMwdNdbTlM4FQiy3wWm/Kmmqm55XlGnlMdZa9My
         YW/Q==
X-Gm-Message-State: APjAAAUFYhhQqFN5YiVjbQKYn9jVuvx26K6T/SxRnEblK2QkcEpprRU2
        5lqczTPdprDIYdhkUvkIMc3ykcsYbSg=
X-Google-Smtp-Source: APXvYqxF4uFlhtx/8QHwgpa+krmaamiO0scxnEIIo+opj/XEVds2YHXGJqCGfu23dUZNN0bx9Oh63Q==
X-Received: by 2002:a2e:3a19:: with SMTP id h25mr23873180lja.129.1571176040265;
        Tue, 15 Oct 2019 14:47:20 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id n3sm5298765lfl.62.2019.10.15.14.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2019 14:47:19 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id a22so21838588ljd.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2019 14:47:18 -0700 (PDT)
X-Received: by 2002:a2e:8310:: with SMTP id a16mr18060112ljh.48.1571176038634;
 Tue, 15 Oct 2019 14:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191015191926.9281-1-vgupta@synopsys.com> <20191015191926.9281-4-vgupta@synopsys.com>
In-Reply-To: <20191015191926.9281-4-vgupta@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 15 Oct 2019 14:47:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
Message-ID: <CAHk-=wg470=r9YPMLyJdgr-aLvHSnDOFwFx=Y=_HPAW-aqyFRg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] asm-generic/tlb: stub out p4d_free_tlb() if nop4d ...
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2019 at 12:19 PM Vineet Gupta
<Vineet.Gupta1@synopsys.com> wrote:
>
> This came up when removing __ARCH_HAS_5LEVEL_HACK for ARC as code bloat
> from this routine not required in a 2-level paging setup

Similarly acked,

          Linus
