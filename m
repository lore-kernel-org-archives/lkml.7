Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D22C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F76420709
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 22:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577140484;
	bh=j8a30uKBFpUoS+kQpAO4xSXpzCOq7JiQ5JV9DxclKWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=dGUTLtALOL6xpSv03TvV0wWdltkc6wV93AZAzyuS51laulzdcKWryzSBmwJxLHhnW
	 fV1yJI61R5UMt/03+w2TrdPxcSdFcbvDy+RsWWU1qRmbAQ7/9Dj6+xk2HqT39b/YbB
	 hINHI85BNBIk53SWRW03mgto52WG4MwZuul99Jgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbfLWWen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 17:34:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:37952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfLWWem (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 17:34:42 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0509D206CB;
        Mon, 23 Dec 2019 22:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577140482;
        bh=j8a30uKBFpUoS+kQpAO4xSXpzCOq7JiQ5JV9DxclKWA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hr5gCpX42uVTaiblB+Bfoal6gLIaxariS4egoyL+iBb+XHZcr0tzDHaLeCzdlgDOU
         HRI6QaMGoQ7qNf6L6plJkPd3QaplPS1+N4TVRYZEd9LdzXOoqiQ7tFcBJ3u+Es7+0P
         WC/F2V273Qdwx2+20nZXtt2YIiZqq554kkwk5QNg=
Date:   Mon, 23 Dec 2019 14:34:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Thomas =?ISO-8859-1?Q?Hellstr=F6m?= (VMware) 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@suse.com>,
        pv-drivers@vmware.com, linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: Ack to merge through DRM tree? WAS [PATCH v4 0/2] mm, drm/ttm:
 Fix pte insertion with customized protection
Message-Id: <20191223143441.38bca86132378a801094c0cc@linux-foundation.org>
In-Reply-To: <cc7e153d-84ff-d1f8-484f-614eafac1864@shipmail.org>
References: <20191212084741.9251-1-thomas_os@shipmail.org>
        <cc7e153d-84ff-d1f8-484f-614eafac1864@shipmail.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2019 09:06:08 +0100 Thomas Hellstr=F6m (VMware) <thomas_os@s=
hipmail.org> wrote:

> Andrew,
>=20
> On 12/12/19 9:47 AM, Thomas Hellstr=F6m (VMware) wrote:
> > From: Thomas Hellstrom <thellstrom@vmware.com>
> >
> > The drm/ttm module is using a modified on-stack copy of the
> > struct vm_area_struct to be able to set a page protection with customiz=
ed
> > caching. Fix that by adding a vmf_insert_mixed_prot() function similar
> > to the existing vmf_insert_pfn_prot() for use with drm/ttm.
> >
> > I'd like to merge this through a drm tree.
> >
> > Changes since v1:
> > *) Formatting fixes in patch 1
> > *) Updated commit message of patch 2.
> > Changes since v2:
> > *) Moved vmf_insert_mixed_prot() export to patch 2 (Michal Hocko)
> > *) Documented under which conditions it's safe to use a page protection
> >     different from struct vm_area_struct::vm_page_prot. (Michal Hocko)
> > Changes since v3:
> > *) More documentation regarding under which conditions it's safe to use=
 a
> >     page protection different from struct vm_area_struct::vm_page_prot.=
 This
> >     time also in core vm. (Michal Hocko)
> >
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: Ralph Campbell <rcampbell@nvidia.com>
> > Cc: "J=E9r=F4me Glisse" <jglisse@redhat.com>
> > Cc: "Christian K=F6nig" <christian.koenig@amd.com>
> >
> Seems all concerns with this series have been addressed. Could I have an=
=20
> ack to merge this through a DRM tree?
>=20

Yes, please do that.

Acked-by: Andrew Morton <akpm@linux-foundation.org>

for both.
