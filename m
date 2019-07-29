Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E445C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D9206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 17:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbfG2Rcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 13:32:45 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:53921 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbfG2Rco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 13:32:44 -0400
Received: by mail-wm1-f53.google.com with SMTP id x15so54624212wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 10:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7HtRXlu8gLMjmdEPvaN8cA83YotUWNPBua50ykhl1as=;
        b=A65QqXNSZ3dJ5JF+Vht/NnUrKphnY607BTQmX0zceoxAcXp7QhBKz/DV7QTst3ytVx
         /H4u46pUlGqB6CFcuQIE7ITlMgSwddPu7hwoXufb/tBgg1nz3CoLTCaAMivyKh+fERZ+
         MGBpjOr0FFSzmd/8ctBO+RUgAOaChMeKtnG7tkRkJdcid0YhyDjUHfK9+8XKoFbGGPwp
         hgxaJ4gUGT5bF1xoH4aPADNbnY+d/SCm4AWfQzi1spTa8mqn458dkge0QnD+h95dH563
         lL26ZI4xyH25Jj598CRtWpP6GYsnOz1ivYNu8aRV3AzB+FflWlgRO3UtrotMz66brcfZ
         tDrA==
X-Gm-Message-State: APjAAAXKGgXLKYFp5cBKK+3bqzXFkhCibjdKqDlcIfLA9t2dp8MMeZWE
        wbkplg5BQ8uDVWSPrRcn0AfmaA==
X-Google-Smtp-Source: APXvYqyQa3kYTSQWS/BcXsNm1KJQXcbT9e4AFH5fZzlj6Rb0limYVCm41jejT/v1Mtw2we7gPPNGyA==
X-Received: by 2002:a1c:b707:: with SMTP id h7mr98962564wmf.45.1564421562548;
        Mon, 29 Jul 2019 10:32:42 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b8sm79772886wmh.46.2019.07.29.10.32.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 10:32:41 -0700 (PDT)
Subject: Re: [patch 11/12] hrtimer: Prepare support for PREEMPT_RT
To:     Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
References: <20190726183048.982726647@linutronix.de>
 <20190726185753.737767218@linutronix.de>
 <42299f02-ff29-f7e3-45f0-b9fef041aec9@suse.com>
 <20190729110806.57c57399@gandalf.local.home>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <9a9bde89-e0b3-a7b9-749e-a6b35d74b729@redhat.com>
Date:   Mon, 29 Jul 2019 19:30:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729110806.57c57399@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/07/19 17:08, Steven Rostedt wrote:
> On Sun, 28 Jul 2019 11:06:50 +0200
> Juergen Gross <jgross@suse.com> wrote:
> 
>> In case we'd want to change that I'd rather not special case timers, but
>> apply a more general solution to the quite large amount of similar
>> cases: I assume the majority of cpu_relax() uses are affected, so adding
>> a paravirt op cpu_relax() might be appropriate.
>>
>> That could be put under CONFIG_PARAVIRT_SPINLOCK. If called in a guest
>> it could ask the hypervisor to give up the physical cpu voluntarily
>> (in Xen this would be a "yield" hypercall).
> 
> Seems paravirt wants our cpu_chill() ;-)

Actually that is not really a joke! :)

Paolo

