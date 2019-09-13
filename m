Return-Path: <SRS0=WcLH=XI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ABFC49ED7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59E0E20678
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Sep 2019 12:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cvk.de header.i=@cvk.de header.b="K/7939ls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729701AbfIMMZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Sep 2019 08:25:16 -0400
Received: from cvk-fw2.cvk.de ([194.39.189.12]:34822 "EHLO cvk-fw2.cvk.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfIMMZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Sep 2019 08:25:16 -0400
Received: from localhost (cvk-fw2 [127.0.0.1])
        by cvk-fw2.cvk.de (Postfix) with ESMTP id 46VFG16pVxz4xrd
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:25:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cvk.de; h=
        mime-version:content-transfer-encoding:content-type:content-type
        :content-language:accept-language:message-id:date:date:subject
        :subject:from:from; s=mailcvk20190509; t=1568377513; x=
        1570191914; bh=TPwPQL5cCJ15Ks4CMna9H0KgsAQcT58ggxOhpQB391w=; b=K
        /7939lsK0dnm2Td6mpi5aGx4n1PwSG3dvlyRJaZ5DS5r8lZK5udFz8r9bb8rt+O9
        knjZc2HNIOn5d99AaJ4bv1oFwYR1SyTIoTh6k7WjXVfBUvZHesSenGPJgQi47PIC
        2PJP9ylOKWGidBG2Xysecs51uOIMY5RIYEnNnZnkdXQDcYFUe570ARg5vuCp/zeM
        o6IbHOzYJ6vomfvmatUSW/ll/NHs8Lp6/IA2BC58oMvn8mEqWv6tRXxnyOKVWIok
        c2iMgrn8+j8deVxg8f/7XhQ2x46AkVC1G4lN443ctwb0YMHosOxr7kLkfojgm2H5
        KFggrcrFGPQ/QJyDZd+og==
X-Virus-Scanned: by amavisd-new at cvk.de
Received: from cvk-fw2.cvk.de ([127.0.0.1])
        by localhost (cvk-fw2.cvk.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id pmex5ZjYrIr1 for <linux-kernel@vger.kernel.org>;
        Fri, 13 Sep 2019 14:25:13 +0200 (CEST)
Received: from cvk027.cvk.de (cvk027.cvk.de [10.1.0.22])
        by cvk-fw2.cvk.de (Postfix) with ESMTP
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:25:13 +0200 (CEST)
Received: from cvk038.intra.cvk.de (cvk038.intra.cvk.de [10.1.0.38])
        by cvk027.cvk.de (Postfix) with ESMTP id 9A36C84AE1A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2019 14:25:14 +0200 (CEST)
Received: from CVK038.intra.cvk.de ([::1]) by cvk038.intra.cvk.de ([::1]) with
 mapi id 14.03.0468.000; Fri, 13 Sep 2019 14:25:14 +0200
From:   "Bartschies, Thomas" <Thomas.Bartschies@cvk.de>
To:     "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: big ICMP requests get disrupted on IPSec tunnel activation
Thread-Topic: big ICMP requests get disrupted on IPSec tunnel activation
Thread-Index: AdVqLkX3YVEzmvmfRqSBzJS46Ii+RA==
Date:   Fri, 13 Sep 2019 12:25:14 +0000
Message-ID: <EB8510AA7A943D43916A72C9B8F4181F629D9D90@cvk038.intra.cvk.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.11.10.4]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-GBS-PROC: 5zoD1qfZ1bhzGU/FjtQuf/lTuRddoiqbj9aNu4Hj/Hw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello together,

since kenel 4.20 we're observing a strange behaviour when sending big ICMP =
packets. An example is a packet size of 3000 bytes.
The packets should be forwarded by a linux gateway (firewall) having multip=
le interfaces also acting as a vpn gateway.

Test steps:
1. Disabled all iptables rules
2. Enabled the VPN IPSec Policies.
3. Start a ping with packet size (e.g. 3000 bytes) from a client in the DMZ=
 passing the machine targeting another LAN machine 4. Ping works 5. Enable =
a VPN policy by sending pings from the gateway to a tunnel target. System t=
ries to create the tunnel 6. Ping from 3. immediately stalls. No error mess=
ages. Just stops.
7. Stop Ping from 3. Start another without packet size parameter. Stalls al=
so.

Result:
Connections from the client to other services on the LAN machine still work=
. Tracepath works. Only ICMP requests do not pass the gateway anymore. tcpd=
ump sees them on incoming interface, but not on the outgoing LAN interface.=
 IMCP requests to any other target IP address in LAN still work. Until one =
uses a bigger packet size. Then these alternative connections stall also.

Flushing the policy table has no effect. Flushing the conntrack table has n=
o effect. Setting rp_filter to loose (2) has no effect.
Flush the route cache has no effect.

Only a reboot of the gateway restores normal behavior.

Is this a bug?

Best regards,
--
i. A. Thomas Bartschies=20
IT Systeme

Cornelsen Verlagskontor GmbH
Kammerratsheide 66
33609 Bielefeld
Telefon: +49 (0)521 9719-310
Telefax: +49 (0)521 9719-93310
thomas.bartschies@cvk.de
http://www.cvk.de
