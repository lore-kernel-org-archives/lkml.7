Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD2DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A97821873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553103879;
	bh=pWBZMiDJ4MfbJ8pnd+IJ2rbVZAb1N+eaq/Nw+CLDzNo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O8mzBd08IHAAZuCy+paTtQ22NEAAkhdchEbXKrpdZd2KPjKu6bCzI6FWrp/JyNRl8
	 5+Tosbkfgr0PhqdBSPKbYkHs8Tb7XRiLkqe2WJ43930+nFF8EKlszWHGrhXhLSSGWg
	 2+P3dMUvdzY/6sEV7l5/TGyvhvBtf2zjFdfr1KoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727371AbfCTRoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:44:38 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54683 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727267AbfCTRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:44:37 -0400
Received: by mail-it1-f196.google.com with SMTP id w18so131213itj.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJWBhpRbEsqIJ/DPGDyokhV3NlZo8RjYnfZk7wmzygQ=;
        b=XjPpCD+ZJTMYSk/BqhuSEWRGlQaW/hyey9PaU3FV5gAeNwYyxO4i7aKuB5YbiCbZAt
         hr/e/rN2zuXCyeU7jZSmgzLrhktYCTGIqP21ysoYS4nnJOyKaxvWSjnfNmLqRu/wPpJX
         9F7CSp4UdH4UlhCsCtrdKWgaRnIAztFvwZgVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJWBhpRbEsqIJ/DPGDyokhV3NlZo8RjYnfZk7wmzygQ=;
        b=Ev/LjiY1Ecdk6womTf/BEg9XE4VlgNboiT1ud0zgTs9hUJv0+a6Aw/8D5sk1OPC7Nn
         AcnB1hGKReUKf2bOpH4iuaNO880cCmypU+PEuCd5lkhjacEFITLDtJTWbvPBESKCrLVs
         GWXzoOADm2WeqZAbf6aZlZ36YBhuJOzp/FgcPh0KBtqg12e3EpgperWBCOVoR8cBCVy4
         OEAMnIHj+tETVi7Gw1MDc6/0plSgND1DZLiQ4zAlHL2f9W6r5l3xbTvguabyg68Mlmxk
         1AoAqJR95KrCSCAFP3baOhaHg29YDiKSGBZb0F/bEL1BAMnRBsyzCanCYLDbfnddk8Ex
         ojNA==
X-Gm-Message-State: APjAAAVuF9e2OPf+GMgnCgT9bFbfvdVn/lVzgUOxcRCwgwwDH8yVC1Rr
        InovJCVtkXbvKd1gJNMwA3WTzzteFDSiqAAXwjGyOQ==
X-Google-Smtp-Source: APXvYqxfZ6ixIH0xqyyWhq2SKkFOcfrQCZEajo6cJAAjo4EckoJs3VPKsrPtHoDwKk0p7K/roLqpIt5pOLfXha6zckw=
X-Received: by 2002:a05:660c:11cb:: with SMTP id p11mr4418477itm.105.1553103876286;
 Wed, 20 Mar 2019 10:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190320152315.82758-1-thellstrom@vmware.com> <20190320152315.82758-2-thellstrom@vmware.com>
In-Reply-To: <20190320152315.82758-2-thellstrom@vmware.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Mar 2019 10:44:25 -0700
Message-ID: <CAADWXX9N+mCN5Vg1eVz9k-UFMQPzc5QXUm6fieBf0oEnC1-=OA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] mm: Allow the [page|pfn]_mkwrite callbacks to
 drop the mmap_sem
To:     Thomas Hellstrom <thellstrom@vmware.com>
Cc:     DRI mailing list <dri-devel@lists.freedesktop.org>,
        linux-graphics-maintainer@vmware.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 8:23 AM Thomas Hellstrom <thellstrom@vmware.com> wrote:
>
> Driver fault callbacks are allowed to drop the mmap_sem when expecting
> long hardware waits [...]

No comment on the patch itself, but please fix your email setup.

All the patches were marked as spam, because you sent them from your
vmware.com address, but without going through the proper vmware smtp
gateway.

So they lack the proper vmware DKIM hashes and proper mail handling
should (and does) consider them spam.

               Linus
