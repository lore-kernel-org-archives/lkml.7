Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BC6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0E712082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554407355;
	bh=rbB/d1HoDWLb0C/C4Qg8TRWaUl3+wjPa3bCsuL99K7E=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=qzlkaiO/cVdq5RCBXHZX68k540YMfi3k6R50hx4MqNW4ZRd0l4qxvL5J6ZZZC1anD
	 7Zcz95E4EStXF6u3kDOjqfUkUihmuyu8zgjxtKzFhwX7y8agtUnVL5qtW6ylIKtE2R
	 cZ8jaa4iiP3cBEbI9ToCbecMT5i/pvxzHjdKQFRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbfDDTtN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:49:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729714AbfDDTtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:49:13 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB69F20652;
        Thu,  4 Apr 2019 19:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554407352;
        bh=rbB/d1HoDWLb0C/C4Qg8TRWaUl3+wjPa3bCsuL99K7E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=jtp39WqcWCOuEHOKDrA7A+4wNaB10zupBqoWZNpwLXEL4OA1JZieKHWPvNYhzlyQN
         U2QKlw5xNA4ER51gwkjJsjjtwTsfAzyvk/KWYV8tR22Y0DTvLZ9LDnSQuE1JXLRNlV
         tWCpqb4qtv2CJaulaNZPnInCoyoFTbF7Rbg+wQ2c=
Date:   Thu, 4 Apr 2019 21:49:05 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jon Masters <jcm@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tyler Hicks <tyhicks@canonical.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
In-Reply-To: <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.1904042145590.9803@cbobk.fhfr.pm>
References: <cover.1554396090.git.jpoimboe@redhat.com> <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2019, Josh Poimboeuf wrote:

> Configure powerpc CPU runtime speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
[ ... snip ... ]
> -	if (!no_nospec)
> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)

'!no_nospec' is something that I am sure will come back to hunt me in my 
bad dreams.

But that's been there already, and fixing it is out of scope of this 
patch. Other than that, as discussed previously -- I really like this new 
global option. Feel free to add

	Reviewed-by: Jiri Kosina <jkosina@suse.cz>

for the whole set.

Thanks,

-- 
Jiri Kosina
SUSE Labs

