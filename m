Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6A7C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D43C208E3
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559669962;
	bh=aYguEb5aG56wiHY6OzZHyRUFhv/lZp83hT9+l3dp638=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=n+qVvhtT9RsdMBbWLpspZA1V8/syekxtR9wzJky88TJT73rQqlqbypTVKPUhxEfJJ
	 ilk+HJYiF+yEvjpPDn3tpiNBz31IuMvmjE4cxTjNq0fPEH2CVUXeS5OIqb/COSoP69
	 UNzT5dXo/2CQdeASRpfyb9vOsF4dYrCuTK2SQNTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfFDRjV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 13:39:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:51528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbfFDRjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 13:39:21 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C8A208E3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2019 17:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559669961;
        bh=aYguEb5aG56wiHY6OzZHyRUFhv/lZp83hT9+l3dp638=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZHE4Dw92A2LpBnMgIII9AZNaZa0i8z36M5lXAuE5NjwKWoKY499Fye+2L7IRYvfao
         1ryehXVFellQIyP3ZK99HSFuDxyNoinIoPFE0Zrp9re15I7MndIRkJsSP/53BSB8Fd
         i848f1zEzfPvjysD/yvjOLFsBboYheKUuCFc3aVs=
Received: by mail-wr1-f45.google.com with SMTP id d18so16734806wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2019 10:39:20 -0700 (PDT)
X-Gm-Message-State: APjAAAVmeHO9QnLrXA1y1G1mSLhQC6aK891FxF+hDf/YMxFupG70gEsu
        iOH91AyVTURMOh8IULmdDDwzjky1MXczcuJ18TnpBw==
X-Google-Smtp-Source: APXvYqyg01tQSt5O2lN3mZLnwAel5frzOX/OUAFM4IOFuds5sxzUjj3rfd8O0VqT4+oCtFsLsiL6CXnRgwGmhtxIqiU=
X-Received: by 2002:adf:fe90:: with SMTP id l16mr555546wrr.221.1559669959488;
 Tue, 04 Jun 2019 10:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1905281055240.1859@nanos.tec.linutronix.de> <20190604164117.22154-1-alexander.sverdlin@nokia.com>
In-Reply-To: <20190604164117.22154-1-alexander.sverdlin@nokia.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 4 Jun 2019 10:39:06 -0700
X-Gmail-Original-Message-ID: <CALCETrW6aE--Fo3qnK2zCAis5C-NraZtie4RBw59DVmzg5K_oA@mail.gmail.com>
Message-ID: <CALCETrW6aE--Fo3qnK2zCAis5C-NraZtie4RBw59DVmzg5K_oA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/vdso: implement clock_gettime(CLOCK_MONOTONIC_RAW, ...)
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Vas Dias <jason.vas.dias@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 4, 2019 at 9:42 AM Sverdlin, Alexander (Nokia - DE/Ulm)
<alexander.sverdlin@nokia.com> wrote:
>
> From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
>
> Add CLOCK_MONOTONIC_RAW to the existing clock_gettime() vDSO
> implementation. This is based on the ideas of Jason Vas Dias and comments
> of Thomas Gleixner.
>

Can you benchmark this against pulling the mult and shift into the
per-clock base?

--Andy
