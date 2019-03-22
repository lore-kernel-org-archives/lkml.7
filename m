Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B108C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFD272083D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telekom.de header.i=@telekom.de header.b="E+FfPmpU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfCVOoo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:44:44 -0400
Received: from mailout11.telekom.de ([194.25.225.207]:38875 "EHLO
        mailout11.telekom.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728881AbfCVOol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:44:41 -0400
X-Greylist: delayed 577 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2019 10:44:39 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=telekom.de; i=@telekom.de; q=dns/txt; s=dtag1;
  t=1553265880; x=1584801880;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=73tDh/5xmfG4wso0tiBDujxqvW3lVqtnRg8skXa68lI=;
  b=E+FfPmpUZVlBurVEMeNgFMHmKg9qVUVYAPIp7PW+LS924ODJgdLduNFy
   NUm9RuH3m2IwvKmqhPca9cRZMg6yj/oqijUUp7hQMkeHhlA/26LRkzD0U
   0J71+fVxoiixXHEtF59W+Z8u1jyuqUv3qMkdPuyvoyi8m49FbcUPypYZ4
   34E1AOMgWw9v0BqdxW0DK/iTNjw5BSxLflbwJiGx03TJS6C1Ld1e9l6jm
   tjOCoU70AtXEW/xdNyYPe+mwkGPG7IK7CUA23Hhf7RCW8e103LEl4F8qb
   E2t8N1m5lHypdkccZUSuvckXA7hHe9gIpLZIcrdT1PiTY3BO1uPKw8Tjl
   A==;
Received: from qdezc2.de.t-internal.com ([10.171.255.37])
  by MAILOUT11.dmznet.de.t-internal.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2019 15:35:00 +0100
Received: from he105667.emea1.cds.t-internal.com ([10.169.118.63])
  by qde0ps.de.t-internal.com with ESMTP/TLS/AES256-SHA; 22 Mar 2019 15:35:00 +0100
Received: from HE105850.EMEA1.cds.t-internal.com (10.169.118.24) by
 HE105667.emea1.cds.t-internal.com (10.169.118.63) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Fri, 22 Mar 2019 15:34:59 +0100
Received: from HE106564.emea1.cds.t-internal.com (10.171.40.16) by
 HE105850.EMEA1.cds.t-internal.com (10.169.118.24) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3 via Frontend Transport; Fri, 22 Mar 2019 15:34:59 +0100
Received: from GER01-LEJ-obe.outbound.protection.outlook.de (51.5.80.21) by
 O365mail01.telekom.de (172.30.0.234) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 22 Mar 2019 15:34:58 +0100
Received: from FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE (10.158.133.21) by
 FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE (10.158.133.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Fri, 22 Mar 2019 14:34:58 +0000
Received: from FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE
 ([fe80::51bb:6941:3ad1:4a7]) by FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE
 ([fe80::51bb:6941:3ad1:4a7%5]) with mapi id 15.20.1709.017; Fri, 22 Mar 2019
 14:34:58 +0000
From:   <Markus.Amend@telekom.de>
To:     <gerrit@erg.abdn.ac.uk>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <dccp@vger.kernel.org>
Subject: [PATCH] net: dccp: Checksum verification considering skb->ip_summed
Thread-Topic: [PATCH] net: dccp: Checksum verification considering
 skb->ip_summed
Thread-Index: AdTguTC7dENChGQnSD+RBpn6Db35/A==
Date:   Fri, 22 Mar 2019 14:34:58 +0000
Message-ID: <FRAPR01MB11703F861DE24373440FD1C0FA430@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Markus.Amend@telekom.de; 
x-originating-ip: [212.201.104.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8513597-824f-41ab-53f6-08d6aed38f8f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:FRAPR01MB1170;
x-ms-traffictypediagnostic: FRAPR01MB1170:
x-microsoft-antispam-prvs: <FRAPR01MB11708CC53E99DD5C7BD837E3FA430@FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(376002)(366004)(136003)(396003)(189003)(199004)(33656002)(55016002)(486006)(9686003)(6116002)(106356001)(105586002)(7696005)(6916009)(26005)(15650500001)(54906003)(2906002)(75402003)(53936002)(71190400001)(7736002)(4326008)(2351001)(71200400001)(296002)(8676002)(316002)(476003)(14444005)(2501003)(305945005)(81166006)(97736004)(3846002)(8936002)(5660300002)(52396003)(66066001)(102836004)(186003)(478600001)(74482002)(14454004)(256004)(72206003)(86362001)(68736007)(5640700003)(81156014)(1730700003);DIR:OUT;SFP:1101;SCL:1;SRVR:FRAPR01MB1170;H:FRAPR01MB1170.DEUPRD01.PROD.OUTLOOK.DE;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: telekom.de does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ejVXLHSVna6yA5Q12gcdnMf7m37nfUkoXo4tKeoSR8CMbBhWTAX4N3Awou69u5L09zUWtvn2CXWU2DK0BpwUEzcrf6yFTv9oJhhtf+YHmMxm9ozZC+7FpFHIlXRVo89BPu5ziS6pD4lMiL4BAwLDpV7rsu7AbxHi4BWRsf8Y7+wx+jmfGjlhoAt8Uq7YKpSYVH+2a3KTslvfIypwyAs0HFUBIvViboehVA6OK8ZiZRwxhyTA/lOdx+zOU5V4LbN3vVwcCcfmrORzbx/aRy26WeRgfx5wvpMLL82OF2GpVfhWnEviqPabC6aEIKsFPEvw6541pc2a1d3U/sKXeeadNfDsM80yh0P5Y42Qg3mjRMZl18yr5FIyTA60ziYQTzl8gUePXlbOB7sGkIHsuWkT3WU4d8NHMXeevpEhxnCa9cY=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d8513597-824f-41ab-53f6-08d6aed38f8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 14:34:58.8650
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
case the checksum has already been verified by another process.

Signed-off-by: Nathalie Romo Moreno <natha.ro.moreno@gmail.com>
Signed-off-by: Markus Amend <markus.amend@telekom.de>
---
 net/dccp/ipv4.c | 8 +++++---
 net/dccp/ipv6.c | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c index 26a21d97b6b0..0d777888=
efe1 100644
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
+		  true, false, 0, inet_compute_pseudo)) {
 		DCCP_WARN("dropped packet with invalid checksum\n");
 		goto discard_it;
 	}
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c index d5740bad5b18..7cb7c9f3=
e5e1 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -695,8 +695,8 @@ static int dccp_v6_rcv(struct sk_buff *skb)
 		goto discard_it;
=20
 	/* Step 1: If header checksum is incorrect, drop packet and return. */
-	if (dccp_v6_csum_finish(skb, &ipv6_hdr(skb)->saddr,
-				     &ipv6_hdr(skb)->daddr)) {
+	if (__skb_checksum_validate(skb, IPPROTO_DCCP,
+		true, false, 0, ip6_compute_pseudo)) {
 		DCCP_WARN("dropped packet with invalid checksum\n");
 		goto discard_it;
 	}
--
