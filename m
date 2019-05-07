Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225F7C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5FEE20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 15:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="P0NmBCU8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbfEGPkm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 11:40:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45559 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfEGPkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 11:40:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id a10so15336587otl.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
        b=P0NmBCU8zUOfaF8xaYZsuZ8crvxFB33fl7wDNB9MZv5fgE9bufZ9uXOFacVBRIyhyk
         7jy7cEut0ZZu1RaoDtrr50BVaB/CX/skGeBOtXxoGAGKW89ZemgDpFwl6g0BCyZNTY71
         c96Bv/+lzcoe4YYcd5EMePUR4gTK7GrAqK6itLr2obeqWzYKb3Dql3mDDHzIv1x+/JnT
         zIvYGvdBDonXfV8sEZV0PvMIvA63l1OoRV+8kWQPCfuhVRSXMOb+jYMxWFhFzCGAXSHH
         RES21PeWYeTfPIbRNgVP3JVS3PVW0F6JNq0X1vpUrTbfXgSQ4Ev5ZlVumch1kGRMghci
         mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
        b=HVeoP8TO99ChI2gNQ2g+ky2j8VOpU3s7xIToLIMAVf+wwmuK0Ma2HlGciKuFH3IDbv
         suicEEF64RsZiomrxDqW0imxUhqayBzlgXksE+3eaNYDTfUtMCt7TXueJICDpBrhMEt4
         KoHw90UHjLO2Tj5gwiYgJJjW0l/Pza7D40PcDrVHRm3+BfXWzFK1d5Exg+IZmcCw35FD
         wlBTtDBi8uX2TfEpIjGvUv68bRKFsaBoo1DgxONwYTnu+0iBgzHLAH8WAmcmuyYd4leb
         1PxmZnPNeJz95uvWJBJQzRV25QzzWX9Pcf07Xf6G9MSSaUn0LjKjtEvD0veYk41cXr3b
         KLfg==
X-Gm-Message-State: APjAAAU42cHv+Yw/9Ic0AFi5WoPfjkrlu3vuKh6aOgg+XjlBA7tsRirF
        WtUFE+58uaRYmQC7WuFaPapczIQgNGB57Mm0+teH/Q==
X-Google-Smtp-Source: APXvYqxgIWANkc/KHq9kAogc8tqlkqRrOccsWEIKbqAeeZcNH5LiQg3MPoGwMh9hdCCYG0LuKCXgqpIi0akzNLzuZFI=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22033787ota.353.1557243640877;
 Tue, 07 May 2019 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com> <20190426050039.17460-4-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-4-pagupta@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 7 May 2019 08:40:30 -0700
Message-ID: <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] libnvdimm: add dax_dev sync flag
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        KVM list <kvm@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Ross Zwisler <zwisler@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christoph Hellwig <hch@infradead.org>,
        Len Brown <lenb@kernel.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        lcapitulino@redhat.com, Kevin Wolf <kwolf@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        jmoyer <jmoyer@redhat.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        david <david@fromorbit.com>, cohuck@redhat.com,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kilobyte@angband.pl,
        yuval shaia <yuval.shaia@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 10:02 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_SYNC' flag which is set
> for nd_region doing synchronous flush. This later
> is used to disable MAP_SYNC functionality for
> ext4 & xfs filesystem for devices don't support
> synchronous flush.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0dd316a74a29..c97fc0cc7167 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -7,6 +7,9 @@
>  #include <linux/radix-tree.h>
>  #include <asm/pgtable.h>
>
> +/* Flag for synchronous flush */
> +#define DAXDEV_F_SYNC true

I'd feel better, i.e. it reads more canonically, if this was defined
as (1UL << 0) and the argument to alloc_dax() was changed to 'unsigned
long flags' rather than a bool.
