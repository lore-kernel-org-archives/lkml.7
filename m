Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDCDC43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41C1E20656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 14:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfD2OiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 10:38:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46572 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2OiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 10:38:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1630D3082B69;
        Mon, 29 Apr 2019 14:37:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-45.ams2.redhat.com [10.36.116.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B51B2608C2;
        Mon, 29 Apr 2019 14:37:58 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id A6D1811AAA; Mon, 29 Apr 2019 16:37:57 +0200 (CEST)
Date:   Mon, 29 Apr 2019 16:37:57 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        David Airlie <airlied@redhat.com>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>
Subject: Re: [Spice-devel] [PATCH] Revert "drm/qxl: drop prime import/export
 callbacks"
Message-ID: <20190429143757.yljjfsgobhi23xnb@sirius.home.kraxel.org>
References: <20190426053324.26443-1-kraxel@redhat.com>
 <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
 <20190429075413.smcocftjd2viznhv@sirius.home.kraxel.org>
 <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFB8deXDMP9cT634p_dK5LsM37R1v_vGhAEY1ZLZ+WBVA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Mon, 29 Apr 2019 14:38:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > More useful would be some way to signal this self-reimport capability
> > to userspace somehow.  See DRM_PRIME_CAP_LOCAL patch.
> 
> Userspace is supposed to test whether import/export works for a
> specific combo, not blindly assume it does and then keel over. I think
> we need to fix that, not add more flags - there's lots of reasons why
> a given pair of devices can't share buffers (e.g. all the contiguous
> allocations stuff on socs).

Ok.  Lets scratch the DRM_PRIME_CAP_LOCAL idea then and blame userspace
instead.

> > Right now I have the choice to set DRM_PRIME_CAP_{IMPORT,EXPORT}, in
> > which case some userspace assumes it can do cross-driver export/import
> > and trips over that not working.  Or I do not set
> > DRM_PRIME_CAP_{IMPORT,EXPORT}, which breaks DRI3 ...
> 
> Yeah that's not an option.

Good.  Can I get an ack for this patch then, as it unbreaks DRI3 with qxl?

thanks,
  Gerd

