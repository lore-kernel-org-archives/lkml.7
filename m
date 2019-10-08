Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADA4C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F31621721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V8mYrN5x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbfJHSGn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 14:06:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38267 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbfJHSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 14:06:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id w8so8796227plq.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 11:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NYB6tmPRC1SIoib6ul0uGoI9d0Fak9VnoM9hYJE8RnE=;
        b=V8mYrN5xmCt6W6pA+EkohagbGhwmh7NfbdoIXf9wwYu8JDjgxlVk9CXDbdLc8MPnRd
         jDxStfRjqrgfqq0fz235ZbDxTSDOjO1SdSOXVT1dVT40zbAry1mJXAw/09cjaOCLBbzz
         cG3cHMvTX5QV7Z0O1De47pW3ZcjlB82hMPwEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NYB6tmPRC1SIoib6ul0uGoI9d0Fak9VnoM9hYJE8RnE=;
        b=QeLjhNJVDMdVpr9vptZrmzNG95/utIdE9JQM3ZXUEnxwbfbok/cYRoPxwHBDF5EA/z
         fAUBOKvAeqFy8EFfaf20OvH74XuHoq7jjRCdwVMZ/ms6vXZFQWdOj7tgAwnfpImiEFcK
         iRSgq46sxjbjw4spj4JLi0HyFMPvbkRZ7boHQLMLlVuxSRB12ibv13TBijAMITSpWBIE
         d+4SrL6yNGMgxouAb5YA/oKBv5h9LaGB86vZjgDt4PgmDMJVcUg77IjoZjAUd5/aB9gx
         R5dMMAzGBC4tseIm1k/yqCm2iyuoE6U/UmbGNzch64DBrPeeJIub70RjEz3bFDlXls/y
         jdoQ==
X-Gm-Message-State: APjAAAUvrnhVzjl8PV3FNV0ilQulrWdQfLInj1l8X6pdNroPk+do0B4t
        MEmJyLh0j7q53x/nxwJMeSVBLg==
X-Google-Smtp-Source: APXvYqwwd9+2Ml8+wkWYicH8JkxxqWQMX6APMmp+DMaKOdWBlhq6/O0SLK+eS5lODOTOLuXDfGgd3g==
X-Received: by 2002:a17:902:968e:: with SMTP id n14mr29311899plp.339.1570558002131;
        Tue, 08 Oct 2019 11:06:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l62sm22528320pfl.167.2019.10.08.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 11:06:41 -0700 (PDT)
Date:   Tue, 8 Oct 2019 11:06:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Luis Henriques <lhenriques@suse.com>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: 'unable to handle page fault' in pstore
Message-ID: <201910081105.A4156956@keescook>
References: <87o8yrmv69.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8yrmv69.fsf@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 10:41:02AM +0100, Luis Henriques wrote:
> I've efi-pstore loaded, with a bunch of files in /sys/fs/pstore.  If I
> unload my backend driver (efi-pstore) and try to remove a file from
> /sys/fs/pstore I'll see the following spat:

Oh ew. I think the issue is that the backend should not be removed while
pstore is still loaded. I think ramoops enforces this, but I'll double
check...

-Kees

> 
> BUG: unable to handle page fault for address: ffffffffc0bcf090
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 64a60c067 P4D 64a60c067 PUD 64a60e067 PMD 892200067 PTE 0
> Oops: 0000 [#1] SMP PTI
> CPU: 0 PID: 3154 Comm: mv Tainted: G            E     5.4.0-rc2 #19
> Hardware name: Dell Inc. Precision 5510/0N8J4R, BIOS 1.10.0 02/25/2019
> RIP: 0010:pstore_unlink+0x1e/0x70
> Code: 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 41 54 49 89 fc 55 53 48 8b 46 30 48 8b 80 38 02 00 00 48 8b 58 10 48 8b 3b <48> 83 bf 90 00 00 00 00 74 39 48 83 c7 0c 81 42 00
> RSP: 0018:ffffb2eb40587e70 EFLAGS: 00010246
> RAX: ffff8920cea3e8a0 RBX: ffff8920cd55b400 RCX: 0000000000000000
> RDX: 0000000000000001 RSI: ffff8920cf76f300 RDI: ffffffffc0bcf000
> RBP: ffff8920cf76f300 R08: ffff8920cf76f300 R09: 007a2e636e652e32
> R10: 0000000000000007 R11: 7fffffffffffffff R12: ffff8920d4c91d80
> R13: ffff8920d4c91d80 R14: ffff8920d80c3480 R15: ffff8920d80c3520
> FS:  00007f3afe720640(0000) GS:ffff8920dda00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: ffffffffc0bcf090 CR3: 000000088e260001 CR4: 00000000003606f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  vfs_unlink+0x10f/0x1f0
>  do_unlinkat+0x1af/0x2f0
>  do_syscall_64+0x4c/0x170
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f3afe8ef2f7
> Code: 73 01 c3 48 8b 0d 89 db 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 07 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 64 89 01 48
> RSP: 002b:00007ffd60fea168 EFLAGS: 00000202 ORIG_RAX: 0000000000000107
> RAX: ffffffffffffffda RBX: 00005629c4e3ef70 RCX: 00007f3afe8ef2f7
> RDX: 0000000000000000 RSI: 00005629c4e3dd40 RDI: 00000000ffffff9c
> RBP: 00005629c4e3dcb0 R08: 0000000000000003 R09: 0000000000000000
> R10: fffffffffffff24b R11: 0000000000000202 R12: 0000000000000000
> R13: 00007ffd60fea260 R14: 00005629c4e3ef70 R15: 0000000000000002
> 
> My understanding is that pstore_unlink() is exploding when running:
> 
> 	if (!record->psi->erase)
> 
> because that address (psi) was on the efi-pstore module.
> 
> I'm not sure what's the best way to fix this, probably a
> 
> 	if (psinfo && record->psi->erase)
> 
> would be enough, but ugly (and still racy?).
> 
> Cheers,
> -- 
> Luis

-- 
Kees Cook
