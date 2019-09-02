Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBF2C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:02:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D9D22DD6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 08:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567411343;
	bh=LN1XwY/4Ur1M3NHlUirV6Tt+CvrOb5jtXucTLZnootY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eqV/HZ+LKsY2NkFntBzp77PbDsLfgmceA5tGwJ6b+zEupARynk1thS5Un4QVwuh2Y
	 MHrinRqh89KeM38O3O9rebYqIFFlTpMGjK6Vh+5Xdh2s0tL3dHpVeXjx0S82LLntaK
	 pEA8wGsGJJRtR4qrDBikKmwDh2EzAbgTXFh548+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbfIBICW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 04:02:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:55394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730119AbfIBICV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 04:02:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 24A2AB654;
        Mon,  2 Sep 2019 08:02:20 +0000 (UTC)
Date:   Mon, 2 Sep 2019 10:02:18 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     Bharath Vedartham <linux.bhar@gmail.com>,
        akpm@linux-foundation.org, vbabka@suse.cz,
        mgorman@techsingularity.net, dan.j.williams@intel.com,
        osalvador@suse.de, richard.weiyang@gmail.com, hannes@cmpxchg.org,
        arunks@codeaurora.org, rppt@linux.vnet.ibm.com, jgg@ziepe.ca,
        amir73il@gmail.com, alexander.h.duyck@linux.intel.com,
        linux-mm@kvack.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Add predictive memory reclamation and compaction
Message-ID: <20190902080218.GF14028@dhcp22.suse.cz>
References: <20190813140553.GK17933@dhcp22.suse.cz>
 <3cb0af00-f091-2f3e-d6cc-73a5171e6eda@oracle.com>
 <20190814085831.GS17933@dhcp22.suse.cz>
 <d3895804-7340-a7ae-d611-62913303e9c5@oracle.com>
 <20190815170215.GQ9477@dhcp22.suse.cz>
 <2668ad2e-ee52-8c88-22c0-1952243af5a1@oracle.com>
 <20190821140632.GI3111@dhcp22.suse.cz>
 <20190826204420.GA16800@bharath12345-Inspiron-5559>
 <20190827061606.GN7538@dhcp22.suse.cz>
 <23eca880-d0d7-00f9-cb1b-b2998f2a1dff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23eca880-d0d7-00f9-cb1b-b2998f2a1dff@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 30-08-19 15:35:06, Khalid Aziz wrote:
[...]
> - Kernel is not self-tuning and is dependent upon a userspace tool to
> perform well in a fundamental area of memory management.

You keep bringing this up without an actual analysis of a wider range of
workloads that would prove that the default behavior is really
suboptimal. You are making some assumptions based on a very specific DB
workload which might benefit from a more aggressive background workload.
If you really want to sell any changes to auto tuning then you really
need to come up with more workloads and an actual theory why an early
and more aggressive reclaim pays off.
-- 
Michal Hocko
SUSE Labs
