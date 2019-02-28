Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8958FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A5852184A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="I8m/meDm";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="LFVyfsZ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbfB1PA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:00:58 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:41378 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726403AbfB1PA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:00:57 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SF00xE030926;
        Thu, 28 Feb 2019 07:00:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=9sH0SzOnSRyFjvxZ7Ugm0rBOsxjbK0LcEgtvmcMUmDQ=;
 b=I8m/meDm9giESBvIEYivK4trtlOELC2ah/JQ0D6fHzKoNs/yGSK6RJ8fZvYGA2pawE48
 MeE0BwMuF84viL85n6yhHxrxsDQ8vNoXaNIRPrzEqPZe+VO6vrRIBqREJc6aDJWGKTfi
 G9e0ReZBF7dn8JC2mx8hGMJfWelRrmh/JDsf0lLGSmUvoPyWt4aOmD36Qdrj7F4hqbie
 JsbsB3FbaGeWyFjKC4V5950iG1+EwCBwIaKsJ5bSk6Wotk6ldZ1XVS4oEIZY6/Godl2q
 w/CP6UsRpMFd5VdZZQv7Cpvfzdq4LJcvOSp8+Pho4kpDjduZPTvBQlfeJr7UJ+q7gf9M hA== 
Received: from sc-exch04.marvell.com ([199.233.58.184])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qx4kmt2w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 07:00:37 -0800
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Feb
 2019 07:00:36 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.55) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Feb 2019 07:00:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sH0SzOnSRyFjvxZ7Ugm0rBOsxjbK0LcEgtvmcMUmDQ=;
 b=LFVyfsZ31n7/khCwqbXIotGVCZdS6Onh/ElzfqyFx4kmum5b7b2rL/INToayMf3uJGx1ARQ9e4/7PSzccU3u2wca6A2SYA/4sAGpPbFn5R/wPqiwRW8mc5ng3x49lB6jr+8AMZQoOswVpO1wQsKpZgE9CbQiIeKm6XkLAeXGNqk=
Received: from DM5PR18MB2134.namprd18.prod.outlook.com (52.132.143.31) by
 DM5PR18MB1193.namprd18.prod.outlook.com (10.173.213.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 28 Feb 2019 15:00:35 +0000
Received: from DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e]) by DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e%2]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:00:35 +0000
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
Subject: RE: [EXT] [PATCH net-next 15/15] net: mvpp2: set the GMAC, XLG MAC,
 XPCS and MPCS in reset when a port is down
Thread-Topic: [EXT] [PATCH net-next 15/15] net: mvpp2: set the GMAC, XLG MAC,
 XPCS and MPCS in reset when a port is down
Thread-Index: AQHUz2kh4BYrBZsvtk+IxXxR5vTQu6X1THwA
Date:   Thu, 28 Feb 2019 15:00:34 +0000
Message-ID: <DM5PR18MB2134A10888F49613CC9ECCB7D6750@DM5PR18MB2134.namprd18.prod.outlook.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-16-antoine.tenart@bootlin.com>
In-Reply-To: <20190228132128.30154-16-antoine.tenart@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4462cff9-39ea-4a50-bc9e-08d69d8d7e39
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1193;
x-ms-traffictypediagnostic: DM5PR18MB1193:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;DM5PR18MB1193;23:6XR4Zk+MbAp3Zanlf5DcKWcIVFdDZEp6loI4xoHOr?=
 =?us-ascii?Q?TCq9TswckDeaYUT9c0uf8hF980MbmFV+Y7cS/ZsHotj5lc5tzhdjzkqd9nsT?=
 =?us-ascii?Q?WW5eKe1baNZ6GU66E62njxEHVNjvr8Cpx/bWxVqwobeV20fOMiwOI7XrOn2r?=
 =?us-ascii?Q?eMJXEeF5rG2Lmt7sOTKtJvB4k0r9QCqUQHI3VocYu+1E2Z1Pr6hYlAYTx60h?=
 =?us-ascii?Q?DEsjUsF3V/l8gPmlrad3aRcJ4vWFryoPqDx7J//3VY3CcE/AHbq3tNiM1u+7?=
 =?us-ascii?Q?/ziNPjj5YDPqiL6QrXRu8JNLrjnUBBRwPwSQ/tHRKhUOZU0ZhlotNOKl2NVL?=
 =?us-ascii?Q?ErqdnjK0QPSZhSgiGdTJ4Srv3uSi49l6ojcy9AAWtJfdtjHfAtZzh3hCPObO?=
 =?us-ascii?Q?+3oxNcsWe9JkC6zm2H95rhADsmUcCFRQJVL0t//HXPDzwXYxg5rY2N8TBSPf?=
 =?us-ascii?Q?uRxicxTA1BypsUj671q7yFqbuxdBA4+RYotyu+aTvlPRhO6W/mE5onoa2OPy?=
 =?us-ascii?Q?NVYCo+RUvjs3sbgwIg2PCmQ/89zWt8cSCyD5XdSqpNfNtllO32a0B9PZXR/e?=
 =?us-ascii?Q?uUdnAwuGEbtBQ46jrj8GmeBrOR9mIBwMe+jJy4XN14VBgdtgkQWwZAJb3DBH?=
 =?us-ascii?Q?MlNCSnHEoxaW0ZPRce7/BXI8gjVEJsTCWYunFWKNN6bJSQfku1AGwNIpEqRj?=
 =?us-ascii?Q?TmjXazIo1QyomLn2pnw+lJlf7dNVQxEE8Zn0wrnzrUyPB+MC/c1izjM93sq/?=
 =?us-ascii?Q?DZiMq71KkxCFdwY5vEmrxSw10EiISUH+VgApAyut9EME4TcUbolqCYorq9T6?=
 =?us-ascii?Q?rRQpMpHCTC/6xOA9Q7gEWCPd3Lh7Zgxk07KFhBh2fomWEYarcqeGZ6gQT2Lw?=
 =?us-ascii?Q?2Vs0zaZMZcfpZQxtrYnfKy/Nc54uHromVbdCaLpmTsbUlu1jdMvRi4zgDFtg?=
 =?us-ascii?Q?qvqTqhN+fMBx0lTy9KvUHLPk2SF0HXuZ6V8WE32kaAnjTJWwyaUbhhBDZI0d?=
 =?us-ascii?Q?YEMee41JIXHl76rntW5g+ZOJMc8GSZNUlinS/4pMVpbgKAfAS6mPuK6MRWL5?=
 =?us-ascii?Q?IBfccubK5YGEvTX95kD6Zwl7S8RPoPqNLoK9f1aLPYLISHlOuY9pPMIbZ6v7?=
 =?us-ascii?Q?5kIAZMYrquJ5ulki6BKvbRmdg47BYKQbAj2goXQdj+bU3JbCfZr4m9/SLOkt?=
 =?us-ascii?Q?kdm+YXa0upyVa4ZDIQn93IwjILmvDzC9lC4n9Nuj5ltySCu9VUsYfknAnlO9?=
 =?us-ascii?Q?oAdeWmCrh/NrC9xK2eJuV4Hb/eKq0EA6oscTTQ48o2OiMyEz37UaoyR0VFUv?=
 =?us-ascii?Q?6wRUmfrRMSP69U4qYfEHdI=3D?=
x-microsoft-antispam-prvs: <DM5PR18MB1193DF15E322FD8B474F4A52D6750@DM5PR18MB1193.namprd18.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(376002)(366004)(396003)(39860400002)(346002)(13464003)(199004)(189003)(26005)(68736007)(7416002)(2501003)(486006)(186003)(476003)(11346002)(446003)(53546011)(99286004)(66066001)(102836004)(76176011)(7696005)(33656002)(71200400001)(71190400001)(2906002)(478600001)(6436002)(55016002)(229853002)(105586002)(8676002)(14454004)(9686003)(2201001)(4326008)(97736004)(6506007)(106356001)(81166006)(5660300002)(86362001)(7736002)(6246003)(81156014)(8936002)(6116002)(3846002)(52536013)(53936002)(25786009)(316002)(110136005)(74316002)(256004)(54906003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1193;H:DM5PR18MB2134.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: HFo7HsMP4JYxZzWPTSLXUm+dZDhLUA4GIaWwgFtTIOZRqIRZ6Sq9eyEXb7u5yEXTm1nq/wtPC3Y22bXiHQkrM4fR2KEQx93JG4McKlweTPXkfEvf7J9zxDu/G4aiGQ7h7zHc8XmAgWQ0Foo5Lg0XaSMeWjHBV3H7IS6T6TEzVDGFm70ksoxWslBttt1br80eKjjioBKfpf6L0QpNIqN9BrmlqAVzw8FnoVgO2/rr+bXmT/FYubszigw7OeOntBb3VtmnT9prfWASxvUI/fSfZppDhUP3iVI9ud2aVlF5s+/lonDYl0hP4eNs4vdubuPUoyD8AQpBY4zwTONPCLOdaSNAVQDnui5JQE8L7H56pdK1KGYFun0KkkfzKC3xI5qR0J6HdBZspAkK1leiBN+SyentN6k+ZScCAchDlITAsZM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4462cff9-39ea-4a50-bc9e-08d69d8d7e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:00:35.1135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1193
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_07:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

The eth-down/stop may concurrent with pre-scheduled stats_work.
So it seems better to cancel stats_work first and then make resetS.

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
Subject: [EXT] [PATCH net-next 15/15] net: mvpp2: set the GMAC, XLG MAC, XP=
CS and MPCS in reset when a port is down

External Email

----------------------------------------------------------------------
This patch adds calls in the stop() helper to ensure both MACs and
both PCS blocks are set in reset when the user manually sets a port
down. This is done so that we have the exact same block reset states at
boot time and when a port is set down.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/=
ethernet/marvell/mvpp2/mvpp2_main.c
index 29d32cb3d52b..c10fd894c86f 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -3257,6 +3257,7 @@ static void mvpp2_stop_dev(struct mvpp2_port *port)
=20
 	if (port->phylink)
 		phylink_stop(port->phylink);
+
 	phy_power_off(port->comphy);
 }
=20
@@ -3520,6 +3521,9 @@ static int mvpp2_stop(struct net_device *dev)
 	mvpp2_cleanup_rxqs(port);
 	mvpp2_cleanup_txqs(port);
=20
+	mvpp2_mac_reset(port);
+	mvpp22_pcs_reset(port);
+
 	cancel_delayed_work_sync(&port->stats_work);
=20
 	return 0;
--=20
2.20.1

