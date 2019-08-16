Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0751DC3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD279206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 21:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WMsue2VI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbfHPVQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 17:16:43 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:34083 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbfHPVQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 17:16:39 -0400
Received: by mail-io1-f66.google.com with SMTP id s21so8994760ioa.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 14:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Int3qXRxTtMLZpwLZ2e6cbllifhw+j89MK6a4PSSxKs=;
        b=WMsue2VIg8HAKY+hUVTbQ3NledHMv2Vy3n21BHZtmEGvftmjPF9kPlF0azKgkb45rG
         3eJb0K2ofV4rE5ojGEL84Bsuit8rGVd9s6Yk54sbK1lTSrJ6UJhDVGijSw6iFjtPQ9Ad
         aOCu/SA2uFJsSKD4bwejZP1+CAiv1ZZLfcGs6yG1SG1vDSqdntz4GuP1wQhO8nBHeOSI
         KA0PaBXa/qUFxQRwZ/EydvH9dxp0kzagGaBigUmp1kq0nT7lrgqJSOujPQL6mt4Hokxc
         PmNBeLE9XLvIrIxuc9NktzeND/yyTuLHL72DtYhmkGEKIDpjw/IKBfa8QTQllNN/xg+Y
         MUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Int3qXRxTtMLZpwLZ2e6cbllifhw+j89MK6a4PSSxKs=;
        b=nQi+bkzQdOZ/Zpb4of6gV4rfl0ar7ucMdIeGtYIppiBuOaZbETnKnb0e3jk33OkGMd
         a57seYOxFGQBKyNnt+l8Mxkb4XrAD+KRevOHXsiOaYz/+tf5OSHkDU5dIT1k8NtZJGmg
         D7xMKO4M6wiWIEx9ELBjLnmjWVc7h/b982EfophHJf3TTXIJOfaJqvMwrQiNktyvlEZ6
         2Po/5v807zxc8JOagAXCWPysIoSxVfOX65hHHPumKfHSgZ7g9pPhGHJuH7jdhYWBZMBI
         ywW9/NK+jACFqFBJYU0MTLAAMmoHiCK7fxhOv9gIC+ajlJLSE4pVEYMGJwKbQUuSmpOL
         HRew==
X-Gm-Message-State: APjAAAXa+occ3w7hjkyj7CWPVsaF1W6YqjomWg74Zo6bPLPDKLtUR0UI
        oV1hT4vvKF5N6+lFpg2wHw0qfRD7WZR5VRhaAY+fOQ==
X-Google-Smtp-Source: APXvYqy9tYsUxi0DNu9mhE/ntscDvxLoXebX+iGLalDZMl6lWKFfoR9p+EaKbRUicrM4nhuxZfGC6FfCiU+KY0yLggQ=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr13146161jan.18.1565990197653;
 Fri, 16 Aug 2019 14:16:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190815162032.6679-1-sean.j.christopherson@intel.com>
In-Reply-To: <20190815162032.6679-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 16 Aug 2019 14:16:26 -0700
Message-ID: <CALMp9eTJpzGu=NyTknGUAoxWOfWJiXgJzxZmPJwZEbScJDJqjw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix x86_decode_insn() return when fetching insn
 bytes fails
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 15, 2019 at 9:20 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Jump to the common error handling in x86_decode_insn() if
> __do_insn_fetch_bytes() fails so that its error code is converted to the
> appropriate return type.  Although the various helpers used by
> x86_decode_insn() return X86EMUL_* values, x86_decode_insn() itself
> returns EMULATION_FAILED or EMULATION_OK.
>
> This doesn't cause a functional issue as the sole caller,
> x86_emulate_instruction(), currently only cares about success vs.
> failure, and success is indicated by '0' for both types
> (X86EMUL_CONTINUE and EMULATION_OK).
>
> Fixes: 285ca9e948fa ("KVM: emulate: speed up do_insn_fetch")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
