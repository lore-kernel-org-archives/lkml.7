Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2979C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819452173C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 06:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553756288;
	bh=IY2b8v4jncTm4HanpgMnfdzbl9Pt99kGPfiTLuR4y9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yj9jo82GSz+r8sKFRz8eKvzH/m+2i0F0N0wXs9VfWBllV9xLTxA7qAkX0WY09i78r
	 wMacU6OEnDr1/IJWrVG8BNK9Uq9W7D/8S47t6DTxnvdIyUQxL4j9WfNOx9ogkbcNmC
	 wN3OvvwSfOSfj/UEG0SM/Y4HPFNUTKQHXq6w6EQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbfC1G6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 02:58:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36775 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1G6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 02:58:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so2629384wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 23:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q1PezP2XQg+mDviVgWM5i24dvdC/8vaYo2tkDH927Eo=;
        b=bYD0hu7CTkOEC/UfWVNjLpQswfLDyWnZjO+yG9SsnejA8EdLJW/kg3GeYaawt1Y9cW
         dy44DhTS0R4Cx/7Emjl4MCBwVCyfV292Fp0tlAvel97ms+qOJ49oQhLicjhTTKG5R2wc
         PYCuugbP1qIY+is3hfzJt3iVbADcFFqUcZ8me2LaFLFGBe/ebChN1wa/YjqCnW6aYV3J
         WHhzypsHvExXzetdI6+VXuKMUthGLwRiardenEkpjXNm2P0QVbqbz6qR3BjcIEOetQ/K
         O/OrwIuJZ59/v2Ri2sRdm2wDUu2K7TLZ1qpQe8EWY1zXJ1UI2CZVy/uiB9rXmfOxFff1
         Mgrw==
X-Gm-Message-State: APjAAAVD9kDZfR5mpryevu3h4REr0MrC5nsdhf+ohtyjLvIY3FH26JFa
        wLEIGfNhH4VmimHZwwY1EX8=
X-Google-Smtp-Source: APXvYqxEEg6bIrtRVpuuN9OeVJ+wS5PBnn6jxssxAGzZjgcAgnCUtNx+osvmbWfOn0eBECcFZXWlNQ==
X-Received: by 2002:a7b:c00e:: with SMTP id c14mr14313558wmb.110.1553756285332;
        Wed, 27 Mar 2019 23:58:05 -0700 (PDT)
Received: from localhost (ip-37-188-147-215.eurotel.cz. [37.188.147.215])
        by smtp.gmail.com with ESMTPSA id t69sm3211038wmt.16.2019.03.27.23.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 23:58:03 -0700 (PDT)
Date:   Thu, 28 Mar 2019 07:58:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "Du, Fan" <fan.du@intel.com>, "Huang, Ying" <ying.huang@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/10] Another Approach to Use PMEM as NUMA Node
Message-ID: <20190328065802.GQ11927@dhcp22.suse.cz>
References: <1553316275-21985-1-git-send-email-yang.shi@linux.alibaba.com>
 <20190326135837.GP28406@dhcp22.suse.cz>
 <43a1a59d-dc4a-6159-2c78-e1faeb6e0e46@linux.alibaba.com>
 <20190326183731.GV28406@dhcp22.suse.cz>
 <f08fb981-d129-3357-e93a-a6b233aa9891@linux.alibaba.com>
 <20190327090100.GD11927@dhcp22.suse.cz>
 <CAPcyv4heiUbZvP7Ewoy-Hy=-mPrdjCjEuSw+0rwdOUHdjwetxg@mail.gmail.com>
 <c3690a19-e2a6-7db7-b146-b08aa9b22854@linux.alibaba.com>
 <20190327193918.GP11927@dhcp22.suse.cz>
 <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f8b4c51-3f3c-16f9-ca2f-dbcd08ea23e6@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 27-03-19 19:09:10, Yang Shi wrote:
> One question, when doing demote and promote we need define a path, for
> example, DRAM <-> PMEM (assume two tier memory). When determining what nodes
> are "DRAM" nodes, does it make sense to assume the nodes with both cpu and
> memory are DRAM nodes since PMEM nodes are typically cpuless nodes?

Do we really have to special case this for PMEM? Why cannot we simply go
in the zonelist order? In other words why cannot we use the same logic
for a larger NUMA machine and instead of swapping simply fallback to a
less contended NUMA node? It can be a regular DRAM, PMEM or whatever
other type of memory node.
-- 
Michal Hocko
SUSE Labs
