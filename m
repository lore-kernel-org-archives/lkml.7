Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0880BC48BD9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:10:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A4620843
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561623033;
	bh=+3RdzkrAyBph+sRL34/Ti1TPL46aa6T4hWcYXmbPjAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aZefXHA3SbPf3kW/OUaNV0KSLfSwLVmFlub9QKp6/mPxXaF+Sf/DYJ2kBdw4vH47K
	 ocWDDLcX5h3AupWRxt7Vz5/CXrillH+/Gu5sF+LWrWqBCQUPLGAdpZSMjPrYuavknj
	 d09n1Fv6uw36NFHjbOWgKnUmNrcuu3oF77W0RoPE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfF0IKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:10:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:44610 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726293AbfF0IKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:10:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CEFC3AF3E;
        Thu, 27 Jun 2019 08:10:30 +0000 (UTC)
Date:   Thu, 27 Jun 2019 10:10:29 +0200
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
Message-ID: <20190627080724.GK17798@dhcp22.suse.cz>
References: <20190626061124.16013-1-alastair@au1.ibm.com>
 <20190626061124.16013-2-alastair@au1.ibm.com>
 <20190626062113.GF17798@dhcp22.suse.cz>
 <d4af66721ea53ce7df2d45a567d17a30575672b2.camel@d-silva.org>
 <20190626065751.GK17798@dhcp22.suse.cz>
 <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e66e43b1fdfbff94ab23a23c48aa6cbe210a3131.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 27-06-19 10:50:57, Alastair D'Silva wrote:
> On Wed, 2019-06-26 at 08:57 +0200, Michal Hocko wrote:
> > On Wed 26-06-19 16:27:30, Alastair D'Silva wrote:
> > > On Wed, 2019-06-26 at 08:21 +0200, Michal Hocko wrote:
> > > > On Wed 26-06-19 16:11:21, Alastair D'Silva wrote:
> > > > > From: Alastair D'Silva <alastair@d-silva.org>
> > > > > 
> > > > > If a memory section comes in where the physical address is
> > > > > greater
> > > > > than
> > > > > that which is managed by the kernel, this function would not
> > > > > trigger the
> > > > > bug and instead return a bogus section number.
> > > > > 
> > > > > This patch tracks whether the section was actually found, and
> > > > > triggers the
> > > > > bug if not.
> > > > 
> > > > Why do we want/need that? In other words the changelog should
> > > > contina
> > > > WHY and WHAT. This one contains only the later one.
> > > >  
> > > 
> > > Thanks, I'll update the comment.
> > > 
> > > During driver development, I tried adding peristent memory at a
> > > memory
> > > address that exceeded the maximum permissable address for the
> > > platform.
> > > 
> > > This caused __section_nr to silently return bogus section numbers,
> > > rather than complaining.
> > 
> > OK, I see, but is an additional code worth it for the non-development
> > case? I mean why should we be testing for something that shouldn't
> > happen normally? Is it too easy to get things wrong or what is the
> > underlying reason to change it now?
> > 
> 
> It took me a while to identify what the problem was - having the BUG_ON
> would have saved me a few hours.
> 
> I'm happy to just have the BUG_ON 'nd drop the new error return (I
> added that in response to Mike Rapoport's comment that the original
> patch would still return a bogus section number).

Well, BUG_ON is about the worst way to handle an incorrect input. You
really do not want to put a production environment down just because
there is a bug in a driver, right? There are still many {VM_}BUG_ONs
in the tree and there is a general trend to get rid of many of them
rather than adding new ones.

Now back to your patch. You are adding an error handling where we simply
do not expect invalid data. This is often the case for the core kernel
functionality because we do expect consumers of the code to do the right
thing. E.g. __section_nr already takes a pointer to struct section which
assumes that this core data structure is already valid. Adding a check
here adds an unnecessary overhead so this doesn't really sound like a
good idea to me.
-- 
Michal Hocko
SUSE Labs
