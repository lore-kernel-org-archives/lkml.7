Return-Path: <SRS0=2Nly=TJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1542C04AB1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F19921479
	for <linux-kernel@archiver.kernel.org>; Thu,  9 May 2019 21:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557439181;
	bh=e4tC8vhK107bcrTnHbf4qu6HOZluUTdtCEyMC7T2AKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BSxFII8lZJLjUArVYRue6Rz9hIRAkY7Uyk/fnqX8O5+ey1tR9BZzGp4wwEY88V5el
	 ATrWyj7XHVAF+ZDOfUd29TA20QAivTfG02R/W4Zdz7U5SvJv7xcqTieRHW9ooDYnNK
	 +k/vzGLNOD4zd5scfyU/x18vrCn6uAYYTJrZuc/c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfEIV7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 May 2019 17:59:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:36128 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfEIV7k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 May 2019 17:59:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 May 2019 14:59:39 -0700
X-ExtLoop1: 1
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga007.jf.intel.com with ESMTP; 09 May 2019 14:59:38 -0700
Date:   Thu, 9 May 2019 15:54:09 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario.Limonciello@dell.com
Cc:     kai.heng.feng@canonical.com, hch@lst.de, axboe@fb.com,
        sagi@grimberg.me, rafael@kernel.org, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, keith.busch@intel.com
Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
Message-ID: <20190509215409.GD9675@localhost.localdomain>
References: <064701C3-2BD4-4D93-891D-B7FBB5040FC4@canonical.com>
 <CAJZ5v0ggMwpJt=XWXu4gU51o8y4BpJ4KZ5RKzfk3+v8GGb-QbQ@mail.gmail.com>
 <A4DD2E9F-054E-4D4B-9F77-D69040EBE120@canonical.com>
 <20190509095601.GA19041@lst.de>
 <225CF4F7-C8E1-4C66-B362-97E84596A54E@canonical.com>
 <20190509103142.GA19550@lst.de>
 <AB325926-0D77-4851-8E8A-A10599756BF9@canonical.com>
 <31b7d7959bf94c15a04bab0ced518444@AUSX13MPC101.AMER.DELL.COM>
 <20190509192807.GB9675@localhost.localdomain>
 <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a002851c435481593f8629ec9193e40@AUSX13MPC101.AMER.DELL.COM>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 09:37:58PM +0000, Mario.Limonciello@dell.com wrote:
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned npss)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&ctrl->scan_lock);
> > +	nvme_start_freeze(ctrl);
> > +	nvme_wait_freeze(ctrl);
> > +	ret = nvme_set_features(ctrl, NVME_FEAT_POWER_MGMT, npss, NULL, 0,
> > +				NULL);
> > +	nvme_unfreeze(ctrl);
> > +	mutex_unlock(&ctrl->scan_lock);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(nvme_set_power);
> 
> I believe without memory barriers at the end disks with HMB this will
> still kernel panic (Such as Toshiba BG3).

Well, the mutex has an implied memory barrier, but your HMB explanation
doesn't make much sense to me anyway. The "mb()" in this thread's original
patch is a CPU memory barrier, and the CPU had better not be accessing
HMB memory. Is there something else going on here?
 
> This still allows D3 which we found at least failed to go into deepest state and blocked
> platform s0ix for the following SSDs (maybe others):
> Hynix PC601
> LiteOn CL1

We usually write features to spec first, then quirk non-compliant
devices after.
