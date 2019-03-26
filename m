Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43EAC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A0292080F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553559015;
	bh=WMJRBKlNDw38qp/1xuZqDu2eoQ4xMd5LQSfiiy6YFr8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ojxJ1uAxFq2VER8BiqPMR6D7gMjgrkUyYaIpYJJpeqpOgmTeLBBK1FZVaC60JXJrD
	 /32Gx7HVnK24x5VtpRcYzItfiB+YnpUQJXpzwrxrGhZe6/rIQsroJeQdWJ/iBgwib9
	 zSpRk4+pspbWBKmPOTIT3DWNg56DXIgJX711m4Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbfCZAKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 20:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbfCZAKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 20:10:13 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB42220879
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553559013;
        bh=WMJRBKlNDw38qp/1xuZqDu2eoQ4xMd5LQSfiiy6YFr8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B7NlvGMOjuZ7UVPpSMgBRR9mAWUkSs9L7iOc/zLf4xTZqrL5HsqaurthuT7JVwX+v
         cEMhgwQ+D5PQieYNWFfBrVYqcuf2TlNlyBOTLxBX5GNH76xEZ93nqRThYZ2HGNc5bF
         h90lkF9LduKTnm6cylywmHcEBpOEBr09bAlW3JHc=
Received: by mail-wm1-f47.google.com with SMTP id 4so10765733wmf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 17:10:12 -0700 (PDT)
X-Gm-Message-State: APjAAAWslpkTznIA2m99SS/Dt0tFLhO+lOZBRNxWC7j7ySjOgZpQyVGH
        Ew4BSq+rgiO0B/GqlaLLsWFE/x5AL2CFvX1YMJ9Skg==
X-Google-Smtp-Source: APXvYqwo6Frd6wZMrexD6Qd3HSV7HadjqnpeISg+KBAkuGAdk7BOjnEKUZk20j37g3jwwhuHtMIDerIQBIanJfohKrE=
X-Received: by 2002:a1c:e188:: with SMTP id y130mr6750289wmg.83.1553559011275;
 Mon, 25 Mar 2019 17:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190325220954.29054-1-matthewgarrett@google.com>
 <20190325220954.29054-24-matthewgarrett@google.com> <20190325164221.5d8687bd@shemminger-XPS-13-9360>
In-Reply-To: <20190325164221.5d8687bd@shemminger-XPS-13-9360>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Mar 2019 17:10:00 -0700
X-Gmail-Original-Message-ID: <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
Message-ID: <CALCETrU=EqqRwyQGBT0=_N9-E_pBM53=z+WJrd9OzV7g6xJa0A@mail.gmail.com>
Subject: Re: [PATCH 23/27] bpf: Restrict kernel image access functions when
 the kernel is locked down
To:     Stephen Hemminger <stephen@networkplumber.org>,
        Linux API <linux-api@vger.kernel.org>
Cc:     Matthew Garrett <matthewgarrett@google.com>,
        James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Chun-Yi Lee <jlee@suse.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 4:42 PM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
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

I wasn't cc'd on this series, nor was linux-api, so it's awkward to review.

A while back, I suggested an approach to actually make this stuff
mergeable: submit a patch series that adds lockdown mode, enables it
by command line option (and maybe sysctl) *only* and has either no
effect or only a token effect.  Then we can add actual features to
lockdown mode one at a time and review them separately.

And I'm going to complain loudly unless two things change about this
whole thing:

1. Lockdown mode becomes three states, not a boolean.  The states are:
no lockdown, best-effort-to-protect-kernel-integrity, and
best-effort-to-protect-kernel-secrecy-and-integrity.  And this BPF
mess illustrates why: most users will really strongly object to
turning off BPF when they actually just want to protect kernel
integrity.  And as far as I know, things like Secure Boot policy will
mostly care about integrity, not secrecy, and tracing and such should
work on a normal locked-down kernel.  So I think we need this knob.

2. All the proponents of this series, and the documentation, needs to
document that it's best effort.  There will always be security bugs,
and there will always be things we miss.


--Andy
