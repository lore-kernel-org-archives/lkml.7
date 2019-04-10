Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36255C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02FDE217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 10:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbfDJKYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 06:24:24 -0400
Received: from mga12.intel.com ([192.55.52.136]:43939 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727497AbfDJKYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 06:24:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Apr 2019 03:24:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,332,1549958400"; 
   d="scan'208";a="163012781"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 10 Apr 2019 03:24:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 10 Apr 2019 13:24:15 +0300
Date:   Wed, 10 Apr 2019 13:24:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v3 PATCH 6/6] usb: mtu3: register a USB Role Switch for dual
 role mode
Message-ID: <20190410102415.GH20058@kuha.fi.intel.com>
References: <1554257354-7440-1-git-send-email-chunfeng.yun@mediatek.com>
 <1554257354-7440-7-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1554257354-7440-7-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:09:14AM +0800, Chunfeng Yun wrote:
> +static int ssusb_role_sw_register(struct otg_switch_mtk *otg_sx)
> +{
> +	struct usb_role_switch_desc role_sx_desc = { 0 };
> +	struct ssusb_mtk *ssusb =
> +		container_of(otg_sx, struct ssusb_mtk, otg_switch);
> +
> +	if (!otg_sx->role_sw_used)
> +		return 0;
> +
> +	role_sx_desc.set = ssusb_role_sw_set;
> +	role_sx_desc.get = ssusb_role_sw_get;

        role_sw_desc.fwnode = dev_fwnode(ssusb->dev);

> +	otg_sx->role_sw = usb_role_switch_register(ssusb->dev, &role_sx_desc);
> +
> +	return PTR_ERR_OR_ZERO(otg_sx->role_sw);
> +}

thanks,

-- 
heikki
