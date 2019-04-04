Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1848DC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D336B217D7
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Srd5KVv9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Ihd5zwGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfDDSMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:12:31 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60404 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727398AbfDDSMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:12:31 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x34I6ACB000542;
        Thu, 4 Apr 2019 11:10:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=pCIecSyhcZ4FjbvBSaSE+zmAwJU/dsze8jxdSO2pa20=;
 b=Srd5KVv9KOtVxf2uotfB4J3DBSasZsX5NTgVEH2F++8RMn3hb5dYhoYpZSiQgX56hF2v
 O5eJ1DNJBY73uQ2+uk5lxj3hk0UpszqZ1vEzzlMF/63VNH/5Rfq8Nxw+cRv7AMLgG4KX
 kfR9wY8rae8fUjqz3Scz6Ofoe4YKbh+JN5g= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rnpjug302-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 04 Apr 2019 11:10:45 -0700
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 11:10:44 -0700
Received: from frc-hub01.TheFacebook.com (2620:10d:c021:18::171) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 4 Apr 2019 11:10:44 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 4 Apr 2019 11:10:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCIecSyhcZ4FjbvBSaSE+zmAwJU/dsze8jxdSO2pa20=;
 b=Ihd5zwGb/C1thqJd1YQN1q304AiZIfh0YCpaUowtbgRghbkce1FBAAt+IZ+5HfEiLhPEwj7RjMMmWIcC8tMYeuRUus+yklOgoCmoIMC/cVA6IN7iq2/PLIPkJ6/MG7YyQ62j8KyH6jWaDKro7/5iZglgq7VQpB7rh+/yfs4pQnU=
Received: from BYAPR15MB2311.namprd15.prod.outlook.com (52.135.197.145) by
 BYAPR15MB2822.namprd15.prod.outlook.com (20.179.158.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.16; Thu, 4 Apr 2019 18:10:42 +0000
Received: from BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::1803:10f2:3d80:c10c]) by BYAPR15MB2311.namprd15.prod.outlook.com
 ([fe80::1803:10f2:3d80:c10c%2]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 18:10:42 +0000
From:   Lawrence Brakmo <brakmo@fb.com>
To:     David Miller <davem@davemloft.net>,
        "olivier.tilmans@nokia-bell-labs.com" 
        <olivier.tilmans@nokia-bell-labs.com>
CC:     "koen.de_schepper@nokia-bell-labs.com" 
        <koen.de_schepper@nokia-bell-labs.com>,
        "research@bobbriscoe.net" <research@bobbriscoe.net>,
        "fw@strlen.de" <fw@strlen.de>,
        "borkmann@iogearbox.net" <borkmann@iogearbox.net>,
        "ycheng@google.com" <ycheng@google.com>,
        "ncardwell@google.com" <ncardwell@google.com>,
        "edumazet@google.com" <edumazet@google.com>,
        "agshew@gmail.com" <agshew@gmail.com>,
        "glenn.judd@morganstanley.com" <glenn.judd@morganstanley.com>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Topic: [PATCH net-next v2] tcp: Ensure DCTCP reacts to losses
Thread-Index: AQHU6uFJ5qKL9TJ2LUy0DTa6bmxAT6YsSKWAgAAmjIA=
Date:   Thu, 4 Apr 2019 18:10:42 +0000
Message-ID: <532BB0D8-95C8-4A4D-A73D-3B563909780F@fb.com>
References: <20190404121731.13917-1-olivier.tilmans@nokia-bell-labs.com>
 <20190404.105243.1039649838417325989.davem@davemloft.net>
In-Reply-To: <20190404.105243.1039649838417325989.davem@davemloft.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.14.0.181208
x-originating-ip: [2620:10d:c090:180::1499]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3e0302-022b-4469-110d-08d6b928d9cd
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB2822;
x-ms-traffictypediagnostic: BYAPR15MB2822:
x-microsoft-antispam-prvs: <BYAPR15MB282267D6CF88EF50924EE2A8A9500@BYAPR15MB2822.namprd15.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(68736007)(5660300002)(83716004)(36756003)(53936002)(316002)(71190400001)(71200400001)(6246003)(105586002)(58126008)(106356001)(110136005)(54906003)(6512007)(4326008)(25786009)(6486002)(2501003)(6116002)(82746002)(99286004)(2906002)(97736004)(256004)(14444005)(229853002)(6436002)(11346002)(446003)(86362001)(478600001)(7416002)(476003)(2616005)(81166006)(4744005)(186003)(81156014)(8676002)(8936002)(33656002)(46003)(305945005)(7736002)(14454004)(6506007)(102836004)(486006)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2822;H:BYAPR15MB2311.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B+X9RUlhKV2Xa+fzXS9GO9/6xpoKVxjBS2lmHpzJqJH2aMchpbI03umKrnlVoJeiU/yP5dcmhkrE1rjwE3SnbC+wXbXw+vxiiaJrlTICeWUVjQiOmIHjopR2v0OzimMF7G7R++IXNALFXWh0EjSBT/W5g75VNoCagFg9pK9mljMayCzWkdvArOESL2eSDXoPLd4DF00qtpFcQwa4U9ojW4oyX4YB/qGgCLlzbhFwu2ygRIJ9PNzloPypta2b/NmiuMcsITvAh+N+UmSQEBrc563PeZdac1TpMbd7qCJ1D8Oc5FS1GXu3JBkdrthKyrOPMEe75TW8LGk/gKJw/4ga0tmw+OAAThabFDnjr1Zlf+APgs2TfvdQaCb0CBOUsNahNK4ugRXqzwdnzcsfZ4R3iGqTPCLYYqabl49zMJMgXEs=
Content-Type: text/plain; charset="utf-7"
Content-ID: <D383DEF0D7FEE143BC182D62AE97CDE5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: db3e0302-022b-4469-110d-08d6b928d9cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 18:10:42.1588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2822
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-04_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


+/v8-On 4/4/19, 10:53 AM, +ACI-David Miller+ACI- +ADw-davem+AEA-davemloft.n=
et+AD4- wrote:

    From: +ACI-Tilmans, Olivier (Nokia - BE/Antwerp)+ACI- +ADw-olivier.tilm=
ans+AEA-nokia-bell-labs.com+AD4-
    Date: Thu, 4 Apr 2019 12:24:02 +-0000
   =20
    +AD4- RFC8257 +AKc-3.5 explicitly states that +ACI-A DCTCP sender MUST =
react to
    +AD4- loss episodes in the same way as conventional TCP+ACI-.
    ...
    +AD4- This patch replace the clamping of alpha by setting ssthresh to
    +AD4- half of cwnd for both fast retransmissions and RTOs, at most once
    +AD4- per RTT. Consequently, the dctcp+AF8-clamp+AF8-alpha+AF8-on+AF8-l=
oss module parameter
    +AD4- has been removed.
   =20
    Applied to 'net' and queued up for -stable, thanks.
   =20
DCTCP is meant to be used in environments where the switches/routers do ECN=
 marking, so it is not surprising that it performs badly when used in envir=
onments where it was not meant to be used. Has anyone measured the effect o=
f this changed when DCTCP is used in environments where all the switches/ro=
uters do ECN marking? My concern is that we could end up hurting performanc=
e when DCTCP is used how it was meant to be used in order to protect incorr=
ect uses of DCTCP.

