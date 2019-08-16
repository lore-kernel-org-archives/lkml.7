Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE12C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F017206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbfHPKQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41944 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfHPKQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:16:39 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hyZHd-0007Xv-5c; Fri, 16 Aug 2019 12:16:33 +0200
Date:   Fri, 16 Aug 2019 12:16:32 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Anders Roxell <anders.roxell@linaro.org>
cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3] seqlock: mark raw_read_seqcount and read_seqcount_retry
 as __always_inline
In-Reply-To: <20190726111804.18290-1-anders.roxell@linaro.org>
Message-ID: <alpine.DEB.2.21.1908161209280.1873@nanos.tec.linutronix.de>
References: <20190726111804.18290-1-anders.roxell@linaro.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jul 2019, Anders Roxell wrote:
>  
> -static inline void __seqcount_init(seqcount_t *s, const char *name,
> +static __always_inline void __seqcount_init(seqcount_t *s, const char *name,
>  					  struct lock_class_key *key)

That has nothing to do with the actual problem

> -static inline void raw_write_seqcount_begin(seqcount_t *s)
> +static __always_inline void raw_write_seqcount_begin(seqcount_t *s)

Neither this, nor these:

> -static inline void raw_write_seqcount_end(seqcount_t *s)
> +static __always_inline void raw_write_seqcount_end(seqcount_t *s)
>  {

> -static inline void raw_write_seqcount_barrier(seqcount_t *s)
> +static __always_inline void raw_write_seqcount_barrier(seqcount_t *s)

The following is fine as it is used in the NMI safe time accessors which
can be used as trace clock:

> -static inline int raw_read_seqcount_latch(seqcount_t *s)
> +static __always_inline int raw_read_seqcount_latch(seqcount_t *s)

The rest is bogus...

s/inline/__always_inline/g is conveniant, but does neither match the
changelog nor does it make sense.

Thanks,

	tglx
