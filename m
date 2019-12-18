Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694FC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D40B2465E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="XGCMW5r3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbfLRTFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:05:16 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:53334 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbfLRTFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:05:16 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695915; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=BjpzurhMhS3nVjCNC6B/Q+JIxPeQXE2CiRAt+BcpBCY=;
 b=XGCMW5r3Sjed+EvQQAg0yqSPevgasW0DlVgbdzk4+16HllcP/LymqT8iAH8FvqOwKqTR3aCr
 02XLmWpOAGzwTVLr6tBlCAWkKlAV6zN1Uhhjxn8P9pXMhHxFTHA13jmTlZGoB7CBqHhdo5vC
 0dKis5mw3LnY5V+RpKePS35qu+Y=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa7869.7f0461220a78-smtp-out-n03;
 Wed, 18 Dec 2019 19:05:13 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 005CFC4479F; Wed, 18 Dec 2019 19:05:12 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFE48C447A5;
        Wed, 18 Dec 2019 19:05:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFE48C447A5
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mwifiex: delete unused mwifiex_get_intf_num()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191210003911.28066-1-briannorris@chromium.org>
References: <20191210003911.28066-1-briannorris@chromium.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     linux-wireless@vger.kernel.org, <linux-kernel@vger.kernel.org>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Nishant Sarmukadam <nishants@marvell.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Sharvari Harisangam <sharvari@marvell.com>,
        Brian Norris <briannorris@chromium.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218190513.005CFC4479F@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 19:05:12 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> Commit 7afb94da3cd8 ("mwifiex: update set_mac_address logic") fixed the
> only user of this function, partly because the author seems to have
> noticed that, as written, it's on the borderline between highly
> misleading and buggy.
> 
> Anyway, no sense in keeping dead code around: let's drop it.
> 
> Fixes: 7afb94da3cd8 ("mwifiex: update set_mac_address logic")
> Signed-off-by: Brian Norris <briannorris@chromium.org>

Patch applied to wireless-drivers-next.git, thanks.

1c9f329b084b mwifiex: delete unused mwifiex_get_intf_num()

-- 
https://patchwork.kernel.org/patch/11281155/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
