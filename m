Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3E1FA372A
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:39:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7893320659
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 11:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571312384;
	bh=kF8QRKmECkshTHtERF1GzIHNP8UUaplgvUra5aJVBVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R37Cg2qNIrLS8CilDifvz36xkVrhHl0PwGe+RlDDKB5Om14aDmzhVy9Echc3y2vno
	 2X74reGBFJEmg59+Ef1JBSq9Ja5Zkg+1XQFAbgcXooVklPCVOWG3ued9PK6DebfAR5
	 C4U1ZS7axjeJqFIeXrPFVZ0JaCO00AKiDI2W2iow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393009AbfJQLjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 07:39:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:59798 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727991AbfJQLjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 07:39:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3FE09B717;
        Thu, 17 Oct 2019 11:39:41 +0000 (UTC)
Date:   Thu, 17 Oct 2019 13:39:39 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Pavel Machek <pavel@denx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 4.19 56/81] kernel/sysctl.c: do not override max_threads
 provided by userspace
Message-ID: <20191017113939.GH24485@dhcp22.suse.cz>
References: <20191016214805.727399379@linuxfoundation.org>
 <20191016214842.621065901@linuxfoundation.org>
 <20191017105940.GA5966@amd>
 <20191017110516.GG24485@dhcp22.suse.cz>
 <b41558c732384c6280f0fe18823aa7e1@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b41558c732384c6280f0fe18823aa7e1@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-10-19 11:25:47, David Laight wrote:
> From: Michal Hocko
> > Sent: 17 October 2019 12:05
> ...
> > > Plus, I don't see any locking here, should this be WRITE_ONCE() at
> > > minimum?
> > 
> > Why would that matter? Do you expect several root processes race to set
> > the value?
> 
> One of them wins. No one is going to notice is the value is set an extra time.

Right, this is quite obvious. The question is whether/how much it really
matters.

> WRITE_ONCE() is rarely required.
> Probably only if other code is going to update the value after seeing the first write.
> (eg if you are unlocking a mutex - although they have to be more complex)
> 
> READ_ONCE() is a different matter.
> IMHO the compiler shouldn't be allowed to do more reads than the source requests.


Right, we are talking about setting an int value. While nobody can rule
out that the compiler splitting the single write into multiple ones I
would be quite curious about seeing that...
-- 
Michal Hocko
SUSE Labs
