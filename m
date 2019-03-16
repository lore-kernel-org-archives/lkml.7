Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5699C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:31:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72908218FC
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552725100;
	bh=/SFWCF1pINWV275o94a/20vhtzE/OnOkIsrNQJFd4E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YfFNKl9xt985M7FzUow1vzwBNSnivx4Zr0nc6NjgcB9a5cp/Wyt0cVPtoM1gI6yc8
	 E4JtZ9NMzyX3t0hnpTM4g0xkr35XFTnH6U0sG9ta70myfvh0pYJj+Yz4T5PF5PD2x3
	 qhb5Pnlh8SMWp1S8YlFCIP6FgfKbpoFj6GP7sLVg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfCPIbi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:31:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:34580 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfCPIbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:31:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id CC681AE26;
        Sat, 16 Mar 2019 08:31:36 +0000 (UTC)
Date:   Sat, 16 Mar 2019 09:31:35 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] elf: simpler check for -EEXIST
Message-ID: <20190316083135.GH15672@dhcp22.suse.cz>
References: <20190314204208.GA18143@avx2>
 <52458645-823f-825e-660f-7b01d5dbb979@i-love.sakura.ne.jp>
 <20190315160517.GA2135@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315160517.GA2135@avx2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 15-03-19 19:05:17, Alexey Dobriyan wrote:
> On Fri, Mar 15, 2019 at 07:02:23AM +0900, Tetsuo Handa wrote:
> > On 2019/03/15 5:42, Alexey Dobriyan wrote:
> > > 	PTR_ERR((void *)map_addr) == -EEXIST
> > > 
> > > is a very complicated way of doing the obvious.
> > 
> > Michal suggested me to explicitly use PTR_ERR()
> 
> without any explanation why...

The return value is ERR_PTR. This code uses unsigned long which is OK
but I thought it is better to call out the return value convention
explicitly. It is not like I would argue about that though.
-- 
Michal Hocko
SUSE Labs
