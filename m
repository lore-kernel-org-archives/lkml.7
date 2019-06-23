Return-Path: <SRS0=VFBv=UW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F5FCC43613
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0806020663
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Jun 2019 14:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfFWOO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Jun 2019 10:14:59 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:51102 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfFWOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jun 2019 10:14:58 -0400
Received: from fsav305.sakura.ne.jp (fsav305.sakura.ne.jp [153.120.85.136])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x5NEEuE2037688;
        Sun, 23 Jun 2019 23:14:56 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav305.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp);
 Sun, 23 Jun 2019 23:14:55 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav305.sakura.ne.jp)
Received: from [192.168.1.2] (118.153.231.153.ap.dti.ne.jp [153.231.153.118])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x5NEEtSo037679
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Sun, 23 Jun 2019 23:14:55 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>, Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: stmmac regression on ASUS TinkerBoard
Message-ID: <8fa9ce79-6aa2-d44d-e24d-09cc1b2b70a3@katsuster.net>
Date:   Sun, 23 Jun 2019 23:14:55 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello stmmac maintainers,

I found this commit and that has some regressions:
   74371272f97f net: stmmac: Convert to phylink and remove phylib logic


My environment is:
   - ASUS TinkerBoard
   - SoC is RK3288
   - Using STMMAC driver
     drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
   - Using this device-tree
     arch/arm/boot/dts/rk3288.dtsi ('gmac: ethernet@ff290000' node)

Current linux-next on my environment, 'ifconfig eth0 up' does not work
correctly with following message...

-----
root@linaro-alip:~# ifconfig eth0 up
[  105.028916] rk_gmac-dwmac ff290000.ethernet eth0: stmmac_open: Cannot 
attach to PHY (error: -19)
SIOCSIFFLAGS: No such device
-----

I checked drivers/net/ethernet/stmicro/stmmac/stmmac_main.c and found
stmmac_init_phy() is going to fail if ethernet device node does not
have following property:
   - phy-handle
   - phy
   - phy-device

This commit broke the device-trees such as TinkerBoard. The mdio
subnode creating a mdio bus is changed to required or still optional?


Best Regards,
Katsuhiro Suzuki
