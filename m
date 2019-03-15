Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907ACC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6971D218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 09:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfCOJLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 05:11:34 -0400
Received: from mga07.intel.com ([134.134.136.100]:25123 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727282AbfCOJLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 05:11:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 02:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,481,1544515200"; 
   d="scan'208";a="155287992"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 15 Mar 2019 02:11:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 15 Mar 2019 11:11:27 +0200
Date:   Fri, 15 Mar 2019 11:11:27 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 4/6] usb: roles: add API to get usb_role_switch by node
Message-ID: <20190315091127.GF7752@kuha.fi.intel.com>
References: <1552635513-2378-1-git-send-email-chunfeng.yun@mediatek.com>
 <1552635513-2378-5-git-send-email-chunfeng.yun@mediatek.com>
 <20190315081835.GD7752@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315081835.GD7752@kuha.fi.intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 10:18:35AM +0200, Heikki Krogerus wrote:
> Andy already pointed out that you need to use fwnodes.
> 
> Rule of thumb: You always use fwnodes. Only if there is something that
> can't be done with fwnodes you use DT or ACPI nodes directly.
> 
> In this case there is absolutely nothing that would prevent you from
> using fwnodes.

...

> +/**
> + * usb_role_switch_get_by_node - Find USB role switch by it's parent node
> + * @node: The node that register USB role switch
> + *
> + * Finds and returns role switch registered by @node. The reference count
> + * for the found switch is incremented.
> + */
> +struct usb_role_switch *usb_role_switch_get_by_node(struct device_node *node)

This is my proposal for function prototype:

struct usb_role_switch *
fwnode_usb_role_switch_get(struct fwnode_handle *fwnode);


thanks,

-- 
heikki
