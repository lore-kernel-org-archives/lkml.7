Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EB4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863DF21019
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 17:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m0FweG2/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbfEUROS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 13:14:18 -0400
Received: from mail-eopbgr80078.outbound.protection.outlook.com ([40.107.8.78]:5305
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726900AbfEUROR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 13:14:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ml2apWTWPBi5XppK8Yua76O7UxUx4kNPg3sh8ctsvz4=;
 b=m0FweG2/OCK9SA+6aBBi8CVxP82vYA0aCN8YblKlOH77PyIZWXPe/9X9ljy1pINp/k8PSCT4ixQx8xnQXLmcV7nIRicoHWf4a3LBGcQ3x1W1QoND4OQejdW8A/PXsZUOo7XcPsPGCo7JFDWjzpWxWkeEgpQzlKP+ARoEGdIDCXU=
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com (52.134.3.153) by
 VI1PR0402MB3551.eurprd04.prod.outlook.com (52.134.4.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1900.17; Tue, 21 May 2019 17:14:12 +0000
Received: from VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::a450:3c13:d7af:7451]) by VI1PR0402MB3485.eurprd04.prod.outlook.com
 ([fe80::a450:3c13:d7af:7451%3]) with mapi id 15.20.1900.020; Tue, 21 May 2019
 17:14:12 +0000
From:   Horia Geanta <horia.geanta@nxp.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Device obligation to write into a DMA_FROM_DEVICE streaming DMA
 mapping
Thread-Topic: Device obligation to write into a DMA_FROM_DEVICE streaming DMA
 mapping
Thread-Index: AQHVD/ibza+0VQqKf0WUTNByTE5q8A==
Date:   Tue, 21 May 2019 17:14:12 +0000
Message-ID: <VI1PR0402MB348537CB86926B3E6D1DBE0A98070@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=horia.geanta@nxp.com; 
x-originating-ip: [94.69.234.123]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9379d1f-bfa2-4148-7e8d-08d6de0fbeab
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR0402MB3551;
x-ms-traffictypediagnostic: VI1PR0402MB3551:
x-microsoft-antispam-prvs: <VI1PR0402MB35514D6ACEC00786D1016C5998070@VI1PR0402MB3551.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0044C17179
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(189003)(66476007)(316002)(2906002)(66066001)(7696005)(6506007)(99286004)(25786009)(54906003)(110136005)(5660300002)(9686003)(6436002)(66556008)(71190400001)(68736007)(74316002)(478600001)(71200400001)(14454004)(55016002)(33656002)(86362001)(476003)(44832011)(486006)(53936002)(3846002)(305945005)(7736002)(6116002)(186003)(26005)(76116006)(52536014)(4326008)(8676002)(66946007)(64756008)(66446008)(73956011)(8936002)(102836004)(256004)(81156014)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3551;H:VI1PR0402MB3485.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ygCfBJQYw+2HqpNA2oBTBsoA2uArrSn4Ed/Pow0u6q/EtXvUR0SfQ4mMgU8aJQATkyqMo4+nu10uS9MqTsU+1Leo+3GU8dssY5ad5IPBFPPt1QoA9uD2YvU/YQurADhvEHXZZdxCi7AUl92oBlNQ9iwsaDLvu2CdZVI6ytkR1LWwSXYdKkHuqf3IRFDHR7pe2oOMMQI4W2cO9Iy3Llh4PzU4InOaOe0G9H9JXceiE8/PpZTTSxVgP9UsUGyZLy3HapQrpoi6VCPoy3l4XwPEuCIEaNqEbyHQRsGMVnoEGgr69/E7JcotZQEX+Srv6GFh5cIys6dUdeIbwyorQ9vSO1PDTdAhnPZd997VC01pn5kuK/mwwxRRJjSpdqy/eO+NfOXI5kikJZ+o/4NEso4r6oPdurt5k4KZlQX1TRPVPo8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9379d1f-bfa2-4148-7e8d-08d6de0fbeab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2019 17:14:12.3190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,=0A=
=0A=
Is it mandatory for a device to write data in an area DMA mapped DMA_FROM_D=
EVICE?=0A=
Can't the device just "ignore" that mapping - i.e. not write anything - and=
=0A=
driver should expect original data to be found in that location (since it w=
as=0A=
not touched / written to by the device)?=0A=
[Let's leave cache coherency aside, and consider "original data" to be in R=
AM.]=0A=
=0A=
I am asking this since I am seeing what seems to be an inconsistent behavio=
r /=0A=
semantics between cases when swiotlb bouncing is used and when it's not.=0A=
=0A=
Specifically, the context is:=0A=
1. driver prepares a scatterlist with several entries and performs a=0A=
dma_map_sg() with direction FROM_DEVICE=0A=
2. device decides there's no need to write into the buffer pointed by first=
=0A=
scatterlist entry and skips it (writing into subsequent buffers)=0A=
3. driver is notified the device finished processing and dma unmaps the sca=
tterlist=0A=
=0A=
When swiotlb bounce is used, the buffer pointed to by first scatterlist ent=
ry is=0A=
corrupted. That's because swiotlb implementation expects the device to writ=
e=0A=
something into that buffer, however the device logic is "whatever was previ=
ously=0A=
in that buffer should be used" (2. above).=0A=
=0A=
For FROM_DEVICE direction:=0A=
-swiotlb_tbl_map_single() does not copy data from original location to swio=
tlb=0A=
	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&=0A=
	    (dir =3D=3D DMA_TO_DEVICE || dir =3D=3D DMA_BIDIRECTIONAL))=0A=
		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_TO_DEVICE);=0A=
-swiotlb_tbl_unmap_single() copies data from swiotlb to original location=
=0A=
	if (orig_addr !=3D INVALID_PHYS_ADDR &&=0A=
	    !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&=0A=
	    ((dir =3D=3D DMA_FROM_DEVICE) || (dir =3D=3D DMA_BIDIRECTIONAL)))=0A=
		swiotlb_bounce(orig_addr, tlb_addr, size, DMA_FROM_DEVICE);=0A=
and when device did not write anything (as in current situation), it overwr=
ites=0A=
original data with zeros=0A=
=0A=
In case swiotlb bounce is not used and device does not write into the=0A=
FROM_DEVICE streaming DMA maping, the original data is available.=0A=
=0A=
Could you please clarify whether:=0A=
-I am missing something obvious OR=0A=
-the DMA API documentation should be updated - to mandate for device writes=
 into=0A=
FROM_DEVICE mappings) OR=0A=
-the swiotlb implementation should be updated - to copy data from original=
=0A=
location irrespective of DMA mapping direction?=0A=
=0A=
Thanks,=0A=
Horia=0A=
