Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AD8C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC45020879
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 19:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ascii.art.br header.i=@ascii.art.br header.b="Et90Vecb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbfDHTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:21:14 -0400
Received: from bonobo.maple.relay.mailchannels.net ([23.83.214.22]:9739 "EHLO
        bonobo.maple.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726633AbfDHTVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 15:21:14 -0400
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id BAFE82C2743;
        Mon,  8 Apr 2019 19:21:12 +0000 (UTC)
Received: from pdx1-sub0-mail-a5.g.dreamhost.com (100-96-6-122.trex.outbound.svc.cluster.local [100.96.6.122])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 30AE82C2CB6;
        Mon,  8 Apr 2019 19:21:11 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|tuliom@ascii.art.br
Received: from pdx1-sub0-mail-a5.g.dreamhost.com ([TEMPUNAVAIL].
 [64.90.62.162])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.17.2);
        Mon, 08 Apr 2019 19:21:12 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|tuliom@ascii.art.br
X-MailChannels-Auth-Id: dreamhost
X-Decisive-Ski: 0e563a0e7da5864e_1554751272361_1713802298
X-MC-Loop-Signature: 1554751272361:2254281142
X-MC-Ingress-Time: 1554751272360
Received: from pdx1-sub0-mail-a5.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a5.g.dreamhost.com (Postfix) with ESMTP id 8D5A57FFA4;
        Mon,  8 Apr 2019 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=ascii.art.br; h=from:to:cc
        :cc:subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=ascii.art.br; bh=WZB7eDUpWJiplAY9t38748BmWlw=; b=
        Et90VecbyQqvcITL6oR9BMLlP4m7OJcf9K67/Qo6SsBr0cIYCiEcndT41DUtgiPG
        1bnobZonWeTo+Au5yDltEID71ugoLhlMUhu4fPuiW6h6IbqSULbIg/qolY83Jr8W
        XoYW6kChqE/haH+4e47qqSrR563WwvMX2yvky6HqEiA=
Received: from ascii.art.br (unknown [32.104.18.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tuliom@ascii.art.br)
        by pdx1-sub0-mail-a5.g.dreamhost.com (Postfix) with ESMTPSA id 9D5857FFA6;
        Mon,  8 Apr 2019 12:20:45 -0700 (PDT)
X-DH-BACKEND: pdx1-sub0-mail-a5
From:   Tulio Magno Quites Machado Filho <tuliom@ascii.art.br>
To:     Carlos O'Donell <codonell@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Michael Meissner <meissner@linux.ibm.com>,
        Alan Modra <amodra@gmail.com>,
        Peter Bergner <bergner@vnet.ibm.com>,
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
Subject: Re: [PATCH 1/4] glibc: Perform rseq(2) registration at C startup and thread creation (v7)
In-Reply-To: <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
References: <20190212194253.1951-1-mathieu.desnoyers@efficios.com> <20190212194253.1951-2-mathieu.desnoyers@efficios.com> <5166fbe9-cfe0-8554-abc7-4fc844cf2765@redhat.com> <1965431879.7576.1553529272844.JavaMail.zimbra@efficios.com> <87lg0tosfz.fsf@concordia.ellerman.id.au> <87pnq4zxyj.fsf@oldenburg2.str.redhat.com> <ce6f9db3-bf85-7aec-4bae-998e6fd629e1@redhat.com> <87y34o4xt3.fsf@oldenburg2.str.redhat.com> <43f97ddb-c8df-27ea-9517-63252ebd3183@redhat.com>
User-Agent: Notmuch/0.27 (http://notmuchmail.org) Emacs/25.3.1 (x86_64-redhat-linux-gnu)
Date:   Mon, 08 Apr 2019 16:20:37 -0300
Message-ID: <877ec4pam2.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-VR-OUT-STATUS: OK
X-VR-OUT-SCORE: -100
X-VR-OUT-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudefgddufeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuggftfghnshhusghstghrihgsvgdpffftgfetoffjqffuvfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufgjfhgffffkgggtsehttdertddtredtnecuhfhrohhmpefvuhhlihhoucforghgnhhoucfsuhhithgvshcuofgrtghhrgguohcuhfhilhhhohcuoehtuhhlihhomhesrghstghiihdrrghrthdrsghrqeenucfkphepfedvrddutdegrddukedrvddtvdenucfrrghrrghmpehmohguvgepshhmthhppdhhvghloheprghstghiihdrrghrthdrsghrpdhinhgvthepfedvrddutdegrddukedrvddtvddprhgvthhurhhnqdhprghthhepvfhulhhiohcuofgrghhnohcusfhuihhtvghsucforggthhgrughoucfhihhlhhhouceothhulhhiohhmsegrshgtihhirdgrrhhtrdgsrheqpdhmrghilhhfrhhomhepthhulhhiohhmsegrshgtihhirdgrrhhtrdgsrhdpnhhrtghpthhtoheplhhinhhugidqrghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos O'Donell <codonell@redhat.com> writes:

> On 4/5/19 5:16 AM, Florian Weimer wrote:
>> * Carlos O'Donell:
>>> It is valuable that it be a trap, particularly for constant pools because
>>> it means that a jump into the constant pool will trap.
>> 
>> Sorry, I don't understand why this matters in this context.  Would you
>> please elaborate?
>
> Sorry, I wasn't very clear.
>
> My point is only that any accidental jumps, either with off-by-one (like you
> fixed in gcc/glibc's signal unwinding most recently), result in a process fault
> rather than executing RSEQ_SIG as a valid instruction *and then* continuing
> onwards to the handler.
>
> A process fault is achieved either by a trap, or an invalid instruction, or
> a privileged insn (like suggested for MIPS in this thread).

In that case, mtmsr (Move to Machine State Register) seems a good candidate.

mtmsr is available both on 32 and 64 bits since their first implementations.

It's a privileged instruction and should never appear in userspace
code (causes SIGILL).

Any comments?

-- 
Tulio Magno
