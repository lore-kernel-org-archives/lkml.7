Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFF8C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA0A218A6
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 16:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553876816;
	bh=Tccv/yg+5lH9K1dXNYk4rXg6MPswEtky165ALatvt9A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QkkoFlTItL/g/qo4OBYs3AdPAM3giSptGpz98N85l0FpXfrvENV8qRvmGo1QKLMBj
	 bJz78ej2UWhZ+VgLksdRe188+7cSxVVbjMzS2Gp2k7jj+KICod80UnuTeauMkolk9Q
	 vccHMP2oosdQFz8iqT94oCGBtUok2uJPPIFR07gA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbfC2Q0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 12:26:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:39856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfC2Q0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 12:26:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB4F52173C;
        Fri, 29 Mar 2019 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553876814;
        bh=Tccv/yg+5lH9K1dXNYk4rXg6MPswEtky165ALatvt9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CspyTwQ2USzqVg46DHPocag4nY8KdT/QVnLT8M0E7OIaedW6/tf+B1AiSWtU9FA0O
         DuAwMQtFu0z1dJweqTs+uobfXiwDpst7idxWjgRrNRI8GvvCpbU7PP9i/Q21d9Gnhp
         9cyndw4KkMRfrNWUTlhxqPTqt+OniJ90HepBqQU8=
Date:   Fri, 29 Mar 2019 17:26:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Lingutla Chandrasekhar <clingutla@codeaurora.org>
Cc:     quentin.perret@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com, juri.lelli@gmail.com,
        catalin.marinas@arm.com, jeremy.linton@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arch_topology: Make cpu_capacity sysfs node as
 ready-only
Message-ID: <20190329162651.GA9608@kroah.com>
References: <20190328044705.16838-1-clingutla@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328044705.16838-1-clingutla@codeaurora.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 28, 2019 at 10:17:05AM +0530, Lingutla Chandrasekhar wrote:
> If user updates any cpu's cpu_capacity, then the new value is going to
> be applied to all its online sibling cpus. But this need not to be correct
> always, as sibling cpus (in ARM, same micro architecture cpus) would have
> different cpu_capacity with different performance characteristics.
> So, updating the user supplied cpu_capacity to all cpu siblings
> is not correct.
> 
> And another problem is, current code assumes that 'all cpus in a cluster
> or with same package_id (core_siblings), would have same cpu_capacity'.
> But with commit '5bdd2b3f0f8 ("arm64: topology: add support to remove
> cpu topology sibling masks")', when a cpu hotplugged out, the cpu
> information gets cleared in its sibling cpus. So, user supplied
> cpu_capacity would be applied to only online sibling cpus at the time.
> After that, if any cpu hotplugged in, it would have different cpu_capacity
> than its siblings, which breaks the above assumption.
> 
> So, instead of mucking around the core sibling mask for user supplied
> value, use device-tree to set cpu capacity. And make the cpu_capacity
> node as read-only to know the asymmetry between cpus in the system.
> While at it, remove cpu_scale_mutex usage, which used for sysfs write
> protection.
> 
> Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Tested-by: Quentin Perret <quentin.perret@arm.com>
> Reviewed-by: Quentin Perret <quentin.perret@arm.com>
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Lingutla Chandrasekhar <clingutla@codeaurora.org>

I see 3 "v2" patches in my queue, all different :(

Also, you need to list what changed below the --- line as the
documentation says to do so.  Please fix up and resend v3.

thanks,

greg k-h
