Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F19BC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E0120868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555401219;
	bh=ONqeZcRHRT/O4g4lf7ZcpK42MxCIqizXMac+tt9gYaY=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=uAIwa56Mxhpv39LGoccmlmSWtyofEBz87tjBuswyD8JyNd8SR2osW22zFLYl1xACu
	 iYeFAtYoRX6LnxMmj5dzsmq5VQmi7PyYTzGKKIS7yEnc9mBq80JjTiM5XS48JQaC+g
	 TfGFGBKgT+TFqgHIgdXRZ6ZJlsb91vbZK5mO+1xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfDPHxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 03:53:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726837AbfDPHxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 03:53:37 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A70F2073F;
        Tue, 16 Apr 2019 07:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555401216;
        bh=ONqeZcRHRT/O4g4lf7ZcpK42MxCIqizXMac+tt9gYaY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=FBg4Q0pIZL9TzwGBeYNIsctEvSg9Xx1zDVoIJ8BBPSImdhijx5iyU5zfnuznvWNaW
         GgsIOlz1u2GnfLehgDY/RZ4KUFg838OqNk+mpm0X3nkfHreLYfzrN4t//RYhmSTgIi
         yM2b4pHeeElMHPiKlio78LPNCpf28uUgF10x+Ogs=
Date:   Tue, 16 Apr 2019 09:53:29 +0200 (CEST)
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Steven Price <steven.price@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH v2 0/5] cpu/speculation: Add 'mitigations=' cmdline
 option
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.1904160952410.9803@cbobk.fhfr.pm>
References: <cover.1555085500.git.jpoimboe@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Apr 2019, Josh Poimboeuf wrote:

> v2:
> - docs improvements: [Randy, Michael]
> - Rename to "mitigations=" [Michael]
> - Add cpu_mitigations_off() function wrapper [Michael]
> - x86: Simplify logic [Boris]
> - powerpc: Fix no_rfi_flush checking bug (use '&&' instead of '||')
> - arm64: Rebase onto Jeremy Linton's v7 patches [Will]
> - arm64: "kpti command line option" [Steve P]
> - arm64: Add nospectre_v2 support
> 
> -----------
> 
> Keeping track of the number of mitigations for all the CPU speculation
> bugs has become overwhelming for many users.  It's getting more and more
> complicated to decide which mitigations are needed for a given
> architecture.  Complicating matters is the fact that each arch tends to
> have its own custom way to mitigate the same vulnerability.
> 
> Most users fall into a few basic categories:
> 
> a) they want all mitigations off;
> 
> b) they want all reasonable mitigations on, with SMT enabled even if
>    it's vulnerable; or
> 
> c) they want all reasonable mitigations on, with SMT disabled if
>    vulnerable.
> 
> Define a set of curated, arch-independent options, each of which is an
> aggregation of existing options:
> 
> - mitigations=off: Disable all mitigations.
> 
> - mitigations=auto: [default] Enable all the default mitigations, but
>   leave SMT enabled, even if it's vulnerable.
> 
> - mitigations=auto,nosmt: Enable all the default mitigations, disabling
>   SMT if needed by a mitigation.
> 
> Josh Poimboeuf (5):
>   cpu/speculation: Add 'mitigations=' cmdline option
>   x86/speculation: Support 'mitigations=' cmdline option
>   powerpc/speculation: Support 'mitigations=' cmdline option
>   s390/speculation: Support 'mitigations=' cmdline option
>   arm64/speculation: Support 'mitigations=' cmdline option

Tested-by: Jiri Kosina <jkosina@suse.cz> (on x86)
Reviewed-by: Jiri Kosina <jkosina@suse.cz>

Thanks,

-- 
Jiri Kosina
SUSE Labs

