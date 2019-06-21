Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B656C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2A20656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 05:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561094559;
	bh=NuBaidFvEBtC7ilPgjpukJjyDzHqtDpAv+g7vUem4L0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qnFLIMy3dJkzSFqmMpOeUAwc1Y8UVmQUxJwOU28R+3bBj2msQaqOi6lpQAQNiiqCm
	 pxj9gc50DjoQaZMYwZ/JLs1L8LsHNrMschwexsY2BpMBnML/NQaBfGYDBGI3q/0cC9
	 /9OC7NF4kIg1xpjUlsuQU9ab1Rd5PvrysLHKuL8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfFUFWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 01:22:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfFUFWg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 01:22:36 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90B7F214AF
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 05:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561094555;
        bh=NuBaidFvEBtC7ilPgjpukJjyDzHqtDpAv+g7vUem4L0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wHAqle4rYQtIgTUx0PgajIpQgVKMwYiszYWGnbwOGOPg3f8h0SxwonPpfRgqoNfGK
         xQeM96lmb2OBA0PM5sujPByl7Yu2MDplcbR8vGDNOnHiNd3rwfDyjwpvAMHW6TdhA+
         nqRfnXEPGM49QDf+f05/i8KCZ4T3qIfq70U1rkKo=
Received: by mail-wr1-f50.google.com with SMTP id n4so3996615wrs.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 22:22:35 -0700 (PDT)
X-Gm-Message-State: APjAAAXKeVPvo38ZsLC5S3ODkMJCV1b4eCNG2AXOKVcCJ3B5hRMnYcfV
        s8xkecjQO0WhOb8AZatIZphQoo7syjOQynjiAppO0A==
X-Google-Smtp-Source: APXvYqxNI6hTt7wfX1kpwI+fEFQ6wgbPiPAT/+6DNON5Il4mnboFbwtvmIjXpVXA3ghfnQeAd17VPzBRahUg/utphO4=
X-Received: by 2002:adf:cc85:: with SMTP id p5mr32554986wrj.47.1561094554094;
 Thu, 20 Jun 2019 22:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190621011941.186255-1-matthewgarrett@google.com> <20190621011941.186255-25-matthewgarrett@google.com>
In-Reply-To: <20190621011941.186255-25-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 20 Jun 2019 22:22:21 -0700
X-Gmail-Original-Message-ID: <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
Message-ID: <CALCETrVUwQP7roLnW6kFG80Cc5U6X_T6AW+BTAftLccYGp8+Ow@mail.gmail.com>
Subject: Re: [PATCH V33 24/30] bpf: Restrict bpf when kernel lockdown is in
 confidentiality mode
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>, linux-security@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matthew Garrett <mjg59@google.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2019 at 6:21 PM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: David Howells <dhowells@redhat.com>
>
> There are some bpf functions can be used to read kernel memory:
> bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> private keys in kernel memory (e.g. the hibernation image signing key) to
> be read by an eBPF program and kernel memory to be altered without
> restriction. Disable them if the kernel has been locked down in
> confidentiality mode.

This patch exemplifies why I don't like this approach:

> @@ -97,6 +97,7 @@ enum lockdown_reason {
>         LOCKDOWN_INTEGRITY_MAX,
>         LOCKDOWN_KCORE,
>         LOCKDOWN_KPROBES,
> +       LOCKDOWN_BPF,
>         LOCKDOWN_CONFIDENTIALITY_MAX,

> --- a/security/lockdown/lockdown.c
> +++ b/security/lockdown/lockdown.c
> @@ -33,6 +33,7 @@ static char *lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1] = {
>         [LOCKDOWN_INTEGRITY_MAX] = "integrity",
>         [LOCKDOWN_KCORE] = "/proc/kcore access",
>         [LOCKDOWN_KPROBES] = "use of kprobes",
> +       [LOCKDOWN_BPF] = "use of bpf",
>         [LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",

The text here says "use of bpf", but what this patch is *really* doing
is locking down use of BPF to read kernel memory.  If the details
change, then every LSM needs to get updated, and we risk breaking user
policies that are based on LSMs that offer excessively fine
granularity.

I'd be more comfortable if the LSM only got to see "confidentiality"
or "integrity".

--Andy
