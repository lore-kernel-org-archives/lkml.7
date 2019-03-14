Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68931C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FBE21019
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 07:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=openedev.com header.i=@openedev.com header.b="R6ZrXvTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbfCNH7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 03:59:06 -0400
Received: from se14t.web-hosting.com ([162.255.118.155]:35339 "EHLO
        se14t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCNH7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 03:59:05 -0400
X-Greylist: delayed 2313 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Mar 2019 03:59:05 EDT
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se14.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <akash@openedev.com>)
        id 1h4Kf0-00019f-1z; Thu, 14 Mar 2019 00:20:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J+3nukUHldE+Mk0hZpPnpS+i785FbEu4bQBR4zvx+ps=; b=R6ZrXvTj3MEVFxR+ayywWLv1IO
        WIAIbNrlASOkwp4Z6DZbgqcsAObQO75YAQ8xaZXENrnk37Vvb2ngWwNpar3/w2OShx2GCrUVn1cVN
        QhZTakDfjNvP20sVbEzDe2AKWhEHmZmpEbKO1Vx5KPCJvvcpTGU0OeBL33bX5d2srSz7semr3SRgl
        6CS26/RVlxjSonIxPyBb26hdT520YtBKcaMwCj35p0ZF8bhlT12blVS0GoJRjvkBxYXgxg3omb0ns
        BRNrCbFqvB7uLzfrWyzou5qccM7fpLKeOr7jR2ha/9gKC78PsuFZH7Zeks3nVVckDIlvGvkjVLXB2
        IdkWdtQw==;
Received: from nat-inn.mentorg.com ([192.94.34.34]:19766 helo=agajjar-vr.inn-wifi.mentorg.com)
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <akash@openedev.com>)
        id 1h4Ket-002iQG-3m; Thu, 14 Mar 2019 03:20:08 -0400
From:   Akash Gajjar <akash@openedev.com>
To:     heiko@sntech.de
Cc:     Akash Gajjar <akash@openedev.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vicente Bergas <vicencb@gmail.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andrius=20=C5=A0tikonas?= <andrius@stikonas.eu>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] add gpu node support on rock960 and rockpi4
Date:   Thu, 14 Mar 2019 12:48:40 +0530
Message-Id: <20190314071853.32176-1-akash@openedev.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OutGoing-Spam-Status: No, score=-0.5
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.09)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5qvZCgtLBf1wBe7g3QkF0Ix602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO9Kz5dih1EthU2MWX/atyIaZdK0HkmzEk8rbnHWK2CAwKQpkZZXbqBHHS7K4iXvv6D9w
 t2xWqJRpuLe8wpAsBWCPrIKyLEzqJhCS72BIl4JOpBy80lCTHMqwkVavo/hGPVpMJt2hvioWDQLR
 +F8Qzq07Jl0cTbMjtJzGDA/hgJi5KsyTeHKuBkcJ13PXNCvSiriFGgMRx6d6FbBzxs0Z8EswRpnA
 IuFluGKjDRq2iBJyWunPl/ohRNIiwFqCBEOsmBguLxWDsPJb+k4qKIjw6Kjs5m+7wJmzKH/9Awyx
 ktoGjXMGAfCVtfbjcya7FiZ10+qSYmDhmfCGznB+LvwZMnbQQFzDBjhPYYLyyVl/DO04GZWT6Tsv
 DXKv683dSPZhX8v6RglqCRiWLLlJfXqOwsSEQ1zg63VRC9n5o9IubHRCajhI/osHQYQOY9tKQuYh
 V0/2daO84E+CJIUWxPZgHA4oVG4R1QSBae5eMu8El8wp8YJwPcY3BZj5hjW3jSN7kDZQ6OtBjX2d
 hf8r1xeX6dGaEFvYj4y8eeqFFdtAEhWvd4DaCK6Pjpd0ktFAUcyBO/hTzdUB76FJbC2aoijjK5vZ
 VLoBIQ/0Yot61dtATH/YSE8bhW7Do3k5xAFc45r9HH9q0aZI3qbhXsaDdLgW9bq7ONs0Jo7siUxp
 CnbQuxznTS5wWhJczORue9s9vxMyvT3ZEg7qDAZihU7TNifj61aWKjPv6Se6da4XjLm88/LDLnDH
 LQNX6Z9k7LHvI3S8k8yoD25LMd/8Q6GyVYHQHyyqls2q2f6GiuILRCoVzcAUesmMQdfOVPytGy0v
 aP8A+OIp7Ll3zg39paKeqrIPi/nXs2KsRjKrCowEavDwQuKonn43CVihpNXqOZnA1kmofBq13Vtd
 PYPpQDJAG8jZaE6kPx28ZCmzF6xraiN8yTq5LrsYgOOLVP0PfMA01LCiikBDOYLztKvzrLSd1VxM
 Ru4N5NrpfsZsRnl/I/FTR139Shj4g7fEqX8BGOvWI8yqhtlg1q14MI9rG0MenXlswhbk2P5lYvz2
 ervtNnQfK6kuRnPRYcAeHV8hxEmZPAz5djibSz1TZEeHqHdttKvBUzCN4NAlGxY6r4hMSxGQ+U5v
 Nu4rMPKlzWU9qMOiGXHBuQl7kvd3Y9+UVnnGTsDuvLq0N5hlE2LuZbV6X+y312KNlGoBrkyiaxWd
 ombtIRbrbHLYM3A6BXfvel8OEFDbU50ueTym1wgy3QoDz1w5VXFhebjHJPwXPZ6YHMJ8vHED6QY4
 ei+01UVhKsXWCf/f12Vc+wcBvq1ZAdP9Br8WkgqueLGXOud3vgQ6Lwxr8Zs7itcxKJJ78am5WUrT
 xjBCYAo5Ix7/C9VwqPH/5QpQnZ0BqABLpxpkKfYdpWqgBL2Mh16HX+6x4KcU/f2CYrvOMnz/q172
 TuUUAfA6uqFnxU12
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gpu node support on both rockchip-rk3399 board.
performance tested with freedesktop.org panfrost mali driver.

Akash Gajjar (2):
  arm64: dts: rockchip: add mali gpu support on rockpi4
  arm64: dts: rockchip: add mali gpu support on rock960

 arch/arm64/boot/dts/rockchip/rk3399-rock-pi-4.dts | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3399-rock960.dts   | 5 +++++
 2 files changed, 10 insertions(+)

-- 
2.17.1

