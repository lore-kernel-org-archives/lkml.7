Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763EACA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B0C121929
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 19:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VvAk2qBt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b6tt6kRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfKCTso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 14:48:44 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:56925 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbfKCTsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 14:48:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572810523; x=1604346523;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=///Klnc2BiVPsbNzXrrVdGb70uqSvefLG599oQ/+Z9Q=;
  b=VvAk2qBt6ejvtRB+ppmOi8Ut+zlrj1l+5BiuHhw5/UJVDh+Jtdux1TMT
   loVXSNF+imfoK9ofeL/5fT/98b6fNMoQKbyBjR64Qo6WC1Ws911VS2qwZ
   dXX7bfwIaxXK/2Orsfe9tO2Tx/isv3aovEee7Ojc7pEYWHgwFG4cIkR+t
   m+MjAxBhQuF46EbCRSfKIF0JVHaAtwEnD5kvGomP7IrNkodPfwBdmTx8C
   IJzTpBWUH73hYFcaqms+qR47/SRrzDTAjYC1ckRH/I9CbppigZ3nOga1Y
   vAIlIkpb3OBmiSyf3GPN5hMrgmAUs3ao7HapUMstes+zC3s0BoicC08tE
   g==;
IronPort-SDR: t8YDDqCfCozufXFcy8PN+/KhdvuFGDTPRjsOi2ZJi/Ygt371d79R1vWiE9im2dNGurC1Z04zog
 2JZp3pk+L9EPnWeDDpSclrfFHBgxBQFTKwtCiUfCQUpNzIROS35X+Du5YwYJ/++Hnti1D8G/T3
 KuGIkfIeNmWZNfu9vrXfptcACzOze3xsxawJUwvQV9T2hkkZKmRX3R259zlRXnTrbKcYqY6Ab2
 hHk8xVYskxrvboSJ/ebKN5pCREs2Prn5D0dfOwVhAL38JR5jenn1tFaf9giLu7R4YqnwwqKtIC
 Iz8=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; 
   d="scan'208";a="123594950"
Received: from mail-co1nam05lp2058.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.58])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 03:48:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NHBaCh1Dl8IxWI9gCJanSVD96Mbqh90GWmaspZ6vl6gJhefjcNpnfne+fmV2/VRred6PDDuQGnX685l+un4R4dMjAJnTHPUQ3wC8bObpX+dwkqJDMSCf2seRrUR0Hz0q54B+Nj//vtInt69nf3UY6MOZCXZCh4G5PPaMd7YJdmeKqv5F6/Ksd/bU3Pq9FxkRPFzb4gPIxn+yDoCUxtj/gdNISpzSoW7xOM6eSTghYwkODD/sEUKdoDLyMz0GXZJFafGoDuwqEDi0ulRb4FgUfxM26GMsMl8Gta1flcTIWvLQDpD3S17VqLuPJc0aXEkRxbfonPUoaAcx5d3OCC+Qvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TSknZqJQltkzsMM6mL68iCHMjxbt6vbWLoOm3c7m48=;
 b=cViLyC9t56d9nAqofUaBdI8xpxg5Kacs0RL6T+XVdmA1NM9+TZ12GMVXDzB1AuKiPydeYcoqr+9N9eb/Fyug1hxUPDKz3ZiGc/FCPDl3wLgXXMnm3KE6Oeubok7BRIjV0cdq7KTHFAG3nCwS4sL5dTe4FpeTl3pmt9QfQuls7UNwgpAv2VU2oYW/zeJH6THDMP+3yW2Q3+3AEusEICdrym0/Dd8Cm4j6Z8KyG0M9nXNOqI34C2riUSV7qJSZ+ez9DDONR7WvR6Y3k30IKpydU5MdZKOUBNBoaQbJ0FnDoZWSbZM6c8VCCqLchv6DxflRuDdm+01rpUFSSbgbDqdBWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9TSknZqJQltkzsMM6mL68iCHMjxbt6vbWLoOm3c7m48=;
 b=b6tt6kRRkBpovgyLBJvZex851diGFaVUHPUOp5IwlAntxrf4oSS8N9Et4F56q+ZmdpHHWAcier9nOdJCIsulKlCkfBnaolTqE8VpuYu3c3Ha/tcj1I2dUZPctV6lCmNgI+4yYGO47PV3NfEaPe1rWCGB1qy1TlaGnRHigwDB28o=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB5895.namprd04.prod.outlook.com (20.179.60.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Sun, 3 Nov 2019 19:48:35 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 19:48:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Thread-Topic: [RFC] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVjzYhgmqnvQGm+02Suay/wXEq1Q==
Date:   Sun, 3 Nov 2019 19:48:28 +0000
Message-ID: <BYAPR04MB5749D02B62E8F4BB12F8DB9A867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <20191031145127.GC6024@lst.de>
 <BYAPR04MB574907EE2666D6DA48DE30AD867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 408a4ff8-6cfa-432d-c258-08d76096cc90
x-ms-traffictypediagnostic: BYAPR04MB5895:
x-microsoft-antispam-prvs: <BYAPR04MB58956A589D3A39252D03E506867C0@BYAPR04MB5895.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(199004)(189003)(316002)(8676002)(478600001)(66476007)(7696005)(14454004)(66556008)(64756008)(76176011)(66446008)(76116006)(102836004)(110136005)(52536014)(99286004)(2906002)(25786009)(54906003)(4326008)(5660300002)(81156014)(81166006)(6506007)(53546011)(8936002)(26005)(71200400001)(86362001)(71190400001)(6246003)(3846002)(66946007)(446003)(6116002)(9686003)(256004)(14444005)(476003)(229853002)(6436002)(33656002)(486006)(7736002)(186003)(305945005)(66066001)(55016002)(74316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5895;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nhFf+F9FxFGi7pFVdnGqPQSRsUApY6ZyjuS7YScAF8VTaMHqECYRuwnv70SlxHxKd0lfbu+mNs75WppixwK4bC/B1kWjBnD60zWZRUqSJms8etCpXP35zLa7KQcGRBdJcQqtdTd2E//AiYdtg3y1G2m1Gw5QUV32ZNTOJWgyuIlKtlz3YAoQnbHDY8nZiB7ohsE+Jrymka3ko26DjXcvOsZUQjeP7UXHVUT6U8Ajg5NgNbnGLya9XrcyRtaTtfn9Kcgol9nmUUlfFbQpkyTtOfHqZumL0BH7TgWK5jCFzzZCggSVwvoijvZ49VZVoB5UB3HCRpwsHAvhUQGFtLDxwpctLeKvT3O2zzEkLrGTuiSk5csBFsl5iKTk4SNXAc+X6wFuMKeZq1BCA70BUuwOWbIC/mLYhivh9pl2C/i3/WKO2+sUVhPRUll32UE7cZ/A
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408a4ff8-6cfa-432d-c258-08d76096cc90
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 19:48:28.6885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d3Ug8UxDB87oegG8mLOyq0EK8EqImD7/M5/AgqDwW9VwokwDQOFigOb+FzSPEUh18hzab0HHGvaCtTNx7vis+N/Xr0VjPRr4aNFkW005xP0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5895
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It will not work as it will consume outstanding command=0A=
posted by host for which aen is not generated yet, and=0A=
when aen is generated it will not have command in the=0A=
async_event_cmds[].=0A=
=0A=
On 11/03/2019 10:55 AM, Chaitanya Kulkarni wrote:=0A=
> Something like following on the top of this patch ?=0A=
> (compile tested only).=0A=
>=0A=
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
> index b1b9dc58c3b4..36a859082846 100644=0A=
> --- a/drivers/nvme/target/core.c=0A=
> +++ b/drivers/nvme/target/core.c=0A=
> @@ -153,6 +153,18 @@ static void nvmet_async_events_process(struct=0A=
> nvmet_ctrl *ctrl, u16 status)=0A=
>                   mutex_unlock(&ctrl->lock);=0A=
>                   nvmet_req_complete(req, status);=0A=
>           }=0A=
> +=0A=
> +       while (1) {=0A=
> +               mutex_lock(&ctrl->lock);=0A=
> +               if (!ctrl->nr_async_event_cmds) {=0A=
> +                       mutex_unlock(&ctrl->lock);=0A=
> +                       return;=0A=
> +               }=0A=
> +=0A=
> +               req =3D ctrl->async_event_cmds[--ctrl->nr_async_event_cmd=
s];=0A=
> +               mutex_unlock(&ctrl->lock);=0A=
> +               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);=
=0A=
> +       }=0A=
>    }=0A=
>=0A=
>    static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)=0A=
>=0A=
=0A=
