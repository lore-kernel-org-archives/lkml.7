Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D806C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28510214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PnNY68ax"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728136AbfHSTvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:51:49 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40652 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbfHSTvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:51:48 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so9957596wrd.7;
        Mon, 19 Aug 2019 12:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=pzCA9EjyG4XJe4nsj76MAbU+PlVIyUYzsKg1myRtXSQ=;
        b=PnNY68axxZ0tMth7YdBJnqjXuqfWxrvf1x5Jwk/nOTTU28YS/Nessvg5vuGu5amgj/
         3WAnZQ7wMkPUNwksh18seCdiqhRLe2mxnxaW3LYfqhqCHmYW+ZP7cIMvGOsEGmA2ymUN
         vmTQ0MEoLGH8WXuvxWGNGzyMjq16FaDrgfBOxHUwcdi0VwHVsDWJzkGmeOCuL2hQejwk
         27awx/xl3RvFbCCZG4tNULTy9IqhRCNWAnUO2EhMTreKvMoifZRbui4WL5GScwTHbPXk
         MlbOkaGmMjOZsL81hnqADAYO5cTmlC8JmNRu/sDbF5A40gR+rN+N0QT42Zy4FeXE1IqQ
         P5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pzCA9EjyG4XJe4nsj76MAbU+PlVIyUYzsKg1myRtXSQ=;
        b=UXna4vcIt2Ll29deyoyj8eBWD4wPC+TQWQE3MjMwXHae5wLhrBr5Ej9t2NBkkUlvtn
         DGo6xql0i4N2NVll+9AVpOkHnCQ3+7c4k5tDJqk92Y//ooCl1oCVsQ49nl4/zC7FHFiy
         0eqaHlN78qlneujRY+BPSoDU1bO5fUwlw14n8ranKd35qzXr2vRuQztnq7RFxZcx0Dtr
         2oymbWBAVo5BVInWtmixh3s+EvC8pBc6CV+zF5RCtOXNAkkjZNqAmXMBIpzQ5LdUaW0C
         GNRqt+vV4NC3xzCh0kZ2qOYNROIyzGzIDDfbvywLmFC4SaOekpmkXADybF20CGQ0yqBI
         WbPw==
X-Gm-Message-State: APjAAAViGsUIJodoaQkpC0v09YE0ckmajZpEaR9ITCk/MuHcZnR1DdqX
        v2LsgHve9lQdkjBtvbqRs7R+So/+
X-Google-Smtp-Source: APXvYqycMvO/qbJ5ikCJOdyW+xaDBp5miZLWG6Hd+/87FLdLjQHtxGGrY1I6YLv3fU8lVokQ1DnT2Q==
X-Received: by 2002:adf:ecc3:: with SMTP id s3mr30047364wro.302.1566244307026;
        Mon, 19 Aug 2019 12:51:47 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f47:db00:69f9:84c:2cc6:baef? (p200300EA8F47DB0069F9084C2CC6BAEF.dip0.t-ipconnect.de. [2003:ea:8f47:db00:69f9:84c:2cc6:baef])
        by smtp.googlemail.com with ESMTPSA id t198sm26869507wmt.39.2019.08.19.12.51.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 12:51:46 -0700 (PDT)
Subject: Re: [PATCH net-next 1/1] Add genphy_c45_config_aneg() function to
 phy-c45.c
To:     Marco Hartmann <marco.hartmann@nxp.com>,
        Christian Herber <christian.herber@nxp.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1566237157-9054-1-git-send-email-marco.hartmann@nxp.com>
 <1566237157-9054-2-git-send-email-marco.hartmann@nxp.com>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <3b16b8b6-7a9f-0376-ba73-96d23262dd6e@gmail.com>
Date:   Mon, 19 Aug 2019 21:51:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1566237157-9054-2-git-send-email-marco.hartmann@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.08.2019 19:52, Marco Hartmann wrote:
> and call it from phy_config_aneg().
> 
Here something went wrong.

> commit 34786005eca3 ("net: phy: prevent PHYs w/o Clause 22 regs from
> calling genphy_config_aneg") introduced a check that aborts
> phy_config_aneg() if the phy is a C45 phy.
> This causes phy_state_machine() to call phy_error() so that the phy
> ends up in PHY_HALTED state.
> 
> Instead of returning -EOPNOTSUPP, call genphy_c45_config_aneg()
> (analogous to the C22 case) so that the state machine can run
> correctly.
> 
> genphy_c45_config_aneg() closely resembles mv3310_config_aneg()
> in drivers/net/phy/marvell10g.c, excluding vendor specific
> configurations for 1000BaseT.
> 
> Fixes: 34786005eca3 ("net: phy: prevent PHYs w/o Clause 22 regs from
> calling genphy_config_aneg")
> 
This tag seems to be the wrong one. This change was done before
genphy_c45_driver was added. Most likely tag should be:
22b56e827093 ("net: phy: replace genphy_10g_driver with genphy_c45_driver")
And because it's a fix applying to previous kernel versions it should
be annotated "net", not "net-next".

> Signed-off-by: Marco Hartmann <marco.hartmann@nxp.com>
> ---
>  drivers/net/phy/phy-c45.c | 26 ++++++++++++++++++++++++++
>  drivers/net/phy/phy.c     |  2 +-
>  include/linux/phy.h       |  1 +
>  3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
> index b9d4145781ca..fa9062fd9122 100644
> --- a/drivers/net/phy/phy-c45.c
> +++ b/drivers/net/phy/phy-c45.c
> @@ -509,6 +509,32 @@ int genphy_c45_read_status(struct phy_device *phydev)
>  }
>  EXPORT_SYMBOL_GPL(genphy_c45_read_status);
>  
> +/**
> + * genphy_c45_config_aneg - restart auto-negotiation or forced setup
> + * @phydev: target phy_device struct
> + *
> + * Description: If auto-negotiation is enabled, we configure the
> + *   advertising, and then restart auto-negotiation.  If it is not
> + *   enabled, then we force a configuration.
> + */
> +int genphy_c45_config_aneg(struct phy_device *phydev)
> +{
> +	int ret;
> +	bool changed = false;

Reverse xmas tree please.

> [...]

Overall looks good to me. For a single patch you don't have to provide
a cover letter.
