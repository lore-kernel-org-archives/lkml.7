Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABE5CA9EB9
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810C521920
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 09:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571736180;
	bh=MtwsP7fcRWcu/yiKFb2y8zPHvuSpocGfqzcw69Qu8Ko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vNkEwG0+jqeEICmBPwyX8oPE9irhde2fYTmPvytcv+HEb/BaMxXwvS5Gqi6DuRJJa
	 JJc5231agqKPU16fBvo6wgpvFUNTTOd7ByHY3xLfFxRUpnwky2PwQ7GKrsBNUu6S+A
	 DMgO1qGR0wwkrTyIc2IHwAfgjWpqQj5tOfwmXOqA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388530AbfJVJW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:22:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:46430 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387995AbfJVJW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Oct 2019 05:22:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F914AC16;
        Tue, 22 Oct 2019 09:22:57 +0000 (UTC)
Date:   Tue, 22 Oct 2019 11:22:56 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     n-horiguchi@ah.jp.nec.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 10/16] mm,hwpoison: Rework soft offline for free
 pages
Message-ID: <20191022092256.GH9379@dhcp22.suse.cz>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20191017142123.24245-11-osalvador@suse.de>
 <20191018120615.GM5017@dhcp22.suse.cz>
 <20191021125842.GA11330@linux>
 <20191021154158.GV9379@dhcp22.suse.cz>
 <20191022074615.GA19060@linux>
 <20191022082611.GD9379@dhcp22.suse.cz>
 <20191022083505.GA19708@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191022083505.GA19708@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-10-19 10:35:17, Oscar Salvador wrote:
> On Tue, Oct 22, 2019 at 10:26:11AM +0200, Michal Hocko wrote:
> > On Tue 22-10-19 09:46:20, Oscar Salvador wrote:
> > [...]
> > > So, opposite to hard-offline, in soft-offline we do not fiddle with pages
> > > unless we are sure the page is not reachable anymore by any means.
> > 
> > I have to say I do not follow. Is there any _real_ reason for
> > soft-offline to behave differenttly from MCE (hard-offline)?
> 
> Yes.
> Do not take it as 100% true as I read that in some code/Documentation
> a while ago.
> 
> But I think that it boils down to:
> 
> soft-offline: "We have seen some erros in the underlying page, but
>                it is still usable, so we have a chance to keep the
>                the contents (via migration)"
> hard-offline: "The underlying page is dead, we cannot trust it, so
>                we shut it down, killing whoever is holding it
>                along the way".

Hmm, that might be a misunderstanding on my end. I thought that it is
the MCE handler to say whether the failure is recoverable or not. If yes
then we can touch the content of the memory (that would imply the
migration). Other than that both paths should be essentially the same,
no? Well unrecoverable case would be essentially force migration failure
path.

MADV_HWPOISON is explicitly documented to test MCE handling IIUC:
: This feature is intended for testing of memory error-handling
: code; it is available only if the kernel was configured with
: CONFIG_MEMORY_FAILURE.

There is no explicit note about the type of the error that is injected
but I think it is reasonably safe to assume this is a recoverable one.
-- 
Michal Hocko
SUSE Labs
