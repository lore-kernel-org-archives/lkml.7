Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4923C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADC392175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 10:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfCTK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 06:56:36 -0400
Received: from mga18.intel.com ([134.134.136.126]:20679 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727012AbfCTK4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 06:56:36 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 03:56:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,248,1549958400"; 
   d="scan'208";a="133135879"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 20 Mar 2019 03:56:32 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 20 Mar 2019 12:56:31 +0200
Date:   Wed, 20 Mar 2019 12:56:31 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix to check return value of ida_simple_get
Message-ID: <20190320105631.GT3622@lahna.fi.intel.com>
References: <20190319172259.8874-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319172259.8874-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 12:22:59PM -0500, Aditya Pakki wrote:
> ida_simple_get on failure can return an error. The patch ensures that
> the dev_set_name is set on non failure cases.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/thunderbolt/xdomain.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
> index e27dd8beb94b..b1768f595259 100644
> --- a/drivers/thunderbolt/xdomain.c
> +++ b/drivers/thunderbolt/xdomain.c
> @@ -772,7 +772,9 @@ static void enumerate_services(struct tb_xdomain *xd)
>  		svc->dev.bus = &tb_bus_type;
>  		svc->dev.type = &tb_service_type;
>  		svc->dev.parent = &xd->dev;
> -		dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev), svc->id);
> +		if (svc->id >= 0)
> +			dev_set_name(&svc->dev, "%s.%d", dev_name(&xd->dev),
> +					svc->id);

I think the correct way to handle this case is to cleanup svc right
after the allocation fails and then break out without enumerating more
services.
