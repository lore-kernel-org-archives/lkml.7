Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AB4C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8445120872
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="enaoKJ57"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbfFFTKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:10:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46974 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728690AbfFFTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:10:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id 81so829617pfy.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 12:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=iq2ZMOKhxG40k3ZjkkAfD8/mhEY6iwy4v663CmYVX5Q=;
        b=enaoKJ57+AWkQ/VcvXkyxXhGlqXFGFOA4xotHL8PViRCGoywuFOLat/NWbwVKMJRsv
         /6zQrNaJ/cDsC6+AIUtQfT7+hSekvAbQRzbG+qaghYV1vBxnYVc15Dubhn5p/wGgF9C0
         qYorLZzRxLxQgeQRYQWkc09mR1WoWRq8CbOmrM88g/lRcS5jm0LYcxiabWtbQHrvNkaM
         dIxA9UpmM+zdTDic/w9UuUE7kWVNHRKuf0BRjNIM+PHVO3d+u2FGXZ3twojCUvuWkrvx
         Rk5DdAzQV1rEkUg4pyUMZ3jneiFRWmLJcal3R4IGVvVE8z/g47u+QICQFjAskvWhaAKk
         mZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=iq2ZMOKhxG40k3ZjkkAfD8/mhEY6iwy4v663CmYVX5Q=;
        b=FsL49qRuuCbpXrij7fyS5zKY5yUmGTsFtdCl3PeL78T+R+n4D1IpVmmkelkY04s1qT
         dE5AcLGrbWAYeHI7BxAkq+pR6WkswUM9N7APvx3uBrPWytUPTxd9K0fkZ5vFF1FCQkaU
         f4Vxi+Ps9/EB4vkIRDsQN9azLstRBRpG1vLowZ5N2ORWllytbh61r3GJFyMApeNxmpAO
         L6xuG+OQGJHnaUffmsR7aKsHGsEgvCqV+8avmPdqwUIqKP8kUx/Y9hFQsdZ7m+nS5+yG
         UNkhz4bMlNHqKkC2oKEcqQxlaVH0u22lMkRL2/+hdAVx11ic6tsbkDmr/3A39Y9G1STg
         i3dg==
X-Gm-Message-State: APjAAAV+0Kt6Am1oAO8MNEnkfCZctZivMUxomq+U6uPhckLI9SViYlWZ
        gWFfr64etN8jutOP9BvR83YGHw==
X-Google-Smtp-Source: APXvYqwd5dsw5v4s6YM7SnjJ88V7ez2g5lofdM2+M1Q+bnvTbwqCj3SskP3oB92MGYpTz2nDFDvQtg==
X-Received: by 2002:a62:750c:: with SMTP id q12mr33795301pfc.59.1559848232489;
        Thu, 06 Jun 2019 12:10:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id z15sm2307084pge.40.2019.06.06.12.10.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 12:10:31 -0700 (PDT)
Date:   Thu, 06 Jun 2019 12:10:31 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 12:09:29 PDT (-0700)
Subject:     Re: [PATCH] RISC-V: Break load reservations during switch_to
In-Reply-To: <20190606090518.GB1369@infradead.org>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-ea7cfd57-8e3a-49e6-8f95-74c009001774@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jun 2019 02:05:18 PDT (-0700), Christoph Hellwig wrote:
> On Wed, Jun 05, 2019 at 04:17:35PM -0700, Palmer Dabbelt wrote:
>>  	REG_S ra,  TASK_THREAD_RA_RA(a3)
>> +	/*
>> +	 * The Linux ABI allows programs to depend on load reservations being
>> +	 * broken on context switches, but the ISA doesn't require that the
>> +	 * hardware ever breaks a load reservation.  The only way to break a
>> +	 * load reservation is with a store conditional, so we emit one here.
>> +	 * Since nothing ever takes a load reservation on TASK_THREAD_RA_RA we
>> +	 * know this will always fail, but just to be on the safe side this
>> +	 * writes the same value that was unconditionally written by the
>> +	 * previous instruction.
>> +	 */
>> +#if (TASK_THREAD_RA_RA != 0)
>
> I don't think this check works as intended.  TASK_THREAD_RA_RA is a
> parameterized macro, thus the above would never evaluate to 0. The
> error message also is rather odd while we're at it.

OK, I didn't try it.  The resulting number can never be non-zero, which is why
I couldn't come up with an error message that made sense.  I'm not opposed to
dropping the check.

>> +#if (__riscv_xlen == 64)
>> +	sc.d  x0, ra, 0(a3)
>> +#else
>> +	sc.w  x0, ra, 0(a3)
>> +#endif
>
> I'd rather add an macro ala REG_S to asm.h and distinguish between the
> xlen variants there:
>
> #define REG_SC		__REG_SEL(sc.d, sc.w)

Ya, I guess I was just being lazy.  I'll put that in a v2.
