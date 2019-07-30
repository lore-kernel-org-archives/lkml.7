Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE48C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651A8206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfG3Qo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 12:44:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39067 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728271AbfG3Qo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 12:44:58 -0400
Received: by mail-pf1-f193.google.com with SMTP id f17so26144034pfn.6;
        Tue, 30 Jul 2019 09:44:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IgLumb9MAqzHCb15Mc0pwpcDGFeDvUjDUIMAgIXJu/M=;
        b=b4bmnj+VCaujyNoHm8oPIQT/L0SpoyWZGQZ0uC7eTz9TRVkRyvYvgYcoSJpAvMMPZz
         swgegMeg6IlkV/3ABbhbrnpHNq27gM7rSvm/4QdbDtxSz90gotrSs6JceEe8H30Jj4kc
         eqdBzPzNcVi/47wScP3v+ywlMM12SwiWFsTnZEpxU3eoyddgaBRSd1cWBF6cnwK7ZrsQ
         PP057Je2/E2sLPqfKiXYz2XBDhsE9uXT3wDYnue/8cVsqhsjQkeDaYo6nZqvGoMrIbLT
         D7tF14SA7r2yYnXlDpCGYuxBQBI4bl9zDbxpi9MvWvCJt4AKd7KmhsxayeW1Lg1GNIJA
         l6fw==
X-Gm-Message-State: APjAAAV1ASwau7ojZ0HydDWAbxuB4wbLFPrqzcMQDiNjoAZvq8S5fjSo
        qvhFtw+bcmyyf/lmlqZklTer7Ea4
X-Google-Smtp-Source: APXvYqzETn+TkzKurtIvT651Je4T+ppTeR4MfCImlYST4x/wDVnKSg/2y1oG+xUB4eQpgtfQhW4fQw==
X-Received: by 2002:a17:90b:f0e:: with SMTP id br14mr117837277pjb.117.1564505097732;
        Tue, 30 Jul 2019 09:44:57 -0700 (PDT)
Received: from [192.168.1.105] ([194.135.60.194])
        by smtp.gmail.com with ESMTPSA id h70sm60845304pgc.36.2019.07.30.09.44.53
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 09:44:57 -0700 (PDT)
Subject: Re: [PATCH v3] modpost: check for static EXPORT_SYMBOL* functions
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190714152817.24693-1-efremov@linux.com>
 <20190729141801.31333-1-efremov@linux.com>
 <20190730082618.5bb5edf3@canb.auug.org.au>
 <1b6f749c-2a25-219a-3eb3-0f2c7a542426@linux.com>
 <CAK7LNATnC6eVmahn=44F-j3Uf-x+cUWuP0q7QuP800biL9QJiA@mail.gmail.com>
From:   Denis Efremov <efremov@linux.com>
Message-ID: <d26ff0d1-fc45-d5b5-fe84-26fa9df09c3e@linux.com>
Date:   Tue, 30 Jul 2019 19:44:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNATnC6eVmahn=44F-j3Uf-x+cUWuP0q7QuP800biL9QJiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.2019 19:29, Masahiro Yamada wrote:
> I prefer this, but why do you need to check type?
> 
> Doesn't this work?
> 
> for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
>          unsigned char bind = ELF_ST_BIND(sym->st_info);
> 
>          struct symbol *s = find_symbol(remove_dot(info.strtab +
>                                                    sym->st_name));
> 
>          if (s && (bind == STB_GLOBAL || bind == STB_WEAK))
>                  s->is_static = 0;
> }

This works. However, I thought it will be too costly to call find_symbol 
on each symbol. Hence, 'type == STT_OBJECT || type == STT_FUNC || type 
== STT_NOTYPE' is a small performance optimization because we need to 
check only variables and functions. Is it worth to remove it in v4?

Denis
