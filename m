Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185EAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6CCE2087E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730511AbfCYJ7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:59:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:59675 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730250AbfCYJ7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:59:23 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 02:59:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="134498673"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga008.fm.intel.com with SMTP; 25 Mar 2019 02:59:20 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Mar 2019 11:59:19 +0200
Date:   Mon, 25 Mar 2019 11:59:19 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] thunderbolt: Fix to check the return value of kmemdup
Message-ID: <20190325095919.GD3622@lahna.fi.intel.com>
References: <20190323202034.7331-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190323202034.7331-1-pakki001@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 23, 2019 at 03:20:33PM -0500, Aditya Pakki wrote:
> uuid in add_switch is allocted via kmemdup which can fail. The patch
> logs the error and cleans up the allocated memory for switch.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> 
> ---
> v1: Change error handling from WARN_ONCE to return after clean up.
> ---
>  drivers/thunderbolt/icm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thunderbolt/icm.c b/drivers/thunderbolt/icm.c
> index e3fc920af682..be1174d86cef 100644
> --- a/drivers/thunderbolt/icm.c
> +++ b/drivers/thunderbolt/icm.c
> @@ -473,6 +473,11 @@ static void add_switch(struct tb_switch *parent_sw, u64 route,
>  		goto out;
>  
>  	sw->uuid = kmemdup(uuid, sizeof(*uuid), GFP_KERNEL);
> +	if (!sw->uuid) {
> +		WARN_ONCE(1, "cannot allocate memory for switch\n");

Please use tb_sw_WARN() or tb_sw_warn() here instead.

> +		tb_switch_put(sw);
> +		goto out;
> +	}
>  	sw->connection_id = connection_id;
>  	sw->connection_key = connection_key;
>  	sw->link = link;
> -- 
> 2.17.1
