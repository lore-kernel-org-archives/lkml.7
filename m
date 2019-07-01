Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7167BC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35961208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561978022;
	bh=Tn9Ofar3/Ihin9bAR7IrIZQ9RLrHu9BhdKwnffmGeuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d5pbkCrknf/LnvZyBrcX9A5vGj3Y6PlSx3XQIWHRpyIR/K+AuIU+mvVlQwcRhUCGx
	 uwKHczkQjyAUS+0+hS4ZMjvT7tYXoCe9S5xkviN5EJLo0InkVdrb2ynG7mpsZhi+Fq
	 TTW3I12jQ732tZtzhsgmjvjjPSo3Daw8YW67YhUQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728056AbfGAKrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 06:47:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:43316 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727041AbfGAKrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 06:47:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 972EBAD8D;
        Mon,  1 Jul 2019 10:46:59 +0000 (UTC)
Date:   Mon, 1 Jul 2019 12:46:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: Trigger bug on if a section is not found in
 __section_nr
Message-ID: <20190701104658.GA6549@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
 <20190626062113.GF17798@dhcp22.suse.cz>
 <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
 <20190626065751.GK17798@dhcp22.suse.cz>
 <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
 <20190627080724.GK17798@dhcp22.suse.cz>
 <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <833b9675bc363342827cb8f7c76ebb911f7f960d.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 28-06-19 10:46:28, Alastair D'Silva wrote:
[...]
> Given that there is already a VM_BUG_ON in the code, how do you feel
> about broadening the scope from 'VM_BUG_ON(!root)' to 'VM_BUG_ON(!root
> || (root_nr == NR_SECTION_ROOTS))'?

As far as I understand the existing VM_BUG_ON will hit when the
mem_section tree gets corrupted. This is a different situation to an
incorrect section given so I wouldn't really mix those two. And I still
do not see much point to protect from unexpected input parameter as this
is internal function as already pointed out.

-- 
Michal Hocko
SUSE Labs
