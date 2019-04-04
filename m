Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EB9C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1505920820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554374133;
	bh=s13C7RYgXPk+LrTq3e45iGiNRfJi4yFDT84ZX9WVF24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNCv1NHx3jN+uFRoZ2pMgVWZoyLk7d5Z+eJnlNRdfKIl55fUvi4HKmviPBhfJCy1G
	 pWmhSMjfmEN8JUlPi+UXyrTRajTuyG7IdmkXV/XxFKTji8bbjaCdgF66fXSO9qOwL3
	 HsxDU/uDhYRYUeW2lVv0iSIxm68CdhbODXogsWvw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbfDDKfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 06:35:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:39302 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728818AbfDDKfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 06:35:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 91E5FABC1;
        Thu,  4 Apr 2019 10:35:29 +0000 (UTC)
Date:   Thu, 4 Apr 2019 12:35:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Willem de Bruijn <willemb@google.com>,
        kernel-janitors@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] cpumask: Introduce possible_cpu_safe()
Message-ID: <20190404103528.GG12864@dhcp22.suse.cz>
References: <20190404100218.GA26946@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404100218.GA26946@kadam>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 04-04-19 13:02:19, Dan Carpenter wrote:
> There have been two cases recently where we pass user a controlled "cpu"
> to possible_cpus().  That's not allowed.  If it's invalid, it will
> trigger a WARN_ONCE() and an out of bounds read which could result in an
> Oops.
> 
> This patch introduces possible_cpu_safe() which first checks to see if
> the cpu is valid, turns off speculation and then checks if the cpu is
> possible.

Why cannot we do the check in possible_cpu directly? Is it used from any
hot path? I am quite skeptical people will use the new helper
consistently.
-- 
Michal Hocko
SUSE Labs
