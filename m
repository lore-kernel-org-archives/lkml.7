Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9CBC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA2B52082E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567699953;
	bh=eXl4eYahB1aGqdIO4XlYgDiYZoYYX53kWxQSYsX4y4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=O/RZO+7TpwqsZ2kWDb1w+C7OR4Mmmb5DQYCZQchCVzTUHU420C1/HXmxkARjif6KK
	 OZ/UX4SU9Ap18qWBJPztOQ1YyP6Yqu4w6gA6i/ey8TYFdkwUqf/EJB9k2cqsVYwPUY
	 n6VkCqATTjZEavAsZTLsXCcsbJzdg279XXeRhSR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729908AbfIEQMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 12:12:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:43028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727014AbfIEQMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 12:12:31 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EFB020825;
        Thu,  5 Sep 2019 16:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567699951;
        bh=eXl4eYahB1aGqdIO4XlYgDiYZoYYX53kWxQSYsX4y4o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WdNZI6L1F1Du6+UD+3leGaA/lnP9ad/3lg9we5IJuUO2tiN4Z27EO2vzYCN/Gtacx
         OyyGH0jl8gQLo8kAo/0f6HjvEEJZVOXdm3oSJovUZyDY0mQHas+CsQnrwTVl/dlC7I
         JweZK5XSEhINZiNuF89OBJP6yMEFk6/pBn/BgqH8=
Date:   Fri, 6 Sep 2019 01:12:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        <xen-devel@lists.xenproject.org>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
Subject: Re: [Xen-devel] [PATCH -tip 0/2] x86: Prohibit kprobes on
 XEN_EMULATE_PREFIX
Message-Id: <20190906011226.f5e8f3d69c6cc8254f97ae7c@kernel.org>
In-Reply-To: <1d868c99-58c5-1bbd-e6a4-2003dd319b5b@citrix.com>
References: <156759754770.24473.11832897710080799131.stgit@devnote2>
        <ad6431be-c86e-5ed5-518a-d1e9d1959e80@citrix.com>
        <20190905104937.60aa03f699a9c0fbf1b651b9@kernel.org>
        <1372ce73-e2d8-6144-57df-a98429587826@citrix.com>
        <20190905203224.e41d7f3dfbf918c5031f9766@kernel.org>
        <20190905220958.d0189e1e253f9e553b880675@kernel.org>
        <1d868c99-58c5-1bbd-e6a4-2003dd319b5b@citrix.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 14:31:56 +0100
Andrew Cooper <andrew.cooper3@citrix.com> wrote:

> >>> The KVM version was added in c/s 6c86eedc206dd1f9d37a2796faa8e6f2278215d2
> > Hmm, I think I might misunderstand what the "emulate prefix"... that is not
> > a prefix which replace actual prefix, but just works like an escape sequence.
> > Thus the next instruction can have any x86 prefix, correct?
> 
> There is a bit of history here :)
> 
> Originally, 13 years ago, Xen invented the "Force Emulate Prefix", which
> was the sequence:
> 
> ud2a; .ascii 'xen'; cpuid
> 
> which hit the #UD handler and was recognised as a request for
> virtualised CPUID information.  This was for ring-deprivileged
> virtualisation, and is needed because the CPUID instruction itself
> doesn't trap to the hypervisor.
> 
> Following some security issues in our instruction emulator, I reused
> this prefix with VT-x/SVM guests for testing purposes.  It behaves in a
> similar manner - when enabled, it is recognised in #UD exception
> intercept, and causes Xen to add 5 to the instruction pointer, then
> emulate the instruction starting there.
> 
> Then various folk thought that having the same kind of ability to test
> KVM's instruction emulator would be a good idea, so they borrowed the idea.
> 
> From a behaviour point of view, it is an opaque 5 bytes which means
> "break into the hypervisor, then emulate the following instruction".
> 
> The name "prefix" is unfortunate.  It was named thusly because from the
> programmers point of view, it was something you put before the CPUID
> instruction which wanted to be emulated.  It is not related to x86
> instruction concept of a prefix.

OK, then we should not use the insn->prefixes for those escape sequences.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
