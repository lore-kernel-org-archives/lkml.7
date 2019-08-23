Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C45C3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB082173B
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566600397;
	bh=5AtlJ8cym2kVMj3VKczQ/Xr2AFA5SHmNJu+9Zb0ZS8I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dc7DEkrJjcJTXGrhkCtC92W4ntjbCgUw/1xdw7lCMoVeRFH+BDmJcy4A5KKhwc7Nr
	 qcWl6uoam4WOhENEaUH2xD8snrvleO+XQdXhhkp1Ea8c+gR+DQ9cxAb/2V2SBfZL2R
	 1ZtxJbXcjLf5vpw1eycdXLxZJWxEJ4Nd7md9HT+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfHWWqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:46:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfHWWqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:46:35 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA5121897
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 22:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566600394;
        bh=5AtlJ8cym2kVMj3VKczQ/Xr2AFA5SHmNJu+9Zb0ZS8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZY8C3/B7eZSRy5ebXhQPvij2EefFFDcbMwxZDWtqCfrP/cBNiP9RF8ww/isge35Ua
         zFxjNcx10rXYutEyJmLe+95iYLCIYPZGdAKheA2SHe/bxpBwNqYTP4IkIoF2YbClqM
         eZNIfK6+Uxl9//ymGHg3lB/X7m82VSY57qMbE2U4=
Received: by mail-wm1-f42.google.com with SMTP id m125so10471838wmm.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 15:46:34 -0700 (PDT)
X-Gm-Message-State: APjAAAXlwEo8KVTyrAouquFST9Mowo2nhClMmn2iqK95cxk3ZLt4lJ4x
        kyOZFch1r8FJZETtkBs9FtkoMwQG1yJ/SZwcJB/gFQ==
X-Google-Smtp-Source: APXvYqwTdt6tHwJgQgfuQY2j6MTIhPY5i33QMVfj1jsY5dz0nP10DPqA6QTn2BjMkcIJfrNxuRltErSdubOhX7NWEAo=
X-Received: by 2002:a1c:f910:: with SMTP id x16mr7225160wmh.173.1566600392711;
 Fri, 23 Aug 2019 15:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190823205544.24052-1-sean.j.christopherson@intel.com>
In-Reply-To: <20190823205544.24052-1-sean.j.christopherson@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 23 Aug 2019 15:46:20 -0700
X-Gmail-Original-Message-ID: <CALCETrXFRAmgqyxtsknpnQaMtVU-hqMRPYR=4Q5JtBgNGxuSGQ@mail.gmail.com>
Message-ID: <CALCETrXFRAmgqyxtsknpnQaMtVU-hqMRPYR=4Q5JtBgNGxuSGQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Don't update RIP or do single-step on faulting emulation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 1:55 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Don't advance RIP or inject a single-step #DB if emulation signals a
> fault.  This logic applies to all state updates that are conditional on
> clean retirement of the emulation instruction, e.g. updating RFLAGS was
> previously handled by commit 38827dbd3fb85 ("KVM: x86: Do not update
> EFLAGS on faulting emulation").
>
> Not advancing RIP is likely a nop, i.e. ctxt->eip isn't updated with
> ctxt->_eip until emulation "retires" anyways.  Skipping #DB injection
> fixes a bug reported by Andy Lutomirski where a #UD on SYSCALL due to
> invalid state with RFLAGS.RF=1 would loop indefinitely due to emulation

EFLAGS.TF=1
