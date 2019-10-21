Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8DFCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C54D720873
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 15:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="XPj+XOjk";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Vp2Fj/rx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729364AbfJUPwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 11:52:23 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47892 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727403AbfJUPwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:52:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id x9LFm1RQ017021;
        Mon, 21 Oct 2019 08:51:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=uTdQQbaXJGWl8bjueKDx/70G1inUU71xdDfkSPjSp5Y=;
 b=XPj+XOjkwktMukmQl9acRlKT+igkLPPFJQeI4JmMUH7rois7PjIpbAGDo350K0qFFYdE
 ClkArf+N3PAs2rlOzRTBmtIvI6jAODHMipQLTikrvd6pl5npgSaR8f8vmm3Q9i25eks1
 gQFZvUltDmHNVKTfcUOLqq1p3A0VQqsGFJQ= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2vqx5nqj6b-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 21 Oct 2019 08:51:24 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 21 Oct 2019 08:51:24 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 21 Oct 2019 08:51:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd3uJKWNn7mL5ciT62BvDM1MI5dFhM7Lfn6/U86WHDTYjPk1XUunrEsuSKuhJr5I70Y28RQgSV/wqlxY3wp8qRJdJ5CnKmX1B+EWsVylZboRF0OVXsAJm6jTiKWmdaECHw6uSV7ADMcrJPsOQ9BtEtSFXOjWdgnE4QNs7tuOZCX57yCuSRp7rJi/RVr7GeHmgtF+8kcXr7EuD1qnkLBLiLXXyBRMVoTxaVDO1tWN5QOJCxot580zLP2WbzejBn1P/XpqQD/d2fvW68CmygheVkyf5OeZRoDeQpCaUtydL1XNuWs7h94vq8Kk7gTIBQyq4YFg9qaW4EolnnrWWhrxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTdQQbaXJGWl8bjueKDx/70G1inUU71xdDfkSPjSp5Y=;
 b=ffClsvHn8h4cnSuNgnf6GUz8JHfNShV3vAPiRufqWRgPWwoIUhEvmCXeFkwx3MxZHAnTOdeS0AD4JxO4xpYIFxGtAqqD8dYN0Nkk4yZXCIw2hgS3+d9a1g3BoWyHPYBd7FH0/i72M9lgQk4GkpiSlZaMPSU56yKDvOtwxYI2kWTyWeZB+8v8tyPUZRZ1CT0F5CWfOTM5W5SObBYSQM8pqt5wqeT9LblCELcVHe/sbiQCottcUWHSOVlt1MB70msor2XEHTqUchbI6RzGhc4sumUJLPtU4N0VIurPIx/C7OJHMLhmqMUksET/iTh047gjFcwRhYpq0aLx0uMR2wXI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uTdQQbaXJGWl8bjueKDx/70G1inUU71xdDfkSPjSp5Y=;
 b=Vp2Fj/rxCsirrmfYyVEOv3umymwM9++jGD7TCCLgNxAo+Ydvp0yZfDydg2K9avfk8AVcdku0FaMA4SbJYX5i8RsBYhROvShJoeEghLQ8uDgN4fT1E2i/pUaQiCsKskRehmV1CbL+NpjnbkyQkRqwBLugv4pn6aapeNv2pyMl/0g=
Received: from MWHPR15MB1165.namprd15.prod.outlook.com (10.175.3.22) by
 MWHPR15MB1583.namprd15.prod.outlook.com (10.173.235.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.20; Mon, 21 Oct 2019 15:51:23 +0000
Received: from MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5]) by MWHPR15MB1165.namprd15.prod.outlook.com
 ([fe80::fdc8:5546:bace:15f5%5]) with mapi id 15.20.2367.022; Mon, 21 Oct 2019
 15:51:23 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Prateek Sood <prsood@codeaurora.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kaushalk@codeaurora.org" <kaushalk@codeaurora.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] trace: fix race in perf_trace_buf initialization
Thread-Topic: [PATCH] trace: fix race in perf_trace_buf initialization
Thread-Index: AQHVhfjE7dIEhO7k+kaJeehh7fcyAKdkiAKAgAC4ygCAAAIIAA==
Date:   Mon, 21 Oct 2019 15:51:22 +0000
Message-ID: <B428485E-ADF9-4931-A35E-D2F5C4DC15B9@fb.com>
References: <1571120245-4186-1-git-send-email-prsood@codeaurora.org>
 <20191018171216.3e446f1e@gandalf.local.home>
 <59d02ee4-5329-5cfd-1fc2-790d99fe4b0d@codeaurora.org>
 <20191021114406.15b6ee88@gandalf.local.home>
In-Reply-To: <20191021114406.15b6ee88@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3594.4.19)
x-originating-ip: [2620:10d:c090:180::cf63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 240ef7cd-10f0-471b-262e-08d7563e85e8
x-ms-traffictypediagnostic: MWHPR15MB1583:
x-microsoft-antispam-prvs: <MWHPR15MB1583BC1057C5714634230E62B3690@MWHPR15MB1583.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 0197AFBD92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(136003)(39860400002)(376002)(199004)(189003)(476003)(36756003)(86362001)(6436002)(102836004)(486006)(8936002)(446003)(6246003)(46003)(66446008)(64756008)(14454004)(4744005)(186003)(229853002)(54906003)(76176011)(66946007)(66476007)(99286004)(6512007)(6116002)(8676002)(6486002)(66556008)(50226002)(7736002)(2906002)(305945005)(316002)(76116006)(478600001)(33656002)(71200400001)(71190400001)(6506007)(256004)(5660300002)(81156014)(2616005)(25786009)(53546011)(4326008)(81166006)(11346002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1583;H:MWHPR15MB1165.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6boAMDmwB8tQ9fgDWYuwzP8UH3FZ9ebuf7WS1u1+HMC6Fn1TqO/A91O1dsLYAlGUqzdm4vFVxMv3UEDxyIwf3WOGbZMWFh/SKiXlYKveCr5BeycLQ7mD6ZRmeGkGdr7ce4eKkHviydTD+H+uTC45ZHR1RJZi+iGVW/B7zXyEaS5Le+JTbsnuVY0KS3ztUvoLycnDSXC/d6Q5yHsI/w5LU2pjN2+9Ipvg1l8x3q9u15EOfFqn0ZvVsNijNLbOfMhA5b0MMtcJgebbfCMQ76ZhdlXnY5HXdS7DcOpEoCpH1951EmapEhlfLXP8x4fn7sBe9prwK+mlISQnd7ZcXe00GJILSOW9RlzHfXeYz2JhrZSqmaUpx3yLvVS92V0TlpuSWZWN1Dx8dI/AdGlpwR+4eiuuKmm5xhtDm8c1ZC9DA4QS/HntzlhOR4IMIieAWW2P
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <151FCFDA27C8DF49852F685C28532EFE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 240ef7cd-10f0-471b-262e-08d7563e85e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2019 15:51:22.8710
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Scq7c+eONZMwXmSNjnDop2HfTpLJI99CJXQZ67IyZIAIA/kj3BU0HkR89S6wpqu/LylRsvCsEw5JOCKwv8s2vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1583
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-21_04:2019-10-21,2019-10-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 phishscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxlogscore=914
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910210149
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 21, 2019, at 8:44 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Mon, 21 Oct 2019 10:12:43 +0530
> Prateek Sood <prsood@codeaurora.org> wrote:
>=20
>> Hi Song,
>>=20
>> Could you please help in this query.
>=20
> I have it ready to go to Linus. I'll wait a few hours, and if I don't
> hear anything I'll send it out.
>=20

Sorry for the late response.=20

The fix looks good to me.=20

Acked-by: Song Liu <songliubraving@fb.com>=20


