Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95992C00307
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B901F206CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 14:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567692515;
	bh=lLiim3xozZsjHT0hv+3puo/J1QUY0m34Dk8S3dYgrd8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bYLkNOB8UYW/8HMx8YoVjG0FqLWaKPDusIV2tia9ZjGypo3SqvY0wxr2buDg2NE12
	 2tKodRfEpfJ/WXgiF3bEeZfrooX4s3RIPXveJPG4oH4siAzQB6hq6DuSc4K8vqg0b5
	 Z+jDHkzjW+ZOCq0ZYhdwQr0x4XUr9Wzlklb9dprE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbfIEOIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 10:08:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:40136 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727053AbfIEOIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 10:08:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3F3F5AD07;
        Thu,  5 Sep 2019 14:08:33 +0000 (UTC)
Date:   Thu, 5 Sep 2019 16:08:33 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     David Rientjes <rientjes@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] mm, oom: disable dump_tasks by default
Message-ID: <20190905140833.GB3838@dhcp22.suse.cz>
References: <20190903144512.9374-1-mhocko@kernel.org>
 <af0703d2-17e4-1b8e-eb54-58d7743cad60@i-love.sakura.ne.jp>
 <20190904054004.GA3838@dhcp22.suse.cz>
 <alpine.DEB.2.21.1909041302290.95127@chino.kir.corp.google.com>
 <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12bcade2-4190-5e5e-35c6-7a04485d74b9@i-love.sakura.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05-09-19 22:39:47, Tetsuo Handa wrote:
[...]
> There is nothing that prevents users from enabling oom_dump_tasks by sysctl.
> But that requires a solution for OOM stalling problem.

You can hardly remove stalling if you are not reducing the amount of
output or get it into a different context. Whether the later is
reasonable is another question but you are essentially losing "at the
OOM event state".

> Since I know how
> difficult to avoid problems caused by printk() flooding, I insist that
> we need "mm,oom: Defer dump_tasks() output." patch.

insisting is not a way to cooperate.
-- 
Michal Hocko
SUSE Labs
