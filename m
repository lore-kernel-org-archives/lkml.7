Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68F49C04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48CFC205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 14:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfE0OFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 10:05:21 -0400
Received: from 8bytes.org ([81.169.241.247]:40248 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726184AbfE0OFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 10:05:21 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6FB302E2; Mon, 27 May 2019 16:05:19 +0200 (CEST)
Date:   Mon, 27 May 2019 16:05:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lukasz Odzioba <lukasz.odzioba@intel.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        dwmw2@infradead.org, grzegorz.andrejczuk@intel.com
Subject: Re: [PATCH 1/1] iommu/vt-d: Remove unnecessary rcu_read_locks
Message-ID: <20190527140514.GE8420@8bytes.org>
References: <1558359688-21804-1-git-send-email-lukasz.odzioba@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558359688-21804-1-git-send-email-lukasz.odzioba@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 20, 2019 at 03:41:28PM +0200, Lukasz Odzioba wrote:
> We use RCU's for rarely updated lists like iommus, rmrr, atsr units.
> 
> I'm not sure why domain_remove_dev_info() in domain_exit() was surrounded
> by rcu_read_lock. Lock was present before refactoring in d160aca527,
> but it was related to rcu list, not domain_remove_dev_info function.
> 
> dmar_remove_one_dev_info() doesn't touch any of those lists, so it doesn't
> require a lock. In fact it is called 6 times without it anyway.
> 
> Fixes: d160aca5276d ("iommu/vt-d: Unify domain->iommu attach/detachment")
> 
> Signed-off-by: Lukasz Odzioba <lukasz.odzioba@intel.com>

Applied, thanks.

