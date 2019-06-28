Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2EC5B57A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE25F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561709931;
	bh=rD2QnGgrojSpM34ae6AihudP5kCQ6TOlihTyO5800L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CJNbF9K55gknP3NZfND715l2jiWwhT1CDdsELm/MKOXMLfmF+bb7cY8N76zE4R4O4
	 Ku41mGPi7dqepBI69Dv6ApbJBCezHfA2q3BOPsbNt2xlZ9wf5Y55q2YJTzq8kUgLx5
	 XD0n7dI0SyvGuDFPd7A60Pjny8DOv1Wsn8onF6YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfF1ISu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 04:18:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726416AbfF1ISu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 04:18:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16C562053B;
        Fri, 28 Jun 2019 08:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561709929;
        bh=rD2QnGgrojSpM34ae6AihudP5kCQ6TOlihTyO5800L4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iVgpQl/oCK/abO+hiHK3IBZZy0vSILVWOWrnX7bEDka90LJunF1vtPkbDftREZclb
         aL/liw82kdvmjvPL2rTccAG5hfoUiGgrGOfabTTEXXrUP+C+rtEXbXDOAUtL6KYb2P
         dzzXkCttQAgBPsbSySsMmclwCY3di6UMG6iZNyFc=
Date:   Fri, 28 Jun 2019 10:18:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, nv@vosn.de
Subject: Re: [PATCH] drivers/usb/typec/tps6598x.c: fix two bugs
Message-ID: <20190628081846.GA19778@kroah.com>
References: <20190628081235.19205-1-nikolaus.voss@loewensteinmedical.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628081235.19205-1-nikolaus.voss@loewensteinmedical.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 10:12:35AM +0200, Nikolaus Voss wrote:
> 1. Portinfo bit field is 3 bits wide, not 2 bits. This led to
>    a wrong driver configuration for some tps6598x configurations.
> 
> 2. Writing 4CC commands with tps6598x_write_4cc() already has
>    a pointer arg, don't reference it when using as arg to
>    tps6598x_block_write(). Correcting this enforces the constness
>    of the pointer to propagate to tps6598x_block_write(), so add
>    the const qualifier there to avoid the warning.

Please split this up into two seprate patches as these are doing two
different things.

thanks,

greg k-h
