Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8038BC43215
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468A2217D6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 10:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575023071;
	bh=VjBbZ2snQPvCylKfggADmKtB7KOQ00A+5qv/wamd9BI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NVZJaowKE2dSHDy7+jLHOdwhUK/jdRaAdqTGtbTG2trJM/089aTkdZRvYsuNlacqN
	 C3mDBE9noHvx29rJViOF4CmVveXO82cEvm2KprlYAVdxIVrs/nt/1/j0wGtvFboUMX
	 zaWEmVOBSNY3b4eVpPuT5VqYlhafVa9Ibi9y7kYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbfK2KYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 05:24:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:44364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbfK2KYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 05:24:30 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38D1217BA;
        Fri, 29 Nov 2019 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575023069;
        bh=VjBbZ2snQPvCylKfggADmKtB7KOQ00A+5qv/wamd9BI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A4mBF7y2wubx7yJLQJsBFt9G/OPUtUbvyriYy4NmNtpOcIW5tUWsocV7wrA6Qy6Yg
         3mi8RQParNjCdNLFd657ThNyEh4bsWQdhJfSj1BiTydE+qZyhntU/td0YP4Bqj+eB+
         uiO666YGv0W1qJbb7nUGBFd5tsauyVwdATlruN1g=
Date:   Fri, 29 Nov 2019 10:24:22 +0000
From:   Will Deacon <will@kernel.org>
To:     Bhupesh Sharma <bhsharma@redhat.com>
Cc:     linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        x86@kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kexec@lists.infradead.org, Boris Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Dave Anderson <anderson@redhat.com>,
        Kazuhito Hagio <k-hagio@ab.jp.nec.com>
Subject: Re: [PATCH v5 0/5] Append new variables to vmcoreinfo (TCR_EL1.T1SZ
 for arm64 and MAX_PHYSMEM_BITS for all archs)
Message-ID: <20191129102421.GA28322@willie-the-truck>
References: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574972621-25750-1-git-send-email-bhsharma@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 01:53:36AM +0530, Bhupesh Sharma wrote:
> Changes since v4:
> ----------------
> - v4 can be seen here:
>   http://lists.infradead.org/pipermail/kexec/2019-November/023961.html
> - Addressed comments from Dave and added patches for documenting
>   new variables appended to vmcoreinfo documentation.
> - Added testing report shared by Akashi for PATCH 2/5.

Please can you fix your mail setup? The last two times you've sent this
series it seems to get split into two threads, which is really hard to
track in my inbox:

First thread:

https://lore.kernel.org/lkml/1574972621-25750-1-git-send-email-bhsharma@redhat.com/

Second thread:

https://lore.kernel.org/lkml/1574972716-25858-1-git-send-email-bhsharma@redhat.com/

Thanks,

Will
