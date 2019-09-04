Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F33DEC3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6D2F22CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567584850;
	bh=J+OIFYExxocW6B68S4JLGY+p958bcUxgg5CgZpa4dWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RchNPbuxLZZuQM2EIobocbeBRzPBmL5GnZ5HWBp6hCmAllFu1Y3eweMhlq4GcaSHx
	 ccyIoQyNVZ8lnTRWwhI7d0nNUNQEw9C1nM0zZ3yvgU9LIxOrOS+lRNdszTKSA2wzCn
	 b0ALd+TCnJ5H43kYStyvE/4h6RepUmCgt4vxngGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbfIDIOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:14:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:35076 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725267AbfIDIOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:14:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8A303AB9B;
        Wed,  4 Sep 2019 08:14:08 +0000 (UTC)
Date:   Wed, 4 Sep 2019 10:14:08 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     sunqiuyang <sunqiuyang@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/migrate: fix list corruption in migration of
 non-LRU movable pages
Message-ID: <20190904081408.GF3838@dhcp22.suse.cz>
References: <20190903082746.20736-1-sunqiuyang@huawei.com>
 <20190903131737.GB18939@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C1B09@dggeml512-mbx.china.huawei.com>
 <20190904063836.GD3838@dhcp22.suse.cz>
 <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157FC541501A9C4C862B2F16FFE316DC190C2EBD@dggeml512-mbx.china.huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not top post please

On Wed 04-09-19 07:27:25, sunqiuyang wrote:
> isolate_migratepages_block() from another thread may try to isolate the page again:
> 
> for (; low_pfn < end_pfn; low_pfn++) {
>   /* ... */
>   page = pfn_to_page(low_pfn);
>  /* ... */
>   if (!PageLRU(page)) {
>     if (unlikely(__PageMovable(page)) && !PageIsolated(page)) {
>         /* ... */
>         if (!isolate_movable_page(page, isolate_mode))
>           goto isolate_success;
>       /*... */
> isolate_success:
>      list_add(&page->lru, &cc->migratepages);
> 
> And this page will be added to another list.
> Or, do you see any reason that the page cannot go through this path?

The page shouldn't be __PageMovable after the migration is done. All the
state should have been transfered to the new page IIUC.
-- 
Michal Hocko
SUSE Labs
