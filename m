Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06996CA9EB5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6628206C2
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 08:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571648316;
	bh=HfuKQhR9m5s4aT9bAlUb721xryitD0Rls9WoOoE/hQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TFEG1mFxT0i4WAPPG0YfQpi9cFdkWm5oFulUTBXsxpE2LeU62m9K5tJ8flYa7a15Q
	 UyiDz6m0elZVZS3uN3q7wwB0LhA7q3Ba8wtYPu9a1MBbYe9JtwbfDQjvUGsAKhHk7n
	 44RQuSJKxLS/QQeZ5A3VgL6avOz+W5OTLhBi6IeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbfJUI6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 04:58:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50294 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbfJUI6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 04:58:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id q13so2264666wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sMl0RIrFxIHdsJG6JoCqFkrVqi6mHCo1NGESZx0zkH0=;
        b=r9lSF+9mg/YYYy257m+Vjc6FCvdsjEnldufxWcpFe/FCJkkKJ7h9HEbWtIkG56OFNQ
         unnUsuY6wpI7nLRkWEB6hGPVq3uJsAzgGoKqrUxk2Nm1Fr27DO6IGYnkaiybzNOPnuQi
         I1n70hi2EML+fUhz0TGu415iL/VJLEy8du77LsdYl84VqMbA0b9t2W8tI+euoYvw+Ig+
         DouMDB4TC1OoLCFxJCv/X6W0HT/LZYAzOhernKRee5578h5hlpAtzlZovVNAF3WZnp4D
         EJYR+o6S+ERH0WUcSHIfzIcNT0ZqURCamVzHGyk6+n4p6cFE+G9Y9Qsx5KUrlgaXyu0/
         WyQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sMl0RIrFxIHdsJG6JoCqFkrVqi6mHCo1NGESZx0zkH0=;
        b=C9qIUp07OdZC1Pb1svwTm0eA2acaMpUSikkIyJRGm/Wi29lxoadELlDZgdJp3sv34Q
         wVKaOZGkgw0q6PJGokoTVCoAcZ9AG0fUaPOB1HzlxubYJshyzJYYcuedGxbjvDdvQczd
         4Xj7VUIKtPAaVNrqjcnE70q/pC0H/OmWz0ZACqkRMs/YvalFp+eTuLjTNoVIM5QUNBzN
         eboO+O05ZrZnhlGXbmq34iBq00b2Ppol9MTMA5ZPvJuzgXp7+ShTxTS2wAicccY5yYbi
         9ku6zti15DjyVApL+1YOwVwP8lFhjSBoEbVdp0Z18kjB5n5hUIAJdAPimHHS5LTm5G14
         oFew==
X-Gm-Message-State: APjAAAV33Qf4KgNCJbe+YvrfFRB4d8iRJC56DflFKQNF8RkFhLhs+5Aa
        OjuZ3bydHkuhkNwt/6gTgtE=
X-Google-Smtp-Source: APXvYqyHf7oNAFQc1sbWzbEbk53/qqmHEG366UXdwF/FsRCPop8dtpOvtTQdKGziW1mqLwxLu/kTvw==
X-Received: by 2002:a1c:a657:: with SMTP id p84mr5079989wme.35.1571648313492;
        Mon, 21 Oct 2019 01:58:33 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y1sm17235496wrw.6.2019.10.21.01.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 01:58:32 -0700 (PDT)
Date:   Mon, 21 Oct 2019 10:58:30 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, jpoimboe@redhat.com, jeyu@kernel.org
Subject: Re: [PATCH v4 09/16] x86/alternative: Remove text_poke_loc::len
Message-ID: <20191021085830.GA102207@gmail.com>
References: <20191018073525.768931536@infradead.org>
 <20191018074634.457534206@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018074634.457534206@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

>  	 * Second step: update all but the first byte of the patched range.
>  	 */
>  	for (do_sync = 0, i = 0; i < nr_entries; i++) {
> -		if (tp[i].len - sizeof(int3) > 0) {
> +		int len = text_opcode_size(tp[i].opcode);
> +
> +		if (len - sizeof(int3) > 0) {
>  			text_poke((char *)tp[i].addr + sizeof(int3),
>  				  (const char *)tp[i].text + sizeof(int3),
> -				  tp[i].len - sizeof(int3));
> +				  len - sizeof(int3));
>  			do_sync++;
>  		}

Readability side note: 'sizeof(int3)' is a really weird way to write '1' 
and I had to double check it's not measuring the size of some larger 
entity.

I think it might make sense to just break out INT3_SIZE from 
arch/x86/kernel/kprobes/opt.c into a header, rename it to INS_INT3_SIZE 
and define it to 1, because the opt.c use is pretty obfuscated as well:

  #define INT3_SIZE sizeof(kprobe_opcode_t)

Where kprobe_opcode_t is u8 on x86 (and won't ever be anything else).

?

Thanks,

	Ingo
