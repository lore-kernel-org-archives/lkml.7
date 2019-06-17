Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C386CC31E54
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9A321954
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 07:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560755770;
	bh=K3DbmG8Az+ljzRJmf/WKCIyoehhkMoDGRovokaBbToE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2TYu/094MiyPOIEljTUmGECESgOoqGuKAns1NhZTnTHLU1em5e/1a+BZgvilUd03C
	 0vRILqNJ2m/ssoLWDbdB3pNZGk/R8QV85n33O/IWIvRXYPpesqzULjWyWHPvrira6b
	 QUxI+yPSe6bk6Szbm2klzDSOuB+qp3MUsLPKLVmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFQHQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 03:16:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:56046 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725826AbfFQHQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 03:16:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64B4CADAB;
        Mon, 17 Jun 2019 07:16:07 +0000 (UTC)
Date:   Mon, 17 Jun 2019 09:16:05 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Alastair D'Silva <alastair@d-silva.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Arun KS <arunks@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>
Subject: Re: [PATCH 5/5] mm/hotplug: export try_online_node
Message-ID: <20190617071605.GD30420@dhcp22.suse.cz>
References: <20190617043635.13201-1-alastair@au1.ibm.com>
 <20190617043635.13201-6-alastair@au1.ibm.com>
 <20190617065921.GV3436@hirez.programming.kicks-ass.net>
 <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1bad6f784efdd26508b858db46f0192a349c7a1.camel@d-silva.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Jerome - email thread starts
http://lkml.kernel.org/r/20190617043635.13201-1-alastair@au1.ibm.com]

On Mon 17-06-19 17:05:30,  Alastair D'Silva  wrote:
> On Mon, 2019-06-17 at 08:59 +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2019 at 02:36:31PM +1000, Alastair D'Silva wrote:
> > > From: Alastair D'Silva <alastair@d-silva.org>
> > > 
> > > If an external driver module supplies physical memory and needs to
> > > expose
> > 
> > Why would you ever want to allow a module to do such a thing?
> > 
> 
> I'm working on a driver for Storage Class Memory, connected via an
> OpenCAPI link.
> 
> The memory is only usable once the card says it's OK to access it.

Isn't this what HMM is aiming for? Could you give a more precise
description of what the actual storage is, how it is going to be used
etc... In other words describe the usecase?

-- 
Michal Hocko
SUSE Labs
