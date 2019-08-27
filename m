Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74ABFC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D71D22CBB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947597;
	bh=rHBa9MRffMSBHyUH5QZwjBWkLfU0q5vCcm3u+l5rcIw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=svJiGt4QrpVmgvphGadFCebShucKz888AkQ6Zgb/UD6vmyAaD5jV9k2BdDf2fLSzE
	 eyIRfYcRpBsVyHjKrvxGzh+NDjil7Zz0O69CjhBvRtC1UlKz6uqU6AnQdGia8qdFIn
	 I3F5jrpe5Xk/MXs7rP65cv2Q3I4foyUPmLtbosp4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfH0XNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726034AbfH0XNQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:13:16 -0400
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00D422CF5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 23:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566947595;
        bh=rHBa9MRffMSBHyUH5QZwjBWkLfU0q5vCcm3u+l5rcIw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VxPi+cBN5ooECgFEkOe7rqU7j7NTwarw2iKh9moOiOt+uRZ/cjiNPytBIwpf3g0nu
         m9VFcnmtKZTNMv+NVPptklx0a6m5WrvfRfGpBPuaUiOi56VZtrEE38zN/5vXc0MDu8
         RezyNRm0OmabY8hQ6jqygiNoF+0fXTWmD1YteHE0=
Received: by mail-wr1-f49.google.com with SMTP id z11so481981wrt.4
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:13:14 -0700 (PDT)
X-Gm-Message-State: APjAAAXYEBkY5ISCIljyfZLmd8YIsSiinZGTwr7gNLcy35BRsv0eEi7F
        rRAxqrWBlOFpML40vxsSb+U+UBY2AOBwu3842BQx3Q==
X-Google-Smtp-Source: APXvYqyhai/RL03y2ctYuCVVMR3Zh5Z8EvEHeMe+nXuXfKhsi/nR/0O9Eg9HydYHuOyg0ONueDfECKBsKQewV5ifbIo=
X-Received: by 2002:a5d:4d4c:: with SMTP id a12mr511436wru.343.1566947593137;
 Tue, 27 Aug 2019 16:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190823225248.15597-1-namit@vmware.com> <20190823225248.15597-3-namit@vmware.com>
In-Reply-To: <20190823225248.15597-3-namit@vmware.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 27 Aug 2019 16:13:02 -0700
X-Gmail-Original-Message-ID: <CALCETrX91RqYsetbTjfrsMHH8LhTW=YMPuatHuo0bdTJeejP=Q@mail.gmail.com>
Message-ID: <CALCETrX91RqYsetbTjfrsMHH8LhTW=YMPuatHuo0bdTJeejP=Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/3] x86/mm/tlb: Defer PTI flushes
To:     Nadav Amit <namit@vmware.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 11:13 PM Nadav Amit <namit@vmware.com> wrote:
>
> INVPCID is considerably slower than INVLPG of a single PTE. Using it to
> flush the user page-tables when PTI is enabled therefore introduces
> significant overhead.
>
> Instead, unless page-tables are released, it is possible to defer the
> flushing of the user page-tables until the time the code returns to
> userspace. These page tables are not in use, so deferring them is not a
> security hazard.

I agree and, in fact, I argued against ever using INVPCID in the
original PTI code.

However, I don't see what freeing page tables has to do with this.  If
the CPU can actually do speculative page walks based on the contents
of non-current-PCID TLB entries, then we have major problems, since we
don't actively flush the TLB for non-running mms at all.

I suppose that, if we free a page table, then we can't activate the
PCID by writing to CR3 before flushing things.  But we can still defer
the flush and just set the flush bit when we write to CR3.

--Andy
