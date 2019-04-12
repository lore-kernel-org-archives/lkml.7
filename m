Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B68C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A40B20850
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDLQue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 12:50:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726624AbfDLQud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 12:50:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9822D330255;
        Fri, 12 Apr 2019 16:50:33 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-121-98.rdu2.redhat.com [10.10.121.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4875E60BEC;
        Fri, 12 Apr 2019 16:50:31 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com>
References: <CAHk-=wieBr3G=_ZGoCndi8XnuG1wtkedaGqkWB+=AVq65=_8sQ@mail.gmail.com> <5cae03c4.iIPk2cWlfmzP0Zgy%lkp@intel.com> <20190411193906.GA12232@hirez.programming.kicks-ass.net> <20190411195424.GL14281@hirez.programming.kicks-ass.net> <20190411211348.GA8451@worktop.programming.kicks-ass.net> <20190412105633.GM14281@hirez.programming.kicks-ass.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dhowells@redhat.com, Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>, LKP <lkp@01.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nadav Amit <namit@vmware.com>
Subject: Re: 1808d65b55 ("asm-generic/tlb: Remove arch_tlb*_mmu()"): BUG: KASAN: stack-out-of-bounds in __change_page_attr_set_clr
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5889.1555087830.1@warthog.procyon.org.uk>
Date:   Fri, 12 Apr 2019 17:50:30 +0100
Message-ID: <5890.1555087830@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Fri, 12 Apr 2019 16:50:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> We should never have stack alignment bigger than 16 bytes.  And
> preferably not even that.

At least one arch I know of (FRV) had instructions that could atomically
load/store register pairs or register quads, but they had to be pair- or
quad-aligned (ie. 8- or 16-byte), which made for more efficient code if you
could use them.

I don't know whether any arch we currently support has features like this (I
know some have multi-reg load/stores, but they seem to require only
word-alignment).

David
