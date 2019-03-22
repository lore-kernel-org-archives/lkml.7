Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A9C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0C2820657
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 17:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ssg9jzJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbfCVR1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 13:27:15 -0400
Received: from mail-eopbgr690110.outbound.protection.outlook.com ([40.107.69.110]:22500
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727741AbfCVR1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 13:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hhqcsQB0rrX0DcG8RkkzffGiQY7ware5mtAA6pSQD8=;
 b=Ssg9jzJRu0Tv8VPUnxFWsIAI/iwCjJabee2Xks6cTAdW+FuIU52aaisqTimaY9OPJTItGB8KTpAWsJB5l49IRX8xfmj46taO3y5OJEuBZ0W0jNDxCUZ2O8nZ/2Sv2WbUOKu/Ayja8Du585eKD5E0GxAn5UAl8biw2R5BRxJoOKo=
Received: from DM5PR21MB0747.namprd21.prod.outlook.com (10.173.172.13) by
 DM5PR21MB0153.namprd21.prod.outlook.com (10.173.173.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.5; Fri, 22 Mar 2019 17:27:12 +0000
Received: from DM5PR21MB0747.namprd21.prod.outlook.com
 ([fe80::3d1e:56c2:2b7:cf91]) by DM5PR21MB0747.namprd21.prod.outlook.com
 ([fe80::3d1e:56c2:2b7:cf91%8]) with mapi id 15.20.1750.002; Fri, 22 Mar 2019
 17:27:12 +0000
From:   Prakhar Srivastava <prsriva@microsoft.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Subject: Adding cmldine args measure to ima
Thread-Topic: Adding cmldine args measure to ima
Thread-Index: AdTg1Hsi+/BTuAz2T8ua6RTRa1/xhA==
Date:   Fri, 22 Mar 2019 17:27:12 +0000
Message-ID: <DM5PR21MB0747326E1CAA3F66CE61B149BC430@DM5PR21MB0747.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=prsriva@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-03-22T17:27:10.5308305Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0ccbfdb5-9bbd-4015-9640-694c5667768e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
x-originating-ip: [2001:4898:80e8:7:6cee:5fa7:15d6:4d76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf1fa35-45a7-4bf7-c2c6-08d6aeeb9ecd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0153;
x-ms-traffictypediagnostic: DM5PR21MB0153:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=prsriva@microsoft.com; 
x-microsoft-antispam-prvs: <DM5PR21MB01535077A4AEF11E1FDFA65CBC430@DM5PR21MB0153.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(136003)(376002)(366004)(199004)(189003)(6436002)(10090500001)(71200400001)(2906002)(8676002)(305945005)(55016002)(74316002)(4744005)(102836004)(86362001)(106356001)(316002)(110136005)(8990500004)(486006)(186003)(81166006)(14454004)(476003)(71190400001)(81156014)(22452003)(5660300002)(9686003)(450100002)(2501003)(99286004)(52536014)(86612001)(105586002)(14444005)(97736004)(53936002)(25786009)(46003)(478600001)(68736007)(33656002)(6506007)(256004)(6116002)(7736002)(7696005)(10290500003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0153;H:DM5PR21MB0747.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yJsMhKZ6dopBuuxUzzU2i22w/g4y8WjJYLDsLkBgzUkd9JmfDsTYaThDAr/6A+6CC7UUKltp41CZ/c7dQSI9i74raUI+cfGKh6pcwBm1FcsUMycy1aS+iA4PfaJA3ERCMe+7W3tylB6FppOX19QNkX3OGpryB6/POlhvgwHg7u9djpxBKbiNnyQ7cy1urZZc2YWsH9Tggxbcd0oJkJEYPasInzzluFu3cJgH+7LoD6kU3/hvwlE1XT4FIvihi6XFpAIsDfGfOHpT3eesQH4BMHbUo9IQ9qN5p558DdKno6xQ5QPnOhG/qa6MCZ5zy3wjiR5RsALzR1bOkPqynZGM8DU5fXqlHFE175Yg/e3Mi72Q/ixkWg7q9GHh89QgG73uTf/IwdueG/oPQ6Xeedjq6SEosN2t0gsS0qeX73Dh4v8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf1fa35-45a7-4bf7-c2c6-08d6aeeb9ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 17:27:12.3225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0153
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Currently Kexec (kexec_file_load) code path does not measure the cmdline=20
arguments passed to the next kernel.The boot_aggregate won't change since=20
the EFI loader hasn't been triggered. Attesting the same in K2 has no impac=
t.
Adding the cmdline measurement will add some attestable criteria.

To account for the cmdline passed, we are looking at using IMA to measure a=
nd=20
pass the buffer so that it can be attested.

Do you have any alternate solutions/concerns with this approach?

Thanks,
Prakhar Srivastava
