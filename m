Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19768C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E996C20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfHLKc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:32:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:29383 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfHLKc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:32:29 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2019 03:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,377,1559545200"; 
   d="scan'208";a="193928694"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 12 Aug 2019 03:31:48 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 12 Aug 2019 13:31:47 +0300
Date:   Mon, 12 Aug 2019 13:31:47 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     Roger Quadros <rogerq@ti.com>,
        "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Anil Joy Varughese <aniljoy@cadence.com>
Subject: Re: [PATCH v10 5/6] usb:cdns3 Add Cadence USB3 DRD Driver
Message-ID: <20190812103147.GA4691@kuha.fi.intel.com>
References: <1563733939-21214-1-git-send-email-pawell@cadence.com>
 <1563733939-21214-6-git-send-email-pawell@cadence.com>
 <88742d5b-ee10-cf4e-6724-58e7bdd19cb9@ti.com>
 <BYAPR07MB47090BCA728600F0C2F4E129DDD00@BYAPR07MB4709.namprd07.prod.outlook.com>
 <1e557bcf-2d50-f600-0e81-1f9fba5499a1@ti.com>
 <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB4709F306EC472B7AABEB7D4CDDD30@BYAPR07MB4709.namprd07.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >>>> +	real_role = cdsn3_real_role_switch_get(cdns->dev);
> >>>> +
> >>>> +	current_role = role;
> >>>> +	dev_dbg(cdns->dev, "Switching role");
> >>>> +
> >>>> +	ret = cdns3_role_start(cdns, real_role);
> >>>> +	if (ret) {
> >>>> +		/* Back to current role */
> >>>> +		dev_err(cdns->dev, "set %d has failed, back to %d\n",
> >>>> +			role, current_role);
> >>>> +		ret = cdns3_role_start(cdns, current_role);
> >>>> +		if (ret)
> >>>> +			dev_err(cdns->dev, "back to %d failed too\n",
> >>>> +				current_role);
> >>>> +	}
> >>>> +exit:
> >>>> +	pm_runtime_put_sync(cdns->dev);
> >>>> +	return ret;
> >>>> +}
> >>>> +
> >>>> +static const struct usb_role_switch_desc cdns3_switch_desc = {
> >>>> +	.set = cdns3_role_switch_set,
> >>>> +	.get = cdsn3_real_role_switch_get,
> >>>> +	.allow_userspace_control = true,
> >>>
> >>> how does user initiated cdns3_role_switch_set() via sysfs co-exist with role
> >>> changes done by hardware events. e.g. ID/VBUS?
> >>>
> >>
> >> Do you expect any issues whit this,  have you seen any problem with this
> >> on your  platform ?
> >>
> >> I assume that it should work in this way:
> >> 1. user change role by sysfs
> >> 2. Driver change the role according with user request.
> >> 3. If we receive correct ID/VBUS then role should not be changed
> >>     because new role is the same as current set in point 2.
> >>
> >
> >I have not tested this series yet.
> >My understanding is that if user sets role to "host" or "device" then it should
> >remain in that role irrespective of ID/VBUS. Once user sets it to "none" then
> >port should set role based on ID/VBUS.
> 
> According with your understanding it works the same way as by debugfs. 
> Now I have no doubts to remove debugfs.c file :)

Hold on! The role "none" means that the connector should not be
connected to either the host nor device.

The sysfs file we expose from the class for the role switches is
primarily meant for supporting proprietary protocols that require us
to basically override the connector USB data role. The default role
should always be selected in the drivers.

With USB Type-C connectors and alternate modes, the "none" role is
used for example when the connector is put into "USB Safe State". In
case you guys are not familiar with USB Safe State, then it is a state
(defined in USB PD specifications) for the connector where the data
lines on the connector should not be physically connected to anything.
The connector needs to be put into safe state always when entering
or exiting an alternate mode, before the final mode (USB or alternate)
is actually being set for the connector.


thanks,

-- 
heikki
