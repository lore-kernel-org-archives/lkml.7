Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37D6C04AAC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AE721019
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558595838;
	bh=eiGOOX+EGA1KBiToSWBKualahQfAUa0B+ueJ5NG+3hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UEV2mh4ZSTFwxqVhyPjWSDw4BaEhF2vxVTThpIXA+pazod2ZB39ik/eOYhKS71gqN
	 ei4Z1arers4GKrBy+PhCm+/cEIe3agIb9ZsgKieIWlDshDsEPl173GNpcZKpZVhgXV
	 3q8lKkhHOxWbkzeCNo94IgVYKI8BjNgSj1gxc8O0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbfEWHRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 03:17:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfEWHRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 03:17:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4E1C204FD;
        Thu, 23 May 2019 07:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558595836;
        bh=eiGOOX+EGA1KBiToSWBKualahQfAUa0B+ueJ5NG+3hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ky26tUWoLRLmc9oFI55i6FmOCFtmJyYaUeQcO/BAX7wMD31mamubA8JN8SepI7iwB
         8nk/5BFfgliPziiTdoy+ulGp6nfazf/kSKFr/0jD6uAP13R6nrPPzTvi/LzG9UQODT
         XXPW6wM0pM/5dkpeE8gmD0enuH3x7lXiFHBwuTPM=
Date:   Thu, 23 May 2019 09:17:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc:     David Kershner <david.kershner@unisys.com>,
        Petr Machata <petrm@mellanox.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jann Horn <jannh@google.com>, sparmaintainer@unisys.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: unisys: visornic: Replace GFP_ATOMIC with
 GFP_KERNEL
Message-ID: <20190523071713.GA24998@kroah.com>
References: <20190522170530.GA4331@hari-Inspiron-1545>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522170530.GA4331@hari-Inspiron-1545>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:35:30PM +0530, Hariprasad Kelam wrote:
> As per below information
> 
> GFP_KERNEL  FLAG
> 
> This is a normal allocation and might block. This is the flag to use in
> process context code when it is safe to sleep.
> 
> GFP_ATOMIC FLAG
> 
> The allocation is high-priority and does not sleep. This is the flag to
> use in interrupt handlers, bottom halves and other situations where you
> cannot sleep
> 
> And we can take advantage of GFP_KERNEL , as when system is in low
> memory chances of getting success is high compared to GFP_ATOMIC.
> 
> As visornic_probe is in  process context we can use GPF_KERNEL.

Ah, nice catch!  Will go queue this up now, thanks.

greg k-h
