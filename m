Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CD0C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FD8520870
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 11:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbfDALIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 07:08:39 -0400
Received: from ozlabs.org ([203.11.71.1]:53017 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725882AbfDALIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 07:08:38 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 44XqMj2fSxz9sQr;
        Mon,  1 Apr 2019 22:08:31 +1100 (AEDT)
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Andrey Abramov <st5pub@yandex.ru>, vgupta <vgupta@synopsys.com>,
        benh <benh@kernel.crashing.org>, paulus <paulus@samba.org>,
        tglx <tglx@linutronix.de>, mingo <mingo@redhat.com>,
        bp <bp@alien8.de>, hpa <hpa@zytor.com>, x86 <x86@kernel.org>,
        mark <mark@fasheh.com>, jlbec <jlbec@evilplan.org>,
        richard <richard@nod.at>, dedekind1 <dedekind1@gmail.com>,
        "adrian.hunter" <adrian.hunter@intel.com>,
        gregkh <gregkh@linuxfoundation.org>,
        "naveen.n.rao" <naveen.n.rao@linux.vnet.ibm.com>,
        jpoimboe <jpoimboe@redhat.com>,
        Dave Chinner <dchinner@redhat.com>,
        "darrick.wong" <darrick.wong@oracle.com>,
        "ard.biesheuvel" <ard.biesheuvel@linaro.org>,
        George Spelvin <lkml@sdf.org>,
        linux-snps-arc <linux-snps-arc@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        ocfs2-devel <ocfs2-devel@oss.oracle.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        sfr <sfr@canb.auug.org.au>
Cc:     malat <malat@debian.org>, npiggin <npiggin@gmail.com>,
        "yamada.masahiro" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v2 2/5] powerpc: module_[32|64].c: replace swap function with built-in one
In-Reply-To: <14019281554057359@sas1-87f9feb8d943.qloud-c.yandex.net>
References: <19606671554056883@myt3-1179f584969c.qloud-c.yandex.net> <14019281554057359@sas1-87f9feb8d943.qloud-c.yandex.net>
Date:   Mon, 01 Apr 2019 22:08:30 +1100
Message-ID: <87v9zyoudt.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrey Abramov <st5pub@yandex.ru> writes:
> Replace relaswap with built-in one, because relaswap
> does a simple byte to byte swap.

I replied to v1 with an ack, which stands, this is just a clarification.

> Since Spectre mitigations have made indirect function calls more
> expensive, and the default simple byte copies swap is implemented
> without them, an "optimized" custom swap function is now
> a waste of time as well as code.

Spectre mitigations don't necessarily slow down indirect function calls
on all arches or in all configurations on all arches, so that
justification is a bit dubious.

That's not really a problem for this patch, because the existing
overhead of the function call is probably already enough to rival the
cost of the 24 byte copy.

cheers
