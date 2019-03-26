Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4BDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B79820856
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telekom.de header.i=@telekom.de header.b="L19fHT2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731065AbfCZIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 04:55:45 -0400
Received: from mailout41.telekom.de ([194.25.225.151]:26233 "EHLO
        mailout41.telekom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbfCZIzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 04:55:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=telekom.de; i=@telekom.de; q=dns/txt; s=dtag1;
  t=1553590543; x=1585126543;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=KdPAcJEWVhXUiqkTbqZ0SaahZuQYwJQfMkoR1Q3Gtn0=;
  b=L19fHT2WdF808dLlEgReSgoFh+iGaZg5YXYcAHlxBiNtGgf+tbqzfn0c
   juVIYwpH8aEmvZRBuNHM7acnnIwJ5bHduiIR9kAVqaDZaQiGVHcoR4ahN
   a6/Z5UiNSdKBHWPmejZS1xB++nhyU/meC7TfjDGusuS68HTx/fBwcjVHw
   vH+9ZZXZA7qjXR4YeiQyWkvi9jlbY6lvVpjmbjjAdIxpjhM1XxN/0aInX
   BmbabYjTTFzKB63FSzz7raY5FPOIc17+JXFSvTDkBLxLmOQ2d69QrBsEE
   nIigV1x7sX5ZI604N3VmrRD7UMw+tBNj3c31mwFzyWpEItfzRNqc6snId
   g==;
Received: from qdec94.de.t-internal.com ([10.171.255.41])
  by MAILOUT41.dmznet.de.t-internal.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Mar 2019 09:55:41 +0100
X-IronPort-AV: E=Sophos;i="5.60,271,1549926000"; 
   d="scan'208";a="389615111"
Received: from he105865.emea1.cds.t-internal.com ([10.169.119.42])
  by QDEC97.de.t-internal.com with ESMTP/TLS/AES256-SHA; 26 Mar 2019 09:54:42 +0100
Received: from HE105647.EMEA1.cds.t-internal.com (10.169.119.61) by
 HE105865.emea1.cds.t-internal.com (10.169.119.42) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Tue, 26 Mar 2019 09:54:42 +0100
Received: from HE104162.emea1.cds.t-internal.com (10.171.40.37) by
 HE105647.EMEA1.cds.t-internal.com (10.169.119.61) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3 via Frontend Transport; Tue, 26 Mar 2019 09:54:42 +0100
Received: from GER01-LEJ-obe.outbound.protection.outlook.de (51.5.80.24) by
 O365mail04.telekom.de (172.30.0.231) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 26 Mar 2019 09:54:40 +0100
Received: from FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE (10.158.133.21) by
 FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE (10.158.133.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.18; Tue, 26 Mar 2019 08:54:41 +0000
Received: from FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE
 ([fe80::51bb:6941:3ad1:4a7]) by FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE
 ([fe80::51bb:6941:3ad1:4a7%5]) with mapi id 15.20.1730.019; Tue, 26 Mar 2019
 08:54:41 +0000
From:   <Markus.Amend@telekom.de>
To:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dccp@vger.kernel.org>
Subject: [PATCH v2] net: dccp: Checksum verification enhancement
Thread-Topic: [PATCH v2] net: dccp: Checksum verification enhancement
Thread-Index: AdTjsTXoyB+mDItYROqT/u+sEk/4OA==
Date:   Tue, 26 Mar 2019 08:54:41 +0000
Message-ID: <FRAPR01MB117083E6F526BDCB88742713FA5F0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Markus.Amend@telekom.de; 
x-originating-ip: [212.201.104.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d79d5f4-a7dd-4c7e-42af-08d6b1c8afa1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:FRAPR01MB1170;
x-ms-traffictypediagnostic: FRAPR01MB1170:
x-microsoft-antispam-prvs: <FRAPR01MB1170DC95413CB95034A96F65FA5F0@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(486006)(74482002)(8936002)(33656002)(9686003)(55016002)(15650500001)(105586002)(7736002)(476003)(5660300002)(102836004)(97736004)(66066001)(106356001)(478600001)(3846002)(6116002)(186003)(305945005)(316002)(71200400001)(71190400001)(110136005)(26005)(7696005)(2201001)(72206003)(8676002)(450100002)(81156014)(81166006)(2906002)(53936002)(52396003)(2501003)(68736007)(75402003)(14454004)(14444005)(86362001)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:FRAPR01MB1170;H:FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: telekom.de does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: TLNkfqR92kZZwasz1nvruZ9Q8yq6Ts/HdVcC4iKxpf2ttYJWgEesi5hp37Snf14GmpIL5GpbthDYmLu3chmS1ywsyAbiXo0bPcD+2Zhlg/TUYHpKCag/fxwf0RNyaGNQED0T63UCJauKQ1ylkrwrgwdZr7aJsLv8mR8LNpsigIhY6ISbEPV/1VjkygA5BGjX5lkQ4vwTwyqtRqTlTGmPIGC2W7PxskeZWcFaSuod+O5cZ1xVVaFVhtC2fM7+yRFMwGW/USReJ3LEcypjJz4PAM+ThEA9yfDR7eHR/dRfWAzqwIuVNZYgqG880sP9x2uR4o0w4gnHHHG9zLsQR5BMW3L6qyWDInFeVjawn280eYVkhWIAu2TKh6calirKxT6lhqAnzKYOQV0sSjduhSbb8WSv7G+JDCnXg9bpW8UCFko=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d79d5f4-a7dd-4c7e-42af-08d6b1c8afa1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 08:54:41.6319
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bde4dffc-4b60-4cf6-8b04-a5eeb25f5c4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRAPR01MB1170
X-OriginatorOrg: telekom.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Modify checksum verification to allow the validation of skb->ip_summed, in =
case the checksum has already been verified in lower layers.

Signed-off-by: Nathalie Romo Moreno <natha.ro.moreno@gmail.com>
Signed-off-by: Markus Amend <markus.amend@telekom.de>
---
 net/dccp/ipv4.c | 8 +++++---
 net/dccp/ipv6.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c index 26a21d97b6b0..7e56327e=
385a 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -763,8 +763,9 @@ int dccp_invalid_packet(struct sk_buff *skb)
 	}
=20
 	/* If header checksum is incorrect, drop packet and return.
-	 * (This step is completed in the AF-dependent functions.) */
-	skb->csum =3D skb_checksum(skb, 0, cscov, 0);
+	 * (This step is completed in the AF-dependent functions.)
+	 * skb->csum =3D skb_checksum(skb, 0, cscov, 0);
+	 */
=20
 	return 0;
 }
@@ -786,7 +787,8 @@ static int dccp_v4_rcv(struct sk_buff *skb)
=20
 	iph =3D ip_hdr(skb);
 	/* Step 1: If header checksum is incorrect, drop packet and return */
-	if (dccp_v4_csum_finish(skb, iph->saddr, iph->daddr)) {
+	if (__skb_checksum_validate(skb, IPPROTO_DCCP,
+				    true, false, 0, inet_compute_pseudo)) {
 		DCCP_WARN("dropped packet with invalid checksum\n");
 		goto discard_it;
 	}
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c index d5740bad5b18..60743c42=
5ceb 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -695,8 +695,8 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 		goto discard_it;
=20
 	/* Step 1: If header checksum is incorrect, drop packet and return. */
-	if (dccp_v6_csum_finish(skb, &ipv6_hdr(skb)->saddr,
-				     &ipv6_hdr(skb)->daddr)) {
+	if (__skb_checksum_validate(skb, IPPROTO_DCCP,
+				    true, false, 0, ip6_compute_pseudo)) {
 		DCCP_WARN("dropped packet with invalid checksum\n");
 		goto discard_it;
 	}
--
2.20.1

