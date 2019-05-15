Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F93EC04E87
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655CF20862
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="iZiDcxsC";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="fOD2oBOx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfEORAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:00:20 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45056 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726690AbfEORAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:00:19 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4FGxrCI006997;
        Wed, 15 May 2019 10:00:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qynf98ZDwvcznbRqFMYmPrHxCPwYBWB3HgqqCZNwtf0=;
 b=iZiDcxsC8/ted1IAEzOXtnCM3ZzaHq6B/NXIPQiMD5Fy1nd2EleNBygRWHBFu/gTgb0c
 zfEH1WPGqHug6bR8ssEnivwANeLiqdtumCEophLjsv37Su/a+/WOxJIdVA85bMsy5CqU
 bJaL7XsZ1i3QI9F7CWY2iiba1ZA5dG0Qykk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sgjm2h0ru-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 15 May 2019 10:00:16 -0700
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Wed, 15 May 2019 10:00:09 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Wed, 15 May 2019 10:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qynf98ZDwvcznbRqFMYmPrHxCPwYBWB3HgqqCZNwtf0=;
 b=fOD2oBOxSXNH1+ai1E86WzpIj55PPGwdBOGPiwRYmqJc8Ym2IJBaB89wbkOhlWV+rXScOrOilSATj7a3zK2HfivZmFm5t09OlR4gsIFlORFyPFcmmgCTbQxlMOF+F5wqCiK0MptuN77BN2hNAV/QmGAqJdRVwwZT118S8vwwxi8=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3335.namprd15.prod.outlook.com (20.179.58.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1878.21; Wed, 15 May 2019 17:00:07 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1878.024; Wed, 15 May 2019
 17:00:07 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        "Kirill Tkhai" <ktkhai@virtuozzo.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 5/5] proc: use down_read_killable for /proc/pid/map_files
Thread-Topic: [PATCH 5/5] proc: use down_read_killable for /proc/pid/map_files
Thread-Index: AQHVCvoDISknOLVQ6k6bg7diwORU3aZsaUuA
Date:   Wed, 15 May 2019 17:00:07 +0000
Message-ID: <20190515165956.GA7845@castle>
References: <155790967258.1319.11531787078240675602.stgit@buzz>
 <155790968346.1319.5754627575519802426.stgit@buzz>
In-Reply-To: <155790968346.1319.5754627575519802426.stgit@buzz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR04CA0104.namprd04.prod.outlook.com
 (2603:10b6:301:3a::45) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::779]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 92b3c1fb-46a7-414f-fff4-08d6d956c863
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR15MB3335;
x-ms-traffictypediagnostic: BYAPR15MB3335:
x-microsoft-antispam-prvs: <BYAPR15MB33358990A201ABE1D0176103BE090@BYAPR15MB3335.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:299;
x-forefront-prvs: 0038DE95A2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(366004)(136003)(346002)(376002)(39860400002)(396003)(189003)(199004)(6916009)(5660300002)(14444005)(256004)(14454004)(52116002)(73956011)(66946007)(1076003)(4744005)(66476007)(64756008)(66446008)(86362001)(7736002)(33656002)(33716001)(6436002)(2906002)(229853002)(54906003)(66556008)(9686003)(6512007)(4326008)(76176011)(305945005)(99286004)(6486002)(25786009)(476003)(68736007)(102836004)(446003)(53936002)(81156014)(11346002)(6246003)(6506007)(71190400001)(8936002)(386003)(71200400001)(486006)(316002)(6116002)(46003)(478600001)(186003)(81166006)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3335;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6/RELJ0RRVug8wSQJMo+82B8MKiw/XhwU9vW+V9iWxDtK7NiN4HF/jEeL+y2YFLZwH1BuDrLJRHufY6kuk8JGHqDafV8sTgw5G43jD4q/FZm8YYQWm6vKu7HfsIHheqmi/USG8iHr43aL4UCTQ6hvCHidgYjvUPpao1kB0gBTdbvK3NCMjhCNjZMATiYbVImGYGA41j7SdbIDhJG7W68uX0YamVF9xJE7a5wcvpLRIKm0QyUSbZkC6W1ylQJNkoUMWohJwJTHp/z1o/v+1/Dgb9s9VM7aNcIBt0W0f5quMvHszHzggTsjg8ekA34LNrVmXlkY7U45D3sR9fjjED6fzl2Vr1gIxt8Gtt9pIH/hQfsfInwooXo6avluymLy8guYokv2pSYMwWfeYrQVXP0ZX+HMW5e9U1tUKGHpqOcMZo=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D5C73FF056CC549AE708161877DEBF7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b3c1fb-46a7-414f-fff4-08d6d956c863
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2019 17:00:07.5053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3335
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-15_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 15, 2019 at 11:41:23AM +0300, Konstantin Khlebnikov wrote:
> It seems ->d_revalidate() could return any error (except ECHILD) to
> abort validation and pass error as result of lookup sequence.
>=20
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  fs/proc/base.c |   27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)

Hi!

The series looks good to me!

Reviewed-by: Roman Gushchin <guro@fb.com>
for all patches in the set.

The only thing, you need to add a bit more detailed commit messages
to patches 2 and 3.

Thanks!
