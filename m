Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C875FC282DA
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A78C20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 18:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555439649;
	bh=P4+RnJCuebIn4tzI6w3JMJbpiPt+/6YEXBgeVkZBjaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WuJEXf765VsHecAy5VfF1mG4RUyTZVbBMc483OzzQoSobEZ6a8Vmd66d39G/ENw1s
	 qAZ4z5TsboVbtxVKd03iOW5kahlRz88zmiSo1zXt6uTW7GKi+4hLnd2d97dbz4FeR+
	 osqg+V8u9H1EmqJYEV5HERTpeivYTk6ujfk60Edk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729975AbfDPSeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 14:34:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:55898 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfDPSeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 14:34:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 919C9AC58;
        Tue, 16 Apr 2019 18:34:06 +0000 (UTC)
Date:   Tue, 16 Apr 2019 20:34:04 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190416183404.GA655@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <b9b40585-cb59-3d42-bcf8-e59bff77c663@intel.com>
 <20190416143958.GI11561@dhcp22.suse.cz>
 <bddc3469-2984-2d32-f2cf-e1d0cc64f1e8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bddc3469-2984-2d32-f2cf-e1d0cc64f1e8@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 08:46:56, Dave Hansen wrote:
> On 4/16/19 7:39 AM, Michal Hocko wrote:
> >> Strict binding also doesn't keep another app from moving the
> >> memory.
> > I would consider that a bug.
> 
> A bug where, though?  Certainly not in the kernel.

Kernel should refrain from moving explicitly bound memory nilly willy. I
certainly agree that there are corner cases. E.g. memory hotplug. We do
break CPU affinity for CPU offline as well. So this is something user
should expect. But the kernel shouldn't move explicitly bound pages to a
different node implicitly. I am not sure whether we even do that during
compaction if we do then I would consider _this_ to be a bug. And NUMA
rebalancing under memory pressure falls into the same category IMO.
-- 
Michal Hocko
SUSE Labs
