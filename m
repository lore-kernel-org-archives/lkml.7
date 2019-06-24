Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA819C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5D02133F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 13:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561383124;
	bh=i/oz6d/CYK14KfGbNSqXTYBOv0SZT9Rzqz+x5/YI0v0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tHJx9VIIxsSUCsiDPoIw9UnMb+0Yo0ZRl6fhT0gzlwMsy8zh8cglMlLrK3VZyEIGJ
	 oqJtSCVL+Jc0fvW3ZqF5l1m6dK+yjCdVTIqkvFyzLeibaudvU7gk3CS5jk+qD5Prvp
	 rUVnHPye4LazubLDl+Cc8y7QIdgHwVSoEfIFEGyg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbfFXNcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 09:32:03 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34104 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729020AbfFXNcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 09:32:02 -0400
Received: by mail-lj1-f194.google.com with SMTP id p17so12662797ljg.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCHpK1CZOVMMRr9wyoLp/eyfAndWJItR7EDWf+w9QSU=;
        b=fP2Ot5P/h6IfQPNnkVaknnZvAAp4gjmHLWg6mRMP+CMZ9YAztqfCuIF7zICgw8PE7u
         /C5LdKfScbPHPRwoC7oBsNOwoCQQK/AfSEDzYLOxSTacOSmZz5MIf7KYY0IaZD9cXmtQ
         J7BnzTNhxal/KCJBAvzgxW3R7HKTgQazjdJ9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCHpK1CZOVMMRr9wyoLp/eyfAndWJItR7EDWf+w9QSU=;
        b=slWfTEIR3x8BJT9fX7DNWFrRsqWJuCPasASBNybzGDyFYKJbUkrNBwlJCBgRvrexTA
         NvvFKcgzytkXOdL9eseOfnRtwlulH+G7PDD54ES/Zp49G+hrFvasGygjTurdBKuGJdCi
         fyC8EnCiNUgeWQPXavHsLuF741CvzgHGiUKghfNOSC3Nj6vQEtrJ+Q303oBmw67esCdL
         g76Xznk3xWWsLkXQzUbLhO2JKfsM026O6hSTGlUIfE1WEXnq1qKjocCK1Ur+6ru2JLx7
         JZB+M9Og4m2niuf/PXxtDLwYdX9lhiFjMlhYdge7hrry1y0OHCnxtpe3UCJa78K1ZQOr
         Fkxg==
X-Gm-Message-State: APjAAAWZQYaV6YFDbX18pKiIwPBpYuqKahRijsmUG6VtQo2Z0k8Lzkda
        FTNyMHl8qHet7TI6z5MgNzdz39D+qA4=
X-Google-Smtp-Source: APXvYqx/fha9NF/NMXaHjIkRjoJJKpXTuuTE6mOMfeWPdjxKP7LjiQTPOxVXeQKMExY58NS9bK1Yuw==
X-Received: by 2002:a2e:5bdd:: with SMTP id m90mr70770517lje.46.1561383119997;
        Mon, 24 Jun 2019 06:31:59 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r14sm1555551lff.44.2019.06.24.06.31.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:31:58 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id k18so12617083ljc.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2019 06:31:58 -0700 (PDT)
X-Received: by 2002:a2e:95d5:: with SMTP id y21mr63467183ljh.84.1561383118160;
 Mon, 24 Jun 2019 06:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190620022008.19172-1-peterx@redhat.com> <20190620022008.19172-3-peterx@redhat.com>
 <CAHk-=wiGphH2UL+To5rASyFoCk6=9bROUkGDWSa_rMu9Kgb0yw@mail.gmail.com> <20190624074250.GF6279@xz-x1>
In-Reply-To: <20190624074250.GF6279@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Jun 2019 21:31:42 +0800
X-Gmail-Original-Message-ID: <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
Message-ID: <CAHk-=whRw_6ZTj=AT=cRoSTyoEk2-hiqJoNkqgWE-gSRVE5YwQ@mail.gmail.com>
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

On Mon, Jun 24, 2019 at 3:43 PM Peter Xu <peterx@redhat.com> wrote:
>
> Should we still be able to react on signal_pending() as part of fault
> handling (because that's what this patch wants to do, at least for an
> user-mode page fault)?  Please kindly correct me if I misunderstood...

I think that with this patch (modulo possible fix-ups) then yes, as
long as we're returning to user mode we can do signal_pending() and
return RETRY.

But I think we really want to add a new FAULT_FLAG_INTERRUPTIBLE bit
for that (the same way we already have FAULT_FLAG_KILLABLE for things
that can react to fatal signals), and only do it when that is set.
Then the page fault handler can set that flag when it's doing a
user-mode page fault.

Does that sound reasonable?

               Linus
