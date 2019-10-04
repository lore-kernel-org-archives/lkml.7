Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1175FC4360C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58D32084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201033;
	bh=crFelfh0Sn/O8mB2YPt3Mozpd1WcKFo0ht7BKzHX6bI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eNzVRxH9Lt5LNPnCE69Fv7x+ho7KQImopC0So5SSXo6AnhBD1VV11JPw24vD/DXDB
	 5EqT3COWQ6JdMgg8AoY8z6zF1Oo+TsqOkKXf1KuLtuzoKFkARe1VFBjUjgtZXj3PA5
	 gOwyLT+t9YgXzba+IlQpldLeLvXnv/HdRoJrooUs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389440AbfJDO5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:57:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389042AbfJDO5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:57:12 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E2D3222C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 14:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201032;
        bh=crFelfh0Sn/O8mB2YPt3Mozpd1WcKFo0ht7BKzHX6bI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZV9Uig7IsG0spaw0caqrW3Q2fqYoIacHVBgoYU9FOb8oSapqSp1DIJ4eSjY3x7Djd
         Y6/w8lYmZotuqGOqt2NQV+emn/oW5jSqjOMytuhXYCjGov35flVZxuxnYUaWGgU4f4
         1EZ5D/haZRb8VRyR5cSCjjUDAva2X/lFYafJDhAs=
Received: by mail-wr1-f47.google.com with SMTP id o18so7559886wrv.13
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:57:11 -0700 (PDT)
X-Gm-Message-State: APjAAAVJEvuVueuY+/4YTiFurNQ5DW/u973n6G62HgfhHVUqk+INjC+A
        c6H6julspKXqzU+gYs5uEwEm+4EIvhWmrx5beMETEA==
X-Google-Smtp-Source: APXvYqwknDFkFaJzo6VOtFntrB9U7DIZ2Bs13Lu1v1o7MImeIR75HTQyzSZPi+TJSharOuJdeBuc1fee3GNxv2jxmGM=
X-Received: by 2002:a5d:4647:: with SMTP id j7mr12415523wrs.106.1570201030525;
 Fri, 04 Oct 2019 07:57:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20191003212400.31130-1-rick.p.edgecombe@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 4 Oct 2019 07:56:58 -0700
X-Gmail-Original-Message-ID: <CALCETrW9MEvNt+kB_65cbX9VJiLxktAFagkzSGR0VQfd4VHOiQ@mail.gmail.com>
Message-ID: <CALCETrW9MEvNt+kB_65cbX9VJiLxktAFagkzSGR0VQfd4VHOiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] XOM for KVM guest userspace
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        "Dock, Deneen T" <deneen.t.dock@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 3, 2019 at 2:38 PM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> This patchset enables the ability for KVM guests to create execute-only (XO)
> memory by utilizing EPT based XO permissions. XO memory is currently supported
> on Intel hardware natively for CPU's with PKU, but this enables it on older
> platforms, and can support XO for kernel memory as well.

The patchset seems to sometimes call this feature "XO" and sometimes
call it "NR".  To me, XO implies no-read and no-write, whereas NR
implies just no-read.  Can you please clarify *exactly* what the new
bit does and be consistent?

I suggest that you make it NR, which allows for PROT_EXEC and
PROT_EXEC|PROT_WRITE and plain PROT_WRITE.  WX is of dubious value,
but I can imagine plain W being genuinely useful for logging and for
JITs that could maintain a W and a separate X mapping of some code.
In other words, with an NR bit, all 8 logical access modes are
possible.  Also, keeping the paging bits more orthogonal seems nice --
we already have a bit that controls write access.
