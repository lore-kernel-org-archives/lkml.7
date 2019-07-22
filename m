Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C88FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D8321901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 13:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbfGVNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:25:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50525 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728819AbfGVNZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 09:25:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6MDPERI012550
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 09:25:15 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id EEE1E4202F5; Mon, 22 Jul 2019 09:25:13 -0400 (EDT)
Date:   Mon, 22 Jul 2019 09:25:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Gao Xiang <hsiangkao@aol.com>
Cc:     dsterba@suse.cz, Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Fang Wei <fangwei1@huawei.com>
Subject: Re: [PATCH v3 23/24] erofs: introduce cached decompression
Message-ID: <20190722132513.GA5172@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Gao Xiang <hsiangkao@aol.com>, dsterba@suse.cz,
        Gao Xiang <gaoxiang25@huawei.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Li Guifu <bluce.liguifu@huawei.com>, Fang Wei <fangwei1@huawei.com>
References: <20190722025043.166344-1-gaoxiang25@huawei.com>
 <20190722025043.166344-24-gaoxiang25@huawei.com>
 <20190722101818.GN20977@twin.jikos.cz>
 <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41f1659a-0d16-4316-34fc-335b7d142d5c@aol.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2019 at 06:58:59PM +0800, Gao Xiang wrote:
> > The number of individual Kconfig options is quite high, are you sure you
> > need them to be split like that?
> 
> You mean the above? these are 3 cache strategies, which impact the
> runtime memory consumption and performance. I tend to leave the above
> as it-is...

Unless cache strategies involve a huge amount of kernel code, I'd
recommend always compiling all of the cache strategies, and then have
a way to change the cache strategy via a mount option (and possibly
remount, although that can get tricky if there is already cached
information).  You could also specify a default in the erofs
superblock, you think that would be useful.

	    	      	   	    - Ted
