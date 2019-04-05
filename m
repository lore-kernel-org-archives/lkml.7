Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0750DC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D532175B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbfDEPkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:40:25 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41096 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:40:24 -0400
Received: by mail-qt1-f193.google.com with SMTP id w30so7862384qta.8
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dg22T3baDIhfCrRLPvN5DXD5MUJ7qj8e6W0LfPeHBFI=;
        b=TlhlqKWYHUPllvySCb9JLICkSMFQu1ZxFQNgiX6xEPTQN5n1nSG7XqMy6eFjXf3j/q
         0wZ+bHXn7lcmGBlfS8OT3wR4/O1xOCEbSv80h8IIB/vkMHq4HassbXAsBjrrRAzcHKoU
         UuYDMAzKwYQ/gf/qEOPNZdI7F9RvGd4Y9Fom3jkBwN66kmh3iAxLWT4kRbQlkEafmo48
         lAjzDiB1/xM/n9Bavyqd00Kjf5ZOtc3bdsobUF2m83ywgzwPABkq9njKB3Z5nWLqbP6a
         iqzdjnTJ3nDMFs441gxUq9CWg+1JQF7Io2BNzx30dJUSc7IfXilMiGEbyOrqtOiiEWEC
         OI6g==
X-Gm-Message-State: APjAAAUXP9kjEic2H8l5q5j/hf2jGBis129FAR8St3iZV8IzxTR8D+jn
        1udYxanzzRxdhTWzewpIkVnUzw==
X-Google-Smtp-Source: APXvYqw7+REQ0WAMBsllvENvMWZAaNd1dqJh1SUSpgQl/kq6RCWBPgB7N3oDIvNlP6khbao1n7zyRQ==
X-Received: by 2002:a0c:8738:: with SMTP id 53mr10612534qvh.210.1554478823762;
        Fri, 05 Apr 2019 08:40:23 -0700 (PDT)
Received: from [10.150.73.190] (214.sub-174-240-132.myvzw.com. [174.240.132.214])
        by smtp.gmail.com with ESMTPSA id g34sm15309819qtc.9.2019.04.05.08.40.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Apr 2019 08:40:22 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Florian Weimer <fweimer@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
 <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
Date:   Fri, 5 Apr 2019 11:40:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/5/19 5:16 AM, Florian Weimer wrote:
> * Carlos O'Donell:
>> It is valuable that it be a trap, particularly for constant pools because
>> it means that a jump into the constant pool will trap.
> 
> Sorry, I don't understand why this matters in this context.  Would you
> please elaborate?

Sorry, I wasn't very clear.

My point is only that any accidental jumps, either with off-by-one (like you
fixed in gcc/glibc's signal unwinding most recently), result in a process fault
rather than executing RSEQ_SIG as a valid instruction *and then* continuing
onwards to the handler.

A process fault is achieved either by a trap, or an invalid instruction, or
a privileged insn (like suggested for MIPS in this thread).

-- 
Cheers,
Carlos.
