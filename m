Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B058C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6011120640
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 08:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L2gsP/Wn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfJHIDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 04:03:42 -0400
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:57665
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730370AbfJHIDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 04:03:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m8L3qTxKds2d4+433dR0MEzxLwx5wIpXPjBdD6kzh37PwGhd5es0WCW3ZBETFUD7L4btLXODpPlPIZjWHRYdJPFNO5JHDUenfE2mOflg5AC8zR62FoVV5GIv7po1w3C7y6SEEozm2ttXRuNDviY/BxmfsjT8w3SHYUtmlWJZtv4BvNe6WSSWeuyyjpY2T8NmAc+Wjh6sXOHMuJmm/gBXAK5zVth79CgJg/8IOXTmm8ui7kBi+h07u3iEc3fBaCWubjMAYrJnFpHhOfisKAlLNTIDu8keL3ep8c7QEj/GbH6ttKYrFFzu2x2Bhl4eBICsalvs2a+i9S94frlE+lKq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7n2g1MexqfkdSRD4PCOr6E6x+74y0XBc8Qt8DzlQek=;
 b=Avl0+9w++gjpFCpNf6Q+dG63og46GV230xEdRkc2us1nFcqrMt2nSQRhA06pO8Lb/vrVT3HGiayWCe7Qy79sa5PJn+AZx93yjdsYwVMnblm1fXqPyx+qyPPGArRTUiiBhpwxCmXWHIXvh/g9UTHKeS9xGKuH9DNZyGstNhMalxsP7wg4ahKyuid4loiWZkn7Uw7CwxTJhvU8mZ6BD0W0josJiMGAjoMTswgPTAkOx6rkCt+0wUaAvZ6f0ZB0aIs6BJKIOQTRZcm/9N9hHgMHSBPSSctBZ9laI/rvNx9scughFX06LKHIW5jzYxc+i078JcsE2lW8Tlxd0A0+iMzSUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7n2g1MexqfkdSRD4PCOr6E6x+74y0XBc8Qt8DzlQek=;
 b=L2gsP/WndBxQ1e6o0znz1fCMUuBYas0QpYhfWqjREhmUTprrcphPPjtqNmS1AI9/bZPMwcCkhoDs5t9iVsiFWA9XomLQtj8yaL0BUG2kSUJXmKcRuF/0Riy+Hxkz/HZCmRbNIVwtLkxWS/MKu37kVEA8Em+5ILyt18r3cs+Z5YY=
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com (20.177.52.16) by
 VI1PR04MB6238.eurprd04.prod.outlook.com (20.179.24.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.16; Tue, 8 Oct 2019 08:03:39 +0000
Received: from VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0]) by VI1PR04MB5327.eurprd04.prod.outlook.com
 ([fe80::1da:26dc:6373:4ab0%3]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 08:03:39 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "felipe.balbi@linux.intel.com" <felipe.balbi@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "sureshp@cadence.com" <sureshp@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>
Subject: Re: [PATCH] usb: cdns3: Fix for incorrect DMA mask.
Thread-Topic: [PATCH] usb: cdns3: Fix for incorrect DMA mask.
Thread-Index: AQHVfQdO9c89EvRW9UmjepTra4twUadQY6MA
Date:   Tue, 8 Oct 2019 08:03:39 +0000
Message-ID: <20191008080320.GG5670@b29397-desktop>
References: <1570449803-15299-1-git-send-email-pawell@cadence.com>
In-Reply-To: <1570449803-15299-1-git-send-email-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peter.chen@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 712078f1-b291-4a07-c0c1-08d74bc60751
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: VI1PR04MB6238:
x-microsoft-antispam-prvs: <VI1PR04MB62387AEF13D5C2A01956E8BA8B9A0@VI1PR04MB6238.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(7916004)(366004)(136003)(376002)(346002)(39860400002)(396003)(199004)(189003)(14454004)(33716001)(54906003)(256004)(229853002)(6246003)(9686003)(6512007)(1076003)(71190400001)(71200400001)(25786009)(2906002)(6486002)(33656002)(66066001)(5660300002)(6436002)(478600001)(66476007)(66946007)(7416002)(64756008)(66446008)(26005)(66556008)(8936002)(76116006)(316002)(186003)(86362001)(4326008)(44832011)(7736002)(6116002)(3846002)(486006)(305945005)(446003)(11346002)(476003)(76176011)(8676002)(91956017)(102836004)(53546011)(6506007)(99286004)(81156014)(6916009)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB6238;H:VI1PR04MB5327.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5WGj9CBcFO9080TUUqYDzqg5PA7fuiaFKg1NmRdwBCGI4RN8msaE2Z1ciTenpH63Gi1y9t70732NZYNHWDHaBzVFvMf6PqWGlBGXtfuoyv178v75t/fFvuLXYshXqtjPj14L+YvRpydi79OcwAUQnA9d1YuIHw4pRfA21+SgbVO1+fmsr5LNBkjyMDjvn7yxernx8ZHLW5Q6d7X28gNa21Aw91zK6oiFuMhbQsHUSSwzmss4HXmJzWIw2q9QHIi/Rt2cDy6JUrzlEY7nKZisXNnBTxI6qTBA9lDmMC+aQAMybngzoN9TPAE+aB6S2CmsW05bz+OOwVmEYhALTw2/EsLxolLOnMNJcgox8WCdsoyLiHJl50jgiZgR6yDiu4V8erLPPAuhbGkagl3SjtPqhA1AcRvNzlaIT0x80A3MmPg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FB5FCB709675574BB0A35CB2B0425310@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 712078f1-b291-4a07-c0c1-08d74bc60751
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 08:03:39.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0s0icVPOGKKaLM2axMhwlDJ4XkC/FecnDrUZc+SRaaf0Jq+K4nPouwp2sdW6hQWpElyC9dxDUm/SHVizYTKgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6238
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-07 13:03:23, Pawel Laszczak wrote:
> This patch restores the correct DMA mask after switching back to device
> mode.
> The issue occurred because Device part of controller use 32 bits DMA and
> Host side use 64 bits DMA. During loading XHCI driver the DMA mask
> used by driver is overwritten by XHCI driver so it must be restored
> to 32 bits.
>=20
> Reported-by: Pawel Laszczak <pawell@cadence.com>
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
> ---
>  drivers/usb/cdns3/gadget.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>=20
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index 157536753b8c..2ca280f4c054 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -2663,6 +2663,13 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
>  {
>  	int ret =3D 0;
> =20
> +	/* Ensure 32-bit DMA Mask in case we switched back from Host mode */
> +	ret =3D dma_set_mask_and_coherent(cdns->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(cdns->dev, "Failed to set dma mask: %d\n", ret);
> +		return ret;
> +	}
> +
>  	cdns3_drd_switch_gadget(cdns, 1);
>  	pm_runtime_get_sync(cdns->dev);
> =20

Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
