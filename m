Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8257CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9891F20873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 09:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571648471;
	bh=1MWW0WMs1RVszpMCHXzRp5JKVc+mgc0hNgP/XmatUUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SmkSmaknPRw35uxyHfoK2he6KoADJ67yVnC717nvGRX+PH03TJVQNuS7hc8NbfsPC
	 cmWQVZeFcyfNwBQG89rdn5jzM6E36gL75ujMUji6ckt6GoGErc8O6osSDPV+oF1XtH
	 CqK2EmKXDZwoYliOH+JdluOeJU6/MujHMq6DxOzk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbfJUJBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:01:10 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36868 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfJUJBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 05:01:10 -0400
Received: by mail-wr1-f65.google.com with SMTP id e11so4221985wrv.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ddm/tCcahKMa28WllyS8WVT+c+v/f7HZP2ZaqorwXAI=;
        b=QbcfiFC8PZ9zxxr1cKwbTejpJBiN57xE4H5f4Z5A/PLQPOGRLkOZcJgcZvrMMtfY+i
         rnq7brnj7Z1Q4EVEjJ3tl1BENFEz3x2hGW2qD0iw5vZJDVep2t1LFMNuj5E8n4TR18uq
         KqFi7BCluaV+vvpOikCBDaYlX0RNz6sCKU+zInH+qYHoOJGqv5eB5EPOJXE1KWiD8kra
         7oV2/XGHlCvAWUgvKKePStyrlD8zbBjFvaOHOgNj6exiYGSx43oLO6H0DXp5VmaBbXFL
         Z9caSwPbszbSS5Bw7mCOPx6b1rxT4nsbAFVs69PPLzsALthMov+sZem5krMhELOKJNhF
         O0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ddm/tCcahKMa28WllyS8WVT+c+v/f7HZP2ZaqorwXAI=;
        b=l2w9VoZBw20q5xpx1IzxsAR3y2t7aDiAZQLDxpn+WOgRU6JZ9zyUGJ0czwJhrVvVd4
         v73K+WHCz3aT6uaa50qqVC19DesOhxLSLWXhs78GUSB7dKeTRErjhh1uY2nxsinYq0O/
         l5IUtyE8kdaUP7uKm4TW+0IMoFSPpWMHs0phYf/6UjbQv5NQmOGEGLw+jXYa7ic83XfO
         /nZdX2Qe09ejUozvQe6dVCtDjPVbTkep4ybc1YSish5gq7qN91cSBULAXWO2FUH5IQ7S
         N3DBz1+eeGfphXMUdxSN/RoOS4PFx3SwxD2HbBJ+/6HEpRzcqsQtoueHyKoOe0c+Q3fD
         f/2g==
X-Gm-Message-State: APjAAAXeFAZiofUFKV2ZIi9QXy4Q5kFvCUNIZ1kMrlpNQZdg7rUIKrAS
        aE77vmccVOekGxDksDe/Bgo=
X-Google-Smtp-Source: APXvYqxg7I/KgcDM+d9sokdu5Xj0yobFxal1lnnmagJ6UOqh7jHyDw7SVXOZ1dfiv81jD7nZA3FZNA==
X-Received: by 2002:a5d:60ce:: with SMTP id x14mr3563996wrt.294.1571648467833;
        Mon, 21 Oct 2019 02:01:07 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t123sm18844798wma.40.2019.10.21.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 02:01:07 -0700 (PDT)
Date:   Mon, 21 Oct 2019 11:01:04 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 10/16] x86/alternative: Shrink text_poke_loc
Message-ID: <20191021090104.GB102207@gmail.com>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.514629541@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018074634.514629541@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Employ the fact that all text must be within a s32 displacement of one
> another to shrink the text_poke_loc::addr field. Make it relative to
> _stext.
> 
> This then shrinks struct text_poke_loc to 16 bytes, and consequently
> increases TP_VEC_MAX from 170 to 256.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/alternative.c |   23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> --- a/arch/x86/kernel/alternative.c
> +++ b/arch/x86/kernel/alternative.c
> @@ -937,7 +937,7 @@ static void do_sync_core(void *info)
>  }
>  
>  struct text_poke_loc {
> -	void *addr;
> +	s32 rel_addr; /* addr := _stext + rel_addr */
>  	s32 rel32;
>  	u8 opcode;
>  	const u8 text[POKE_MAX_OPCODE_SIZE];
> @@ -948,13 +948,18 @@ static struct bp_patching_desc {
>  	int nr_entries;
>  } bp_patching;
>  
> +static inline void *text_poke_addr(struct text_poke_loc *tp)
> +{
> +	return _stext + tp->rel_addr;
> +}

So won't this complicate the life of the big-address-space gcc model 
build patches that for purposes of module randomization are spreading the 
kernel and modules all across the 64-bit address space, where they might 
not necessarily end up within a ~2GB window?

Nothing upstream yet, but I remember such patches ...

Thanks,

	Ingo
