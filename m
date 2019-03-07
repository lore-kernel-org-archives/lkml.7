Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF43C43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D2220835
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 04:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="IxcChiCa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbfCGE5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 23:57:38 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:60596 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfCGE5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 23:57:37 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 594B58364E;
        Thu,  7 Mar 2019 17:57:33 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1551934653;
        bh=aT/iyaWbpw8kgdm9cLKA0xhryNej3v5jj3UD0yvK8Zs=;
        h=From:To:Cc:Subject:Date;
        b=IxcChiCaAy8guZDHhV421h/7f2ChucSWBPNS+HF0fP8QrWMWwhHRYufIwfcH3wVBP
         yGs7KiiYOaNLzxbb9qvoQsVDGEF3D9N7tFZTz6s1t8H5nz/QQhuCcfNlZXdaPT5/kk
         EfejXJy6AiErVijX8US7vtQW3x8CQW/YQMGBYElROolOSb+08JiTJu3gvjEw30kXrE
         aR3+9eG0TX1sBIchG++/m1fV8iHhcpEYVPxzEUNhVB+t3GA/h+vnxCkgO38nexCyES
         /AYVrCN2s+ABBgUGeWF+q2Pn28gziqLmobJlsYi8nG7UGJHMPC3etrToKBv7xpgPkg
         tcn5pDv8lTEMg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5c80a4bc0000>; Thu, 07 Mar 2019 17:57:32 +1300
Received: from brodieg-dl.ws.atlnz.lc (brodieg-dl.ws.atlnz.lc [10.33.22.16])
        by smtp (Postfix) with ESMTP id 5949613EEC9;
        Thu,  7 Mar 2019 17:57:33 +1300 (NZDT)
Received: by brodieg-dl.ws.atlnz.lc (Postfix, from userid 1718)
        id 196C6500584; Thu,  7 Mar 2019 17:57:33 +1300 (NZDT)
From:   Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
To:     davem@davemloft.net, stephen@networkplumber.org,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
        luuk.paulussen@alliedtelesis.co.nz,
        Brodie Greenfield <brodie.greenfield@alliedtelesis.co.nz>
Subject: [PATCH 0/2] Make ipmr queue length configurable
Date:   Thu,  7 Mar 2019 17:57:27 +1300
Message-Id: <20190307045729.14972-1-brodie.greenfield@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to have some more space in our queue for processing incoming
multicast packets, so we can process more of them without dropping
them prematurely. It is useful to be able to increase this limit on
higher-spec platforms that can handle more items.

For the particular use case here at Allied Telesis, we have linux
running on our switches and routers, with support for the number of
multicast groups being increased. Basically, this queue length affects
the time taken to fully learn all of the multicast streams.=20

Changes in v3:
 - Corrected a v4 to v6 typo.

Changes in v2:
 - Tidy up a few unnecessary bits of code.
 - Put the sysctl inside ip multicast ifdef.
 - Included the IPv6 version.

Brodie Greenfield (2):
  ipmr: Make cache queue length configurable
  ip6mr: Make cache queue length configurable

 Documentation/networking/ip-sysctl.txt | 16 ++++++++++++++++
 include/net/netns/ipv4.h               |  1 +
 include/net/netns/ipv6.h               |  1 +
 net/ipv4/af_inet.c                     |  1 +
 net/ipv4/ipmr.c                        |  4 +++-
 net/ipv4/sysctl_net_ipv4.c             |  7 +++++++
 net/ipv6/af_inet6.c                    |  1 +
 net/ipv6/ip6mr.c                       |  4 +++-
 net/ipv6/sysctl_net_ipv6.c             |  7 +++++++
 9 files changed, 40 insertions(+), 2 deletions(-)

--=20
2.21.0

