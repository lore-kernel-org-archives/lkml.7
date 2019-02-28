Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107732133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:41:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="zKVPLi/9";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="pBDeZJ7v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732891AbfB1PlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:41:04 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:50260 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727858AbfB1PlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:41:04 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SFamYS031152;
        Thu, 28 Feb 2019 07:40:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=5Q4Ns65d9H3I6hBU+u1Jg+KDWJ0ZxSsJNqOFQHwGCdA=;
 b=zKVPLi/9Sd+y+UR5hkzBJx0xNG2DClLXHCyVaZLFbYPtBsFJFkHx/09p8sLVM0r2Y1fN
 0Kr5OKw7EJHAABmjY0YNyJFVv73B2l3rmzt9ALQaKnGMuj6lMrBxhoJQ56Zmi7D+kGjN
 z2ZCQNj3TRlCWe5kKTl4vuIRwIiuilQllsvlG4YW8aYBtxcsk//BuRXjGijSSyOyKP+y
 aMjDQXNO6Uwzc47ahgn8XoCKpDUmSms9mgJViIAEX7sG7hBt/4lerA7N2XOk8C5MwtCj
 yzrVp2X4IXTUVWgxfubE3P5N6KE9LFCq4sFAQWtFwI9C8AyXMd9KJ21UuHRWyjp2Rfou og== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qx4kmt75x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 07:40:53 -0800
Received: from SC-EXCH02.marvell.com (10.93.176.82) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Feb
 2019 07:40:52 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.59) by
 SC-EXCH02.marvell.com (10.93.176.82) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Feb 2019 07:40:52 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5Q4Ns65d9H3I6hBU+u1Jg+KDWJ0ZxSsJNqOFQHwGCdA=;
 b=pBDeZJ7vhDhWh5RnOPfwByHU/3OI8zYX9JQD85FHQkJxymcT0oxzoFmCfzJ8YVzcgJ64NwcWgkEWDYxuCX3Mf6dFUd5Cc/64aLXuZfIycdapq/pzZDXV2OBr94oNRaUclkdKQeH42WrN76n+5KvWLIywqEMsZJQ49x/f6+dLLIY=
Received: from DM5PR18MB2134.namprd18.prod.outlook.com (52.132.143.31) by
 DM5PR18MB1529.namprd18.prod.outlook.com (10.175.219.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.15; Thu, 28 Feb 2019 15:40:50 +0000
Received: from DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e]) by DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e%2]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:40:50 +0000
From:   Yan Markman <ymarkman@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        "mw@semihalf.com" <mw@semihalf.com>
Subject: RE: [EXT] [PATCH net-next 07/15] net: mvpp2: fix the computation of
 the RXQs
Thread-Topic: [EXT] [PATCH net-next 07/15] net: mvpp2: fix the computation of
 the RXQs
Thread-Index: AQHUz2kgKPwN26EEkkuIctJYcg+bCKX1UyYw
Date:   Thu, 28 Feb 2019 15:40:50 +0000
Message-ID: <DM5PR18MB21347E7CD5D39D016810C62DD6750@DM5PR18MB2134.namprd18.prod.outlook.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-8-antoine.tenart@bootlin.com>
In-Reply-To: <20190228132128.30154-8-antoine.tenart@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f1bec73-5521-4f76-3408-08d69d931de9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1529;
x-ms-traffictypediagnostic: DM5PR18MB1529:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR18MB1529;23:9XGGnGTpwQSrUoQR+WD+Ytxzta+IPfF0+21kfiqPs?=
 =?us-ascii?Q?xCA/k+GeuJum4XilT1mFmlttsMumHYNHyHi3WUXnCSfyH5on/eYMHXL9fFbn?=
 =?us-ascii?Q?89GVaMy352TLYqBzLtrkBOuS1DYt03tF3nXRiPSUhhW6xlYPzWAqngU0DrsC?=
 =?us-ascii?Q?K2tzeqdYNqZXSO225Bo41PTBUKPEmLNXY6rwYhm5z8T5MYUIEHsWq3e2mm59?=
 =?us-ascii?Q?+qp6HIX+ZL0x1BkGhUKWVOCU33GNICUB6ZsXH186Fd3w8bjNK38kd/bfhfuq?=
 =?us-ascii?Q?lujziZGe3mvSH4U9tkkamhEQ1b6OOWkFo9jHs26xWHhfICms6oMbItwrayzL?=
 =?us-ascii?Q?9gTBRhsng+3BdKxwrBkfrmDD2w6S0Z1GU8+5sfTPq3IIwO+K99vJ68qoLCVN?=
 =?us-ascii?Q?H3ERhLSi3xqX/vhHjtE8fKFb8DpaPJm/A0TQY7WsUDpF1ePMRp3nXhcC3zC7?=
 =?us-ascii?Q?sT4h7Y+QiTv7fXeBmCqesygF/GvXme8blCmNUrR6VzRGINWd8fGE4dBMcWsJ?=
 =?us-ascii?Q?cX4SlLZ27cYk3nwoWkDpY4qvvRuVuQJ3L8owSPAqps9cijOv22P2hVybKuPj?=
 =?us-ascii?Q?8aCOQkDI3W42LagL0fmbdEJDQ6ECxFxfjsBkN5yq0NaePdczTCU2UIsCwnGi?=
 =?us-ascii?Q?KNhzgOSrWHH+VDnKeDejbPO26dCISCPJPk9IwbubrZDGAI15P4gAu91tXYPK?=
 =?us-ascii?Q?wZZQvwcMDv+JbICzWerUazeYFAw0j0PsS1qVl3rkdasCrJoxs89cRE52B1it?=
 =?us-ascii?Q?4fKaqCh7e6RD/wisQZupYWno/oPYZrvffz0zq8Netd8D9Fd8ri0W6QYczpcE?=
 =?us-ascii?Q?JImsPWvQTEyGB/2r0Dsgs2VbkaDgMuc2hA5H6Ks11B65EIdWxqnthD+Unvk0?=
 =?us-ascii?Q?wt2cbJqc48dr2CCnKy4zQSjOvXti8pr3Aq6/Ek1kO345foESBjDwrJQmqI+4?=
 =?us-ascii?Q?pu01gNm/JA6lOSkHyZkk2XwThka/TBNGe79my54vTUtQeMuWi/cg1Qd7qtbQ?=
 =?us-ascii?Q?GAnJVIiWErbvCm4ejWHekBU8iPyUpRMTMwvgAb6tyJImEBx81VaT4v7KW3uW?=
 =?us-ascii?Q?yYxfc2HGoLscLbEw8CSxDnbnDSGgPTEY1SoWTnjR+zIJ9Ifa3dyg5ylyWMYG?=
 =?us-ascii?Q?T9kTRc0TXoMXkxJ/ciCZTrRP2izIUDj4NODjX0z18xcx6MKxFRIZ+7t/H2YN?=
 =?us-ascii?Q?UkscLajtM2B1zJ3pdTKazY0+IU4JOHP4VmrbTXlZO5Ex+4M6eK28/svY76Uh?=
 =?us-ascii?Q?DDJeVu+sI+vCBYujvk+2vIguok07n9e7062hykZwyBbNd3l49+rvsh8CtVSi?=
 =?us-ascii?Q?pPoXAnKwVsNG2vqItaOPFs=3D?=
x-microsoft-antispam-prvs: <DM5PR18MB1529879D6A078FE359F54674D6750@DM5PR18MB1529.namprd18.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(136003)(346002)(366004)(13464003)(189003)(199004)(478600001)(33656002)(81166006)(8676002)(6116002)(4326008)(7416002)(81156014)(25786009)(2501003)(305945005)(26005)(68736007)(74316002)(3846002)(7736002)(14454004)(99286004)(2906002)(2201001)(229853002)(9686003)(6506007)(102836004)(53546011)(8936002)(55016002)(11346002)(5660300002)(6436002)(486006)(446003)(71190400001)(97736004)(186003)(105586002)(256004)(6246003)(71200400001)(7696005)(52536013)(316002)(110136005)(66066001)(53936002)(86362001)(76176011)(476003)(106356001)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1529;H:DM5PR18MB2134.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZCSpgA1pH/sXyguW5Y+/+HFm6nuTLa/Dfd6NAiRoKwhmyJtTurPG8ksFR16+YMNlvbaboldC7Q7vKS+GGPwNwoutFfgEBl19UE6+h8vVRFt/jyHeEAX9nU3DRg2pwJnmmlAFHBBJsJe/nK+lxdQxj7M0+SrwraI/E0d0zpe2sDoyh4RyNU2xT64sRZhZJCmt3vsJdBQaO97ppzPK7qWNvL8DOASf3S4gtcsB2yB3wYcyOk7+feUxRlTk0q44Bj98ps+rxCnrPGCXtybQgjsdbhm5oWixVbxi04LvYmilPny1adJs9PVh91MkmXiWuFSCSb9DyueRd6YbYTHU9CU0eyuCSuZaTr04j1o4GFk/dgIUTER9FD64V+5/RpgG5x5kRyX2pqXdNSB/5hb6XLre8/Uw+2TZ1vPvVzg1A59Mh78=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1bec73-5521-4f76-3408-08d69d931de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:40:50.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1529
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some real and "potential" functionalities have been shrunk in September-201=
8
on transition from single-big file to the current split driver onto several=
 files.

Regarding the MVPP2_DEFAULT_RXQ
Seems the current variant is flexible, permitting easy customize the config=
uration according to customer's needs.

Regarding the Queue in probe():
Looking into old code there where no2 queue-modes but 3:
enum mv_pp2_queue_distribution_mode {
	MVPP2_QDIST_SINGLE_MODE,
	MVPP2_QDIST_MULTI_MODE,
	MVPP2_SINGLE_RESOURCE_MODE
};
The current   if(MVPP2_QDIST_MULTI_MODE)else is correct also for the MVPP2_=
SINGLE_RESOURCE_MODE,
but new/patched isn't.

Since this patch doesn't change any functionality (right now) but reduces t=
he flexibility I do not see real reason to apply it.

Regards
Yan Markman

-----Original Message-----
From: Antoine Tenart <antoine.tenart@bootlin.com>=20
Sent: Thursday, February 28, 2019 3:21 PM
To: davem@davemloft.net; linux@armlinux.org.uk
Cc: Antoine Tenart <antoine.tenart@bootlin.com>; netdev@vger.kernel.org; li=
nux-kernel@vger.kernel.org; thomas.petazzoni@bootlin.com; maxime.chevallier=
@bootlin.com; gregory.clement@bootlin.com; miquel.raynal@bootlin.com; Nadav=
 Haklai <nadavh@marvell.com>; Stefan Chulski <stefanc@marvell.com>; Yan Mar=
kman <ymarkman@marvell.com>; mw@semihalf.com
Subject: [EXT] [PATCH net-next 07/15] net: mvpp2: fix the computation of th=
e RXQs

External Email

----------------------------------------------------------------------
The patch fixes the computation of RXQs being used by the PPv2 driver, whic=
h is set depending on the PPv2 engine version and the queue mode used. Ther=
e are three cases:

- PPv2.1: 1 RXQ per CPU.
- PPV2.2 with MVPP2_QDIST_MULTI_MODE: 1 RXQ per CPU.
- PPv2.2 with MVPP2_QDIST_SINGLE_MODE: 1 RXQ is shared between the CPUs.

The PPv2 engine supports a maximum of 32 queues per port. This patch adds a=
 check so that we do not overstep this maximum.

It appeared the calculation was broken for PPv2.1 engines since f8c6ba8424b=
0, as PPv2.1 ports ended up with a single RXQ while they needed 4. This pat=
ch fixes it.

Fixes: f8c6ba8424b0 ("net: mvpp2: use only one rx queue per port per CPU")
Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  4 ++--
 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 23 ++++++++++++-------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h b/drivers/net/ether=
net/marvell/mvpp2/mvpp2.h
index 17ff330cce5f..687e011de5ef 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
@@ -549,8 +549,8 @@
 #define MVPP2_MAX_TSO_SEGS		300
 #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
=20
-/* Default number of RXQs in use */
-#define MVPP2_DEFAULT_RXQ		1
+/* Max number of RXQs per port */
+#define MVPP2_PORT_MAX_RXQ		32
=20
 /* Max number of Rx descriptors */
 #define MVPP2_MAX_RXD_MAX		1024
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 24cee6cbe309..9c6200a59910 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4062,8 +4062,8 @@ static int mvpp2_multi_queue_vectors_init(struct mvpp=
2_port *port,
 			snprintf(irqname, sizeof(irqname), "hif%d", i);
=20
 		if (queue_mode =3D=3D MVPP2_QDIST_MULTI_MODE) {
-			v->first_rxq =3D i * MVPP2_DEFAULT_RXQ;
-			v->nrxqs =3D MVPP2_DEFAULT_RXQ;
+			v->first_rxq =3D i;
+			v->nrxqs =3D 1;
 		} else if (queue_mode =3D=3D MVPP2_QDIST_SINGLE_MODE &&
 			   i =3D=3D (port->nqvecs - 1)) {
 			v->first_rxq =3D 0;
@@ -4156,8 +4156,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
 	    MVPP2_MAX_PORTS * priv->max_port_rxqs)
 		return -EINVAL;
=20
-	if (port->nrxqs % MVPP2_DEFAULT_RXQ ||
-	    port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
+	if (port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
 		return -EINVAL;
=20
 	/* Disable port */
@@ -4778,10 +4777,18 @@ static int mvpp2_port_probe(struct platform_device =
*pdev,
 	}
=20
 	ntxqs =3D MVPP2_MAX_TXQ;
-	if (priv->hw_version =3D=3D MVPP22 && queue_mode =3D=3D MVPP2_QDIST_MULTI=
_MODE)
-		nrxqs =3D MVPP2_DEFAULT_RXQ * num_possible_cpus();
-	else
-		nrxqs =3D MVPP2_DEFAULT_RXQ;
+	if (priv->hw_version =3D=3D MVPP22 && queue_mode =3D=3D MVPP2_QDIST_SINGL=
E_MODE) {
+		nrxqs =3D 1;
+	} else {
+		/* According to the PPv2.2 datasheet and our experiments on
+		 * PPv2.1, RX queues have an allocation granularity of 4 (when
+		 * more than a single one on PPv2.2).
+		 * Round up to nearest multiple of 4.
+		 */
+		nrxqs =3D (num_possible_cpus() + 3) & ~0x3;
+		if (nrxqs > MVPP2_PORT_MAX_RXQ)
+			nrxqs =3D MVPP2_PORT_MAX_RXQ;
+	}
=20
 	dev =3D alloc_etherdev_mqs(sizeof(*port), ntxqs, nrxqs);
 	if (!dev)
--
2.20.1

