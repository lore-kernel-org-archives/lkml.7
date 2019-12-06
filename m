Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B04C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF372173E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:22:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TV+y7iCr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfLFKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:22:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39035 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726128AbfLFKWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:22:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575627727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oPXPVF5DYoU7fv7fbWpSb9qOw8HQXQZZ77OFuUMIvww=;
        b=TV+y7iCrC9Nt0v+os9as0jp/kcob5dN6cyj30aEk7bgiSZ5BLrTu8o1Jt7s9VBzM6gwoK1
        KGrW0PdgmVm6/eoDKJHTCVkXPKGNNB2FrqKBCIEtAI8Dz1E3dgt8+ZW6ozLAhrCs7RxLhf
        wrSBPx/qNfy1UBCNYUl4W5Z8yY9OMBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-mG1Qb4gPNYOp7hybu0Rm2g-1; Fri, 06 Dec 2019 05:22:03 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4726800D5F;
        Fri,  6 Dec 2019 10:22:01 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5698919C4F;
        Fri,  6 Dec 2019 10:22:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 5D90516E18; Fri,  6 Dec 2019 11:22:00 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:22:00 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, robh@kernel.org,
        intel-gfx@lists.freedesktop.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] drm: call drm_gem_object_funcs.mmap with fake
 offset
Message-ID: <20191206102200.6osisct57n424ujn@sirius.home.kraxel.org>
References: <20191127092523.5620-1-kraxel@redhat.com>
 <20191127092523.5620-2-kraxel@redhat.com>
 <20191128113930.yhckvneecpvfhlls@sirius.home.kraxel.org>
 <20191205221523.GN624164@phenom.ffwll.local>
 <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20191206100724.ukzdyaym3ltcyfaa@sirius.home.kraxel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: mG1Qb4gPNYOp7hybu0Rm2g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 11:07:24AM +0100, Gerd Hoffmann wrote:
> On Thu, Dec 05, 2019 at 11:15:23PM +0100, Daniel Vetter wrote:
> > Looks like unrelated flukes, this happens occasionally. If you're paran=
oid
> > hit the retest button on patchwork to double-check.
> > -Daniel
>=20
> Guess you kicked CI?  Just got CI mails, now reporting success, without
> doing anything.  So I'll go push v3 to misc-next.

Oops, spoke too soon.  Next mail arrived.  Fi.CI.BAT works, but
Fi.CI.IGT still fails.

Where is the "test again" button?  Can I re-run the tests on v2?  Right
now I tend to commit v2 to have a fix committed, then go figure why v3
fails ...

cheers,
  Gerd

