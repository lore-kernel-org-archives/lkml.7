Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4C7C742BA
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B741721019
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 12:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="X0/EeCNV";
	dkim=pass (2048-bit key) header.d=raspberrypi.org header.i=@raspberrypi.org header.b="bG5Ya8kL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbfGLMmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 08:42:19 -0400
Received: from mx08-00252a01.pphosted.com ([91.207.212.211]:51060 "EHLO
        mx08-00252a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727426AbfGLMUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 08:20:47 -0400
Received: from pps.filterd (m0102629.ppops.net [127.0.0.1])
        by mx08-00252a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x6CC8jQU026848
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:20:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=raspberrypi.org; h=subject : to :
 cc : references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp;
 bh=aYvRadL6yw0BOyQsAWmctpKAqep0lNQg7LKzEYkgp68=;
 b=X0/EeCNVGCx2yyWuvvn3LkdGbOr9KPiTlxdyR3E0+v5B1nOSKzMq6LGMnVP2gjBsJWCj
 gX+o8gyEe9rEhuYqzX2A41ZObSk0XFX5jtziXchzJD5U4jNACl2yJZDu/cdpeMS+ZmhH
 fGZ6agpByAwjFGxcLfL2pWaV4A/P8bTJgJZ9Xa3G8e1faX3WACWw3UysqcKBiext+Jb2
 Cx0enGru3H6xH5o++YNKiOsgvfvybM9gF7wdJsrG+HxsicvK6xZL2gKojjkRwb8LkK68
 Tb6KASf9bOr+x8YHiaGxI31oP+w5ZnKSsWLSLzRDFK/uf9/nEr/aYtjO2qOheRfrCnnf TQ== 
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        by mx08-00252a01.pphosted.com with ESMTP id 2tmd5x1ugu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 13:20:44 +0100
Received: by mail-wr1-f71.google.com with SMTP id p13so4209101wru.17
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2019 05:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aYvRadL6yw0BOyQsAWmctpKAqep0lNQg7LKzEYkgp68=;
        b=bG5Ya8kLRPKQnc0IcMH7KDpOAIKl/HryHVEWznwsV4N6m3Q4fAYqMGkytOPUtdpNnU
         RDmUN3EDhwNu9GzR+0TkJCHbjNq0Ezf3ADfEQ5rXPLaH2O0dQ4VhQWkyr+/23rdcgfAR
         fVOjisc6FWm7uAq6vaI5K9UQVVRUvbM6k90M18f09aniuIbkUMEJuq6q2c2CmN32dI15
         QbOxkV5S1xzrp7Tj4FSG7vwaRBiEUwBY4hvX8D7KxbfSus/CsrIouN47G1ZT1/hc3qwp
         BzW+O+OlHXY0uo/57Tv9ri4OU0v9y/ZZyddpZhkhGrO3jUBnWnBMRBgH7OS0RPcqSfqh
         7rNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aYvRadL6yw0BOyQsAWmctpKAqep0lNQg7LKzEYkgp68=;
        b=LOVnBFuuHDrIbNEsBkh3Qg/5p4bDX9JY1ZcFiAg30iH9Qcu2WHcmypZLuWpuK2hkIc
         dlPPmsTYk/b/H38s0osZMZaziedwlWIx/lO33mMkgnZl16uK8yTDdf//JgcStzR9tojU
         a8JiMXMbY3Bh3wvJHT8BF1aCYbODzhem3WwiipeAoXxuw0rlZR+9981kbsvEQausxp9c
         SeHg+cHNperiZhFMYHEH8fAJoPJO1x7/ksbpXUGvrmhjTxb20yy2tR53S0ENmMBMxCm1
         TgIduFv6P48dctf94QU/xEP/VAyE7U+7JiSyJcQ8YfLn0pKPvSelB9QZPVebvJb9zLtz
         U0oA==
X-Gm-Message-State: APjAAAXt/BADsMbpmcB35QVeJisAQcPbDgtTBc1O6Zp4oePLo/gKpKID
        V+p762QGhXqf7LDw8fKfCCeXkITlJCrbsZn7hesaRnreujijpx2e9RyWn2ihCwRXeQj5Mo1rjae
        0mxXypx69t/Xyz5UYyjq3C1LZ
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr9642225wmf.166.1562934042981;
        Fri, 12 Jul 2019 05:20:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy0QMAasKV533r2hf9StmKuUCmGS/yGnfCIYPi04R0ntO5GVjUL0ujM4e8C6vp2r9XeajybuQ==
X-Received: by 2002:a1c:c14b:: with SMTP id r72mr9642203wmf.166.1562934042677;
        Fri, 12 Jul 2019 05:20:42 -0700 (PDT)
Received: from ?IPv6:2a00:1098:3142:14:3df0:c4c3:bb86:e0f3? ([2a00:1098:3142:14:3df0:c4c3:bb86:e0f3])
        by smtp.gmail.com with ESMTPSA id k17sm5800070wrq.83.2019.07.12.05.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 05:20:41 -0700 (PDT)
Subject: Re: [PATCH] tty: amba-pl011: Make TX optimisation conditional
To:     Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1562852732-123411-1-git-send-email-phil@raspberrypi.org>
 <20190712112105.GH2790@e103592.cambridge.arm.com>
 <20190712121000.GK11350@BitWizard.nl>
From:   Phil Elwell <phil@raspberrypi.org>
Message-ID: <5bf03345-6a36-1b87-ca0c-e918b6030a74@raspberrypi.org>
Date:   Fri, 12 Jul 2019 13:20:42 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712121000.GK11350@BitWizard.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:5.22.84,1.0.8
 definitions=2019-07-12_04:2019-07-12,2019-07-12 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rogier,

On 12/07/2019 13:10, Rogier Wolff wrote:
> On Fri, Jul 12, 2019 at 12:21:05PM +0100, Dave Martin wrote:
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 89ade21..1902071 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -1307,6 +1307,13 @@ static bool pl011_tx_chars(struct uart_amba_port *uap, bool from_irq);
>>  /* Start TX with programmed I/O only (no DMA) */
>>  static void pl011_start_tx_pio(struct uart_amba_port *uap)
>>  {
>> +	/*
>> +	 * Avoid FIFO overfills if the TX IRQ is active:
>> +	 * pl011_int() will comsume chars waiting in the xmit queue anyway.
>> +	 */
>> +	if (uap->im & UART011_TXIM)
>> +		return;
>> +
> 
> I'm no expert on PL011, have no knowledge of the current bug, but have
> programmed serial drivers in the past.
> 
> This looks "dangerous" to me.
> 
> The normal situation is that you push the first few characters into
> the FIFO with PIO and then the interrupt will trigger once the FIFO
> empties and then you can refil the FIFO until the buffer empties.
> 
> The danger in THIS fix is that you might have a race that causes those
> first few PIO-ed characters not to be put in the hardware resulting in
> the interrupt never triggering.... If you can software-trigger the
> interrupt just before the "return" here that'd be a way to fix things.

I'm also not a serial driver expert, but I think this simplified patch is safe.
The reason is that the UART011_TXIM flag is only set after the pio thread has failed
to write some data into the FIFO because it is full, which would guarantee that
an interrupt is generated once the fill level drops below the half-way mark.

> I'm ok with a reaction like "I've thought about this, it's not a
> problem, now shut up".

I don't think that reaction would be justified - these things are difficult, and having
many minds on the problem helps to avoid bugs like this.

Phil
