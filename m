Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C88FC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC78320657
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559744570;
	bh=Z9CZP5xXWiI8Ugx0q+hW8/ZSOf7va2S8m+zW4CVI1oo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSK40kAzDAuN4KuuHeYZzTxdijTVfX+8ku7i+G94/xPWTD+Ydm6KE3s/B+Qbg4uHN
	 NFmvnMvq/eb/M3vlW0uw2HjVz5gDAvlIGeXVlVHaQ+VUu/4m3RBiN6ZEV9pTkAH8bZ
	 EUSXB6IZMl4Xhm+FjQw+HO9HzRk0v1TZ5OliFQj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbfFEOWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 10:22:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:38254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728369AbfFEOWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 10:22:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B6684AFC7;
        Wed,  5 Jun 2019 14:22:47 +0000 (UTC)
Date:   Wed, 5 Jun 2019 16:22:46 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bharath Vedartham <linux.bhar@gmail.com>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        khalid.aziz@oracle.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove VM_BUG_ON in __alloc_pages_node
Message-ID: <20190605142246.GH15685@dhcp22.suse.cz>
References: <20190605060229.GA9468@bharath12345-Inspiron-5559>
 <20190605070312.GB15685@dhcp22.suse.cz>
 <20190605130727.GA25529@bharath12345-Inspiron-5559>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605130727.GA25529@bharath12345-Inspiron-5559>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 05-06-19 18:37:28, Bharath Vedartham wrote:
> [Not replying inline as my mail is bouncing back]
> 
> This patch is based on reading the code rather than a kernel crash. My
> thought process was that if an invalid node id was passed to
> __alloc_pages_node, it would be better to add a VM_WARN_ON and fail the
> allocation rather than crashing the kernel. 

This makes some sense to me because BUG_ONs are usually a wrong way to
handle wrong usage of the API. On the other hand VM_BUG_ON is special in
the way that production although some distributions enable it by default
IIRC.

> I feel it would be better to fail the allocation early in the hot path
> if an invalid node id is passed. This is irrespective of whether the
> VM_[BUG|WARN]_*s are enabled or not. I do not see any checks in the hot
> path for the node id, which in turn may cause NODE_DATA(nid) to fail to
> get the pglist_data pointer for the node id. 
> We can optimise the branch by wrapping it around in unlikely(), if
> performance is the issue?

unlikely will just move the return NULL ouside of the main code flow.
The check will still be done.

> What are your thoughts on this? 

I don't know. I would leave the code as it is now or remove the
VM_BUG_ON. I do not remember this would be catching any real issues in
the past.
-- 
Michal Hocko
SUSE Labs
