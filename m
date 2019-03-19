Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B51AC4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEDD8217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553033976;
	bh=CWHoK7+ryr2wxJvutZimA/AdCYmtRDG/YpvaeB9T8uM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kHwaZMtBKLjj1Zha9waK/nnGGsW0dQhjY+aE2hJWnSkFaHPveh5g8M3UNlPKbBlC4
	 v76q6abwaN2jx1Bt4pofsI8+s0EOfC8harFLSO9WixizvIfNKjMKiktbO1enWlasVn
	 NB2Pq9VJQdmgxor1vXW9a3DAAjl3UAs5zVmU9+fE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727269AbfCSWTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:19:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53568 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbfCSWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:19:34 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C3ACB3DA8;
        Tue, 19 Mar 2019 22:19:31 +0000 (UTC)
Date:   Tue, 19 Mar 2019 15:19:30 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ira.weiny@intel.com
Cc:     John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RESEND PATCH 0/7] Add FOLL_LONGTERM to GUP fast and use it
Message-Id: <20190319151930.bab575d62fb1a33094160fe3@linux-foundation.org>
In-Reply-To: <20190317183438.2057-1-ira.weiny@intel.com>
References: <20190317183438.2057-1-ira.weiny@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Mar 2019 11:34:31 -0700 ira.weiny@intel.com wrote:

> Resending after rebasing to the latest mm tree.
> 
> HFI1, qib, and mthca, use get_user_pages_fast() due to it performance
> advantages.  These pages can be held for a significant time.  But
> get_user_pages_fast() does not protect against mapping FS DAX pages.
> 
> Introduce FOLL_LONGTERM and use this flag in get_user_pages_fast() which
> retains the performance while also adding the FS DAX checks.  XDP has also
> shown interest in using this functionality.[1]
> 
> In addition we change get_user_pages() to use the new FOLL_LONGTERM flag and
> remove the specialized get_user_pages_longterm call.

It would be helpful to include your response to Christoph's question
(http://lkml.kernel.org/r/20190220180255.GA12020@iweiny-DESK2.sc.intel.com)
in the changelog.  Because if one person was wondering about this,
others will likely do so.

We have no record of acks or reviewed-by's.  At least one was missed
(http://lkml.kernel.org/r/CAOg9mSTTcD-9bCSDfC0WRYqfVrNB4TwOzL0c4+6QXi-N_Y43Vw@mail.gmail.com),
but that is very very partial.

This patchset is fairly DAX-centered, but Dan wasn't cc'ed!

So ho hum.  I'll scoop them up and shall make the above changes to the
[1/n] changelog, but we still have some work to do.

