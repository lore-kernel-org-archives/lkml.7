Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86309C2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 520C52071E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="HP9m2s6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbfL3Ug4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:36:56 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:60828 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727667AbfL3Ugz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 15:36:55 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47mq3S30qFz7N;
        Mon, 30 Dec 2019 21:36:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1577738212; bh=99TqEPrMZ5pkcNiavyKENCBAYULutWOYRq+K2R3BkDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HP9m2s6t5HtwMgqxwN3J7/TDzMYETXRnzQ5iyTP3mbyNmpAMQFp16tZkepK4QiLoP
         oTn7NNmuZh2N2NUiSuntCgACPqE/dVqDzqTwxwB/cemuXbGDb5HMxo6aCj4kqH/khO
         GFuTt6IHLM8VlLhRmKkwk2And0G1JPkqymFggFsF5mSkeJnzb9TL/R/M7H9uQQ9BLu
         gaTvgoAwuYMRHp92ia5yLqjue43QDU3GaMxbK5KGrTNzUCVOsgyyQTpd8YGr74Mktj
         BHR7fcbG5kpLpxZ4iVdiNVJBwM1Vmg4e1+25gziuq7XKOAe4pyyub99T9KLoOd9Qbb
         LPWqb8o+bBCwQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Mon, 30 Dec 2019 21:36:48 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <Peter.Chen@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Felipe Balbi <balbi@kernel.org>, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/16] usb: phy: tegra: Keep CPU interrupts enabled
Message-ID: <20191230203648.GA24135@qmqm.qmqm.pl>
References: <20191228203358.23490-1-digetx@gmail.com>
 <20191228203358.23490-14-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191228203358.23490-14-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 28, 2019 at 11:33:55PM +0300, Dmitry Osipenko wrote:
> There is no good reason for disabling of CPU interrupts in order to
> protect the utmip_pad_count modification.

Since there are sleeping functions called outside of the locked sections,
this should be a mutex instead. OTOH if the spin_lock is to protect register
write against IRQ handler, then the patch is wrong.

[...]
> -	spin_unlock_irqrestore(&utmip_pad_lock, flags);
> +	spin_unlock(&utmip_pad_lock);
>  
>  	clk_disable_unprepare(phy->pad_clk);

Best Regards,
Micha³ Miros³aw
