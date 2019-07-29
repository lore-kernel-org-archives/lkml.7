Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF053C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93626206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 20:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izBESb+v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbfG2UoW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 16:44:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43502 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729446AbfG2UoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 16:44:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so63267387wru.10
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 13:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8BgDTStRQ2T9ojuBwzZJrWwy1PINQlgsG1IgU+UHq/8=;
        b=izBESb+vdlqc9YqQw8zQSWBpeg0LcX419GMZ27hlXw587xn44e4gX7aZEhTIDFN9DN
         TfinglKaWl6R0TFKO08VZ1TMaK+nPjjAaLBfMEX3XFSYrpo3899rFifMgMMO2RWstMGQ
         h87goVbJ9w0GOmNXxk3TydY3FSx6tr9xK3avgS7ZTQPMKgvxOal0qMzJXj16bxZCcD+D
         otCgkqrfe6zs9FwPAyoO9WjQVnFBkED3hx9t1Qj59zZuzyN3sMKC4gyjuCx/6mc5iC5G
         u5mMOctmkp8SfFYsqBCsfM/xAEPRf4wCNjQW9RMggqkoGGGoujX/8m0JVaeu+4ZimoRa
         dDYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8BgDTStRQ2T9ojuBwzZJrWwy1PINQlgsG1IgU+UHq/8=;
        b=s9En5/OadcmIc5fWT7COG/TsrCWMJuVpQ+IBZjP3f1yRRmRzJ4VQkeu78OTQlpegpz
         rM4LW8PdyBQFllCZ23TdTURk+98iAhtybg7F3tPa+Qm2PMpPAzZb2VUwyp+akZajusPr
         4/SKK5R5PU2HrGkraU0vb0bpqNbuWOOVPwhyf9hzZ7EqKJd1tlBE43Aqu49jw3h3lWgJ
         9Rd9LrH6RNjYzvxIG/pISF6ctYHhTIDZ8U+aB2M1m+7vnp9EllBKBNabs8KMBVL8Qcom
         EHiXtrPFFUYwKtp5ZG9JnuG8JoN5MSXTXMgfN14ESeulrSIcS+dCmChvm7EZrLVlQaQE
         m9vQ==
X-Gm-Message-State: APjAAAUd4yUCO3MBEixnnSS59UJHpje/3rAEhvHd+XVKBowiDML3/gDY
        6hP95NdyE+P/VtNuLGtyCw==
X-Google-Smtp-Source: APXvYqyHjqceeE50jegitX8lw8X50gDbvNlWxoP+ljTBv9VXaqbGEfW2pr95C5jMOZnh9URzfMDbeg==
X-Received: by 2002:a5d:4484:: with SMTP id j4mr122166110wrq.143.1564433060100;
        Mon, 29 Jul 2019 13:44:20 -0700 (PDT)
Received: from avx2 ([46.53.248.55])
        by smtp.gmail.com with ESMTPSA id z1sm69735375wrv.90.2019.07.29.13.44.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 13:44:19 -0700 (PDT)
Date:   Mon, 29 Jul 2019 23:44:17 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86: drop REG_OUT macro from hweight functions
Message-ID: <20190729204417.GA2146@avx2>
References: <20190728115140.GA32463@avx2>
 <20190729094329.GW31381@hirez.programming.kicks-ass.net>
 <20190729100447.GD31425@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190729100447.GD31425@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 12:04:47PM +0200, Peter Zijlstra wrote:
> +#define _ASM_ARG1B	__ASM_FORM_RAW(dil)
> +#define _ASM_ARG2B	__ASM_FORM_RAW(sil)
> +#define _ASM_ARG3B	__ASM_FORM_RAW(dl)
> +#define _ASM_ARG4B	__ASM_FORM_RAW(cl)
> +#define _ASM_ARG5B	__ASM_FORM_RAW(r8b)
> +#define _ASM_ARG6B	__ASM_FORM_RAW(r9b)

I preprocessed percpu code once to see what precisely it does because
it was easier than wading through forest of macroes.

Hopefully x86 assembly won't get to that level.
