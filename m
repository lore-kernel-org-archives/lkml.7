Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB97CA9EB0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042C92190F
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RH0xrYrV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ke7dZUqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbfKCSzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 13:55:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:58869 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKCSzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 13:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1572807316; x=1604343316;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RzA+PurWZlAL959Q0Fc8ISMLr2TFsmZsdWcAa6rvGqo=;
  b=RH0xrYrVbiw187JSHGEc7F3cKdvbfRVRp/u40CEl4myBe2uEnn1MdoGt
   Ng3bP1IGrPRj1f1JE/+/uFpid/Mj6Hn3j2hEAJ3yhJAJJ8GGB690hHOWH
   dkQAi/IiXbbZirPBp4VpdOWLL5l4mj+FfaIOpBcQpUBbrADdNMQSae0yD
   CoUTWPSCC138QrSKd+FsuhbR24V3Ua+dVVzZ/4vkf65DC2ETL8/+8FJGY
   9ql641MxYnsJjQ60xx/R0Kae2UT83MFBdRRzVomaDb9GPNKDWg4tTiXn9
   55WszPzCwe81WaSNqeQzTawr3RJRBlKEFFFWRAyeQDQlrFpY7e085VXqE
   A==;
IronPort-SDR: ISFXh6M9sd0sugAB594TitF5eVgs7M6AdJ+IJ6NFNd5ZIq/GG3u6Ezfp7FDLCp10+qwhojv7wb
 7avJQAY8hkttbd2R/UZID/lyZ72dqyKdP/3mZdwsJMZ57xN6bTLEb+RNIN9scdJ/Kw1rdpx0xw
 O0Z8HlX0uaZCNj8+n2RE9RErsTtp1p2RHgKgZstknVhuBFtZNMT5RyPgGG3SHDT2439R0P+cqL
 pieoLrp7L/id6y/YUUpdBJrIo+15bG0X3RXlF6jru4EJL9cDZIMwaKIU1tkynfOEE81beFN3WP
 N0o=
X-IronPort-AV: E=Sophos;i="5.68,264,1569254400"; 
   d="scan'208";a="122013056"
Received: from mail-co1nam03lp2057.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.57])
  by ob1.hgst.iphmx.com with ESMTP; 04 Nov 2019 02:55:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In72s1xsOU2O3vv1iBD9ySPCUjznqtZmr13R2YcgZrBQiXubmHXZkcH7Lr1cFMFCLCW7EPmlRGd7+aLlffL0K4a8B8aF72SWZFwbu8C9SdGTVM7zh+BjE0aolXyjWeBflb/Pwyv0eGOE3R7IlwPmjJxfO5ioq7EfSHtaBQ/KQwej092x8uk252M2204bdstg4o3o3ig9tlP1d1S7Nqj+I17yMKNeI4DnpI1EURxxKUMiihl8Whgle11aIfyqJPWVCaQ2bSlXmHZeTip8simV/BGql2zCFhqUU616uVNCFrrKBSvazXXDLFVwB8C4A9wkD2pVwM8ksn/IS0989eSfXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7NLUppQ4MERkczk5lhlhBf7kQmzcbUTSqEYsnrPWlc=;
 b=IINMuzuiT6tJjCVcz0E3ye65/XshaVSNPF1GpnVwbNWTUeaebXZ25rNBTKdu7V7pNuFo5KiecIHzG5dDv6RDmksol18ZWCjybA+llxZxzbMQOrIJ9dObvBAVf2MqSh08Hca25cnWYllh3TbGmA4Sppe5igejLR/ac6mUsc9kV9LdW1kkmnKtksul8ku4cmt4vtr4aVRm/rJJyLJoI8Odxpcf6Ng99T8LE+XQZTHqIXZbHQQb/qqft8qNGJ5V3TDPUku8pCLcg3ors7M/PkIwr4XqqWSRbGasMBy77TD86ey22IDHdZMZIoPIasnMe7uM+DfTmcypLqY+adfl6g3A6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7NLUppQ4MERkczk5lhlhBf7kQmzcbUTSqEYsnrPWlc=;
 b=Ke7dZUqRAYPhx+7nSbLN+uV6GnvUdAh5Wf/bbW1JT9HBSlwZoSTjc4m6B/gqM/6k63OJ5jF1h0aa9nc1yJJP79fEGCVbz0JW6eND/kToJTemXsX8DKxRyS272EZrhC+X/3H/J4uNzLyLQHAZvOIM6hCD4n2x54za9yKj2sh8Ixk=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.57.21) by
 BYAPR04MB4678.namprd04.prod.outlook.com (52.135.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.23; Sun, 3 Nov 2019 18:55:14 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::6066:cd5d:206:5e04%6]) with mapi id 15.20.2408.024; Sun, 3 Nov 2019
 18:55:14 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [RFC] nvmet: Always remove processed AER elements from list
Thread-Topic: [RFC] nvmet: Always remove processed AER elements from list
Thread-Index: AQHVjzYhgmqnvQGm+02Suay/wXEq1Q==
Date:   Sun, 3 Nov 2019 18:55:14 +0000
Message-ID: <BYAPR04MB574907EE2666D6DA48DE30AD867C0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20191030152418.23753-1-dwagner@suse.de>
 <20191031145127.GC6024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 95cb049a-9583-48d2-1954-08d7608f5ca4
x-ms-traffictypediagnostic: BYAPR04MB4678:
x-microsoft-antispam-prvs: <BYAPR04MB4678FBABC0AF3692A92A67F9867C0@BYAPR04MB4678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0210479ED8
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(52536014)(4326008)(53546011)(7696005)(14444005)(55016002)(2906002)(9686003)(86362001)(6436002)(71190400001)(71200400001)(25786009)(76116006)(229853002)(6246003)(54906003)(66066001)(256004)(476003)(110136005)(478600001)(305945005)(66556008)(74316002)(8936002)(6506007)(66946007)(26005)(486006)(316002)(64756008)(81166006)(99286004)(7736002)(6116002)(76176011)(446003)(102836004)(3846002)(8676002)(81156014)(14454004)(5660300002)(66476007)(66446008)(186003)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4678;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h1Jy1c42RhZ5ir4V4p1PEeKKQXTji/ssWViHg8WT2t7BEj+NETZCblBvSkea+fBoQUE5Cg7WgdCY6ZvmmQsGo6t1Z1ITxLZDexiAJc/qa544mwAGDMnZCwOEpf22OUbsryMEv2IYk8UGL/VKizOGfVjO5aI3HuqMZAQq9naSI6pAcvRP3kwj5NGzhfGguUqLb62/WjdBV1zN+hZEukseswkVBViO72tHB3VKUL2Vznk+COmfV8gXfZAltIqiywOci9vOC7Q77VzKZUFYZbVmUVcsDPfv22dQyRBB1dvJV2cukSMs7w10sdPNyzqsdKH/iHm0dW086AkV1hRdgoLjCL/l/HeF2/YyrxcMjVbZqRFfLzTj5Z+/BLLdmwUPMADmxITCxBMDvpxX2aNCnWavBq1gyblEpy63hx/dHeCng6EoexpDC+gplibSIGDFxnPW
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95cb049a-9583-48d2-1954-08d7608f5ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2019 18:55:14.4933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: azcSfx1I/x7MwA5d11OHaxLHT0UCSQH0jXsyFQO5jTqSuxK0EJQFGRwTjK0gcyU5Umog3kn39fVM59eGUtu/jdCK8+0J/X6aOWwvIqfUbYQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4678
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/2019 07:51 AM, Christoph Hellwig wrote:=0A=
> On Wed, Oct 30, 2019 at 04:24:18PM +0100, Daniel Wagner wrote:=0A=
>> All async events are enqueued via nvmet_add_async_event() which=0A=
>> updates the ctrl->async_event_cmds[] array and additionally an struct=0A=
>> nvmet_async_event is added to the ctrl->async_events list.=0A=
>>=0A=
>> Under normal operations the nvmet_async_event_work() updates again the=
=0A=
>> ctrl->async_event_cmds and removes the corresponding struct=0A=
>> nvmet_async_event from the list again. Though nvmet_sq_destroy() could=
=0A=
>> be called which calles nvmet_async_events_free() which only updates=0A=
>> the ctrl->async_event_cmds[] array.=0A=
>>=0A=
>> Add a new function nvmet_async_events_process() which processes the=0A=
>> async events and updates both array and the list. With this we avoid=0A=
>> having two places where the array and list are modified.=0A=
>=0A=
> I don't think this patch is correct.  We can have AEN commands pending=0A=
> that aren't used - that is the host sent the command, but the target=0A=
> did not have even event yet.  That means the command sits in=0A=
> async_event_cmds, but there is no entry in >async_events for it yet.=0A=
>=0A=
> That being said I think what we want is to do the loop in your new=0A=
> nvmet_async_events_free first, but after that still call the loop in=0A=
> the existing nvmet_async_events_free after that.  That ensures we first=
=0A=
> flush out everything in ->async_events, and then also return any=0A=
> potential remaining entry.=0A=
>=0A=
Something like following on the top of this patch ?=0A=
(compile tested only).=0A=
=0A=
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c=0A=
index b1b9dc58c3b4..36a859082846 100644=0A=
--- a/drivers/nvme/target/core.c=0A=
+++ b/drivers/nvme/target/core.c=0A=
@@ -153,6 +153,18 @@ static void nvmet_async_events_process(struct =0A=
nvmet_ctrl *ctrl, u16 status)=0A=
                 mutex_unlock(&ctrl->lock);=0A=
                 nvmet_req_complete(req, status);=0A=
         }=0A=
+=0A=
+       while (1) {=0A=
+               mutex_lock(&ctrl->lock);=0A=
+               if (!ctrl->nr_async_event_cmds) {=0A=
+                       mutex_unlock(&ctrl->lock);=0A=
+                       return;=0A=
+               }=0A=
+=0A=
+               req =3D ctrl->async_event_cmds[--ctrl->nr_async_event_cmds]=
;=0A=
+               mutex_unlock(&ctrl->lock);=0A=
+               nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);=0A=
+       }=0A=
  }=0A=
=0A=
  static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)=0A=
