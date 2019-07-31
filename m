Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35419C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AB6206B8
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564578166;
	bh=nOK38oPQIq5CjwSztu+m7awIRI43PZwQyDnMhEH4DoA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DUqw3neOs0rXWyg5bIlJGNgZJ9mh+rOQg1FaNgRwwQDb/Ip/pREoDQK2z0QwD0d0Y
	 Cciw/OXZJESWi0MIZe5/4/0eWuhZk6QOtkoJrixefjbPfge9IMPDIJX1LCrU27YdUZ
	 5DARq8yxsHtyCVI5ztA4r9s8zVURARea0ErMMVXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729359AbfGaNCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbfGaNCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:02:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33B8D206B8;
        Wed, 31 Jul 2019 13:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564578163;
        bh=nOK38oPQIq5CjwSztu+m7awIRI43PZwQyDnMhEH4DoA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxA7Ur5hpdNxmxe0yYq4gVgJ7CG8modTO6dJRZMAW0G7VE6k7xmpRXeZe+DaTsaiJ
         Pr7EbYgdj3SmxYnmLCmem66Iw1+Aby6DzyCmujEwNdGncRdCFBYK70VbmzHENlmsx+
         DEgj8ly0m62VZXPRbmws7m6zazEdUB2xmWLT7rqQ=
Date:   Wed, 31 Jul 2019 15:02:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Subject: Re: [PATCH v3 0/7] habanalabs: support info queries by multiple
 processes
Message-ID: <20190731130241.GC7590@kroah.com>
References: <20190731125901.20709-1-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731125901.20709-1-oded.gabbay@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2019 at 03:58:54PM +0300, Oded Gabbay wrote:
> v3 introduces a few fixes and changes the control char device's minor
> number to be 1 above that of the main device.
> 
> Original text:
> 
> Today, the driver allows only a single user application (the deep-learning
> application) to perform queries of the device's stats, information, idle
> state and more.
> 
> This is a serious limitation in data centers, where there are
> multiple system/monitorining applications that want to continuously
> retrieve that information, while allowing the deep-learning application to
> perform work on the device.
> 
> This patch-set allows unlimited number of user applications to perform
> the above queries (by calling the INFO IOCTL), while the deep-learning
> application is running.
> 
> This is done by creating an additional char device per ASIC, that is
> dedicated to information retrieval only (allows only to call the INFO
> IOCTL). This method will maintain backward compatibility with existing
> userspace applications.
> 
> - Patches 1-4 makes small improvements to existing code.
> - Patch 5 removes the accounting of the number of open file-descriptors
>   and replace it with tracking of the driver's internal file private data
>   strcuture.
> - Patch 6 is a pre-requisite to creating the two char devices
> - Patch 7 introduce the additional char device
> 
> Thanks,
> Oded
> 
> Oded Gabbay (7):
>   habanalabs: add handle field to context structure
>   habanalabs: kill user process after CS rollback
>   habanalabs: show the process context dram usage
>   habanalabs: rename user_ctx as compute_ctx
>   habanalabs: maintain a list of file private data objects
>   habanalabs: change device_setup_cdev() to be more generic
>   habanalabs: create two char devices per ASIC

Whole series is:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
