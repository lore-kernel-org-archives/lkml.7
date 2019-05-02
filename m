Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB55EC04AA9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8951220B7C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556802037;
	bh=3afereDZg20659xr8n3IaM3wR+YaxdiF5u/sFeJRbY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dRlFkCun2ERakAaGBxjkQ4fLEFWnaOXuDChFo9ZDQA/UpntpvxHeDtQ1R2nSlOB7U
	 JclU89dg6tT0sd9Vf2uJG6Qi1dYHYF8rQhCqFPI1I8IcxXb2sW6vOmNK2jj6DPcn+n
	 bJFp/nT0RvyScUTsibqOs/LQYiUvCAXgSeKc53aA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfEBNAg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 09:00:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:36218 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbfEBNAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 09:00:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7A7E5AEF9;
        Thu,  2 May 2019 13:00:34 +0000 (UTC)
Date:   Thu, 2 May 2019 09:00:31 -0400
From:   Michal Hocko <mhocko@kernel.org>
To:     Barret Rhoden <brho@google.com>
Cc:     linux-mm@kvack.org, Pingfan Liu <kernelfans@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 1/2] x86, numa: always initialize all possible nodes
Message-ID: <20190502130031.GC29835@dhcp22.suse.cz>
References: <20190212095343.23315-1-mhocko@kernel.org>
 <20190212095343.23315-2-mhocko@kernel.org>
 <34f96661-41c2-27cc-422d-5a7aab526f87@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34f96661-41c2-27cc-422d-5a7aab526f87@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-05-19 15:12:32, Barret Rhoden wrote:
[...]
> A more elegant solution may be to avoid registering with sysfs during early
> boot, or something else entirely.  But I figured I'd ask for help at this
> point.  =)

Thanks for the report and an excellent analysis! This is really helpful.
I will think about this some more but I am traveling this week. It seems
really awkward to register a sysfs file for an empty range. That looks
like a bug to me.

-- 
Michal Hocko
SUSE Labs
