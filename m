Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090F8C7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB89221852
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 07:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564125146;
	bh=QkrAgtdxwcypcCPFUSg9O9Gj9w+cXt1CSKS6LRjmkDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b2T4QCDK5qMNmGfq9y/qbH5ETZN9ap9QYTgrMUDMX7U1DMH3udIgr8YARshSw1XZG
	 mGKiiRgMJXAVL+SMZ3dr69pgiXfA0UuGu9Yalt4Myl4zRAslx1ozvlHgo3Aj4ikxEV
	 BPkU8une4sec2gRjR5VD7JcMKd89YBTrxNjkvEwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGZHMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 03:12:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:43508 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725864AbfGZHMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 03:12:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 40D9DB11C;
        Fri, 26 Jul 2019 07:12:20 +0000 (UTC)
Date:   Fri, 26 Jul 2019 09:12:19 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pengfei Li <lpf.vector@gmail.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, vbabka@suse.cz,
        aryabinin@virtuozzo.com, osalvador@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, pavel.tatashin@microsoft.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 00/10] make "order" unsigned int
Message-ID: <20190726071219.GC6142@dhcp22.suse.cz>
References: <20190725184253.21160-1-lpf.vector@gmail.com>
 <1564080768.11067.22.camel@lca.pw>
 <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD7_sbEXQt0oHuD01BXdW2_=G4h8U8ogHVt0N1Yez2ajFJkShw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26-07-19 07:48:36, Pengfei Li wrote:
[...]
> For the benefit, "order" may be negative, which is confusing and weird.

order = -1 has a special meaning.

> There is no good reason not to do this since it can be avoided.

"This is good because we can do it" doesn't really sound like a
convincing argument to me. I would understand if this reduced a
generated code, made an overall code readability much better or
something along those lines. Also we only use MAX_ORDER range of values
so I could argue that a smaller data type (e.g. short) should be
sufficient for this data type.

Please note that _any_ change, alebit seemingly small, can introduce a
subtle bug. Also each patch requires a man power to review so you have
to understand that "just because we can" is not a strong motivation for
people to spend their time on such a patch.
-- 
Michal Hocko
SUSE Labs
