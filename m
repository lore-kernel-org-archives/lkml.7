Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CE5C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC42083B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 17:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbfF1RI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 13:08:59 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:47586 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfF1RI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 13:08:59 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 45b3Bw6cxrz1rd1j;
        Fri, 28 Jun 2019 19:08:56 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 45b3Bw5ws4z1qqkS;
        Fri, 28 Jun 2019 19:08:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id IiSFhchchR5s; Fri, 28 Jun 2019 19:08:55 +0200 (CEST)
X-Auth-Info: TU38+AnuLvpKw5O7aBilGJhqmRz1wOLhnCRDIh4OLyUBL7JxWbXJRek9upseuio7
Received: from igel.home (ppp-46-244-173-158.dynamic.mnet-online.de [46.244.173.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Fri, 28 Jun 2019 19:08:55 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 3832F2C105E; Fri, 28 Jun 2019 19:08:55 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 02/12] powerpc/ptrace: drop unnecessary #ifdefs CONFIG_PPC64
References: <cover.1561735587.git.christophe.leroy@c-s.fr>
        <34af3942cd27f6b5365caae772fb8e0af44763d5.1561735587.git.christophe.leroy@c-s.fr>
        <874l49mzuv.fsf@igel.home>
        <7dd19eae-793e-b334-e621-7681998ddf2e@c-s.fr>
X-Yow:  ..  this must be what it's like to be a COLLEGE GRADUATE!!
Date:   Fri, 28 Jun 2019 19:08:55 +0200
In-Reply-To: <7dd19eae-793e-b334-e621-7681998ddf2e@c-s.fr> (Christophe Leroy's
        message of "Fri, 28 Jun 2019 18:39:53 +0200")
Message-ID: <87zhm1ljrs.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 28 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> Le 28/06/2019 à 18:36, Andreas Schwab a écrit :
>> On Jun 28 2019, Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>
>>> diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
>>> index f5f1ccc740fc..37d7befbb8dc 100644
>>> --- a/arch/powerpc/include/uapi/asm/ptrace.h
>>> +++ b/arch/powerpc/include/uapi/asm/ptrace.h
>>> @@ -43,12 +43,11 @@ struct pt_regs
>>>   	unsigned long link;
>>>   	unsigned long xer;
>>>   	unsigned long ccr;
>>> -#ifdef __powerpc64__
>>> -	unsigned long softe;		/* Soft enabled/disabled */
>>> -#else
>>> -	unsigned long mq;		/* 601 only (not used at present) */
>>> +	union {
>>> +		unsigned long softe;	/* Soft enabled/disabled */
>>> +		unsigned long mq;	/* 601 only (not used at present) */
>>>   					/* Used on APUS to hold IPL value. */
>>> -#endif
>>> +	};
>>
>> Anonymous unions are a C11 feature.
>>
>
> Is that a problem ?

Yes, this is a UAPI header.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
