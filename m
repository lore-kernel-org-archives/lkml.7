Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECD2ECE58D
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DC321848
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 13:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570627381;
	bh=95P9sgAH69dQG6+sYybN++L8Nw5JZhdYruKV3sa2T1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DVtQ1oWpAHgcZErNweAXRmQxj7VxhgvYLla8h1Pp8K7bXQe4EJhXJyYEmRpXojfDO
	 Vfoj+RRvVQ3l4o8Rnl2ZH9NKoYoJ4bWzJlgsXRCkYtChkO+ACFXgmw6e9rsMJ0AuWZ
	 hptdgeGMPvk7iFC+qPCa294Rser1/fPXbxVYowio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731366AbfJINXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 09:23:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:43674 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729883AbfJINW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 09:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 96F88B182;
        Wed,  9 Oct 2019 13:22:57 +0000 (UTC)
Date:   Wed, 9 Oct 2019 15:22:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Alexey Dobriyan <adobriyan@gmail.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Anthony Yznaga <anthony.yznaga@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: Fix access of uninitialized memmaps in
 fs/proc/page.c
Message-ID: <20191009132256.GZ6681@dhcp22.suse.cz>
References: <20191009091205.11753-1-david@redhat.com>
 <20191009093756.GV6681@dhcp22.suse.cz>
 <67aeaacc-d850-5c81-bd17-e95c7f7f75df@redhat.com>
 <20191009112424.GY6681@dhcp22.suse.cz>
 <a9659e39-3516-13c8-b9ab-d42bdaf4a488@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9659e39-3516-13c8-b9ab-d42bdaf4a488@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-10-19 14:58:24, David Hildenbrand wrote:
[...]
> I would be fine with this, but it means that - for now - the three
> /proc/ files won't be able to deal with ZONE_DEVICE memory.

Thanks for the clarification. Is this an actual problem though? Do we
have any consumers of the functionality?
-- 
Michal Hocko
SUSE Labs
