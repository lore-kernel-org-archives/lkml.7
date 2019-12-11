Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DD65C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6A222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 13:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f6O4NzmA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbfLKNKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 08:10:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54830 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729299AbfLKNKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 08:10:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576069811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9eYb2Zr4aouyWVOs1ApAsQoZVXyaK3L18xDM6NySAw=;
        b=f6O4NzmAxIK4/hQZf8hkIwGjGWr257VBKD8zEwqZbfFEzhZUTkio8rObGKOqHvBswB9wQh
        rTMBBS8eOt169pJihe5JlksoJrv19Aj/uUSkOzEmzIMv6HVYk2nLzb5OW3ToCpq6xxI+p2
        JvIyi4fbl6NGv1e7yksnMfF14I6f6dU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-Q1qPQcIRNgi3tQPSJY7csw-1; Wed, 11 Dec 2019 08:10:08 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6763A800EB5;
        Wed, 11 Dec 2019 13:10:07 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0999960BE2;
        Wed, 11 Dec 2019 13:10:07 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F16D716E05; Wed, 11 Dec 2019 14:10:05 +0100 (CET)
Date:   Wed, 11 Dec 2019 14:10:05 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        gurchetansingh@chromium.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] drm: add pgprot callback to drm_gem_object_funcs
Message-ID: <20191211131005.ojbnsu3rvorlgnof@sirius.home.kraxel.org>
References: <20191211121957.18637-1-kraxel@redhat.com>
 <20191211121957.18637-2-kraxel@redhat.com>
 <20191211123835.GZ624164@phenom.ffwll.local>
MIME-Version: 1.0
In-Reply-To: <20191211123835.GZ624164@phenom.ffwll.local>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: Q1qPQcIRNgi3tQPSJY7csw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +=09/**
> > +=09 * @pgprot:
> > +=09 *
> > +=09 * Tweak pgprot as needed, typically used to set cache bits.
> > +=09 *
> > +=09 * This callback is optional.
> > +=09 *
> > +=09 * If unset drm_gem_pgprot_wc() will be used.
> > +=09 */
> > +=09pgprot_t (*pgprot)(struct drm_gem_object *obj, pgprot_t prot);
>=20
> I kinda prefer v1, mostly because this is a huge can of worms, and solvin=
g
> this properly is going to be real hard (and will necessarily involve
> dma-buf and dma-api and probably more). Charging ahead here just risks
> that we dig ourselves into a corner. You're v1 is maybe not the most
> clean, but just a few code bits here&there should be more flexible and
> easier to hack on and experiment around with.

Hmm.  Second vote for v1.

Problem with v1 is that it covers mmap() only, not vmap() ...

cheers,
  Gerd

