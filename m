Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2379C10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7120520656
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 14:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555425603;
	bh=HDsa5qjoKP54tUlI0s82vGwRG/2PTcMuJjDbzVS2PmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pM7QP+2tK5kQ0zOYU3NmxAI7BFJz+SAltwuyR715kRDZ43tYK/iv0mBc/bMIqiAzj
	 s7fh/GRRCvJ3HVhC/1JjHlbqXSLYHj9t+HIkutEcAdhW3DTqO+K/5M2cBS1qJsgTZo
	 wKmobAlSfMMcU2JJqtsNsEf02K+U0W9gGNDWhYWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729652AbfDPOkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Apr 2019 10:40:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:39840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726605AbfDPOkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Apr 2019 10:40:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 366E2AE56;
        Tue, 16 Apr 2019 14:40:00 +0000 (UTC)
Date:   Tue, 16 Apr 2019 16:39:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
        keith.busch@intel.com, dan.j.williams@intel.com,
        fengguang.wu@intel.com, fan.du@intel.com, ying.huang@intel.com,
        ziy@nvidia.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [v2 RFC PATCH 0/9] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190416143958.GI11561@dhcp22.suse.cz>
References: <1554955019-29472-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190412084702.GD13373@dhcp22.suse.cz>
 <a68137bb-dcd8-4e4a-b3a9-69a66f9dccaf@linux.alibaba.com>
 <20190416074714.GD11561@dhcp22.suse.cz>
 <b9b40585-cb59-3d42-bcf8-e59bff77c663@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9b40585-cb59-3d42-bcf8-e59bff77c663@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 16-04-19 07:30:20, Dave Hansen wrote:
> On 4/16/19 12:47 AM, Michal Hocko wrote:
> > You definitely have to follow policy. You cannot demote to a node which
> > is outside of the cpuset/mempolicy because you are breaking contract
> > expected by the userspace. That implies doing a rmap walk.
> 
> What *is* the contract with userspace, anyway? :)
> 
> Obviously, the preferred policy doesn't have any strict contract.
> 
> The strict binding has a bit more of a contract, but it doesn't prevent
> swapping.

Yes, but swapping is not a problem for using binding for memory
partitioning.

> Strict binding also doesn't keep another app from moving the
> memory.

I would consider that a bug.
-- 
Michal Hocko
SUSE Labs
