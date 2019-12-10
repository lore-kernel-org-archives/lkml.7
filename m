Return-Path: <SRS0=jko7=2A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFCC43603
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01E1A205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Dec 2019 21:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P+ftj8Zt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729786AbfLJVr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Dec 2019 16:47:57 -0500
Received: from mail-bn8nam12on2094.outbound.protection.outlook.com ([40.107.237.94]:32864
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727378AbfLJVJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:09:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c07pa3Pu5hc5TOpSC5Ad2VeR0iNkLBEB2meOZA7jMmb8rmOEdY62gG6t75W4xxzSfeWstKvl4kNQtot8cDvp1j/iodv7IUjCewqtDT3hNnem/rbt+bEsWTt1QiPeOOzP0SbddNdpYyDA5GLTI+v3X6Bjp97p6a4SM45Wn7XzeAnHZvQ/G2CWXRWZ5/bbW/ffBSv8bIvGJDFCHtpk+vwo3H9F9/6ct8XZRLEbPCONA/x70nF2dzQ98nOzGd9JGPTF1ge1ybuXKFhdfAYssQsZq8KjCOMG52C/08rFfVIti+5pD1Yg6HxpTwo19d1+O3Wz6XF7KEEStGU2AM3MKQT7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjXRkNr4pVTiZLb/Kp08Prk/koBOlTWeVZqYYYYgmWo=;
 b=gEehUZmpOz40G11rM1VQID7eHK6i9doJ6IV9Ra0doj3l6vU+YjsIgdi/3yyJM7Htfyr5QNqepsQT3CihFnv8HruXyGPHXOQMWZDVgP9SJz8rNxGIxkPvyjRzPIc2f5/MvKfVaO56qrK0b9hceRUqUlRc1A9XI+AqrT1h2qmn8Oy59OyK565eOtNEIiDKccPB7x5LOInEq45/GTaPdLXzTkVdYtTfr3KsyE5YnKdtORSnnf859vk6bQMm7dzxIZg6rT7dBi7Z3iXcOOAAwsO1/Va+0FkoLaK2dofCxR6K/9DuNnTbjdCQQn8wtqFwr7HXI+HJSo1rWv9qZ+kv0EYR3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjXRkNr4pVTiZLb/Kp08Prk/koBOlTWeVZqYYYYgmWo=;
 b=P+ftj8ZtshGe3qXNGLvXWHQOTAj2j+9V81VySAbSDD1ycmtciK6OW3EEj3WK/VFPxbncr60xHDwKcoz4a+9KPFLQq0iQM4nrK6JTs8C3SlbISNx/S/rUWgMlg5nbM0mZJMwmSNQL05ng4xnC/5W81X04CL3tSsfFHd6vzLAD7Vg=
Received: from CY4PR21MB0632.namprd21.prod.outlook.com (10.175.115.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.7; Tue, 10 Dec 2019 21:08:52 +0000
Received: from CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::283c:9f7f:6def:3c25]) by CY4PR21MB0632.namprd21.prod.outlook.com
 ([fe80::283c:9f7f:6def:3c25%12]) with mapi id 15.20.2516.018; Tue, 10 Dec
 2019 21:08:51 +0000
From:   Steve MacLean <Steve.MacLean@microsoft.com>
To:     Steve MacLean <Steve.MacLean@microsoft.com>,
        Jiri Olsa <jolsa@redhat.com>
CC:     Steve MacLean <steve.maclean@linux.microsoft.com>,
        Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Topic: [PATCH v3] perf inject --jit: Remove //anon mmap events
Thread-Index: AQHVkCoSdDKHEwaGv0G9a4q1EVvH9qd1/B4AgAnxV+CABfnPgIAApblAgC2ObtA=
Date:   Tue, 10 Dec 2019 21:08:51 +0000
Message-ID: <CY4PR21MB06325A6C1C9D9F3B5665B32CF75B0@CY4PR21MB0632.namprd21.prod.outlook.com>
References: <1572553836-32361-1-git-send-email-steve.maclean@linux.microsoft.com>
 <20191101082740.GB2172@krava>
 <CY4PR21MB063262D81AB2BE5FEE88057EF77A0@CY4PR21MB0632.namprd21.prod.outlook.com>
 <20191111113311.GA9791@krava>
 <CY4PR21MB0632B5EE447DA9B931CB114DF7740@CY4PR21MB0632.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB0632B5EE447DA9B931CB114DF7740@CY4PR21MB0632.namprd21.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=stmaclea@microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-11-11T21:35:54.8355878Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=803678eb-e808-48dd-8a22-5ef03782f866;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Steve.MacLean@microsoft.com; 
x-originating-ip: [24.163.126.65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79903d42-8b13-4aaa-c62e-08d77db52893
x-ms-traffictypediagnostic: CY4PR21MB0839:|CY4PR21MB0839:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR21MB083977AFF51A09BDC3C5FF22F75B0@CY4PR21MB0839.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 02475B2A01
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(376002)(346002)(39860400002)(199004)(189003)(81156014)(66946007)(558084003)(66476007)(8936002)(64756008)(66446008)(10290500003)(55016002)(66556008)(19618925003)(71200400001)(76116006)(8990500004)(81166006)(8676002)(4270600006)(52536014)(33656002)(5660300002)(9686003)(2906002)(110136005)(26005)(186003)(316002)(54906003)(7696005)(6506007)(86362001)(478600001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0632.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NmZESDkoAJOWzF8Ze8fgIuGE8P29dJqG3PAuBAJRJMMTf0X1q7S5hL31bOPO3uQH7xeeF4Lsm+b4gN84Xxue0HTWAmtLlnA438XdouGp7RJGg+A50nP2YOEio0mlmRj3g///m/NrQbO5uPV2TLoHCYuktFW7PFunLTh/H2idmdfO+b+6/5U/sgkMLlKbI5ksMf/DLMbuzkoEgureFNvjybih/9ynoiJjorfkSSV4kfsR9KNbiKdY43Z37RI7XHn7Z/VogFP73VmFEFacJmYFhCnqd9ey8XKi86XBi38WtCm5wip2zvlwC9o1EWdPVjXy1kXcXZT6mJcNGhYMIq9dYccP8ig2bBSCaVYd+W7/3ShCWxhlXHn/rrb3T0mz8+2faFIR+clBPeFvWOt8IQBvzo5uqPcS5Cvkoz7fhAVH5F7WFwyYq4Kbwl/c7cmaSnIr
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79903d42-8b13-4aaa-c62e-08d77db52893
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2019 21:08:51.8530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OfA7ANNU+sp/gGdruuhh8jzjI5pnSpLc/M5hMponIgHVOKXETrTp+6rhmU3EVWnMd1jGO+NbYsK693cPYneONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Anything I can do to help get this reviewed?
