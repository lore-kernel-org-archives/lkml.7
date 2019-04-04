Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D76C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150AF20855
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfDDUdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:33:01 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38472 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDUdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:33:00 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so4920940qth.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qd5Qz/L4RJIuJje79jaJ+hi5IZTEPZF8lGl4Vo7whcI=;
        b=jfgeUxgmrbti1Pep2R6RIz4A82sP0TcmXU0ZDhH6c2OH0iYq5rypR4FWdpqeXY4ivj
         SEAsLptJTAx0ePE47geLqh9z1evX4bFiPqzy5itt4Ibg/tHqAXSUWqKxDO3pNt0FJnne
         HMJ4mHLUYw0ws4/xIkR/VLU2Sp84AFeovHBaWmTmQaWqCrIeDk4pLrXMzjkSo7zMBMyo
         y+K1kO4Gf+QGRO3wHPLcc7Zi9ii6GYQ+A62IIZETWP6I9gR7ubUTNSyDVJ+nWsH5U2Cw
         n24pq3pftgHueFXZA4vgiogSDh2Q18y+5/7LLu3MO39SzUPkKahC4K8r3ydNABC/N1dJ
         rCHg==
X-Gm-Message-State: APjAAAXOqc1nwN9IgTyG5Tq4I57K8V+uwFL8sOJrulPHSmMGK0/TRZ1n
        ZaOp2SG56elBLcJB6Xz1XyQeTw==
X-Google-Smtp-Source: APXvYqxkdWCyIk/+1hwOj5L7QQRjswNBbhZSUIYy6gVZ+4QvcQFEPvbC0UESfqaSKofuVjOY1nQOBw==
X-Received: by 2002:ac8:14c:: with SMTP id f12mr7739066qtg.138.1554409979358;
        Thu, 04 Apr 2019 13:32:59 -0700 (PDT)
Received: from [10.150.73.190] (214.sub-174-240-132.myvzw.com. [174.240.132.214])
        by smtp.gmail.com with ESMTPSA id o50sm12943268qtc.23.2019.04.04.13.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:32:58 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Florian Weimer <fweimer@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Paul Burton <paul.burton@mips.com>,
        Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, carlos <carlos@redhat.com>,
        Joseph Myers <joseph@codesourcery.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ben Maurer <bmaurer@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Rich Felker <dalias@libc.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api <linux-api@vger.kernel.org>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com>
 <20190212194253.1951-2-mathieu.desnoyers@efficios.com>
 <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <87lg0tosfz.fsf@concordia.ellerman.id.au>
 <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
Date:   Thu, 4 Apr 2019 16:32:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/19 3:08 AM, Florian Weimer wrote:
> * Michael Ellerman:
> 
>> I'm a bit vague on what we're trying to do here.
>>
>> But it seems like you want some sort of "eye catcher" prior to the branch?
>>
>> That value is a valid instruction on current CPUs (rlwimi.
>> r5,r24,6,1,9), and even if it wasn't it could become one in future.
>>
>> If you change it to 0x8053530 that is both a valid instruction and is a
>> nop (conditional trap immediate but with no conditions set).
> 
> I think we need something that is very unlikely to appear in the
> instruction stream.  It's just a marker.  The instruction will never be
> executed, and it does not have to be a trap, either (I believe that a
> standard trap instruction would be a bad choice).

I assume you want to avoid a standard trap instruction because it would
be common, and so not meet the intent of the RSEQ_SIG choice as being something
that is *uncommon* right?

It is valuable that it be a trap, particularly for constant pools because
it means that a jump into the constant pool will trap.

-- 
Cheers,
Carlos.
