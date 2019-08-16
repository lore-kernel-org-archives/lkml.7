Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF57C3A59D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616BB21721
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 18:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pDG5hmdi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbfHPSXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 14:23:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41074 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbfHPSXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 14:23:00 -0400
Received: by mail-io1-f68.google.com with SMTP id j5so8045626ioj.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2019 11:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agJWohZMr3q676k9RQlDh/wbKRZjdc0c7MZS5+ZmeB0=;
        b=pDG5hmdil4HLm+qgjeNBLGvkzY0OcQFeCNXBtf7EeZzS3CCemkaN1U8cf0ks6SUiY1
         9G4ZyZFbH7i0BW2ERj9II63tLaL06iinZlXcnBfsRD6QGo7ksVIlWyFtaA34oEYUSLmC
         dfO8AHPySJM4CrHjwQRcin/Lqm2SQCpWf/Mcb2dykytnB8anoIOuojBLlza/PIzqi6AL
         v62V/uInV/Uaj89pzuGuWwQzIg2qm7n+YeWNjn8Vuqe87kujWukdtqvww0zw/2jY8TiU
         0wkDBmKXVaAdPkSFFVD55p8ftsEERyFIxUxDEB3LECntCj9RrVCMH148PDdyu/u6fvwS
         RuFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agJWohZMr3q676k9RQlDh/wbKRZjdc0c7MZS5+ZmeB0=;
        b=cnohXdIPyXdmXskzkLRITSHNaZbXgDYJ9KZ3x/wEEoUP73034Zl9E53YWb5Q/iF7J+
         ndifXc3rxXw/EWaN1/QTfvMrPg79ascO0H/L/ABmFkh6dGbbhKazqTgFqr3xAYilUzmQ
         8UP3RpxCdLRLJHmoS8F8B9Sml3paeIobpVdEf6z3BKlhhHHwKH8PvgQp8gT5pEKgjAyR
         g0IC/2GqmxmbuS0Zes26cplT2IIX+Nj8NdXtrjaJmbWq0uZFRQvTDJgua2uTwaT8AAih
         db/HYUoZFpXoKbuHdxA4fLqoc6nVuY5mmiAvyN9yhepSjwrhcWETfhSZHtaoLSTSCn9a
         rQuA==
X-Gm-Message-State: APjAAAWQVQVK+OGGE0Zc0KyWBOBrVST9ekWl1m6Bz6qUWWnsjA9PYu+n
        LfQu91SZqKSSCkTvBpXdm/3HhrSmMdCjLETTWW+yew==
X-Google-Smtp-Source: APXvYqymMyZ+oLaWjU/FyURpfwyR0j6qSnHvftCbU4CW4/Vtsw891sNKDL+NmgRsDkE0mHHV/0o5zWYlsFX1HLQV7xc=
X-Received: by 2002:a5e:c911:: with SMTP id z17mr971749iol.119.1565979778912;
 Fri, 16 Aug 2019 11:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190815200931.18260-1-sean.j.christopherson@intel.com>
In-Reply-To: <20190815200931.18260-1-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 16 Aug 2019 11:22:47 -0700
Message-ID: <CALMp9eQvy-UH3=Puq0AzM-f-C-5wFL1amWubRStZa2aH-m6ebA@mail.gmail.com>
Subject: Re: [PATCH] KVM: VMX: Fix and tweak the comments for VM-Enter
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

On Thu, Aug 15, 2019 at 1:11 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Fix an incorrect/stale comment regarding the vmx_vcpu pointer, as guest
> registers are now loaded using a direct pointer to the start of the
> register array.
>
> Opportunistically add a comment to document why the vmx_vcpu pointer is
> needed, its consumption via 'call vmx_update_host_rsp' is rather subtle.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
