Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB743C31E40
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 873622171F
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="VhXMIl/e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730655AbfHOHOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:14:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37781 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730643AbfHOHOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:14:20 -0400
Received: by mail-ed1-f67.google.com with SMTP id f22so1355886edt.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rjonirMyNKFLmr6pNWt9/0hY9meFYjEaFyv9/3cyMYc=;
        b=VhXMIl/eHGwrgkMfakF/qwMwhZWtWXKUF49966PDQfDBaReTfTCf/9nggMPlMNxWd0
         5XGY5nleuGWkyUPLKbEn0i0w72q4fQknknNeCXEqoKNJzPn1PhygwPcQnXfTc4lcwPVZ
         nORHA6FNAFB2JO91ROMe5aGnJiwmdIbl2oD7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=rjonirMyNKFLmr6pNWt9/0hY9meFYjEaFyv9/3cyMYc=;
        b=EWSY00ZMC5vY6Ad9u468eKRXOSqUACYoJmXdar9oOR+zlcNh4zolzxKISgXekYyPI+
         438CP10qW5ptPTQENojPFqfrVM97V/PpuSkH555Kg8Ap9+i+Uvc22fMBDFCbfJ9L3sq1
         Gq63x60es/eSa/dHD2ELJQJfMhMl2zohzvK/FASVn+JUHlrPNtS9+x8U+1j0JAN0t/Df
         d/kwKFcKJrRDq/TRowPoMVqJ7vaYIb1bO7ehkfqcV/Byy79uQBb9Fk5t7n/4WcE9KvOG
         STSHP9L4CaURvPCe68C/l7mggH1kDsCaM1d8ByvcL1msL4u2p6V3ZEAckbtQB0bdjX4K
         v+eA==
X-Gm-Message-State: APjAAAWInVhJuFhJozozEDpuOOpNepRHLGspB9s0JrsJTibEdPUwgThP
        o2AdlWafr1IesDtKabGzsuoCag==
X-Google-Smtp-Source: APXvYqxHFed471aqkz65evmjZ3bTGMMJcAWmhTm+eeuK6Ic5QidqvFlMXSewSwbHwYbGaD4JTt8JMw==
X-Received: by 2002:a17:906:504e:: with SMTP id e14mr178194ejk.204.1565853258482;
        Thu, 15 Aug 2019 00:14:18 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id br8sm265471ejb.92.2019.08.15.00.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 00:14:17 -0700 (PDT)
Date:   Thu, 15 Aug 2019 09:14:15 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 5/5] mm/hmm: WARN on illegal ->sync_cpu_device_pagetables
 errors
Message-ID: <20190815071415.GD7444@phenom.ffwll.local>
Mail-Followup-To: Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
        Balbir Singh <bsingharora@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>
References: <20190814202027.18735-1-daniel.vetter@ffwll.ch>
 <20190814202027.18735-6-daniel.vetter@ffwll.ch>
 <20190815001137.GE11200@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190815001137.GE11200@ziepe.ca>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 09:11:37PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 14, 2019 at 10:20:27PM +0200, Daniel Vetter wrote:
> > Similar to the warning in the mmu notifer, warning if an hmm mirror
> > callback gets it's blocking vs. nonblocking handling wrong, or if it
> > fails with anything else than -EAGAIN.
> > 
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Cc: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Balbir Singh <bsingharora@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Souptick Joarder <jrdr.linux@gmail.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: "Jérôme Glisse" <jglisse@redhat.com>
> > Cc: linux-mm@kvack.org
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> >  mm/hmm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 16b6731a34db..52ac59384268 100644
> > +++ b/mm/hmm.c
> > @@ -205,6 +205,9 @@ static int hmm_invalidate_range_start(struct mmu_notifier *mn,
> >  			ret = -EAGAIN;
> >  			break;
> >  		}
> > +		WARN(ret, "%pS callback failed with %d in %sblockable context\n",
> > +		     mirror->ops->sync_cpu_device_pagetables, ret,
> > +		     update.blockable ? "" : "non-");
> >  	}
> >  	up_read(&hmm->mirrors_sem);
> 
> Didn't I beat you to this?

Very much possible, I think I didn't rebase this to linux-next before
resending ... have an

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

in case you need.

Cheers, Daniel

> 
> 	list_for_each_entry(mirror, &hmm->mirrors, list) {
> 		int rc;
> 
> 		rc = mirror->ops->sync_cpu_device_pagetables(mirror, &update);
> 		if (rc) {
> 			if (WARN_ON(update.blockable || rc != -EAGAIN))
> 				continue;
> 			ret = -EAGAIN;
> 			break;
> 		}
> 	}
> 
> Thanks,
> Jason

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
