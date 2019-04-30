Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10190C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:47:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D44D621734
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 16:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556642830;
	bh=S48pNAsTw7BEZ36AW1e1TSyWImwtIKer4k1K+rKGgdc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=shtrajp3A8HQM4KLoZna6Hcjc5JwU6DDf81i6q0CtTz9cmYfbhKjX4F722NEiFwre
	 3Wriq0IzVL6wmLs37aXJC5c0Qn6uQBj5nej0TqZHfImxsnqvQC7IMU1ZrDjC1QJD8W
	 yk+PGEE7tp9Wu+H7rt46HxYPSnC293Jq3SCGmS1Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbfD3QrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 12:47:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:36024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbfD3QrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 12:47:09 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26F482173E
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556642828;
        bh=S48pNAsTw7BEZ36AW1e1TSyWImwtIKer4k1K+rKGgdc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OfHCGrtUbiFJqLJB8TSFf7ldICXZA8iqik5XHx+uu4ZsE2UzlSk2VQWW6WYUsnUZr
         hB6najoPJUOCFObaMzBNFOEjtzUHebohanEO9HfhAwUAKuM2Lq8Up3CVLv213XzgBu
         yfoLpbcuVy3Wm2yY972dudRHvVjBb4hHzg0rXing=
Received: by mail-wr1-f50.google.com with SMTP id k16so21839887wrn.5
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2019 09:47:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWh+HnjCq9W83ZwzmompChx+3SKqFSGf8JEYPBxmRWvkNhIH7pY
        86tSjtKwrZjo3bP92reWK39wf4sAT2SXEbCvKNHRAA==
X-Google-Smtp-Source: APXvYqzHEqvh6x3xmyRtRqKnO98xcUmDJgjMNHD1klJcb2L6wbWRNt5Tm23i28W+RKElRE+GeRwRbM4AmqFkXIl8JL4=
X-Received: by 2002:a5d:4e82:: with SMTP id e2mr2206324wru.199.1556642826765;
 Tue, 30 Apr 2019 09:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190318104925.16600-1-sudeep.holla@arm.com> <20190318104925.16600-4-sudeep.holla@arm.com>
In-Reply-To: <20190318104925.16600-4-sudeep.holla@arm.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 30 Apr 2019 09:46:54 -0700
X-Gmail-Original-Message-ID: <CALCETrXEebRqX0W8MuS0SeaMDpEO5KdS3k7id279hZgHrmc8yA@mail.gmail.com>
Message-ID: <CALCETrXEebRqX0W8MuS0SeaMDpEO5KdS3k7id279hZgHrmc8yA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] x86: clean up _TIF_SYSCALL_EMU handling using
 ptrace_syscall_enter hook
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     X86 ML <x86@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        Steve Capper <Steve.Capper@arm.com>,
        Haibo Xu <haibo.xu@arm.com>, Bin Lu <bin.lu@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 18, 2019 at 3:49 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that we have a new hook ptrace_syscall_enter that can be called from
> syscall entry code and it handles PTRACE_SYSEMU in generic code, we
> can do some cleanup using the same in syscall_trace_enter.
>
> Further the extra logic to find single stepping PTRACE_SYSEMU_SINGLESTEP
> in syscall_slow_exit_work seems unnecessary. Let's remove the same.
>

Unless the patch set contains a selftest that exercises all the
interesting cases here, NAK.  To be clear, there needs to be a test
that passes on an unmodified kernel and still passes on a patched
kernel.  And that test case needs to *fail* if, for example, you force
"emulated" to either true or false rather than reading out the actual
value.

--Andy
