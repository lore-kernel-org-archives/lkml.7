Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4346C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8904C2184E
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 12:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfDKMYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 08:24:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726517AbfDKMYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 08:24:15 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72C76883BA;
        Thu, 11 Apr 2019 12:24:15 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (ovpn-116-32.ams2.redhat.com [10.36.116.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0568819742;
        Thu, 11 Apr 2019 12:24:11 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Carlos O'Donell <carlos@redhat.com>
Subject: Re: rseq/arm32: choosing rseq code signature
References: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
Date:   Thu, 11 Apr 2019 14:24:10 +0200
In-Reply-To: <1050734985.2625.1554838340011.JavaMail.zimbra@efficios.com>
        (Mathieu Desnoyers's message of "Tue, 9 Apr 2019 15:32:20 -0400
        (EDT)")
Message-ID: <87pnpsd91x.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 11 Apr 2019 12:24:15 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

> /*
>  * TODO: document trap instruction objdump output on each sub-architecture
>  * instruction sets, as well as instruction set extensions.
>  */
> #define RSEQ_SIG 0x########

Will RSEQ_SIG actually be needed at run time outside the rseq
implementation library (whether it's glibc or something else)?

Actually rseq users will emit the signature directly into the text
section, right?  They never have to load it into a register, I assume.

My concern is that on some architectures, the very act of referencing
RSEQ_SIG will put it into the text section, as a non-instruction, which
is not what we want.

Thanks,
Florian
