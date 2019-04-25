Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71966C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD97620717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 18:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556218249;
	bh=qxF/lXiqo6cG/57oiaUteES7Mb3jGcT9riQl/ZNu7G0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VpDdXIJA0J5gqUSs/toMgjmhfax/BjapMUlQj9dT9knieeKFp2AjQ5SDsgz03aAIX
	 E1IUyuLbSBTt4Gw8ff6JDNGOkKYCHkmL96XxTX6bUR8qlY6xiqqgn8ME+CbcuQqHnF
	 28A7bte5dwSZt73BW1DCN43H1nCurMXtwHyhd+yo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbfDYSus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 14:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbfDYSur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 14:50:47 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 553E42146E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 18:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556218247;
        bh=qxF/lXiqo6cG/57oiaUteES7Mb3jGcT9riQl/ZNu7G0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B80m5djWcvM7FGaP9bH9idT/TL1WS/EHA4jDB/C7IhZYKiFdAU/tL5dCTYG4mDLCC
         FmVlwVFYbPgQubjIzVfut7u2Nlev8TV0PaxqR/vZeywXp3Gv9GrW04uP+MKzsAO/CM
         eDqIZ/o8Hs2Y2Q27kvf8uMZURy9vktZA7OmI+eRI=
Received: by mail-wm1-f41.google.com with SMTP id n25so659811wmk.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:50:46 -0700 (PDT)
X-Gm-Message-State: APjAAAVyhnOHDAS/7+VsHLP7PahPAF3Tm3KG75SREMOfNk4Zx9HUXaBw
        pUh4rxyv/yCrXa39J6Oh5pglb3v+k7PsHe4f6CQFdw==
X-Google-Smtp-Source: APXvYqydoeh+i3DNI6lzmXpy6tzeBOndTDk0R2/se/sGzaRsHorj4pk/wGQxi9a/avUEXgkxmLJWcSm/uTKW/r8FzjA=
X-Received: by 2002:a1c:eb18:: with SMTP id j24mr4882651wmh.32.1556218245380;
 Thu, 25 Apr 2019 11:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190425180828.24959-1-namit@vmware.com>
In-Reply-To: <20190425180828.24959-1-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 25 Apr 2019 11:50:32 -0700
X-Gmail-Original-Message-ID: <CALCETrVmUQ2=qddwh=CHtkaZPn1JMoN9ce=Dv5rNUvFbqjHzUw@mail.gmail.com>
Message-ID: <CALCETrVmUQ2=qddwh=CHtkaZPn1JMoN9ce=Dv5rNUvFbqjHzUw@mail.gmail.com>
Subject: Re: [PATCH v2] x86/mm/tlb: Remove flush_tlb_info from the stack
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 11:08 AM Nadav Amit <namit@vmware.com> wrote:
>
> Move flush_tlb_info variables off the stack. This allows to align
> flush_tlb_info to cache-line and avoid potentially unnecessary cache
> line movements. It also allows to have a fixed virtual-to-physical
> translation of the variables, which reduces TLB misses.
>
> Use per-CPU struct for flush_tlb_mm_range() and
> flush_tlb_kernel_range(). Add debug assertions to ensure there are
> no nested TLB flushes that might overwrite the per-CPU data. For
> arch_tlbbatch_flush() use a const struct.
>

I like this version of the patch.
