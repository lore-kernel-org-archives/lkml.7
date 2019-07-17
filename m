Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B114C76188
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 301AD206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 03:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="w7T5h8le"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbfGQDCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 23:02:13 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32898 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQDCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 23:02:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id q20so23391704otl.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=moIcfOwT7Q28xvMfB1s79vLckwsn6mLmtlt9P80VoSI=;
        b=w7T5h8le8kar8GHbeuzqemVg7xntplejAU3LIpPoPxD5rDaA6mykcolHja7oxamFN+
         fcNJhXd4DetJySCJdhmgJKwbVMDKSXOWyUXGidrtJe3PTgBeA2og6iz5nw8EfAKyCAy6
         Zqj0eon0fp5aANLnzxF0AprfgdUTlPURq0NTh0A0VPAabeJKqJa0f82l0EF5e1m0pJmj
         OQjFnWnmI/ku6kLWxgppPmqjdvamNgPd3JVshYU1hb4KWI+pOcaeI0O2G+kPJcIYRliq
         M0SG+Nr6OPh0EAarDQanDv8ER7J0l7mWieCTBgxEmKozT8FVkUxiQXPrGbA2QGxio928
         qWzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moIcfOwT7Q28xvMfB1s79vLckwsn6mLmtlt9P80VoSI=;
        b=erFQfNGte26Qx6qVUlQXK1Ia4ytALLYej0WdZJddyTzAS5N2PmSTDqsvJ2U31yZApR
         gqbgjrCX/drqnlRBjqOld9jO80PjPPOdjWUt1PUwtRW+kRcgkyWmIQh+Jfh9Vo3dyCNF
         cUjWgXeT2/UxGVBzerfk9v3qVa3DshIyz7waQHp9woXDItUW7oNxbj1PTwWS+dTDayBB
         pv5suF/g5vRGciCN4KdzfiFF/GdfVEXjguscGiFLy9t2wHbnKgUN+JSZBs2HMNl6SWrr
         TlTtuxJIq+Z54kf0qJK7xLYTx/MJbbI9f3xNeZfjEmc5lheDvDgWwAAeVrpyOU10OyEr
         Na6w==
X-Gm-Message-State: APjAAAUTn1uQ88UPYYTsFP16F32jghFEJFrU/gPsxki4R5YSqP/+BRIX
        Qzy9lmuq+ROvZ7qHiayxCKQGNttAE/rOQyM3WTxkxh40
X-Google-Smtp-Source: APXvYqzJ8IMG8VXWy0kEMM/37hXScWIxxaMIJc4srMPsvxzwSqtji4irKjrqrN/DKpO/rDeJRWuz85fCgkFPrES4iVg=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr26992706otf.126.1563332531714;
 Tue, 16 Jul 2019 20:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190712051610.15478-1-pagupta@redhat.com> <20190712101021-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190712101021-mutt-send-email-mst@kernel.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 16 Jul 2019 20:02:00 -0700
Message-ID: <CAPcyv4joSgj7ok4DfW3tWQGavRDP8kp7oQRH8DgkG=0eWgNn1g@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_pmem: fix sparse warning
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>, lcapitulino@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Cornelia Huck <cohuck@redhat.com>,
        yuval shaia <yuval.shaia@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 7:11 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, Jul 12, 2019 at 10:46:10AM +0530, Pankaj Gupta wrote:
> > This patch fixes below sparse warning related to __virtio
> > type in virtio pmem driver. This is reported by Intel test
> > bot on linux-next tree.
> >
> > nd_virtio.c:56:28: warning: incorrect type in assignment
> >                                 (different base types)
> > nd_virtio.c:56:28:    expected unsigned int [unsigned] [usertype] type
> > nd_virtio.c:56:28:    got restricted __virtio32
> > nd_virtio.c:93:59: warning: incorrect type in argument 2
> >                                 (different base types)
> > nd_virtio.c:93:59:    expected restricted __virtio32 [usertype] val
> > nd_virtio.c:93:59:    got unsigned int [unsigned] [usertype] ret
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
>
> Pls merge - I assume nvdimm tree?

Yes, I'll push this with the rest to Linus tomorrow morning.
