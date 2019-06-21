Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C20C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E162064B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfFUBuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:50:35 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32821 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUBue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:50:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id x15so2713846pfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=j5EwuhwdKeX+aMQ1HhFBPq9OFCfHqk3KViLFexG5B9E=;
        b=dlFEtWTOXXp+XHAC4reFd5KEDcbxrVaABYW9+9LRPy9RWpq19Tc3Io1A4xpFuMxtkT
         tK0v/qT+W6S+7L9bQ4humqYxom+6iLdTsAXOMVXGsvH+yKeeR4pFKbqnM/xImvPOpf0c
         PDdrWsj7xMGQjOKmrA1naJsbU0872KMDwW/WsKqSMyDOGoXZ96m50zdw7Pbht6XJQwWD
         +HhC2bDbe/sGVrx3x6CfX70SNvCNBr7ebipUmMpwShL+Q6l226P08a3X9pntjCWCCygP
         aw11wAiBakoJ9kn3PsmixUc9NwQHMlGMI15v0AByJjahO1tL+qEmqdQVuqbrMXgMzKLG
         PHTw==
X-Gm-Message-State: APjAAAWlNd162Lpx1iRAfXH1Xgsn8crHnWe7GCHP5qhFnoPsuiAVaIlS
        zFbpjViX45q6jvX4Axk643MvcA==
X-Google-Smtp-Source: APXvYqz7taZv4NZMlPtAvodeU7r1q7k5R6++mRN+Pt4d3ymudWUR1cbBXbtQFmIcoBHVIqS85x5ApQ==
X-Received: by 2002:a17:90a:8c0c:: with SMTP id a12mr2983319pjo.67.1561081832818;
        Thu, 20 Jun 2019 18:50:32 -0700 (PDT)
Received: from localhost (amx-tls3.starhub.net.sg. [203.116.164.13])
        by smtp.gmail.com with ESMTPSA id h11sm694257pfn.170.2019.06.20.18.50.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 20 Jun 2019 18:50:31 -0700 (PDT)
Date:   Thu, 20 Jun 2019 18:50:31 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Jun 2019 18:50:24 PDT (-0700)
Subject:     Re: [PATCH v2] RISC-V: Break load reservations during switch_to
In-Reply-To: <20190619073600.GA29918@lakrids.cambridge.arm.com>
CC:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     mark.rutland@arm.com
Message-ID: <mhng-c41d9776-2f3e-4a49-8be9-78f9fd55cfda@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jun 2019 00:36:01 PDT (-0700), mark.rutland@arm.com wrote:
> On Fri, Jun 07, 2019 at 03:22:22PM -0700, Palmer Dabbelt wrote:
>> The comment describes why in detail.  This was found because QEMU never
>> gives up load reservations, the issue is unlikely to manifest on real
>> hardware.
>>
>> Thanks to Carlos Eduardo for finding the bug!
>
>> @@ -330,6 +330,17 @@ ENTRY(__switch_to)
>>  	add   a3, a0, a4
>>  	add   a4, a1, a4
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
>
> I suspect that you need to do the same as 32-bit ARM, and clear this in
> your exception return path, rather than in __switch_to, since handlers
> for interrupts and other exceptions could leave a dangling reservation.
>
> For ARM, the architecture permits a store-exclusive to succeed even if
> the address differed from the load-exclusive. I don't know if the same
> applies here, but regardless I believe the case above applies if an IRQ
> is taken from kernel context, since the handler can manipulate the same
> variable as the interrupted code.

RISC-V has the same constraint: an LR can cause the subsequent SC on any
address to succeed.  When writing the patch I thought they had to have matching
addresses, v4 should have a correct comment (assuming I've managed to send it,
I'm on my third continent this week so I'm a bit out of it).

I'd considered breaking reservations on trap entry, but decided it wasn't
necessary.  I hadn't considered doing this on trap exit, but I don't see a
difference so I might be missing something.  The case that I see as an issue is
when a trap comes in the middle of an LR/SC sequence, which boils down to three
cases:

* The trap handler doesn't contend with the LR/SC sequence in any way, in which
  case it's fine for the sequence to succeed.
* The trap handler contends by doing its own LR/SC sequence.  Since the trap
  handler must execute completely before returning control back the parent, we
  know the SC in the trap handler will execute.  Thus there is no way the SC in
  the parent can pair with the LR in the trap handler.  This applies even when
  traps are nested.
* The trap handler contends by performing a regular store to the same address
  as the LR that was interrupted.  In this case the SC must fail, and while I
  assumed that the store would cause that failure the ISA manual doesn't appear
  to require that behavior -- it does allow the SC to always fail in that case,
  but it doesn't mandate it always fails (which is how I got confused).

Assuming the ISA manual is correct in not specifying that stores within an
LR/SC sequence break the load reservations, then I think we do need to break
load reservations on all traps.  I'll go check with the ISA people, but now
that I've noticed it this does seem somewhat reasonable -- essentially it lets
LR just take a line exclusively, SC to succeed only on already exclusively held
lines, and doesn't impose any extra constraints on regular memory operations.

I don't see any reason that breaking reservations on entry as opposed to exit
would be incorrect.  I feel like doing this on entry is a better bet, as we're
already doing a bunch of stores there so I don't need to bring an additional
cache line in for writing.  These lines would be on the kernel stack so it's
unlikely anyone else has them for writing anyway, so maybe it just doesn't
matter.  The only issue I can think of here is that there might be something
tricky for implementations to handle WRT the regular store -> store conditional
forwarding, as that's a pattern that is unlikely to manifest on regular code
but is now in a high performance path.  The regular load -> store conditional
may be easier to handle, and since this is done on the kernel stack it's
unlikely that upgrading a line for writing would be an expensive operation
anyway.

LMK if I'm missing something, otherwise I'll spin another version of the patch
to break reservations on trap entry.
