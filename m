Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF30FC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7E63208CA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 13:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557755552;
	bh=BDtrHeDetR61sJ1NtPNMI5rj1aAqPOBRg2vQUOYWcao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d6wwAlcsH2FdWos0epkVGXiSHUP2e1+KTvFfXFNRclRHBmTaRziNUtCL9JYt2WTmO
	 Za44ji5tJciPGYW/d7m5KzMrj4Cik1JgVhQybgGvVRuONwjA3eValNlKLCk7eOnCE6
	 72gO/FrKibfOfjYsovnDkyVQzhzz/Su3xDRNgJBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729873AbfEMNwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 09:52:31 -0400
Received: from mga09.intel.com ([134.134.136.24]:40693 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729452AbfEMNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 09:52:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 06:52:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,465,1549958400"; 
   d="scan'208";a="171196692"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2019 06:52:29 -0700
Date:   Mon, 13 May 2019 07:47:08 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "Busch, Keith" <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-pm <linux-pm@vger.kernel.org>,
        Mario Limonciello <Mario.Limonciello@dell.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Rafael Wysocki <rafael@kernel.org>
Subject: Re: [PATCH] nvme/pci: Use host managed power state for suspend
Message-ID: <20190513134708.GB15318@localhost.localdomain>
References: <20190510212937.11661-1-keith.busch@intel.com>
 <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB452735778FD952AA838E78C9860E0@SN6PR04MB4527.namprd04.prod.outlook.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2019 at 11:06:35PM -0700, Chaitanya Kulkarni wrote:
> On 5/10/19 2:35 PM, Keith Busch wrote:
> >   
> > +int nvme_set_power(struct nvme_ctrl *ctrl, unsigned ps)

> dev->ctrl.npss is u8 can we use same data type here ?
> If this is due to last_ps we use as a result and then call set_power may 
> be we can change the type of last_ps ?
> OR
> can we please use unsigned int to avoid possible warnings ?

Right, the feature uses a 32-bit value even though only the first byte
is defined at the moment. It's just for foward compatibility. Will make
this a u32.

> > +int nvme_get_power(struct nvme_ctrl *ctrl, u32 *result)
> > +{
> > +	struct nvme_command c;
> May be use struct nvme_command c {} so we can get rid of the memset() call.

Good point.

> > +	union nvme_result res;
> > +	int ret;
> > +
> > +	if (!result)
> > +		return -EINVAL;
> > +
> > +	memset(&c, 0, sizeof(c));
> > +	c.features.opcode = nvme_admin_get_features;
> > +	c.features.fid = cpu_to_le32(NVME_FEAT_POWER_MGMT);
> > +
> > +	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &c, &res,
> > +			NULL, 0, 0, NVME_QID_ANY, 0, 0, false);
> > +	if (ret >= 0)
> > +		*result = le32_to_cpu(res.u32);
>
> May be add a check for result here in above if before deref pointer :-
> 	if (ret >= 0 && result)

I have it checked at the top of the function since it doesn't make much
sense to call this without a way to return the result.
