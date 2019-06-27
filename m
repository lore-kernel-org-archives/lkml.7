Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEC0C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E35208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 05:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="p38og9Bk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cPWgEZ8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfF0Fie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 01:38:34 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25547 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfF0Fie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 01:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561613913; x=1593149913;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7mBiaJd1GqhBOBMPqd6Yh17FhLunw62q24I++YDIYgY=;
  b=p38og9Bkk/5kuvCdr9JzYe5EcrfJd4LzzUCCpjtWpDRmu4iwQOP5/2Mb
   KCzYTSZCWYaeZcR6IFyNE+E2T4VxC8yf2sK64/YJ7pcBcBG5c8/u0/GuV
   fKLQ4Alxvd1mwsLD+1Vxu+k31XJJ1CFKvwFJQneNfeUhPMK50GKVjA5db
   cFl98s+Upya7YVEdIfhafXd2AVjM/r9SBfdBQDCNSMtEg1mH4aOHvu5aX
   ysI/j6VIQa06Xp1T+IvnLhDlZ+nJyzpRcKv08V3GZL7h9Ak62tvxi7Not
   hf+SATFX91SSWfM3JwlBsGwMcHEPedSe/kBg4iSJgghyktO4I2NpFQTPO
   A==;
X-IronPort-AV: E=Sophos;i="5.63,422,1557158400"; 
   d="scan'208";a="112865592"
Received: from mail-co1nam05lp2055.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2019 13:38:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=testarcselector01; d=microsoft.com; cv=none;
 b=KNFeTKexhzBLnIhDd08aOlUgK4xih1mQNP7zv0Cz0kH4Pnq6c7IRncgLheN52rUFh7OfjoQ0fg6jn0VYmK+zKsUXiYz2qDm9Y1CfbLLz36IzNiK9QPySiTKGBoSwX8/IDfyqcQClamEcAvX6cLIB0KCyOeJ1Po6rdkNypV2xIYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=testarcselector01;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x54BzwFn+oH2twBi2f+IhD3o7uQesJvsG8nwGk7+Wo=;
 b=lQTNIj3ySZJYKcdah10GxtjOyW0f2wXwLXCMwFbsoACMiCF7b1+nFfDylfgE3v6HyLgbIs+2SG2JJYXXMgDUj0Puu/soyCybVGbiBUPFqVLAtTwAQrSBeuleXEZCDJIxQSUinrGpTwmQfoYgErxpjrt63FEnxk3cBcnpRqtbeKY=
ARC-Authentication-Results: i=1; test.office365.com
 1;spf=none;dmarc=none;dkim=none;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5x54BzwFn+oH2twBi2f+IhD3o7uQesJvsG8nwGk7+Wo=;
 b=cPWgEZ8vb1MpuOrsNuF/78zCWP13gyDp8860hmDRHe3hwEUjSS3aHwSx73JT0kjLR+M6Rij7yhgA+BWUcYXC5duYWK49DAt6C6Ds4Tec6+FMyfym8pO5Ns8wsQaGvDDW5UZtTkWwaoe06tCag+yChqkBA2mjVNpUgWu9Nl6/XQQ=
Received: from SN6PR04MB4925.namprd04.prod.outlook.com (52.135.114.82) by
 SN6PR04MB4080.namprd04.prod.outlook.com (52.135.82.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.17; Thu, 27 Jun 2019 05:38:31 +0000
Received: from SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a]) by SN6PR04MB4925.namprd04.prod.outlook.com
 ([fe80::c5b2:c213:37f6:819a%7]) with mapi id 15.20.2008.018; Thu, 27 Jun 2019
 05:38:31 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
CC:     Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Alex Lemberg <Alex.Lemberg@wdc.com>
Subject: Re: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Topic: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
Thread-Index: AQHVISOkIGq/TXYo40K7pkiAfhMabKavEp2t
Date:   Thu, 27 Jun 2019 05:38:30 +0000
Message-ID: <SN6PR04MB4925E2C49630065F5201A7F5FCFD0@SN6PR04MB4925.namprd04.prod.outlook.com>
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
In-Reply-To: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Avri.Altman@wdc.com; 
x-originating-ip: [2a00:a040:19b:8202:f0a1:c8f0:b793:82e3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb5ca6c-042c-4931-e68c-08d6fac1b027
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4080;
x-ms-traffictypediagnostic: SN6PR04MB4080:
x-microsoft-antispam-prvs: <SN6PR04MB408065AF4BB93B43705B1625FCFD0@SN6PR04MB4080.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 008184426E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(14444005)(54906003)(8676002)(6436002)(46003)(110136005)(2501003)(76116006)(7736002)(316002)(55016002)(73956011)(68736007)(71200400001)(71190400001)(66946007)(476003)(5660300002)(4326008)(66556008)(486006)(64756008)(66476007)(66446008)(256004)(52536014)(25786009)(6506007)(305945005)(102836004)(76176011)(99286004)(33656002)(186003)(229853002)(74316002)(91956017)(7696005)(9686003)(446003)(478600001)(2906002)(11346002)(6116002)(2201001)(14454004)(53546011)(53936002)(6246003)(86362001)(81166006)(72206003)(8936002)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4080;H:SN6PR04MB4925.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vLvMOtrKa9fQpDXJpQBpHkjEM9v5X/TDC9CjcdsDJ95CwqzhfVdYYcZ00ScDs8ay2GykSB/HWphkW9NflZlg4yCOAD23GmUWsR9BMkZ8vaITYVfa78nQ0xE3/wK849sDs8BFjMhF8fBRkcw4bn6LWLiU7eiqnVJTxln4d99oWdj9UcxRgVCL6REkqGlqmctV6jyosEo0nKdQ6/wTFI27KRDu2ZIH6oX4XOMP3/iG7yTnJ2OGB5q3jPDMuGqtg+076e4MsvWta77CrvTsanBajy1H5jTu4fg4FLZ3a47KtX/BSk4HMHR/wWyBOYrsFUfTi4lZrl44Iq68wFYh6kRaXEC6czfLstvRMEfNPSjTMmP8UMImLtUYy+2xrT/EeY5gtvnC0qXrXI9pSmZ5rWm3qnoaJC8DgRXLSxy0iIwHfrw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb5ca6c-042c-4931-e68c-08d6fac1b027
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 05:38:30.9081
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Avri.Altman@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4080
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A gentle ping.

Thanks,
Avri



________________________________________
From: Avri Altman <avri.altman@wdc.com>
Sent: Wednesday, June 12, 2019 4:34:37 PM
To: James E.J. Bottomley; Martin K. Petersen; linux-scsi@vger.kernel.org; l=
inux-kernel@vger.kernel.org; Arnd Bergmann; Pedro Sousa; Alim Akhtar
Cc: Avi Shchislowski; Alex Lemberg; Avri Altman
Subject: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier

added 'WITH Linux-syscall-note' exception, which is the officially
assigned exception identifier for the kernel syscall exception.
This exception makes it possible to include GPL headers into non GPL
code, without confusing license compliance tools.

fixes: a851b2bd3632 (scsi: uapi: ufs: Make utp_upiu_req visible to user
                     space)

Signed-off-by: Avri Altman <avri.altman@wdc.com>
---
 include/uapi/scsi/scsi_bsg_ufs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/scsi/scsi_bsg_ufs.h b/include/uapi/scsi/scsi_bsg_=
ufs.h
index 17c7abd..9988db6 100644
--- a/include/uapi/scsi/scsi_bsg_ufs.h
+++ b/include/uapi/scsi/scsi_bsg_ufs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  * UFS Transport SGIO v4 BSG Message Support
  *
--
1.9.1

