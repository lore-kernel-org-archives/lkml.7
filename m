Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E67C1C3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E93206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 11:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566818058;
	bh=bKRn9TwljNod0/jWHfNYjqAlZvtw4ALCQ7McT77Ekxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sv29AfwRi2FDihvv1//+hE7adqyj8gcLUwArA+wq8ztc7hrn1wb5cMMkb3v8NVaar
	 JR2o8IJJ29saTH5KpqC1fF2fbh/NEi9Dp2yxHQTAYmwJEFp+PnG9lfdoMeirec+nxL
	 XIwVo2cFjW5GqYN+sssJBtIITkSQ7PQny+5JGsBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfHZLOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 07:14:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:59590 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727123AbfHZLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 07:14:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 19094ABB2;
        Mon, 26 Aug 2019 11:14:16 +0000 (UTC)
Date:   Mon, 26 Aug 2019 13:14:14 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, vbabka@suse.cz
Subject: Re: poisoned pages do not play well in the buddy allocator
Message-ID: <20190826111414.GG7538@dhcp22.suse.cz>
References: <20190826104144.GA7849@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826104144.GA7849@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 26-08-19 12:41:50, Oscar Salvador wrote:
[...]
> I checked [1], and it seems that [2] was going towards fixing this kind of issue.
> 
> I think it is about time to revamp the whole thing.

I completely agree. The current state of hwpoison is just too fragile to
be practically usable. We keep getting bug reports (as pointed out by
Oscar) when people try to test this via soft offlining. 

> @Naoya: I could give it a try if you are busy.

That would be more than appreciated. I feel guilty to have it slip
between cracks but I simply couldn't have found enough time to give it a
serious look. Sorry about that.

> [1] https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] https://lore.kernel.org/linux-mm/1541746035-13408-9-git-send-email-n-horiguchi@ah.jp.nec.com/

-- 
Michal Hocko
SUSE Labs
