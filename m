Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D118C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286E42080F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pzHN7zvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK0TD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:03:27 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35065 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbfK0TD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:03:27 -0500
Received: by mail-qk1-f193.google.com with SMTP id v23so12691004qkg.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Ns8iu9D49xQ4IeMW2/4gv78eKGaXwmWoNevNMNlTk40=;
        b=pzHN7zvkbUTkQa4WJmX1slaYlJ5eM0y/srER0U9JFmrrKZgkfCntUm58vjFRciwZ4T
         6TCcWfaYF+zDxmNgHb8sVScjj4QM3XFf831namegspvyfhL2x7SODdxhkKSRzYJajzAc
         OUI7IX79X6Lfqhz7c9BG3xQ/MPOaupuXfxPwC1usEyEx05/fPQeSyCoAUkqZfkbpJv1U
         Y7AqriiCVPd/q62rw2jDOJg+dc6mV3lSzNzDqa2NtGc78ByHVNxVoouEMCXnIoGDl7oQ
         Wde7lkJYpzJm2t4D6yoCNMVWMh8KxiPaMwW8kTrkUWAgU5m8x4B9YKfjGjAZJtjAN1A4
         MWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Ns8iu9D49xQ4IeMW2/4gv78eKGaXwmWoNevNMNlTk40=;
        b=BHCbq/MGfitXCObON9IbCnTQbfP25iyIwq622clZBUt0bbXT+hhoKh84INyK7qs1Wd
         q/zz0kjBlSBqjgKKJWHAmT7OFmVU5ThyqHPIebJYZ0t8N7ag4+NSQG/WcPp4s+p8pYI+
         BaznB5k1kFcfAmUBc55oETR0r7Zkib/UHvCLwgr6t/6FLw6bjTXgrUTkRsq/aDbVnbR4
         238zvholEqSGD+7oYtlC2dvoJPzeTwapAp99fJ+Nzm8veUr3uRODnf2uUke+McMLVx/e
         nh+e7DeWfCncG7GaxxZ0RhPbfPo5P3/dy7pIJsgjzYQKmA9nB0KgOeC/ZTunspVZSATf
         3h4A==
X-Gm-Message-State: APjAAAV4jPIfzKv/y4r2qQv7tHuvWEAkYYs4wKQQp2bvSWunuZmPQQ6n
        LY+w+aVI/mol6G8umMcvu4DOgmQ9Qtmc/g==
X-Google-Smtp-Source: APXvYqxiQmN/hmDQO7QTsbci5YUMHjW00APmZIZjqmyjyZBbOtcihhNld5EdGDbvmdS/4Sf6ulVOqg==
X-Received: by 2002:a37:bc81:: with SMTP id m123mr6216808qkf.358.1574881404551;
        Wed, 27 Nov 2019 11:03:24 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k196sm7242887qke.97.2019.11.27.11.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:03:23 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 14:03:22 -0500
Message-Id: <74CE315E-319F-4D2D-8276-7F89293286CF@lca.pw>
References: <20191127174158.28226-1-david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <20191127174158.28226-1-david@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 12:42 PM, David Hildenbrand <david@redhat.com> wrote:
>=20
> Now that we always check against a zone, we can stop checking against
> the nid, it is implicitly covered by the zone.
>=20
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> mm/memory_hotplug.c | 23 ++++++++---------------
> 1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 46b2e056a43f..602f753c662c 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -344,17 +344,14 @@ int __ref __add_pages(int nid, unsigned long pfn, un=
signed long nr_pages,
> }
>=20
> /* find the smallest valid pfn in the range [start_pfn, end_pfn) */
> -static unsigned long find_smallest_section_pfn(int nid, struct zone *zone=
,
> -                     unsigned long start_pfn,
> -                     unsigned long end_pfn)
> +static unsigned long find_smallest_section_pfn(struct zone *zone,
> +                           unsigned long start_pfn,
> +                           unsigned long end_pfn)
> {
>    for (; start_pfn < end_pfn; start_pfn +=3D PAGES_PER_SUBSECTION) {
>        if (unlikely(!pfn_to_online_page(start_pfn)))
>            continue;
>=20
> -        if (unlikely(pfn_to_nid(start_pfn) !=3D nid))
> -            continue;

Are you sure? I thought this is to check against machines with odd layouts, n=
o?=20

			/*
			 * Nodes's pfns can be overlapping.
			 * We know some arch can have a nodes layout such a=
s
			 * -------------pfn-------------->
			 * N0 | N1 | N2 | N0 | N1 | N2|....
			 */

