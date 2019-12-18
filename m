Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDF4C2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52571218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 19:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OLHAAPl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfLRTGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 14:06:37 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:37146 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727205AbfLRTGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 14:06:37 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1576695996; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7NiU3hLTXWzHEhyJIYMdxnxbeihs4foH5jdP5okwMbc=;
 b=OLHAAPl/44UmaVmRx73ZhRjWxgAKO9R0W6OsjuJpmgSEBCGfmuYcgCM94JZY9ldCu9pe1X7n
 XESHGAQ9mLZAGgL7Mv+XKv8o2JT9eg8dI2CJj4XdGj4x4Jri9wV8Wo64jOQHwv0V8aoMYv0N
 4psJriTW6mOYdoZzV1ymlslXbVA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfa78b7.7f46ea6e81f0-smtp-out-n03;
 Wed, 18 Dec 2019 19:06:31 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F453C433CB; Wed, 18 Dec 2019 19:06:31 +0000 (UTC)
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 12E94C43383;
        Wed, 18 Dec 2019 19:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 12E94C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/7] at76c50x-usb: fix endpoint debug message
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20191210114426.4713-3-johan@kernel.org>
References: <20191210114426.4713-3-johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
        Arend van Spriel <arend@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Jes Sorensen <Jes.Sorensen@redhat.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Siva Rebbagondla <siva8118@gmail.com>,
        Daniel Drake <dsd@gentoo.org>,
        Ulrich Kunitz <kune@deine-taler.de>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20191218190631.3F453C433CB@smtp.codeaurora.org>
Date:   Wed, 18 Dec 2019 19:06:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan@kernel.org> wrote:

> Make sure to use the current alternate setting, which may not be the
> same as the first alternate setting, also when printing the number of
> endpoints at probe.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

6 patches applied to wireless-drivers-next.git, thanks.

af615abd1596 at76c50x-usb: fix endpoint debug message
3428fbcd6e6c brcmfmac: fix interface sanity check
b73e05aa543c orinoco_usb: fix interface sanity check
39a4281c312f rtl8xxxu: fix interface sanity check
3139b180906a rsi_91x_usb: fix interface sanity check
2d68bb2687ab zd1211rw: fix storage endpoint lookup

-- 
https://patchwork.kernel.org/patch/11282005/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
