Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D245C48BD5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3522146E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 02:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561514421;
	bh=QM4hCiMfYMsIl8IzD7niRFPSCurP42tdwlww78WBCWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VnaIOOGhVHLo0stzC8dAlrxxkN4X+aDFhvurcikUyCR/UCb9NDUnZoi5hkPt5dXkv
	 JHqz3nmAdS6O17QR8gBR+aiMyfKZa+9vXEGtqX/ShvPX8PQw5sS4yGkT2e6NgkrGUI
	 SEtjX5VobzXddWFeVAPHNFfNHr3Fw5vjco0+LPhg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfFZCAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 22:00:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38147 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbfFZCAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 22:00:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id b11so396424lfa.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsgDSI95KqePAPPmaFBiHY1206TOaDNoZExEWQf1Sgo=;
        b=VwxNwghjBlw6GDL//RFARFoXaDXKpoQaUs6zJSY4ZWsCZaI26bo7Npqkcj1+QDQtcx
         GVs1+ScO8o6NledD1rJbu3+AA5VOwqzSvHJzkC9ABBvPoIuMq+feRogzt1wHTnXJbjmu
         We4/fXRgj5n6LY0T1QL70h/w/6qH6xvQq668w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsgDSI95KqePAPPmaFBiHY1206TOaDNoZExEWQf1Sgo=;
        b=kPSztUpooAKhsWvsd/ry7txyS7oxKvUtwbs0helgFnisaE9gqTRNGyiIQ/mmS1fpID
         aAlGgJwjvqu6IqZwL2WxXTOFUyMCQDRIx+Mrj/gnslf12FZOAcBirfnIN+SAQSrWgVtk
         ZR7Kk2uNSDVB95YIDGD4S/P3jagteUXs+3PMuaZ2iQzuKhlXzVN4HFA4ngTuMHbg0nK8
         jVRikGRYLWh5NZuFn95CMsLBoc42r8zXqRW2IGIMJMgllkPyM95xDxY8jM0wI1L41cNh
         SeUVand0MXaqabFBmF//lrE8dJes6qZ4g0Wry/65rqwuxLiRgUK5ewNgGwv4ZiMIPxAU
         1y/Q==
X-Gm-Message-State: APjAAAUSd0sbyxnYzZb+qpaOF7oKwA5FzOCJMRqEppfXB4vrSM0Neltm
        TV7xx5nLtSA+tN1TiHxzXv6ry2VZKGqU3A==
X-Google-Smtp-Source: APXvYqxKZ+tDodR1vIqGGrTxxNkTETvLE+PVT7Yus8tx7BjzOp14LfE5QSL18EaQ4jziujjyRAHvoQ==
X-Received: by 2002:ac2:41d3:: with SMTP id d19mr939981lfi.127.1561514415702;
        Tue, 25 Jun 2019 19:00:15 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id 199sm2559127ljf.44.2019.06.25.19.00.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 19:00:14 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id y198so408715lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 19:00:14 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr993375lfm.134.1561514414187;
 Tue, 25 Jun 2019 19:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20190620022008.19172-1-peterx@redhat.com> <20190620022008.19172-3-peterx@redhat.com>
 <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com>
 <20190624074250.GF6279@xz-x1> <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
 <20190625053047.GC10020@xz-x1>
In-Reply-To: <20190625053047.GC10020@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 26 Jun 2019 09:59:58 +0800
X-Gmail-Original-Message-ID: <CAHk-=wjxOz5RXpFTU=wSJg4Mjg1ugOBhBVppSTH6qjZPxpGOKg@mail.gmail.com>
Message-ID: <CAHk-=wjxOz5RXpFTU=wSJg4Mjg1ugOBhBVppSTH6qjZPxpGOKg@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] mm: userfault: return VM_FAULT_RETRY on signals
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Shaohua Li <shli@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 1:31 PM Peter Xu <peterx@redhat.com> wrote:
>
> Yes that sounds reasonable to me, and that matches perfectly with
> TASK_INTERRUPTIBLE and TASK_KILLABLE.  The only thing that I am a bit
> uncertain is whether we should define FAULT_FLAG_INTERRUPTIBLE as a
> new bit or make it simply a combination of:
>
>   FAULT_FLAG_KILLABLE | FAULT_FLAG_USER

It needs to be a new bit, I think.

Some things could potentially care about the difference between "can I
abort this thing because the task will *die* and never see the end
result" and "can I abort this thing because it will be retried".

For a regular page fault, maybe FAULT_FLAG_INTERRUPTBLE will always be
set for the same things that set FAULT_FLAG_KILLABLE when it happens
from user mode, but at least conceptually I think they are different,
and it could make a difference for things like get_user_pages() or
similar.

Also, I actually don't think we should ever expose FAULT_FLAG_USER to
any fault handlers anyway. It has a very specific meaning for memory
cgroup handling, and no other fault handler should likely ever care
about "was this a user fault". So I'd actually prefer for people to
ignore and forget that hacky flag entirely, rather than give it subtle
semantic meaning together with KILLABLE.

[ Side note: this is the point where I may soon lose internet access,
so I'll probably not be able to participate in the discussion any more
for a while ]

             Linus
