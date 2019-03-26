Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE88C10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0AC20823
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 12:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553603405;
	bh=sQM5jiXixK+TRDZp1EAAOo+9HgawHweRTNi+g/sfHoc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s5glUZ0gXi3BBC2Mb+8wnzX1YV2xjAU/XqalPDY+CmNeWS+m9xw77hxsyjjZ/DPoE
	 45NL0TsmrPIARXVi1KwJlYWI0QjTh1IBuURExpSLILha7j64jFlCbTkfDSLXv41Qd6
	 Ba9Pz1L6JawYkUZAzNTpCQPcq7aguM4UK1jjBZKc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbfCZMaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 08:30:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbfCZMaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 08:30:03 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 541F32075E;
        Tue, 26 Mar 2019 12:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553603402;
        bh=sQM5jiXixK+TRDZp1EAAOo+9HgawHweRTNi+g/sfHoc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xhZC2++NWBiXNXmdSXrpYb1M0HosHFRHAsRrGl+eSqgsAOxJpxtO7GrXy7xTnJ8bv
         UJWKjcHU5xyzizH4d/CifKUT7Jmvm7rzMXa1DYFNfqHBdo7e6IL/TvGyaoIpqIkxVO
         btrP1dkjJOnp828VwDufoLIZ0enWzb8MeOdPLvFs=
Date:   Tue, 26 Mar 2019 21:29:57 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        davem@davemloft.net, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 22/27] Lock down kprobes
Message-Id: <20190326212957.f5b518990c14cf21262bfdcc@kernel.org>
In-Reply-To: <20190325220954.29054-23-matthewgarrett@google.com>
References: <20190325220954.29054-1-matthewgarrett@google.com>
        <20190325220954.29054-23-matthewgarrett@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 15:09:49 -0700
Matthew Garrett <matthewgarrett@google.com> wrote:

> From: David Howells <dhowells@redhat.com>
> 
> Disallow the creation of kprobes when the kernel is locked down by
> preventing their registration.  This prevents kprobes from being used to
> access kernel memory, either to make modifications or to steal crypto data.

Hmm, if you enforce signature check of modules, those modules
should be allowed to use kprobes?
I think we should introduce some kind of trust inheritance from
signed (trusted) modules.

Thank you,

> 
> Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Matthew Garrett <matthewgarrett@google.com>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
> Cc: davem@davemloft.net
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index f4ddfdd2d07e..6f66cca8e2c6 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1552,6 +1552,9 @@ int register_kprobe(struct kprobe *p)
>  	struct module *probed_mod;
>  	kprobe_opcode_t *addr;
>  
> +	if (kernel_is_locked_down("Use of kprobes"))
> +		return -EPERM;
> +
>  	/* Adjust probe address from symbol */
>  	addr = kprobe_addr(p);
>  	if (IS_ERR(addr))
> -- 
> 2.21.0.392.gf8f6787159e-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
