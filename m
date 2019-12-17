Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD2BC2D0C8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1177E207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 07:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="gMWbLiCU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfLQH6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 02:58:45 -0500
Received: from se15e.web-hosting.com ([198.54.122.209]:55033 "EHLO
        se15e.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfLQH6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 02:58:44 -0500
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se15.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1ih7kO-000174-Op; Mon, 16 Dec 2019 23:58:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Message-Id:Date:Subject:Cc:To:From:Sender:
        Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=pf6lwI0OtmTw6cMfHbrk+qj1Co4LlkApAh8zixkmj40=; b=gMWbLiCUrgpFV2mLT55GYt+kQt
        W+3mjSNGqA3ZwchmQTxXLw4zT9tayMndh+SCTzwuWHa2aR1WImhBcI76VpNnT+YB6KmK+Ec9ipFZl
        5TMseLhoWbSrxD/kIg55vAY6eHm3voNmj5IzLdKcBMaLa2eJiAUlB80AutuBfZkMh55+KAziq3aZS
        iUlEjGQFyngbUyT8PmPcNQtXDs+40sijdeFPOjx8u4cgcuPepsbeiXLoRiJqeg2ZU4bo0n4tVLV1T
        W++z5bXu3bv2/Zejaj+fENCUQIZ5/i7dscZwuNe2RonNVoRbGyo0OeP3kEjC+qfnU9G8CbSYAShUz
        ZIjZ8O3w==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:44656 helo=akash-vm.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <akash@openedev.com>)
        id 1ih7k8-003CWq-7t; Tue, 17 Dec 2019 02:58:20 -0500
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     jagan@openedev.com, tom@radxa.com, kever.yang@rock-chips.com,
        Akash Gajjar <akash@openedev.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 0/2] add usb2-phy support for RK3308 SoC
Date:   Tue, 17 Dec 2019 13:27:13 +0530
Message-Id: <20191217075722.11646-1-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0c2Pj46HODYmpAMVAv0J1pOpSDasLI4SayDByyq9LIhVGTtulVTIveB2
 2GkZx2Xv70TNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3Kk502M/hntTzIKfCMISdhHQGg
 t7nAtP8WjkKKy9v/mXRkty7kshl0qfjNTiHz6D+lTs1OFZCJnqICuBP35KwNAmisedSHrV8USIJy
 ZKu4Q0eBPJf4fBJswECxJoMRbkC3SF2DuTVJlHUR2BtY80W8dG60QfvEMzMeJ6Rw9B2oZpcFefeT
 nKVTea+Z7pU/97kaMRINxtYvoDPmxBEirO18GFgbEtxGbfWvsckv3Tqu01KJGGjsNnBvKhksFPgp
 Ju7VRAUaZyvXYsGqun+gsnRrw40vpN++k/mRssszRiW/L+aVL5CXNSk/AzmiJysF8dLHRyryw85/
 rAZb27+VZ3biGtaW8qQvbDNe5IP3ZP124DrwHHYNWMFQ3rxmq0HUMfG+c6Hob6r/eV86ndcww4rw
 I7v+rPO4bNDPm0iPpRI8tT6nvHgTJm4rUod0ueKDsCR8lJjuWToZaiaFIvhnz77Y+k6uhs/Q2KE1
 Lby4XA9T8Bmj3saNZ0eUp3kqVmG1d7Vk0NCCILyLLaQ9eQTOszvxQTkjHv8L1XCo8f/lClCdnQEw
 egH725V8o9NmtwsOgq00IT3zX/Zzh6cpDYUl6c6Y0/5r1yWIc3jXLVN/s8cHerYtW55yLfDen/wr
 oS11FXNac8XwfSk5a6wPi3PS+6vBhpISIqK1GdyQE0WyMBODOy30v1Op0AWqhD2stjbU32pojN4X
 8zAZfIZ8CjT9GInTMPN38Uyq3PQ8yDScr+8662B3D4UT/bdQYZMqtJwVgGaPV8GdcLPofFI165s+
 Fi8oQNCwxvxuh+xtfMocbqMn/Qow8uvbAccZ4WWjZTIX9MhLKTjECb0PwpN4olPuA0AI93gbcx8Z
 jKXXCSz+ofgapDj5Myrxgk8zlzkZR8hg4/tjCwvQy21RlJtzRtySOaj2KF+AYvFFhaUnET8cMwHU
 FSFp/ySXGPBwab3MRSsiX4HiRnxfIvD0xWRSasqqxNnWfwc3A8r6JfNzxEm+Adh5Il9bsJFhaqar
 dOLrAnCsmfJ3HSl/Lt1pDXWpU9yav05pkh6OyKSeNsS3Px6flMhiWi1AgZXOLlKfgzwl5b96WfO9
 Z3+qi/5h4DZCfPGWm7MoPBOavov9A2tPRpxsJ/Ez2OT1H/aAwarQpYDOYx/6JtUOkfNK1xk8kTd1
 Ny+HuiOkN2mAdCO+RVfxIo7mcAZ9GMPEl9B+0hmmdOnbSMz7Y9ZIgfFrL3927nPLXidUYhzTL/6b
 zJY8ZLbVls9GTjTyP2j0DLjHCOlbYrvqvTn3lmAWHSgj8REt1LPAYpi/k8cuog==
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb2-phy support in RK3308 SoC dtsi
Add usb2-phy support for RK3308 SoC in Rockchip USB driver

- Tested USB2.0 with these patches on RockPiS board and Mainline Linux kernel

Akash Gajjar (2):
  arch: arm64: rockchip: add usb node for RK3308
  phy: phy-rockchip-inno-usb2: add usb2-phy support for RK3308 SoC

 .../bindings/phy/phy-rockchip-inno-usb2.txt   |  1 +
 arch/arm64/boot/dts/rockchip/rk3308.dtsi      | 49 +++++++++++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 44 +++++++++++++++++
 3 files changed, 94 insertions(+)

-- 
2.17.1

