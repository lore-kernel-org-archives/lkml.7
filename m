Return-Path: <SRS0=8q5G=VR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF2CC76188
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 391642085A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jul 2019 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="nitR6D2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfGTOXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jul 2019 10:23:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34899 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbfGTOXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jul 2019 10:23:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id w24so17013814plp.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2019 07:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UqZBrRv2xf43dMebSY7ggTEIPQNkD7oY1J85gPXaZlI=;
        b=nitR6D2/AinbZMpmNM7NqHY/dIjxIIp41JObgwc8v1GhiOQ+38+7bEeTr8eatc5icu
         dKDclJBaFQEA7M66oj6rgCeV9V5oi11Tic5NuPRM/jhF45RMLnICNkAX3TXnkkC7XHA3
         tcIM+V5S/gcMPYom+9s2mM8w9KrCmAyziNMMYod2IL13L37TdBGTDCo2RUEzVYlIUhTY
         iBsOr0vtgmaY4bzToAk77kAqfyzZ95Gb5l/J2pyXIuehlubvAomJSIiGgUc7p4iiJdBo
         PIBmeRliE+vxCG3KvYfdpKE8XrilZiDcHlU8MsZ4vRdUsQufQjzwnQ1pDURksuwr3/k0
         H0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UqZBrRv2xf43dMebSY7ggTEIPQNkD7oY1J85gPXaZlI=;
        b=W3EyqYuDzozcsj6P9ZqfNWoSH3seaWs7jSqvYXJwa6DjXhOeH+tHa6OGSmsh4wJDDu
         tn9UaL6WcIdSEOfigj10BN1wtuROFiEe0SzVEMTwlqEHP6Fk/6bkCACrXaqx551Gc2vD
         N1aZGhmBOdpLoTPfY1XN/jwVIYInD0FrEljeD66pDNgdbtBkzuYR4+2khOTAy18Vh0/5
         mytEzP9F4E83APl3vWKbaRG2w9vHNHnFOoXQ+L+rhIrgNjAOaDVeBFn+00aiRyCjKuvd
         QnY2U7BjL/6YCE0cPNxC2Piip/NlT44TOUI6g0TZU1ULb5zD6EfkF9yWHfsHsK/enP9v
         CsXw==
X-Gm-Message-State: APjAAAXvF2lOhkUMSodJ5cCx7D5QhlGYUGtxfwHJqDvF/pAJCcfRdJ6j
        WEriVloyDU/NtcH7eeg7R70=
X-Google-Smtp-Source: APXvYqx2GLgYbLRHJB2hTR206nehq3djl55CUe8KG8g9txhpGuc7utVE8O7RsBeedKI5GUiZl3gmuw==
X-Received: by 2002:a17:902:7043:: with SMTP id h3mr34544437plt.10.1563632621930;
        Sat, 20 Jul 2019 07:23:41 -0700 (PDT)
Received: from Etsukata.local (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id s185sm44064923pgs.67.2019.07.20.07.23.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 07:23:41 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Tracing vs CR2
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux_lkml_grp@oracle.com, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        He Zhe <zhe.he@windriver.com>,
        Joel Fernandes <joel@joelfernandes.org>
References: <20190711114054.406765395@infradead.org>
 <4c71e14d-3a32-c3bb-8e3b-6e5100853192@oracle.com>
 <97cdd0af-95cc-2583-dc19-129b20809110@oracle.com>
 <d82854b2-d2a4-5b83-b4a4-796db0fd401b@etsukata.com>
 <CALCETrVH_F-OVQOsJ=KRGtNLQfM5QpSzP4UNn2RbLjP4ueeq-g@mail.gmail.com>
 <98e20ed8-4032-09b5-e852-9f21df5c237c@etsukata.com>
 <CALCETrUkEB89jkBzWg26Y0unCwgOWYT5da+OkbatUU_Bh97T8g@mail.gmail.com>
From:   Eiichi Tsukata <devel@etsukata.com>
Openpgp: preference=signencrypt
Autocrypt: addr=devel@etsukata.com; keydata=
 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
Message-ID: <009b1e7e-3278-6acb-40f7-cb5b1245a4ba@etsukata.com>
Date:   Sat, 20 Jul 2019 23:23:36 +0900
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUkEB89jkBzWg26Y0unCwgOWYT5da+OkbatUU_Bh97T8g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/07/20 21:49, Andy Lutomirski wrote:
> On Fri, Jul 19, 2019 at 8:59 PM Eiichi Tsukata <devel@etsukata.com> wrote:
>>
...
>>
>> ====
>>
>> debug() // dr6: 0xffff4ff0, user_mode: 1
>>   TRACE_IRQS_OFF
>>     arch_stack_user_walk()
>>       debug()  // dr6: 0xffff4ff1 == 0xffff4ff0 | 0xffff0ff1 ... (*)
>>         do_debug()
>>           WARN_ON_ONCE
>>   do_debug() // dr6: 0xffff0ff0(cleared in the above do_debug())
> 
> The dr6 register will indeed be cleared like this, but the dr6
> variable should still be 0xffff4ff0.

I should have use DR6 to mean it is a register, not variable.
"dr6" was ambiguous.

> 
>>
...
>>
>> Note: printk() in do_debug() can cause infinite loop(printk() ->
>> irq_disable() -> do_debug() -> printk() ...), so printk_deferred()
>> was preferable.
>>
> 
> Shouldn't that be fixed with my patches?  It should only be able to
> recurse two deep: do_debug() from user mode can indeed trip
> breakpoints, but the next do_debug() will clear DR7 in paranoid_entry.
> 

Sorry, I missed that. Now I confirmed your patches fixed the loop.

Thanks

Eiichi 


