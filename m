Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E322CA9EA0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2E6214B2
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 08:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731142AbfJVIfZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 04:35:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:42164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726978AbfJVIfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 04:35:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9F613B4F5;
        Tue, 22 Oct 2019 08:35:20 +0000 (UTC)
Date:   Tue, 22 Oct 2019 10:35:17 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022083505.GA19708@linux>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022082611.GD9379@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2019 at 10:26:11AM +0200, Michal Hocko wrote:
> On Tue 22-10-19 09:46:20, Oscar Salvador wrote:
> [...]
> > So, opposite to hard-offline, in soft-offline we do not fiddle with pages
> > unless we are sure the page is not reachable anymore by any means.
> 
> I have to say I do not follow. Is there any _real_ reason for
> soft-offline to behave differenttly from MCE (hard-offline)?

Yes.
Do not take it as 100% true as I read that in some code/Documentation
a while ago.

But I think that it boils down to:

soft-offline: "We have seen some erros in the underlying page, but
               it is still usable, so we have a chance to keep the
               the contents (via migration)"
hard-offline: "The underlying page is dead, we cannot trust it, so
               we shut it down, killing whoever is holding it
               along the way".

Am I wrong Naoya?

-- 
Oscar Salvador
SUSE L3
