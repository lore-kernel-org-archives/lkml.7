Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98187C3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 685DF23AA7
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566289104;
	bh=wEI2KC2m1XzGfOGS6X399yBP/45s+3KPbWStKXi0BIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fdeMtogeTF6OSqgaAShxDOwo2S5n/0ALnIK3QV3SQwZsHfpQmbjEebW2QyvUq8ey/
	 Fy/6erIgPRIEuF4OfzYOotIct1Y26CLBKCaJli1q9F3+TD+mMgY/DSnTYit7dq5DGD
	 cnhKHhi3FMVD+DAxjjYujMVrE+gC/LUy2xQM8VTs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729443AbfHTISX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:18:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:51218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729150AbfHTISX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 04:18:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 956A7AEA1;
        Tue, 20 Aug 2019 08:18:21 +0000 (UTC)
Date:   Tue, 20 Aug 2019 10:18:20 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        Dimitri Sivanich <sivanich@hpe.com>,
        Andrew Morton <akpm@linux-foundation.org>, jglisse@redhat.com,
        ira.weiny@intel.com, gregkh@linuxfoundation.org, arnd@arndb.de,
        william.kucharski@oracle.com, hch@lst.de,
        inux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Linux-kernel-mentees][PATCH v6 1/2] sgi-gru: Convert put_page()
 to put_user_page*()
Message-ID: <20190820081820.GI3111@dhcp22.suse.cz>
References: <1566157135-9423-1-git-send-email-linux.bhar@gmail.com>
 <1566157135-9423-2-git-send-email-linux.bhar@gmail.com>
 <20190819125611.GA5808@hpe.com>
 <20190819190647.GA6261@bharath12345-Inspiron-5559>
 <0c2ad29b-934c-ec30-66c3-b153baf1fba5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2ad29b-934c-ec30-66c3-b153baf1fba5@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 19-08-19 12:30:18, John Hubbard wrote:
> On 8/19/19 12:06 PM, Bharath Vedartham wrote:
> > On Mon, Aug 19, 2019 at 07:56:11AM -0500, Dimitri Sivanich wrote:
> > > Reviewed-by: Dimitri Sivanich <sivanich@hpe.com>
> > Thanks!
> > 
> > John, would you like to take this patch into your miscellaneous
> > conversions patch set?
> > 
> 
> (+Andrew and Michal, so they know where all this is going.)
> 
> Sure, although that conversion series [1] is on a brief hold, because
> there are additional conversions desired, and the API is still under
> discussion. Also, reading between the lines of Michal's response [2]
> about it, I think people would prefer that the next revision include
> the following, for each conversion site:
> 
> Conversion of gup/put_page sites:
> 
> Before:
> 
> 	get_user_pages(...);
> 	...
> 	for each page:
> 		put_page();
> 
> After:
> 	
> 	gup_flags |= FOLL_PIN; (maybe FOLL_LONGTERM in some cases)
> 	vaddr_pin_user_pages(...gup_flags...)

I was hoping that FOLL_PIN would be handled by vaddr_pin_user_pages.

> 	...
> 	vaddr_unpin_user_pages(); /* which invokes put_user_page() */
> 
> Fortunately, it's not harmful for the simpler conversion from put_page()
> to put_user_page() to happen first, and in fact those have usually led
> to simplifications, paving the way to make it easier to call
> vaddr_unpin_user_pages(), once it's ready. (And showing exactly what
> to convert, too.)

If that makes the later conversion easier then no real objections from
me. Assuming that the current put_user_page conversions are correct of
course (I have the mlock one and potentials that falls into the same
category in mind).
-- 
Michal Hocko
SUSE Labs
