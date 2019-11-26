Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D20C2C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A72D92071A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 14:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnOG2CPr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728206AbfKZOzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 09:55:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42306 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfKZOzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 09:55:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id a15so22812152wrf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 06:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gAgCpOkG0CJjj2IFAJR4DNaPYnOca7utLu7qbIQQs80=;
        b=lnOG2CPrDsBR3s1As/va8KQnttWwJwEztlWw+DWSnGR9ylPtiIjHY0epAyKvohy03K
         KIqoR3yv2USeXlUfdgdJFCd5vLk6I/M1xbgu0BvtdSDKSX6gQ3NlXLNlL2E9xwcHZz1s
         +whYQQxseK5cSMRB8EHWnA1DVskgYuujPmelVtzmc85JO11hdyZzYjI/m5GKt2sXJLlW
         nEcVqIOaJwEsj7eDwP9BOLzt2lu0jlM5XryENo2k4JR8siCZQA34tmCYOCCqmGWey/cw
         U/xFJEInHoNYXOlBehkHaDgFfIweXNFnubeE5AOV0YlLRRUr1TEbJ4D/dYvR/PbhqXvl
         duSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gAgCpOkG0CJjj2IFAJR4DNaPYnOca7utLu7qbIQQs80=;
        b=mosjh2cU6jQ0ZCFEjMWS1qKh2U0s84KB0hm21w5+YzoQmblnWTra30H5WuC0sj66UM
         iIpwnkdayv6i7iNM1+4XuoZ1LpQYX43QzgcuqqF8AK8KdDsoFBRD+RrGL2frwCQPFh+r
         XZSbQRaY8U9cdzKalebMOeUBNe/PR5fjmSQG2WmXWuNWTC/NT67HAEo2U/tts98kOdvD
         mCrhkhVa7WuEdB4sSEe5gZQSbXv1igQE5/8H5B9c5TVvg8l7MXlerEI6ovlg8rUOrtCL
         TVHUabhW9vtBqCxfnOkyhMuC30ecnOKJVkNHuaxvaxAyH9ADIzernKXREDpne9mUUJGN
         IT4A==
X-Gm-Message-State: APjAAAXd1JSMG3IwTnVk8c32ZXsrgnFgUjjB6KGkf3D1LyK6i73Xo5Eb
        7rK1Net+Mgz1ILiTNBrU9rQ=
X-Google-Smtp-Source: APXvYqyf0ou5DnVsUssYXL+snAKsOsfoIMefMqPoDOLg1WEgrM/FwYfatiAjbx4JWRqshoUbMq0fbQ==
X-Received: by 2002:a5d:5267:: with SMTP id l7mr32515964wrc.84.1574780141417;
        Tue, 26 Nov 2019 06:55:41 -0800 (PST)
Received: from localhost ([193.47.161.132])
        by smtp.gmail.com with ESMTPSA id e16sm3294586wme.35.2019.11.26.06.55.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Nov 2019 06:55:40 -0800 (PST)
Date:   Tue, 26 Nov 2019 15:54:50 +0100
From:   Oliver Graute <oliver.graute@gmail.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mripard@kernel.org" <mripard@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "olof@lixom.net" <olof@lixom.net>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: defconfig: Change CONFIG_AT803X_PHY from m to y
Message-ID: <20191126145450.GB5108@optiplex>
References: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572848275-30941-1-git-send-email-peng.fan@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/19, Peng Fan wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> With phy-reset-gpios are enabled for i.MX8MM-EVK board, phy
> will be reset. Without CONFIG_AT803X_PHY as y, board will stop
> booting in NFS DHCP, because phy is not ready. So mark
> CONFIG_AT803X_PHY from m to y to make board boot when using nfs rootfs.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/configs/defconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index c9a867ac32d4..cd778c9ea8a4 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -285,7 +285,7 @@ CONFIG_SNI_AVE=y
>  CONFIG_SNI_NETSEC=y
>  CONFIG_STMMAC_ETH=m
>  CONFIG_MDIO_BUS_MUX_MMIOREG=y
> -CONFIG_AT803X_PHY=m
> +CONFIG_AT803X_PHY=y
>  CONFIG_MARVELL_PHY=m
>  CONFIG_MARVELL_10G_PHY=m
>  CONFIG_MESON_GXL_PHY=m
> -- 
> 2.16.4

Hello Peng,

this patch broke my imx8qm nfs setup. With the generic phy driver my
board is booting fine. But with the AT803X_PHY=y enabled  I'am running
into the following phy issue. So on my side it looks inverse as on
yours. What is the best proposal to fix this?

[    5.550442] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[    5.573206] Sending DHCP requests ...... timed out!
[   95.339702] IP-Config: Retrying forever (NFS root)...
[   95.348873] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[   99.438443] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[   99.461206] Sending DHCP requests ...... timed out!
[  174.419639] IP-Config: Retrying forever (NFS root)...
[  174.428834] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[  178.542418] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[  178.565206] Sending DHCP requests .....
[  209.261271] random: crng init done
[  230.565202] . timed out!
[  260.577340] IP-Config: Retrying forever (NFS root)...
[  260.586497] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[  264.686438] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[  264.709206] Sending DHCP requests ...... timed out!
[  339.259701] IP-Config: Retrying forever (NFS root)...
[  339.268835] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[  343.374422] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[  343.405206] Sending DHCP requests ...... timed out!
[  433.171676] IP-Config: Retrying forever (NFS root)...
[  433.180842] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[  437.294439] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off
[  437.317206] Sending DHCP requests ...... timed out!
[  509.003660] IP-Config: Retrying forever (NFS root)...
[  509.012836] Atheros 8035 ethernet 5b040000.ethernet-1:06: attached PHY driver [Atheros 8035 ethernet] (mii_bus:phy_addr=5b040000.ethernet-1:06, irq=POLL)
[  513.102416] fec 5b040000.ethernet eth0: Link is Up - 1Gbps/Full - flow control off

Best Regards,

Oliver
