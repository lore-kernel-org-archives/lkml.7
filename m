Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C91AC43215
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 347DA222C7
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 13:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574169811;
	bh=KuVVClqX8tsVfH+5W3FLR+U/sFzRduxkNvUYuYq4oQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CIznuEFtWvsAFIfm51SpD5kEhF5JG6482Lh23cb9uhD8bg4aNNHKFL+OH1GwlV/Rv
	 HfWyXDnbaat/4jP8dA79YMMEhbcFwPdwMYT5vTVTXahxpJJmoDMEJc2hKLfX2u7oWi
	 UmA2TZY6cyu3wZ4QcjBlEVqmMTwIoWM1/4HPOwhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbfKSNXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 08:23:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:53772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726510AbfKSNX3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 08:23:29 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDDC2080F;
        Tue, 19 Nov 2019 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574169809;
        bh=KuVVClqX8tsVfH+5W3FLR+U/sFzRduxkNvUYuYq4oQI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hiE8XEJmou9/ZrBT8NlxamTWukBVCrTIFa/eOP4HsNpjt4Ry9PJuOmkGAQzFtje8E
         dDsYNs++9ogGaBD61ybRs2LBg3g5nGdAo0Cmq3Fpj0A3LPtVtAXvRcd2GHfbLeYLx3
         g8iT39gkDQvcTH0jofkbOgj0B3WD4dMA5VrACuFA=
Date:   Tue, 19 Nov 2019 08:23:28 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Fix crash handler reset of
 Hyper-V synic
Message-ID: <20191119132328.GF16867@sasha-vm>
References: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1573713076-8446-1-git-send-email-mikelley@microsoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 14, 2019 at 06:32:01AM +0000, Michael Kelley wrote:
>The crash handler calls hv_synic_cleanup() to shutdown the
>Hyper-V synthetic interrupt controller.  But if the CPU
>that calls hv_synic_cleanup() has a VMbus channel interrupt
>assigned to it (which is likely the case in smaller VM sizes),
>hv_synic_cleanup() returns an error and the synthetic
>interrupt controller isn't shutdown.  While the lack of
>being shutdown hasn't caused a known problem, it still
>should be fixed for highest reliability.
>
>So directly call hv_synic_disable_regs() instead of
>hv_synic_cleanup(), which ensures that the synic is always
>shutdown.
>
>Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Queued up, thank you.

-- 
Thanks,
Sasha
