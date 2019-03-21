Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F572C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01799218A5
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 06:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfCUGBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 02:01:04 -0400
Received: from mga06.intel.com ([134.134.136.31]:28099 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbfCUGBE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 02:01:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Mar 2019 23:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,251,1549958400"; 
   d="scan'208";a="124509653"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by orsmga007.jf.intel.com with SMTP; 20 Mar 2019 23:01:00 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 21 Mar 2019 08:00:59 +0200
Date:   Thu, 21 Mar 2019 08:00:59 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Fix to check the return value of kmemdup
Message-ID: <20190321060059.GE3622@lahna.fi.intel.com>
References: <20190319183834.14503-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319183834.14503-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 01:38:34PM -0500, Aditya Pakki wrote:
> uuid in add_switch is allocted via kmemdup which can fail. The patch
> logs the error in such a scenario.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  drivers/thunderbolt/icm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index e3fc920af682..8df8057cd79e 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -473,6 +473,7 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
>  		goto out;
>  
>  	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
> +	WARN_ONCE(!sw->uuid, "%s: sw->uuid = NULL", __func__);

I don't think it is good idea to continue here since uuid is kind of
needed. Maybe do the same as above (goto out) with a useful error
message along the lines of "cannot allocate memory for switch" or so.

Remember to use tb_switch_put() in that case.
