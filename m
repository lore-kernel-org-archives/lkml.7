Return-Path: <SRS0=Kqgt=XG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5143CC49ED6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9EE207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Sep 2019 13:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbfIKNv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Sep 2019 09:51:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48366 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728068AbfIKNv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Sep 2019 09:51:27 -0400
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4068769098
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 13:51:27 +0000 (UTC)
Received: by mail-qk1-f200.google.com with SMTP id n135so24976766qke.23
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2019 06:51:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=152d67FF4RV7HTf/TX16nav3+dbWDhuM37ZTXxyyvyE=;
        b=rS9YePnvWGMLCmEuQkxcdV/Q1xM0rKfgcXo+fEOlDGIx9IX836dHb5rFZBFUvWMKdQ
         WjXC/Eqgn8KkhY+0WO0DuEbB+2suwqjJyvAFnrhEMyAAj479NhI073qvjgiODLNcTKB3
         gZgqPJQ0CTR2qpm/BuWeeAw1eK8ip/2K6njQJI+cQuga9Jo/y3LAihUQZBetGcpQN6tZ
         kYIdisXcGKSrNs0NFEuj+gsIaLqmbe3C+p0MRpgbOSRwXi+YvyrC+fd7r7a4tq1XWDtZ
         P2JxEsYRZQsws/O4RZY3CrzKOb00gGCWCMCCxKv6NcTIJ+dNhgnK26GcDeh/P9HSRB4I
         YLlg==
X-Gm-Message-State: APjAAAW+I000MiyCjfFcAhVi4i5u5phHjtnIUVPyYV+VSjoRPQ8LJf0h
        /4+zvQwg79Ni48xX4jkg7XJl4J4gT2R6TuRiqTR88UzvdQWPgbt7ULafCNKnQKsd7eSrcw82+6f
        a1/HI/BMkmuNUAt8JSnEWQiaX
X-Received: by 2002:ac8:6706:: with SMTP id e6mr2563900qtp.143.1568209886593;
        Wed, 11 Sep 2019 06:51:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwaO6d0va5B79pj+BVvjOJY7I7L3GALGaTfXtlaBYWZSZUc9ffvRmXeRRX5Y4F/HwVRR5aQWQ==
X-Received: by 2002:ac8:6706:: with SMTP id e6mr2563882qtp.143.1568209886370;
        Wed, 11 Sep 2019 06:51:26 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
        by smtp.gmail.com with ESMTPSA id y58sm5426960qta.1.2019.09.11.06.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2019 06:51:25 -0700 (PDT)
Date:   Wed, 11 Sep 2019 09:51:20 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v2] vhost: block speculation of translated descriptors
Message-ID: <20190911092544-mutt-send-email-mst@kernel.org>
References: <20190911120908.28410-1-mst@redhat.com>
 <20190911121628.GT4023@dhcp22.suse.cz>
 <20190911082236-mutt-send-email-mst@kernel.org>
 <20190911123316.GX4023@dhcp22.suse.cz>
 <20190911085807-mutt-send-email-mst@kernel.org>
 <20190911131235.GZ4023@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190911131235.GZ4023@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 03:12:35PM +0200, Michal Hocko wrote:
> On Wed 11-09-19 09:03:10, Michael S. Tsirkin wrote:
> > On Wed, Sep 11, 2019 at 02:33:16PM +0200, Michal Hocko wrote:
> > > On Wed 11-09-19 08:25:03, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 11, 2019 at 02:16:28PM +0200, Michal Hocko wrote:
> > > > > On Wed 11-09-19 08:10:00, Michael S. Tsirkin wrote:
> > > > > > iovec addresses coming from vhost are assumed to be
> > > > > > pre-validated, but in fact can be speculated to a value
> > > > > > out of range.
> > > > > > 
> > > > > > Userspace address are later validated with array_index_nospec so we can
> > > > > > be sure kernel info does not leak through these addresses, but vhost
> > > > > > must also not leak userspace info outside the allowed memory table to
> > > > > > guests.
> > > > > > 
> > > > > > Following the defence in depth principle, make sure
> > > > > > the address is not validated out of node range.
> > > > > > 
> > > > > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > > > Tested-by: Jason Wang <jasowang@redhat.com>
> > > > > 
> > > > > no need to mark fo stable? Other spectre fixes tend to be backported
> > > > > even when the security implications are not really clear. The risk
> > > > > should be low and better to be covered in case.
> > > > 
> > > > This is not really a fix - more a defence in depth thing,
> > > > quite similar to e.g.  commit b3bbfb3fb5d25776b8e3f361d2eedaabb0b496cd
> > > > x86: Introduce __uaccess_begin_nospec() and uaccess_try_nospec
> > > > in scope.
> > > >
> > > > That one doesn't seem to be tagged for stable. Was it queued
> > > > there in practice?
> > > 
> > > not marked for stable but it went in. At least to 4.4.
> > 
> > So I guess the answer is I don't know. If you feel it's
> > justified, then sure, feel free to forward.
> 
> Well, that obviously depends on you as a maintainer but the point is
> that spectre gatgets are quite hard to find. There is a smack check
> AFAIK but that generates quite some false possitives and it is PITA to
> crawl through those. If you want an interesting (I am not saying
> vulnerable on purpose) gatget then it would be great to mark it for
> stable so all stable consumers (disclaimer: I am not one of those) and
> add that really great feeling of safety ;)
> 
> So take this as my 2c

OK it seems security@kernel.org is the way to handle these things.
I'll try that.

> -- 
> Michal Hocko
> SUSE Labs
