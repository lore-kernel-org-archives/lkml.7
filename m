Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA8CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103BE20716
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 11:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="epPaeNaK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbfLSLcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 06:32:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54900 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726656AbfLSLcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 06:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576755127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KQVy1060cIcwdmA+aV3D7jzIs8ekG/8Yaj3TYu2HIws=;
        b=epPaeNaKmi+ogpQYq5/P7IsgijAekT88f9uUs7Jlxm9egU3iGO8/xjnmxdwECe/dW9TtLQ
        MJ6Ff/rEuxiwLWn8uYVPEEYZKVZa6pNN+gook/kGqypSOsnFYE9OtF8TAMcAV5ZVPl1OnN
        LwUt73xBK3xdCjo3dd+bIPaM/Edus/o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-177-1dfDxRcXPu6wUynMAn751g-1; Thu, 19 Dec 2019 06:32:02 -0500
X-MC-Unique: 1dfDxRcXPu6wUynMAn751g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34B2D803A4C;
        Thu, 19 Dec 2019 11:31:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-98.ams2.redhat.com [10.36.116.98])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D99963B89;
        Thu, 19 Dec 2019 11:31:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C695311AAA; Thu, 19 Dec 2019 12:31:51 +0100 (CET)
Date:   Thu, 19 Dec 2019 12:31:51 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     John Garry <john.garry@huawei.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        "kongxinwei (A)" <kong.kongxinwei@hisilicon.com>,
        "Chenfeng (puck)" <puck.chen@hisilicon.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linuxarm <linuxarm@huawei.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dbueso@suse.de
Subject: Re: Warnings in DRM code when removing/unbinding a driver
Message-ID: <20191219113151.sytkoi3m7rrxzps2@sirius.home.kraxel.org>
References: <07899bd5-e9a5-cff0-395f-b4fb3f0f7f6c@huawei.com>
 <f867543cf5d0fc3fdd0534749326411bcfc5e363.camel@collabora.com>
 <c2e5f5a5-5839-42a9-2140-903e99e166db@huawei.com>
 <fde72f73-d678-2b77-3950-d465f0afe904@huawei.com>
 <CAKMK7uFr03euoB6rY8z9zmRyznP41vwfdaKApZ_0HfYZT4Hq_w@mail.gmail.com>
 <fcca5732-c7dc-6e1d-dcbe-bfd914a4295b@huawei.com>
 <CAKMK7uE+nfR2hv1ybfv1ZApZbGnnX7ZHfjFCv5K72ZaAmdtfug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uE+nfR2hv1ybfv1ZApZbGnnX7ZHfjFCv5K72ZaAmdtfug@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> >   Like I said, for most drivers
> > > you can pretty much assume that their unload sequence has been broken
> > > since forever. It's not often tested, and especially the hotunbind
> > > from a device (as opposed to driver unload) stuff wasn't even possible
> > > to get right until just recently.
> >
> > Do you think it's worth trying to fix this for 5.5 and earlier, or just
> > switch to the device-managed interface for 5.6 and forget about 5.5 and
> > earlier?
> 
> I suspect it's going to be quite some trickery to fix this properly
> and everywhere, even for just one driver. Lots of drm drivers
> unfortunately use anti-patterns with wrong lifetimes (e.g. you can't
> use devm_kmalloc for anything that hangs of a drm_device, like
> plane/crtc/connector). Except when it's for a real hotunpluggable
> device (usb) we've never bothered backporting these fixes. Too much
> broken stuff unfortunately.

While being at it:  How would a driver cleanup properly cleanup gem
objects created by userspace on hotunbind?  Specifically a gem object
pinned to vram?

cheers,
  Gerd

