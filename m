Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C3C47404
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:04:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C75F21848
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 00:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570665861;
	bh=0jWhLB0AitAGeTk8uwHb4sWxNylEEp1Z5cSAq6u4bHo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UjsvKtwksR+yEIhSU8tKzbIe/YOJr/PUSbFhs3zPQktPxM9/vCReW01BtpT6foJ4N
	 A7foh5qUwV34obxO49TKnvxyk+r1xpWIHuVCyT72n1Lle30cqdsNvOT4tt1PE0xJ0L
	 +tFs3IUq0Ja3Vh+7vfZZs/nSzow40f98PLdExulI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbfJJAEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 20:04:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730815AbfJJAEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 20:04:20 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0CDDF206C0;
        Thu, 10 Oct 2019 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570665859;
        bh=0jWhLB0AitAGeTk8uwHb4sWxNylEEp1Z5cSAq6u4bHo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KO2fr0Zwkli3KGUSh2qc7P9PK4qBKVwVx+oPFzKFWlWzJfQp26ZNS63n90J7z/xEO
         OY2y+6gSF3DxWMRBNiLNTgqCR/VIKmEV7nt3iO54Ry32FQ7ZiRuxdcv087I5fjVVys
         Ufdj92zu8LIw7MBLpuT5Q1ibuhvI/p9heRTNILr8=
Date:   Wed, 9 Oct 2019 17:04:18 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Qian Cai <cai@lca.pw>, Wei Yang <richardw.yang@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Rik van Riel <riel@surriel.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: "reuse mergeable anon_vma as parent when fork" causes a crash
 on s390
Message-Id: <20191009170418.b7954140de86e422f3818381@linux-foundation.org>
In-Reply-To: <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
References: <1570656570.5937.24.camel@lca.pw>
        <CALvZod4psOEyYwPOF1UcJoK96LbYBccYhsG0DrKD+CCf8Sc-Yg@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2019 15:21:11 -0700 Shakeel Butt <shakeelb@google.com> wrote:

> On Wed, Oct 9, 2019 at 2:30 PM Qian Cai <cai@lca.pw> wrote:
> >
> > The linux-next commit "mm/rmap.c: reuse mergeable anon_vma as parent when fork"
> > [1] causes a crash on s390 while compiling some C code. Reverted it fixes the
> > issue.
> >
> > [1] https://lore.kernel.org/lkml/20191004160632.30251-1-richardw.yang@linux.intel.com/
> >
>
> ...
>
> Our internal syzbot instance also hit this bug and bisected to the same patch.

Thanks, I'll drop
mm-rmapc-reuse-mergeable-anon_vma-as-parent-when-fork.patch.
