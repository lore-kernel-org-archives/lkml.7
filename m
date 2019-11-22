Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF9CC432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50A07204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 06:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iSyZiWWc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbfKVGcq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 01:32:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726529AbfKVGcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 01:32:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574404365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ihHqeHetXpxDUSWXALWO2fESEh+WPpRGUu/UkNC3/0k=;
        b=iSyZiWWcaaWHYk4/K9z+CR/QYvErqm4OsWYuKY6m16p6H3yI7W7IDN/i13J+OdReYjCmzP
        Q3L67rVF0NXGuNVDQkM8eg6MGl3BE+U2oJfdMMaeODNgJiNthgKkmzCfhXH+hn5zGcerg4
        8TR2ETya36lKpb22tBuYg/DoArnANsI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-3jIkdFjwOJmqko0S6EzAiQ-1; Fri, 22 Nov 2019 01:32:41 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B032801E74;
        Fri, 22 Nov 2019 06:32:38 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com [10.36.116.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2815F700;
        Fri, 22 Nov 2019 06:32:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D0D161747D; Fri, 22 Nov 2019 07:32:36 +0100 (CET)
Date:   Fri, 22 Nov 2019 07:32:36 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Ruhl, Michael J" <michael.j.ruhl@intel.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [Intel-gfx] [PATCH 2/2] drm: share address space for dma bufs
Message-ID: <20191122063236.vs3bh6xvmswlszte@sirius.home.kraxel.org>
References: <20191121103807.18424-1-kraxel@redhat.com>
 <20191121103807.18424-3-kraxel@redhat.com>
 <14063C7AD467DE4B82DEDB5C278E8663D9C8F533@FMSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
In-Reply-To: <14063C7AD467DE4B82DEDB5C278E8663D9C8F533@FMSMSX108.amr.corp.intel.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 3jIkdFjwOJmqko0S6EzAiQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2019 at 04:42:10PM +0000, Ruhl, Michael J wrote:
> >-----Original Message-----
> >From: Intel-gfx <intel-gfx-bounces@lists.freedesktop.org> On Behalf Of G=
erd
> >Hoffmann
> >Sent: Thursday, November 21, 2019 5:38 AM
> >To: dri-devel@lists.freedesktop.org
> >Cc: David Airlie <airlied@linux.ie>; intel-gfx@lists.freedesktop.org; op=
en list
> ><linux-kernel@vger.kernel.org>; Maxime Ripard <mripard@kernel.org>; Gerd
> >Hoffmann <kraxel@redhat.com>
> >Subject: [Intel-gfx] [PATCH 2/2] drm: share address space for dma bufs
> >
> >Use the shared address space of the drm device (see drm_open() in
> >drm_file.c) for dma-bufs too.  That removes a difference betweem drm
> >device mmap vmas and dma-buf mmap vmas and fixes corner cases like
> >unmaps not working properly.
>=20
> Hi Gerd,
>=20
> Just want to make sure I understand this...
>=20
> So unmaps will not work correctly for mappings when a driver does a
> drm_vma_node_unamp()?

Completely removing the mapping (aka munmap syscall) works fine.
Zapping the pte's (using madvise(dontneed) for example) doesn't.

> This is a day one bug?

I guess so, but I'll leave that to others being active longer than me in
drm hacking to answer ...

cheers,
  Gerd

