Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CB1C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33482064B
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 17:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="f79JcH99"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbfLRRwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 12:52:32 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:55726 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727180AbfLRRwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 12:52:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576691551; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=F5m8QQ4p8IPJ3aJPJPuQyUzhNMvwbEpBTfkagoJetIQ=;
 b=f79JcH99C01CMteSvNMGVdT539st92i44DR/21Ruuh57qvJd0nxOwZRaAezc00soVuQPaElk
 AfMjV0yVxKr9nAh5bWYdb/xjb0hvfZ4MhsMk/mg0AzbFXchZMEX3g8VGggGlkktPygLyIKKy
 s+4d2ks/DM191RHAJF94/jhFmpY=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa675a.7efb76ae92d0-smtp-out-n01;
 Wed, 18 Dec 2019 17:52:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8352CC433A2; Wed, 18 Dec 2019 17:52:26 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF429C43383;
        Wed, 18 Dec 2019 17:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF429C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH][next] ath11k: fix memory leak on reg_info
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191212183228.105993-1-colin.king@canonical.com>
References: <20191212183228.105993-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ganesh Sesetti <gseset@codeaurora.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        John Crispin <john@phrozen.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218175226.8352CC433A2@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 17:52:26 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Colin King <colin.king@canonical.com> wrote:

> Currently a return path is leaking the previously allocate reg_info. Fix
> this by exiting via the return path mem_free.  Since the return value ret
> is defaulted to 0, there is no need to re-assign ret to the 0 before
> the goto.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

b5316db229d5 ath11k: fix memory leak on reg_info

-- 
https://patchwork.kernel.org/patch/11289073/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
