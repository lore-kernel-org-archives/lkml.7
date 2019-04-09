Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1336AC10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6552077C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfDIONJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:13:09 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:37697 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfDIONJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:13:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id c1so10325095qkk.4
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2019 07:13:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qse3lIjHnAdp0MsaCR/DWm8tkjHE1e9e9GWKcNGJq+E=;
        b=hD3ckP+Qisa79FNlVQuwRaISnNzc/bqws08poCglcepPpEyTU2/GHiygNSMudEUjBv
         8TeCohB0dJfoyaD369pAmDTrf10uMZfWCAvdtFKEzKijlnZ6wETbHAWsmMyTAMaeJhbS
         DxCHyCeoylJ2XfhsS27ZQ7LGoEhL+6jImbwJo47alfJHexcBXSE2rp8GDB5c9gomL7EG
         yDoij5+xj7L3cv7+zUAnKguXQIpTd6u/wgPTHtPCJvUa/eeRAT/8L0pH4YVAU+Izwrdz
         E17Y9AbYirs8aJwuOuL1CAsLYVrFMK9OUMUVBZ6tXhq8vRS5oXVs6scnN+JAdakMa6Qs
         6dTA==
X-Gm-Message-State: APjAAAU7t/tYwD6vVqCHPl3ywB5Mcbr5zQHelHeFefU2Gs93xg0QQnOC
        BVn7gA1T3GBkePi0o2JKpXYoGg==
X-Google-Smtp-Source: APXvYqyHgtkWwuzUlvZvfhNR4XcyaRHBVYf4facOVUEj9VRCTdaMUYRS6koMW47JSG3XW8uI1b2Xwg==
X-Received: by 2002:a37:de16:: with SMTP id h22mr27541736qkj.306.1554819188345;
        Tue, 09 Apr 2019 07:13:08 -0700 (PDT)
Received: from [10.150.73.190] (109.sub-174-235-139.myvzw.com. [174.235.139.109])
        by smtp.gmail.com with ESMTPSA id w68sm15607734qka.18.2019.04.09.07.13.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Apr 2019 07:13:07 -0700 (PDT)
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and
 thread creation (v7)
To:     Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>,
        Alan Modra <amodra@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
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
References: <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com>
 <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com>
 <87lg0tosfz.fsf@concordia.ellerman.id.au>
 <87pnq4zxyj.fsf@oldenburg2.str.redhat.com>
 <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com>
 <87y34o4xt3.fsf@oldenburg2.str.redhat.com>
 <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
 <877ec4pam2.fsf@linux.ibm.com>
 <ce9fbc66-5eb9-0fa9-99fa-5abfe00ddfc2@redhat.com>
 <877ec3yffq.fsf@concordia.ellerman.id.au>
 <20190409092948.GA14424@bubble.grove.modra.org>
 <871s2bp9f9.fsf@linux.ibm.com>
From:   Carlos O'Donell <codonell@redhat.com>
Message-ID: <86030de9-862d-3ef5-d372-1695af3c8204@redhat.com>
Date:   Tue, 9 Apr 2019 10:13:03 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <871s2bp9f9.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/19 9:58 AM, Tulio Magno Quites Machado Filho wrote:
> Alan Modra <amodra@gmail.com> writes:
>> Yes, looks fine to me, except that in VLE mode (do we care?)
>> ".long 0x0fe50553" disassembles as
>>     0:	0f e5       	se_cmphl r5,r30
>>     2:	05 53       	se_mullw r3,r5
>> No illegal/trap/privileged insn there.
>>
>> ".long 0x0fe5000b" might be better to cover VLE.
> 
> Looks good for me too.

The requirement that it be a valid instruction is simply to aid in the
disassembly of rseq regions which may be hand written assembly with a
thin veneer of CFI/DWARF information.

It has already been pointed out that POWER uses data in the instruction
stream for jump tables to implement switch statements, but that specific
use has compiler support and one presumes good debug information. So as
Alan says, there is already data in the insn stream, though such things
can't be good for performance (pollutes D-cache, problematic for
speculative execution).

> Actually, it better fits what Carlos O'Donnell had requested:
> 
>>>> I think the order of preference is:
>>>>
>>>> 1.  An uncommon insn (with random immediate values), in a literal pool, that is
>>>>       not a useful ROP/JOP sequence (very uncommon)
>>>> 2a. A uncommon TRAP hopefully with some immediate data encoded (maybe uncommon)
>>>> 2b. A NOP to avoid affecting speculative execution (maybe uncommon)
>>>>
>>>> With 2a/2b being roughly equivalent depending on speculative execution policy.

Yes, though "in a literal pool" is something that is not required, since
users might not want literal pools and so we shouldn't require that
feature (it also pollutes D-cache).

Keep in mind the insn will never execute.

If a trap insn calls out the nature of the signature more clearly then
use that instead.

-- 
Cheers,
Carlos.
