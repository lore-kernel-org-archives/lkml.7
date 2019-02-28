Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3919FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4630218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 15:53:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Lg22hQ8Y";
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="LYLuGsht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733275AbfB1Pxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 10:53:43 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:52640 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730843AbfB1Pxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 10:53:42 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x1SFjh5e007055;
        Thu, 28 Feb 2019 07:53:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pfpt0818;
 bh=3EKGAuO/C0bUMiHM8qn8wl+u+NmPzjKImiqTXCmuRU0=;
 b=Lg22hQ8Y6UJ7iYQZwXRmmyka6UAwExb0sfRDvNgjZjf0G+rlyGrCwOQ43MiTTAwMiTGe
 ibPsZNH0ncCCbjEoxnHTOMNX3RQpPU6eiwZTsiJ9kJHkInpie5AS2ORYibw0HGLhWyy+
 0pUj+LM0GD0D6aZR7hmTUzll5viR993LOiJnJvzltDWuhg3MEbLnE8vRomPmXSsnxm+X
 CgTzjntEVnc44X5PA/KZThr9tA44gXgrQLHNDsXZmP8HsJcQWpZkSNcvSkLkWjtN4Ltm
 7WT33t+1rZysS4IYdb0vhcoTIgLndX0nYY/2uIGxR9swT6JvnzcKjsBmecoatsESTzn6 hQ== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 2qx4kmt832-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Feb 2019 07:53:33 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 28 Feb
 2019 07:53:32 -0800
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (104.47.32.55) by
 SC-EXCH04.marvell.com (10.93.176.84) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 28 Feb 2019 07:53:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3EKGAuO/C0bUMiHM8qn8wl+u+NmPzjKImiqTXCmuRU0=;
 b=LYLuGshtLsMnpNWbMq96GL8rilDKBNlKlNUclDB1drSaQKG7EUhVbpkbmN1e3ELYO9ax4JgiEPYjIt/pMbUFa9LU5Fp+rztDbIdtSp7Olx5hBkePQ3dpQ7rw5Ov4Ugnnd55d67ycrY8JwWun37wgB+moLAkraRR2Eh83I3KqDsM=
Received: from DM5PR18MB2134.namprd18.prod.outlook.com (52.132.143.31) by
 DM5PR18MB1018.namprd18.prod.outlook.com (10.168.118.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.18; Thu, 28 Feb 2019 15:53:27 +0000
Received: from DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e]) by DM5PR18MB2134.namprd18.prod.outlook.com
 ([fe80::213e:9645:39f6:ef3e%2]) with mapi id 15.20.1665.015; Thu, 28 Feb 2019
 15:53:27 +0000
From:   Yan Markman <ymarkman@marvell.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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
Thread-Index: AQHUz2kgKPwN26EEkkuIctJYcg+bCKX1UyYwgAAI04CAAACNUA==
Date:   Thu, 28 Feb 2019 15:53:27 +0000
Message-ID: <DM5PR18MB213475B02326F74B5E239A57D6750@DM5PR18MB2134.namprd18.prod.outlook.com>
References: <20190228132128.30154-1-antoine.tenart@bootlin.com>
 <20190228132128.30154-8-antoine.tenart@bootlin.com>
 <DM5PR18MB21347E7CD5D39D016810C62DD6750@DM5PR18MB2134.namprd18.prod.outlook.com>
 <20190228155059.GH4359@kwain>
In-Reply-To: <20190228155059.GH4359@kwain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [212.199.69.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 54e3cef4-97a3-485d-d048-08d69d94e105
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DM5PR18MB1018;
x-ms-traffictypediagnostic: DM5PR18MB1018:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;DM5PR18MB1018;23:XXOeJUByXmg0jquuGvWJSjB4aTTAtrXeHPdKHcS?=
 =?iso-8859-1?Q?TrMMulc3NqRTcs4KFyKazgOjGeqoj5QERkwrbSBDPpYNl8vOoHgQKh8l1i?=
 =?iso-8859-1?Q?j6YLmXrM4gaEgu+G/4qhKVsWkGhCt4loQMQekjLEMOL6f7fBJ9yuhelnfD?=
 =?iso-8859-1?Q?eQuigZ0oAYkNjgUmJjlkEFYX1Cu5QaA0W4BxwnQnObPK+18kdxHSFzft3V?=
 =?iso-8859-1?Q?WOkERh9+yu9dcNdqxLsd2L5K/Y4YY7tTPCoUsr8QZF4NdRjboYmoDufmnv?=
 =?iso-8859-1?Q?mmL9pcgsGtk7jCVl6C8Abh31wasaFAWD4fs//x94pUXeTnQWkOfDn6b7+C?=
 =?iso-8859-1?Q?05WGzY7Yt/RIllfzI73kcS9VpCVdIZzGO0vrCBlxIlPD1rhBlvPhJlKSQR?=
 =?iso-8859-1?Q?i9F23vLInnAHT4W5u/GFrNc6QAk9pNZdovirduLGru/6zy4xL2Kp3MXYIs?=
 =?iso-8859-1?Q?ndbUkS7OaH+RbYiZphWW/MkwtDVb4prGt+idyWNPAX89UbYjCT3o1117TC?=
 =?iso-8859-1?Q?4rlZY3O06XKUSG7rnj0zfCxdPBPBOXD514Icxvsrmbn5F+tO1zARYJNPMZ?=
 =?iso-8859-1?Q?sA2zRcJNm/JWmWipqq8HvB2iuQm+6Nrl0emchmN4Jm8D7nBdLYKwSwIsl3?=
 =?iso-8859-1?Q?n8dTg8rmtV+WOfAYlxD2ls2GGM11jPwrZWyFh0wwajSZMT/KUE3PFmHQ8x?=
 =?iso-8859-1?Q?/X5qGCWKp/+laXrv+WOE47i8VUZHT5GypRQKha+HP+H45SjfllrsmL9CeY?=
 =?iso-8859-1?Q?PkBZABKWD7Xl3QWx0q5lf02nvE3d5uU8zjvS+tr2Ymcn3XIepnm12bVEdb?=
 =?iso-8859-1?Q?nHZjbFqM2432DjMLuTOI8l7Cm1d3AfZBieWnJO8qDIn+WQsXRRcZFl+AhC?=
 =?iso-8859-1?Q?19nE9wTKYgDixhXpvWhcj8jNfqrHAL4QgZ09i16DqKJg7kOfifGTPOr8RW?=
 =?iso-8859-1?Q?tsjxxxApyehfQNEPSCGXr8J7/oRhmFqE3axKSI9TeTrrxFv/cnh4dzfDLq?=
 =?iso-8859-1?Q?vVIUxMnebzdJhgbympJzmvp30tj+O17G+UT8+4C+BaT5FJTdnitgRoOKVX?=
 =?iso-8859-1?Q?T5p0abpPCODKOa0jPVKyH2gDlY3SGVkvJo81je1dTi58U8YEhrho9jjSEk?=
 =?iso-8859-1?Q?X3dMM2yy3ewdzQSW+mgcovbopVALq8/n5zhUBtiZb27u4MbMRMoCfOinLf?=
 =?iso-8859-1?Q?L+NNp4sJoK3n0ivgs4DF9QaPAlhNfxz3Q6gNdl21aDF0Wbxws6P/QHG69k?=
 =?iso-8859-1?Q?Avf6lcHbFbt5ZSQ8dHVf08JtUVOVPcYoDVRpX9igztZYYGYlNY57ljKT2r?=
 =?iso-8859-1?Q?dksim1gGAMCcDK0qMa6Bu14UFNmRWg46eOr7p978NIkGW+MZodj1zPlhnS?=
 =?iso-8859-1?Q?9oN7Wg8wuzobVFrTtUeTdFxfr8GkcZkGcfFaj5PS0ctGLuwrjV0C2sHbav?=
 =?iso-8859-1?Q?j7xmb+dCyPjAzQ=3D?=
x-microsoft-antispam-prvs: <DM5PR18MB1018DE30D3F4E36D8492A66BD6750@DM5PR18MB1018.namprd18.prod.outlook.com>
x-forefront-prvs: 0962D394D2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(396003)(136003)(39860400002)(199004)(189003)(13464003)(7736002)(6506007)(66066001)(6116002)(97736004)(102836004)(3846002)(966005)(54906003)(74316002)(186003)(316002)(26005)(4326008)(53546011)(486006)(66574012)(25786009)(478600001)(6246003)(33656002)(53936002)(229853002)(14444005)(2906002)(6916009)(7416002)(14454004)(99286004)(93886005)(52536013)(305945005)(446003)(71200400001)(8676002)(81166006)(256004)(105586002)(5660300002)(476003)(55016002)(71190400001)(106356001)(11346002)(6436002)(9686003)(6306002)(81156014)(68736007)(76176011)(7696005)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR18MB1018;H:DM5PR18MB2134.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Rj6Mp7BXkaHC4tlPUgMQwaqkNFyYSgJvPMa41GocUjb/C9lq/bIa30pN7CjhM7kB5306mt6u2j+Eu5X9AYuHbuWQIMQW+v15o5dRLlQN19HsuedGlNbGmpbunlzQLxcKzaIdoxE5ei5rv9eyxTF0sPC71tU+Du9sbHQWr1StV1XAUHb3NqQBcSKgXp5R7udvDFbZGQ8iIuwVHfUdIgJaluJloqrzXsLGeJubEgRZxvXe10T6PoXvmcGXa88GAdIzOnt6AzutclP5oteceKmLvyDlcOpZyhfpslGiA4iN/YlK6gCG/I15iP0B1Y23ZUizL4k42xjiXyPutePW1AEYR/+XP09Hl3APrEobLqqktiWqf++EnHnfclazk3BlAbBE5Kwp7C1Rt1hiLpckjbNPuz9iTxUAAwcD5Bukamo8Jdo=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e3cef4-97a3-485d-d048-08d69d94e105
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2019 15:53:27.3787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR18MB1018
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-02-28_08:,,
 signatures=0
X-Proofpoint-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1902280107
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OK-OK. The " It does fix PPv2.1 support, which was broken" is great reason!

-----Original Message-----
From: Antoine Tenart <antoine.tenart@bootlin.com>=20
Sent: Thursday, February 28, 2019 5:51 PM
To: Yan Markman <ymarkman@marvell.com>
Cc: Antoine Tenart <antoine.tenart@bootlin.com>; davem@davemloft.net; linux=
@armlinux.org.uk; netdev@vger.kernel.org; linux-kernel@vger.kernel.org; tho=
mas.petazzoni@bootlin.com; maxime.chevallier@bootlin.com; gregory.clement@b=
ootlin.com; miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; S=
tefan Chulski <stefanc@marvell.com>; mw@semihalf.com
Subject: Re: [EXT] [PATCH net-next 07/15] net: mvpp2: fix the computation o=
f the RXQs

Yan,

On Thu, Feb 28, 2019 at 03:40:50PM +0000, Yan Markman wrote:
>=20
> Regarding the MVPP2_DEFAULT_RXQ
> Seems the current variant is flexible, permitting easy customize the=20
> configuration according to customer's needs.
>=20
> Regarding the Queue in probe():
> Looking into old code there where no2 queue-modes but 3:
> enum mv_pp2_queue_distribution_mode {
> 	MVPP2_QDIST_SINGLE_MODE,
> 	MVPP2_QDIST_MULTI_MODE,
> 	MVPP2_SINGLE_RESOURCE_MODE
> };
> The current   if(MVPP2_QDIST_MULTI_MODE)else is correct also for the
> MVPP2_SINGLE_RESOURCE_MODE, but new/patched isn't.

There are only 2 modes supported in the upstream kernel:
MVPP2_QDIST_SINGLE_MODE and MVPP2_QDIST_MULTI_MODE. The third one you menti=
oned is only supported in out-of-tree kernels.

Therefore patches sent to the upstream kernel do not take in into account, =
as it is not supported.

> Since this patch doesn't change any functionality (right now) but=20
> reduces the flexibility I do not see real reason to apply it.

This patch do not break the upstream support of PPv2 and does improve two t=
hing:

- It limits the total number of RXQs being allocated, to ensure the
  number of RXQs being used do not exceed the number of available RXQ
  (which would make the driver to fail).
- It does fix PPv2.1 support, which was broken.

I do think the patch will benefit the upstream PPv2 support.

Thanks,
Antoine

> The patch fixes the computation of RXQs being used by the PPv2 driver,=20
> which is set depending on the PPv2 engine version and the queue mode=20
> used. There are three cases:
>=20
> - PPv2.1: 1 RXQ per CPU.
> - PPV2.2 with MVPP2_QDIST_MULTI_MODE: 1 RXQ per CPU.
> - PPv2.2 with MVPP2_QDIST_SINGLE_MODE: 1 RXQ is shared between the CPUs.
>=20
> The PPv2 engine supports a maximum of 32 queues per port. This patch=20
> adds a check so that we do not overstep this maximum.
>=20
> It appeared the calculation was broken for PPv2.1 engines since=20
> f8c6ba8424b0, as PPv2.1 ports ended up with a single RXQ while they=20
> needed 4. This patch fixes it.
>=20
> Fixes: f8c6ba8424b0 ("net: mvpp2: use only one rx queue per port per=20
> CPU")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
> ---
>  drivers/net/ethernet/marvell/mvpp2/mvpp2.h    |  4 ++--
>  .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 23 ++++++++++++-------
>  2 files changed, 17 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h=20
> b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> index 17ff330cce5f..687e011de5ef 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2.h
> @@ -549,8 +549,8 @@
>  #define MVPP2_MAX_TSO_SEGS		300
>  #define MVPP2_MAX_SKB_DESCS		(MVPP2_MAX_TSO_SEGS * 2 + MAX_SKB_FRAGS)
> =20
> -/* Default number of RXQs in use */
> -#define MVPP2_DEFAULT_RXQ		1
> +/* Max number of RXQs per port */
> +#define MVPP2_PORT_MAX_RXQ		32
> =20
>  /* Max number of Rx descriptors */
>  #define MVPP2_MAX_RXD_MAX		1024
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c=20
> b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> index 24cee6cbe309..9c6200a59910 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> @@ -4062,8 +4062,8 @@ static int mvpp2_multi_queue_vectors_init(struct mv=
pp2_port *port,
>  			snprintf(irqname, sizeof(irqname), "hif%d", i);
> =20
>  		if (queue_mode =3D=3D MVPP2_QDIST_MULTI_MODE) {
> -			v->first_rxq =3D i * MVPP2_DEFAULT_RXQ;
> -			v->nrxqs =3D MVPP2_DEFAULT_RXQ;
> +			v->first_rxq =3D i;
> +			v->nrxqs =3D 1;
>  		} else if (queue_mode =3D=3D MVPP2_QDIST_SINGLE_MODE &&
>  			   i =3D=3D (port->nqvecs - 1)) {
>  			v->first_rxq =3D 0;
> @@ -4156,8 +4156,7 @@ static int mvpp2_port_init(struct mvpp2_port *port)
>  	    MVPP2_MAX_PORTS * priv->max_port_rxqs)
>  		return -EINVAL;
> =20
> -	if (port->nrxqs % MVPP2_DEFAULT_RXQ ||
> -	    port->nrxqs > priv->max_port_rxqs || port->ntxqs > MVPP2_MAX_TXQ)
> +	if (port->nrxqs > priv->max_port_rxqs || port->ntxqs >=20
> +MVPP2_MAX_TXQ)
>  		return -EINVAL;
> =20
>  	/* Disable port */
> @@ -4778,10 +4777,18 @@ static int mvpp2_port_probe(struct platform_devic=
e *pdev,
>  	}
> =20
>  	ntxqs =3D MVPP2_MAX_TXQ;
> -	if (priv->hw_version =3D=3D MVPP22 && queue_mode =3D=3D MVPP2_QDIST_MUL=
TI_MODE)
> -		nrxqs =3D MVPP2_DEFAULT_RXQ * num_possible_cpus();
> -	else
> -		nrxqs =3D MVPP2_DEFAULT_RXQ;
> +	if (priv->hw_version =3D=3D MVPP22 && queue_mode =3D=3D MVPP2_QDIST_SIN=
GLE_MODE) {
> +		nrxqs =3D 1;
> +	} else {
> +		/* According to the PPv2.2 datasheet and our experiments on
> +		 * PPv2.1, RX queues have an allocation granularity of 4 (when
> +		 * more than a single one on PPv2.2).
> +		 * Round up to nearest multiple of 4.
> +		 */
> +		nrxqs =3D (num_possible_cpus() + 3) & ~0x3;
> +		if (nrxqs > MVPP2_PORT_MAX_RXQ)
> +			nrxqs =3D MVPP2_PORT_MAX_RXQ;
> +	}
> =20
>  	dev =3D alloc_etherdev_mqs(sizeof(*port), ntxqs, nrxqs);
>  	if (!dev)
> --
> 2.20.1
>=20

--
Antoine T=E9nart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
