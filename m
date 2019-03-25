Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E59BE206DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 10:01:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfCYKBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 06:01:09 -0400
Received: from mga11.intel.com ([192.55.52.93]:11202 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729912AbfCYKBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 06:01:09 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Mar 2019 03:01:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,256,1549958400"; 
   d="scan'208";a="143599480"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by FMSMGA003.fm.intel.com with SMTP; 25 Mar 2019 03:01:05 -0700
Received: by lahna (sSMTP sendmail emulation); Mon, 25 Mar 2019 12:01:04 +0200
Date:   Mon, 25 Mar 2019 12:01:04 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: property: fix a buffer overflow and a
 missing check
Message-ID: <20190325100104.GE3622@lahna.fi.intel.com>
References: <20190324224916.1389-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190324224916.1389-1-kjlu@umn.edu>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 24, 2019 at 05:49:16PM -0500, Kangjie Lu wrote:
> First, no memory is allocated for "property->value.text"; the
> following strcpy will lead to a buffer overflow.

It is actually member of union so assigning via value.txt or value.data
is the same.

So no buffer overflow.

> Second, no check is enforced for the return value of kzalloc,
> which may lead to NULL-pointer dereference.

Yes, this is valid.

Can you fix the changelog accordingly and resend?

> 
> The patch fixes the two issues.
> 
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/thunderbolt/property.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
> index 841314deb446..d5b0cdb8f0b1 100644
> --- a/drivers/thunderbolt/property.c
> +++ b/drivers/thunderbolt/property.c
> @@ -587,7 +587,12 @@ int tb_property_add_text(struct tb_property_dir *parent, const char *key,
>  		return -ENOMEM;
>  
>  	property->length = size / 4;
> -	property->value.data = kzalloc(size, GFP_KERNEL);
> +	property->value.text = kzalloc(size, GFP_KERNEL);
> +	if (!property->value.text) {
> +		kfree(property);
> +		return -ENOMEM;
> +	}
> +
>  	strcpy(property->value.text, text);
>  
>  	list_add_tail(&property->list, &parent->properties);
> -- 
> 2.17.1
