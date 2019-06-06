Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B592C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51AE920868
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 19:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbfFFTcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 15:32:06 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:45330 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfFFTcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 15:32:06 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45KbQB6Vflz1rGhn;
        Thu,  6 Jun 2019 21:32:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45KbQB5ZB2z1rBHD;
        Thu,  6 Jun 2019 21:32:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id Get6cdg5GTJE; Thu,  6 Jun 2019 21:32:01 +0200 (CEST)
X-Auth-Info: wsLBElmpFEcCcJ6QVDMufRpEZQC5tFsi61TyY8+ncdmH3bKTG/HRIv08aWCl0Q99
Received: from igel.home (ppp-46-244-173-53.dynamic.mnet-online.de [46.244.173.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu,  6 Jun 2019 21:32:01 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 1ABFB2C1E61; Thu,  6 Jun 2019 21:32:01 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, marco@decred.org,
        me@carlosedp.com, joel@sing.id.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: Break load reservations during switch_to
References: <20190605231735.26581-1-palmer@sifive.com>
        <20190606090518.GB1369@infradead.org>
X-Yow:  LOOK!!  Sullen American teens wearing MADRAS shorts and
 ``Flock of Seagulls'' HAIRCUTS!
Date:   Thu, 06 Jun 2019 21:32:01 +0200
In-Reply-To: <20190606090518.GB1369@infradead.org> (Christoph Hellwig's
        message of "Thu, 6 Jun 2019 02:05:18 -0700")
Message-ID: <87ftom4ij2.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 06 2019, Christoph Hellwig <hch@infradead.org> wrote:

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
> parameterized macro,

Is it?  Just because it is used before an open paren doesn't mean that
the macro takes a parameter.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
