Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD9C43603
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DFA2073C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 14:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575470125;
	bh=t32DU54MSW9OpCMewi9d1HZ0gufv0Hl1VG6pMhyPEIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TBxMfHhJvq5NJCVEWQPPD9n2bTh4WMtpIBqL7ox7Te3nWMWIolPFkFeL6Jq5O9vBi
	 jDQ7FjgDmdj1j6TmzIKPHDaItGzYY3QSrj8PSLg+xuiDs8toVSmPwwHY2bRQmS0CVx
	 wrCt4ZkkFRJz96ThwVp4pUj5FCziQdPS3exzsDS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbfLDOfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 09:35:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42782 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbfLDOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 09:35:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id a15so8857952wrf.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 06:35:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=COMExwvouadcQjAZ+j/aoCpf/bM+m1P6K6pubVfD2Hg=;
        b=WBPaVzrEtfzoYPct8MiHAVbjDeqBN7jBdH4CfrbgXjdTs19ewtARv7xbNan+FCGl/H
         cnqHHQwgpAVgf20q6M4dGPQp5FEjEYvSd1CDQ5HcWkVqGOyz7MTkQ98/rZTTaH+Shbrt
         E6iGk7Zca4k7xwB4WqKnO7LQcB+HoOqvWQ0xNwYtnZ02a+1P3LekC8HK31QOd2p8pdgA
         +C+/BojteU8Iw1BoI3PZerObqwZeA8/YFBs3eiQm8Bokx5hMpWRlsbEI4V1qnjWJOg4y
         zwVO3V113+xwShJit47SEl7xuvaVuGFFV2+DVi4eAjiXvofjvoJdubUkPymA+Vt60ZtN
         NDhg==
X-Gm-Message-State: APjAAAWWuaCAwgLFvt1tksmX7uzX2eLHyKL/XwUeih1wQtmR5X8hBRs6
        XAhJfQ9sXFTRJaaTU7+GwKs=
X-Google-Smtp-Source: APXvYqynBtkN+xmFaa6Ak9kWrzD46VfMxjzOkttwtuEbyf5iK06e03rFUEc6Ktv51sFARz/ZAj3Hxw==
X-Received: by 2002:a5d:4807:: with SMTP id l7mr4541406wrq.64.1575470122948;
        Wed, 04 Dec 2019 06:35:22 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y139sm7286535wmd.24.2019.12.04.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 06:35:21 -0800 (PST)
Date:   Wed, 4 Dec 2019 15:35:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, pv-drivers@vmware.com,
        linux-graphics-maintainer@vmware.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        =?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH v2 2/2] drm/ttm: Fix vm page protection handling
Message-ID: <20191204143521.GJ25242@dhcp22.suse.cz>
References: <20191203104853.4378-1-thomas_os@shipmail.org>
 <20191203104853.4378-3-thomas_os@shipmail.org>
 <20191204135219.GH25242@dhcp22.suse.cz>
 <b29b166c-e9fe-f829-f533-b39f98b334a9@shipmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b29b166c-e9fe-f829-f533-b39f98b334a9@shipmail.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 04-12-19 15:16:09, Thomas Hellström (VMware) wrote:
> On 12/4/19 2:52 PM, Michal Hocko wrote:
> > On Tue 03-12-19 11:48:53, Thomas Hellström (VMware) wrote:
> > > From: Thomas Hellstrom <thellstrom@vmware.com>
> > > 
> > > TTM graphics buffer objects may, transparently to user-space,  move
> > > between IO and system memory. When that happens, all PTEs pointing to the
> > > old location are zapped before the move and then faulted in again if
> > > needed. When that happens, the page protection caching mode- and
> > > encryption bits may change and be different from those of
> > > struct vm_area_struct::vm_page_prot.
> > > 
> > > We were using an ugly hack to set the page protection correctly.
> > > Fix that and instead use vmf_insert_mixed_prot() and / or
> > > vmf_insert_pfn_prot().
> > > Also get the default page protection from
> > > struct vm_area_struct::vm_page_prot rather than using vm_get_page_prot().
> > > This way we catch modifications done by the vm system for drivers that
> > > want write-notification.
> > So essentially this should have any new side effect on functionality it
> > is just making a hacky/ugly code less so?
> 
> Functionality is unchanged. The use of a on-stack vma copy was severely
> frowned upon in an earlier thread, which also points to another similar
> example using vmf_insert_pfn_prot().
> 
> https://lore.kernel.org/lkml/20190905103541.4161-2-thomas_os@shipmail.org/
> 
> > In other words what are the
> > consequences of having page protection inconsistent from vma's?
> 
> During the years, it looks like the caching- and encryption flags of
> vma::vm_page_prot have been largely removed from usage. From what I can
> tell, there are no more places left that can affect TTM. We discussed
> __split_huge_pmd_locked() towards the end of that thread, but that doesn't
> affect TTM even with huge page-table entries.

Please state all those details/assumptions you are operating on in the
changelog.
-- 
Michal Hocko
SUSE Labs
