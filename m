Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3D6C3A5A7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3FB233FF
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 01:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="tRuQF9NG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbfH3BaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 21:30:02 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:41357 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfH3BaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 21:30:01 -0400
Received: by mail-yw1-f68.google.com with SMTP id 129so1213911ywb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 18:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDmQxANGbqTJGtO1OhTa4PkciZSXcUVcA6Y2VnUF5Ug=;
        b=tRuQF9NGsWriwh9rOUGWV/XnpvxEIfrIBLDnzsNlL2DcXYptI5uYx9v9XRgXG9ikj+
         lAdRFBmN8WWgzpxjYwMBvOBMGH9vQkyzn/bAHiywFTqTy8Rv0zmy7NK3LdyKNjjgvNdr
         mcLlIarH9lbZWT5t7oU7MIVWXKIhgWd4FFEn+XvtJUHOlIO0rItLGA+Zt6tlzfYijXTt
         MmEvGy0xnlwDGgt/OUq/OkC9egtS+p7sT3eJ3BcAb9vNf6OatXnbSWZ0hHXVonsgbMVH
         pMy2zHMasv+EgzYrXDb3idQdrvXUOVYyNS1FKC2EzXUecfAda8U+O/uwCTXSTJ6SOTSm
         T3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDmQxANGbqTJGtO1OhTa4PkciZSXcUVcA6Y2VnUF5Ug=;
        b=sWdd+tkIdkca6V8EEGmehrNlWwskamFFwhMEG98Wc9h78vSMU63JxZL3bgo7kh7TxW
         9zz2mVLeOXUR9HZS4HbcPdqhpuxisH5HoNvU0PrnuvCsevFl6F7QlBeX0c8LwlFcRMCP
         3v5qUDt7QVJODIIg6QN7BMUnNcdRqVf55Bl6gBe59/AEYx3Nb4uTlzfxsYA5VQCWAhY3
         aLr/c8ol8Mv5T1MKYhqDnf/Wtskn01GupHnnmnfk97+QVEEWxSr5ol5x024JZ2rngtwB
         cXN2n2IYlxc5JoMpGSKgdIAjKrS/uysDIACRqjo3ZHK54ob2N4WDC0N67QkoaTZnT05t
         FT0A==
X-Gm-Message-State: APjAAAWkKWxQKgt5JjpcazcDwCgD4O4qaWqkEwyBJbk2g3pShgCtFVMP
        kErxeWmZ4dtucp/mWukN7lWc+zWJgmTWJBBT3Rl+Ow==
X-Google-Smtp-Source: APXvYqyIDKOrxjb28zWL9kagM4gqNHMvZYp0EWQP/d+eBC6/dEWbXTKwXclpCyHxrYDHzsr0mwrMijbohn/hHGTlziQ=
X-Received: by 2002:a81:3681:: with SMTP id d123mr9802172ywa.348.1567128600919;
 Thu, 29 Aug 2019 18:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190807013340.9706-1-jhubbard@nvidia.com> <912eb2bd-4102-05c1-5571-c261617ad30b@nvidia.com>
In-Reply-To: <912eb2bd-4102-05c1-5571-c261617ad30b@nvidia.com>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Thu, 29 Aug 2019 21:29:50 -0400
Message-ID: <CAOg9mSQKGDywcMde2DE42diUS7J8m74Hdv+xp_PJhC39EXZQuw@mail.gmail.com>
Subject: Re: [PATCH v3 00/39] put_user_pages(): miscellaneous call sites
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     john.hubbard@gmail.com, Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx@lists.freedesktop.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        devel@driverdev.osuosl.org, devel@lists.orangefs.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-media@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-xfs@vger.kernel.org, netdev@vger.kernel.org,
        rds-devel@oss.oracle.com, sparclinux@vger.kernel.org,
        x86@kernel.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John...

I added this patch series on top of Linux 5.3rc6 and ran
xfstests with no regressions...

Acked-by: Mike Marshall <hubcap@omnibond.com>

-Mike

On Tue, Aug 6, 2019 at 9:50 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/6/19 6:32 PM, john.hubbard@gmail.com wrote:
> > From: John Hubbard <jhubbard@nvidia.com>
> > ...
> >
> > John Hubbard (38):
> >   mm/gup: add make_dirty arg to put_user_pages_dirty_lock()
> ...
> >  54 files changed, 191 insertions(+), 323 deletions(-)
> >
> ahem, yes, apparently this is what happens if I add a few patches while editing
> the cover letter... :)
>
> The subject line should read "00/41", and the list of files affected here is
> therefore under-reported in this cover letter. However, the patch series itself is
> intact and ready for submission.
>
> thanks,
> --
> John Hubbard
> NVIDIA
