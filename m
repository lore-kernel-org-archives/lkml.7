Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946F5C5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60AF120645
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 01:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="he2DovYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfGCBMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 21:12:36 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:37557 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfGCBMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 21:12:34 -0400
Received: by mail-yw1-f68.google.com with SMTP id u141so360951ywe.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 18:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V8AIGJyicRZYtqGrmcePHnOlgzCw65qs5E9QHHoWBTE=;
        b=he2DovYUy55yQQcixOTOCfqaqOCIDKJ+wXV08HXaGfYZ9+SI6BGv1htdlSxkWbeEC6
         qpe6JY8cJwaKiVR+evcDUQEKE/a4Eu49905uPiTRL/MbvWKxBwDE6snnpzMuhvitUgrh
         viipBTuzMDk1yScVUpTiR+tbs7l1XefM84EdnOnCmq0COj7jLrM2IH2kHd3EHxUKSNxa
         bBubggBUMM0CyZlbouRl9k5kYdl9aJHCBpGoI0pd3TPmdLtA6NF8g3FHoI888383SgZc
         GT/tWSRK3mDXuEwRi6OTyqt2/uBZk+z8eEhNKOqkZBKVwYHD+piQAPy3Nxfojp2StnjF
         f63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V8AIGJyicRZYtqGrmcePHnOlgzCw65qs5E9QHHoWBTE=;
        b=K3D0mdvFuqiy070mf7ihjd3aG9U99WRaIebJD7sOGuUSzTkdCO+IvKOLkpR9g177NO
         r64QLNk1ExnMHY9CBKbTa4fdGtyPphqvs0Rr52JcRBBQzB7FrOCeTbaNdlw+omzZxf+C
         ktX4U5UNwOi8WsC/nFYAnIBK13t1SN1M+U4jPs/Lpv/eR51LHKvnxwwWRXa22uP/QwRi
         J3ZnkR3xPOBQEBbgb0sfZupv6FE3yAtdyUcJMACq2VsPeTGgNQ8cOf/nrSRbyrU/R5Eu
         wTNedG6TjhqG83FjNQ+ZRjLo4ESAmwFCJIM1VSCaUj+dvO2+THxzJSEIKMjcG63d5Ye0
         jE+g==
X-Gm-Message-State: APjAAAUjJqzXcb3fZExVBoI0gpK9l6IGI8fOU3dRowW3Cb59BxKw4VxZ
        VWe8YhB3aRP9LvJM+S8RGBdmbWYoU37XDvHY0e/MpaNaAfU=
X-Google-Smtp-Source: APXvYqy6l89dNmQiXZbn5Tz5340voBBdb8GKyP54Bnh3k0fZEaivKza9tydd3SPYnJq1AfDPFc7pv5rq1RP7PDpHLGc=
X-Received: by 2002:a0d:dfc4:: with SMTP id i187mr19764925ywe.146.1562116353082;
 Tue, 02 Jul 2019 18:12:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190702075819.34787-1-walken@google.com> <20190702075819.34787-4-walken@google.com>
 <20190702115225.GB3419@hirez.programming.kicks-ass.net>
In-Reply-To: <20190702115225.GB3419@hirez.programming.kicks-ass.net>
From:   Michel Lespinasse <walken@google.com>
Date:   Tue, 2 Jul 2019 18:12:20 -0700
Message-ID: <CANN689HTCisvT-Pcj9koPZ85b7OY3mOBc8S3X2-eZiVWGhwmqg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] augmented rbtree: rework the RB_DECLARE_CALLBACKS
 macro definition
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 2, 2019 at 4:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > - Reorder the RB_DECLARE_CALLBACKS macro arguments, following the
> >   style of the INTERVAL_TREE_DEFINE macro, so that RBSTATIC and RBNAME
> >   are passed last.
>
> That's, IMO, a weird change. C has storage type and name first, why
> would you want to put that last. If anything, change
> INTERVAL_TREE_DEFINE().

Makes sense, will do. I'll have to make it a v3 of the patchset
because RB_DECLARE_CALLBACKS_MAX was introduced with the opposite
argument order. Oh well, no big deal.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
