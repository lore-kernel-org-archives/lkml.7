Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586A8C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258982080F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="SRRLoe3l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbfCYX7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:59:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44846 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727099AbfCYX7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:59:49 -0400
Received: by mail-pf1-f193.google.com with SMTP id y13so1069847pfm.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 16:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fiI2buvf1c7pUiH9YIPF0JCtZwcv8jOJ4z2y1uVD5A4=;
        b=SRRLoe3lzMtwQcYxhiJroGdC2RLxArCfyG5Fg+L/lmf6tEl9MQB1kOxrrHK+tj6tXz
         yu7LkomrWJnzKqwkV78XIubpC1RJNEEZ+KmbwAzWWQX84xJ/NUhz96Ko+/kuhe3FRcFj
         ZOMrhI0jIkGcITZtCr9Zv3BMHCj0b45bZLf4izDkJyUCHETB07HiNr+0lKJWIFI5aDCS
         urslaorO1JUg0f/KG22tQ2sivV9LOhU9Hh2Q/rHjvx8C/UscprRgyp5rsVnEL1pBvqh+
         ft9xSO9YU2+dEsqSLYf05cI+KWKuN8NO9OqdSGSIggQm0eQD5QOp9uYEIOI/bxmvB1KA
         a+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fiI2buvf1c7pUiH9YIPF0JCtZwcv8jOJ4z2y1uVD5A4=;
        b=OnBr/uU4R87lWuCocxFTDaYJIr0RnW/oZhZACt6ZwWP+Dh9vpZXQVBtWkH10unfD81
         2+BEAkNr1V5ppr6IgZejT5C13Flpl2/QojbEZnqOENzQDtvMtc2IXfflopZ5UkK9VDw2
         N8WnpjMOdLJ4dyI1QRNVAThj4rBF27WJKnBHvwTyS4+Z9H8gN7XjWlNI+FL2vrqbNQBI
         MRpPWQ1O4ZFGlSenfdkKM86xXVtrcmZy95+7FjAv2sbWs81LcFWkPB3u1I001mPdijnT
         lqN9uFUD3NwzQKB1Ldfo8uilX/wJ9nGlspjncxTCbV537yCGxa9pKeqoAIo3HLDsvnj9
         McHw==
X-Gm-Message-State: APjAAAUnay9aXlYdhjK7cpQTeVT5EYsjrmgVCMHhXqUySf40FUJQ7/lY
        dTzAUU3vc++APzGBAUPYpeHObA==
X-Google-Smtp-Source: APXvYqwb/slAPUU5sbjyqZWmIC3MSCK56js2TEjsU1MHbb6UIzNUmAiZM0+TgpbS8m7VPe1REWXrcg==
X-Received: by 2002:a63:2d5:: with SMTP id 204mr25433452pgc.407.1553558388772;
        Mon, 25 Mar 2019 16:59:48 -0700 (PDT)
Received: from shemminger-XPS-13-9360 (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id c11sm26706069pgd.24.2019.03.25.16.59.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 16:59:48 -0700 (PDT)
Date:   Mon, 25 Mar 2019 16:59:44 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     jmorris@namei.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        netdev@vger.kernel.org, Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
Message-ID: <20190325165944.7a8c0ecf@shemminger-XPS-13-9360>
In-Reply-To: <20190325164221.5d8687bd@shemminger-XPS-13-9360>
References: <20190325220954.29054-1-matthewgarrett@google.com>
        <20190325220954.29054-24-matthewgarrett@google.com>
        <20190325164221.5d8687bd@shemminger-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 16:42:21 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> On Mon, 25 Mar 2019 15:09:50 -0700
> Matthew Garrett <matthewgarrett@google.com> wrote:
> 
> > From: David Howells <dhowells@redhat.com>
> > 
> > There are some bpf functions can be used to read kernel memory:
> > bpf_probe_read, bpf_probe_write_user and bpf_trace_printk.  These allow
> > private keys in kernel memory (e.g. the hibernation image signing key) to
> > be read by an eBPF program and kernel memory to be altered without
> > restriction.
> > 
> > Completely prohibit the use of BPF when the kernel is locked down.
> > 
> > Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> > cc: netdev@vger.kernel.org
> > cc: Chun-Yi Lee <jlee@suse.com>
> > cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Signed-off-by: Matthew Garrett <matthewgarrett@google.com>  
> 
> Wouldn't this mean that Seccomp won't work in locked down mode?

Never mind. This is about bpf system call, not locking out all bpf in general.
