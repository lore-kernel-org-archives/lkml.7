Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C78C432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33AB20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 07:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Aamx4FNU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKUHYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 02:24:00 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45019 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUHX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 02:23:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id c19so2021668otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 23:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=Aamx4FNUou5OK5b7p9ovqCkit0cIfdpUzoZz7zxKIrRXmGuxUroJEy8wgfnhc4LNO9
         /bAUGOCzZnxJ+6JvDwrn1hrSEejsJDm9addm6MgSJJndGvNXP5xKWYE3TXfKO3zT1XmE
         G+cfBCOAa0MLYBx0J8IOpV6ETGNBWcIcBSKsVmQ18T+Av5T94jpinvYdky3C2cfJCxww
         zAYPLQyi/BjZmHcmFpPXkMpAq93xJVnFAVyNIJ7wM77MNuYDPu5abIu18Pi9wC4fb9Ij
         LyRjFAPS051ir8jmoxV6RL/1LXpeCK7iPrM3gAOrGb89knq52X47y1B6UQk7Vc8JyaZJ
         Bxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cEXJauHqWm8iI4LnNBvnulW7dvtwyPk4PjbYBEQHLv0=;
        b=EiLOc9Oby8Cucv0gwDx38TMIR3c8KEV9A1YpFe7oM+gTx+X/mnWZxMr0Uoni/1dAS5
         oNEESFmbkBOBNFbueWXiWy5c5WYDLYJWO+kJhaSi0MpDKE5pmML87KlK02v5PtLGBT0U
         N6nJTJXmX7WYlhFwZAK96RlWcwzWBRgDyg0jqL43bSyT0czTb/wZzz/BFtqidNk2GxmD
         PTguj2FLrCPUnkyx3Y8iPIuTP/J/JFTo17dL9GodKZAo0Al617ES3t8krsgvGE6AhiML
         tvgCwKERI0YNFEnnAd52ee7r0pHNYLyTdQqvKwaBoGxrek5PbY7XsHvU2sIWMkM5SgYU
         IHtA==
X-Gm-Message-State: APjAAAWbS0jluk+e/yWZ4Jet1e0/50XuDVEedWZ66rBaDrv8QBsfDHz7
        rzONzFrtgZ8anxaetUbj1IgnBun/9v/9XaZBRumd5A==
X-Google-Smtp-Source: APXvYqws9XkJQSLixl8sCxSf8KR7piXMbSGOHYMZNFTKMUrilxcOOTe8eFSPb/y5vtMhiXzk8SHG7lti/eziN7V7EtQ=
X-Received: by 2002:a9d:30c8:: with SMTP id r8mr5394180otg.363.1574321038732;
 Wed, 20 Nov 2019 23:23:58 -0800 (PST)
MIME-Version: 1.0
References: <20191120092831.6198-1-pagupta@redhat.com> <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49d0dmihmu.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 20 Nov 2019 23:23:46 -0800
Message-ID: <CAPcyv4gCe8k1GdatAWn1991pm3QZq2WBFAGEFsZ2PXpyo2=wMw@mail.gmail.com>
Subject: Re: [PATCH] virtio pmem: fix async flush ordering
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Pankaj Gupta <pagupta@redhat.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Vivek Goyal <vgoyal@redhat.com>,
        Keith Busch <keith.busch@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 9:26 AM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Pankaj Gupta <pagupta@redhat.com> writes:
>
> >  Remove logic to create child bio in the async flush function which
> >  causes child bio to get executed after parent bio 'pmem_make_request'
> >  completes. This resulted in wrong ordering of REQ_PREFLUSH with the
> >  data write request.
> >
> >  Instead we are performing flush from the parent bio to maintain the
> >  correct order. Also, returning from function 'pmem_make_request' if
> >  REQ_PREFLUSH returns an error.
> >
> > Reported-by: Jeff Moyer <jmoyer@redhat.com>
> > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
>
> There's a slight change in behavior for the error path in the
> virtio_pmem driver.  Previously, all errors from virtio_pmem_flush were
> converted to -EIO.  Now, they are reported as-is.  I think this is
> actually an improvement.
>
> I'll also note that the current behavior can result in data corruption,
> so this should be tagged for stable.

I added that and was about to push this out, but what about the fact
that now the guest will synchronously wait for flushing to occur. The
goal of the child bio was to allow that to be an I/O wait with
overlapping I/O, or at least not blocking the submission thread. Does
the block layer synchronously wait for PREFLUSH requests? If not I
think a synchronous wait is going to be a significant performance
regression. Are there any numbers to accompany this change?
