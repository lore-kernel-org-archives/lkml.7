Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99B59C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 563D120863
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 09:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553590906;
	bh=2caQ5ME99w7Qf1zXwB8fLFNzMC4UDO3qQ5HeDsmCJXs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t9mq3G7i5Fz+SS7ZIxjhaqocrvhs8C7xMBSCmhNcDBJATEoXIF4IoNUWSWO2i/o4I
	 J5lqUd20SRrfahTL0y0uQDCn5g2/6Xz/qWO5z4v6DMESDh/s2+a8u1lGUGRZCDqn/R
	 ylf6P+3cvswOCT3x6kU0OqI2ib8x/r/BOcK31aLw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfCZJBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 05:01:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:35982 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbfCZJBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 05:01:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75AA9AD65;
        Tue, 26 Mar 2019 09:01:43 +0000 (UTC)
Date:   Tue, 26 Mar 2019 10:01:42 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
Subject: Re: [External] Re: vmscan: Reclaim unevictable pages
Message-ID: <20190326090142.GH28406@dhcp22.suse.cz>
References: <SG2PR02MB3098E6F2C4BAEB56AE071EDCE8440@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <0b86dbca-cbc9-3b43-e3b9-8876bcc24f22@suse.cz>
 <SG2PR02MB309841EA4764E675D4649139E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <56862fc0-3e4b-8d1e-ae15-0df32bf5e4c0@virtuozzo.com>
 <SG2PR02MB3098EEAF291BFD72F4163936E8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <4c05dda3-9fdf-e357-75ed-6ee3f25c9e52@virtuozzo.com>
 <SG2PR02MB309869FC3A436C71B50FA57BE8470@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <09b6ee71-0007-7f1d-ac80-7e05421e4ec6@virtuozzo.com>
 <SG2PR02MB309864258DBE630AD3AD2E10E8410@SG2PR02MB3098.apcprd02.prod.outlook.com>
 <SG2PR02MB309824F3FCD9B0D1DF689390E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SG2PR02MB309824F3FCD9B0D1DF689390E85F0@SG2PR02MB3098.apcprd02.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[You were asked to use a reasonable quoting several times. This is
really annoying because it turns the email thread into a complete mess]

On Tue 26-03-19 07:53:14, Pankaj Suryawanshi wrote:
> Is there anyone who is familiar with this?  Please Comment.

Not really. You are observing an unexpected behavior of the page reclaim
which hasn't changed for quite some time. So I find more probable that
your non-vanilla kernel is doing something unexpected. It would help if
you could track down how does the unevictable page get down to the
reclaim path. I assume this is a CMA page or something like that but
those shouldn't get to the reclaim path AFIR.
-- 
Michal Hocko
SUSE Labs
