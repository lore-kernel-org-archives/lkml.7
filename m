Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EF4C3A59E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEC220882
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 01:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567648185;
	bh=zo9ULV+hpAXsuDOpSM2OjIMnQQSkYg7lHRWUmgT2DiI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y2uA2A0DsqrFqYs5wPAkXhlyFEYudoQnztsnaJq1bhX/waxZH0OziDmKRl4XZrLks
	 l6z+1NXcqR6YPKXmoYQRx2n5t3Rf/HfzRot60bzPjZYnDkwwvg+dsP4FVPM5uVParU
	 BxpgvqCZlDdisX7We5iQgyYB+teecCN9/zLJhxN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbfIEBto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 21:49:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727156AbfIEBto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 21:49:44 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB0B20644;
        Thu,  5 Sep 2019 01:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567648183;
        bh=zo9ULV+hpAXsuDOpSM2OjIMnQQSkYg7lHRWUmgT2DiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Spbz7M6vwU7hElCNqtXo3bKV+4/MX5UPtIN8l2p64GEiBqZISlxfa5bc1OunLPkii
         bjeBNfoO6cFJ+tXKjrc3gwOfSyZt/cOnKZ4x/xtyWeGsP5iif9c19VeSAr71jIuM6U
         DBVkcDC04fNdgCH4YhXG55EE5a7IGmP7Qh4b0Q98=
Date:   Thu, 5 Sep 2019 10:49:37 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        <xen-devel@lists.xenproject.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH -tip 0/2] x86: Prohibit kprobes on
 XEN_EMULATE_PREFIX
Message-Id: <20190905104937.60aa03f699a9c0fbf1b651b9@kernel.org>
In-Reply-To: <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
        <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Sep 2019 12:54:55 +0100
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> On 04/09/2019 12:45, Masami Hiramatsu wrote:
> > Hi,
> >
> > These patches allow x86 instruction decoder to decode
> > xen-cpuid which has XEN_EMULATE_PREFIX, and prohibit
> > kprobes to probe on it.
> >
> > Josh reported that the objtool can not decode such special
> > prefixed instructions, and I found that we also have to
> > prohibit kprobes to probe on such instruction.
> >
> > This series can be applied on -tip master branch which
> > has merged Josh's objtool/perf sharing common x86 insn
> > decoder series.
> 
> The paravirtualised xen-cpuid is were you'll see it most in a regular
> kernel, but be aware that it is also used for testing purposes in other
> circumstances, and there is an equivalent KVM prefix which is used for
> KVM testing.

Good catch! I didn't notice that. Is that really same sequance or KVM uses
another sequence of instructions for KVM prefix?

> 
> It might be better to generalise the decode support to "virtualisation
> escape prefix" or something slightly more generic.

Agreed, it is easy to expand it, we can switch the prefix template.
Could you tell me where I should look? I will add it.

Thank you,


> 
> ~Andrew


-- 
Masami Hiramatsu <mhiramat@kernel.org>
