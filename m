Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65570C4646B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38EEF208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 03:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QLjtyp+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbfFZDno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 23:43:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34047 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbfFZDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 23:43:42 -0400
Received: by mail-pf1-f196.google.com with SMTP id c85so559915pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5hqZ4vROmwNjHn2rcOKub7XQRl/pvhv83x39qcRNpmY=;
        b=QLjtyp+Iq8FVK2eS5UBbAthW5GOnTsB32WgPl0ymEHCSX2OBegv15pR8TZPeaP1d6o
         1ALJim7p9CP7xwoLy0D+KXqJth22dqOto5ltKoe+cDKPe6+7Q0x2Zg1x7JDRqbXhNUh4
         FrybgwZkZ8eyZ0d1rBImQnUT6SaVDklElxNuivxU3MUqhg5fe+W4fubx6ZLJCag14kv1
         98QsyQ/56bimMYbT0AbQfMajElpS2mKIoz2WdMqcYVgRlk1A7yie4vxr770+MLqQXlot
         wXM3lG3qdVAVsSVAU6U2tugOSJBzNrwFjJUCoZdzzdPjoxdBtAwGEnJmbHPF+LxMSimt
         OatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hqZ4vROmwNjHn2rcOKub7XQRl/pvhv83x39qcRNpmY=;
        b=gEkwJ6EpwVqhDAW2fOwYZlGy9a7Vw7Jj/yy03gqGQ2ff60/X2rCKWfOFjgVQWUN3Lw
         sWGBQy5KPKRu2ww0cOzJ8N7dwxyyOqq090COfA5EYEXFJ9COyEH6MRiqq8uOVq3UJnEE
         ob4OrPb2NQKn/MemeGE6tGmobaMFe/vC08tv+u8sciXbCJVRg+xiT4LI+s1YcT/SJAbu
         5ccNtM5SFiH31L9BmFPtptAlt39Ok/56IW+GfCZ5RqEiMU1bI6dtIfJkX/HtYs6ocP4y
         wsnkO+bCCziX9MmM6NnAzokq2/GrOguIpGSTk6ucPOhZQKQVmco/pPy4Pcn+SXa86zXJ
         wCZw==
X-Gm-Message-State: APjAAAXnBE+Ld1cVZSQBfpUu8fLxIRGewY6iCN6UZ10PGYZGytcJkEKW
        /Y2kwlowwtgdJE22EafqErxWOR/L
X-Google-Smtp-Source: APXvYqwGEWjAY4ufSwDooxQon0wAjogh6V87TXfJND3yAh/V5zUOO7nDcshgpaqVtlnG3j9uxrR6+Q==
X-Received: by 2002:a17:90a:950d:: with SMTP id t13mr1752593pjo.81.1561520621522;
        Tue, 25 Jun 2019 20:43:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f10sm13298825pgo.14.2019.06.25.20.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 20:43:40 -0700 (PDT)
Subject: Re: Steam is broken on new kernels
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Eric Dumazet <edumazet@google.com>,
        lkml <linux-kernel@vger.kernel.org>
References: <a624ec85-ea21-c72e-f997-06273d9b9f9e@valvesoftware.com>
 <20190621214139.GA31034@kroah.com>
 <CAHk-=wgXoBMWdBahuQR9e75ri6oeVBBjoVEnk0rN1QXfSKK2Eg@mail.gmail.com>
 <CANn89iL5+x3n9H9v4O6y39W=jvQs=uuXbzOvN5mBbcj0t+wdeg@mail.gmail.com>
 <CAHk-=wjZ=8VSjWuqeG6JJv4dQfK6M0Jgckq5-6=SJa25aku-vQ@mail.gmail.com>
 <CANn89iLU+NNy7QDPNLYPxNWMx5cXuhziOT7TX2uYt42uUJcNVg@mail.gmail.com>
 <b72599d1-b5d5-1c23-15fc-8e2f9454af05@valvesoftware.com>
 <CAHk-=wjZ1grLwJsGD+Fjz1_U_W47AFodBiwBX84HECUHt-guuw@mail.gmail.com>
 <20190622073753.GA10516@kroah.com> <20190626020220.GA22548@roeck-us.net>
 <20190626022923.GA14595@kroah.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <53b23451-f45b-932d-a2f8-15f74f07a849@roeck-us.net>
Date:   Tue, 25 Jun 2019 20:43:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626022923.GA14595@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/19 7:29 PM, Greg Kroah-Hartman wrote:
> On Tue, Jun 25, 2019 at 07:02:20PM -0700, Guenter Roeck wrote:
>> Hi Greg,
>>
>> On Sat, Jun 22, 2019 at 09:37:53AM +0200, Greg Kroah-Hartman wrote:
>>> On Fri, Jun 21, 2019 at 10:28:21PM -0700, Linus Torvalds wrote:
>>>> On Fri, Jun 21, 2019 at 6:03 PM Pierre-Loup A. Griffais
>>>> <pgriffais@valvesoftware.com> wrote:
>>>>>
>>>>> I applied Eric's path to the tip of the branch and ran that kernel and
>>>>> the bug didn't occur through several logout / login cycles, so things
>>>>> look good at first glance. I'll keep running that kernel and report back
>>>>> if anything crops up in the future, but I believe we're good, beyond
>>>>> getting distros to ship this additional fix.
>>>>
>>>> Good. It's now in my tree, so we can get it quickly into stable and
>>>> then quickly to distributions.
>>>>
>>>> Greg, it's commit b6653b3629e5 ("tcp: refine memory limit test in
>>>> tcp_fragment()"), and I'm building it right now and I'll push it out
>>>> in a couple of minutes assuming nothing odd is going on.
>>>
>>> This looks good for 4.19 and 5.1, so I'll push out new stable kernels in
>>> a bit for them.
>>>
>>> But for 4.14 and older, we don't have the "hint" to know this is an
>>> outbound going packet and not to apply these checks at that point in
>>> time, so this patch doesn't work.
>>>
>>> I'll see if I can figure anything else later this afternoon for those
>>> kernels...
>>>
>>
>> I may have missed it, but I don't see a fix for the problem in
>> older stable branches. Any news ?
>>
>> One possibility might be be to apply the part of 75c119afe14f7 which
>> introduces TCP_FRAG_IN_WRITE_QUEUE and TCP_FRAG_IN_RTX_QUEUE, if that
>> is acceptable.
> 
> That's what people have already discussed on the stable mailing list a
> few hours ago, hopefully a patch shows up soon as I'm traveling at the
> moment and can't do it myself...
> 

Sounds good. Let me know if nothing shows up; I'll be happy to do it
if needed.

Guenter
