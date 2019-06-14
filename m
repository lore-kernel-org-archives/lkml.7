Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99041C31E44
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7520421773
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 10:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfFNKEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 06:04:24 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:33379 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726370AbfFNKEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 06:04:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 4A238100E86C6;
        Fri, 14 Jun 2019 10:04:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beast43_6032aa142690d
X-Filterd-Recvd-Size: 2014
Received: from XPS-9350.home (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 14 Jun 2019 10:04:20 +0000 (UTC)
Message-ID: <8eacbd27239ec5ce956309278beae9b499499108.camel@perches.com>
Subject: Re: [PATCH] bus: hisi_lpc: Don't use devm_kzalloc() to allocate
 logical PIO range
From:   Joe Perches <joe@perches.com>
To:     John Garry <john.garry@huawei.com>, xuwei5@huawei.com
Cc:     bhelgaas@google.com, linuxarm@huawei.com, arm@kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Jun 2019 03:04:19 -0700
In-Reply-To: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
References: <1560505624-39955-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-06-14 at 17:47 +0800, John Garry wrote:
> If, after registering a logical PIO range, the driver probe later fails,
> the logical PIO range memory will be released automatically.
> 
> This causes an issue, in that the logical PIO range is not unregistered
> (that is not supported) and the released range memory may be later
> referenced
> 
> Allocate the logical PIO range with kzalloc() to avoid this potential
> issue.
> 
> Fixes: adf38bb0b5956 ("HISI LPC: Support the LPC host on Hip06/Hip07 with DT bindings")
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/bus/hisi_lpc.c b/drivers/bus/hisi_lpc.c
[]
> @@ -599,7 +599,7 @@ static int hisi_lpc_probe(struct platform_device *pdev)
>  	if (IS_ERR(lpcdev->membase))
>  		return PTR_ERR(lpcdev->membase);
>  
> -	range = devm_kzalloc(dev, sizeof(*range), GFP_KERNEL);
> +	range = kzalloc(sizeof(*range), GFP_KERNEL);

If this is really necessary, it'd be useful to say so in the
code too with a comment so it doesn't get drive-by 'unfixed'
by someone well meaning but ill-uninformed.


