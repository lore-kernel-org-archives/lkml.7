Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9807C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A39C21473
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Qdj7007h";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="PeYiW1J8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbfDAQf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:35:29 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35352 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727021AbfDAQf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:35:29 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x31GKI3l017123;
        Mon, 1 Apr 2019 09:34:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=tf1+Xpzd4dhwxj6UC6yDUVmv4QySBHRRsZiRK/lJBBw=;
 b=Qdj7007hFE2eN7OMvIAD4Wf/xbRnl7KLX+zyxAx1S2DsD3DaTLqi96HESNZaKJdAvs9d
 7XZfW9DWbmvx2WZbvfWiI6h3FCWcc0zlsR88hYEt1DYnhTnpgs11TDNsDLEJb6RZFKPV
 3RNiB1omW5iXk03MvXiQF6FODY+G/v6MXzQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rkjdah0ww-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 01 Apr 2019 09:34:05 -0700
Received: from frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Apr 2019 09:34:04 -0700
Received: from frc-hub05.TheFacebook.com (2620:10d:c021:18::175) by
 frc-mbx06.TheFacebook.com (2620:10d:c0a1:f82::30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 1 Apr 2019 09:34:03 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 1 Apr 2019 09:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf1+Xpzd4dhwxj6UC6yDUVmv4QySBHRRsZiRK/lJBBw=;
 b=PeYiW1J8GMJWyLfUvm8V1lPp2h3RAQ4n8oSQidDsaVHdwhOMKkrqqc295kAIdZFX8nDAOygxFWEK2ZudJHaWmosWWsC+o3cQFhWyhIU6pscoGMwqgy2gzbC0JPXCA1/ZqVu6YcvxeNy2eM3Qto3fvmZXCA0OEc4UzsjGOZ+emX4=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1565.namprd15.prod.outlook.com (10.173.235.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.20; Mon, 1 Apr 2019 16:34:02 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Mon, 1 Apr 2019
 16:34:02 +0000
From:   Martin Lau <kafai@fb.com>
To:     hujunwei <hujunwei4@huawei.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingfangsen@huawei.com" <mingfangsen@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>,
        "zhangwenhao8@huawei.com" <zhangwenhao8@huawei.com>,
        "wangxiaogang3@huawei.com" <wangxiaogang3@huawei.com>
Subject: Re: [PATCH v2 net] ipv6: Fix dangling pointer when ipv6 fragment
Thread-Topic: [PATCH v2 net] ipv6: Fix dangling pointer when ipv6 fragment
Thread-Index: AQHU56DocPVqow9gSEq5XaL6cFBxjKYngiOA
Date:   Mon, 1 Apr 2019 16:34:01 +0000
Message-ID: <20190401163355.4fokjjbyv3ug7nl3@kafai-mbp.dhcp.thefacebook.com>
References: <cbbedd1f-3e99-85f7-86d7-d02a86d59c29@huawei.com>
 <9104f44b-2ce0-7be9-2fca-8b6c12abbb86@huawei.com>
In-Reply-To: <9104f44b-2ce0-7be9-2fca-8b6c12abbb86@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0088.namprd19.prod.outlook.com
 (2603:10b6:320:1f::26) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3005]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7886cc75-9c4d-4118-ef88-08d6b6bfd909
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:MWHPR15MB1565;
x-ms-traffictypediagnostic: MWHPR15MB1565:
x-microsoft-antispam-prvs: <MWHPR15MB1565756B0FFA613769A35BB5D5550@MWHPR15MB1565.namprd15.prod.outlook.com>
x-forefront-prvs: 0994F5E0C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39860400002)(346002)(376002)(366004)(396003)(136003)(189003)(199004)(54906003)(446003)(6246003)(8676002)(316002)(25786009)(6512007)(9686003)(81156014)(5660300002)(81166006)(99286004)(7736002)(6506007)(1076003)(102836004)(305945005)(6916009)(11346002)(386003)(46003)(229853002)(6436002)(6486002)(4744005)(52116002)(6116002)(71190400001)(71200400001)(8936002)(105586002)(86362001)(186003)(256004)(478600001)(68736007)(76176011)(7416002)(4326008)(106356001)(53936002)(14454004)(476003)(2906002)(486006)(97736004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1565;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: eKlY9Dq2rqWokEoJQ9CRmTf4g7WtZaO+y35vYgcX5JXtSIgQh0vjSFZ7rKavWdIQx9oFGcnAoWCzk6X45A2xuMwPk3s0DFejLSi+D1NIOhxWsYBNjpBxruBTytGsdVVKmrAW8RnABlAjkUb8xHrJLLC6dA6uPSWKzxCFnqepodf+f5G+p4VUEBJYg/mbgsVKtreuMZ8bxP5WibmuyyGgK0K7sbmoFFmcw9A5QNtw/wn9aYg4U++e4SuCbFUBwtKQvysoKEdX/TKmVOoe5LBGTRQfAlrKFRto2QYh08K1ME1oOU2YiAhS0wN5pBXG4aFy7KHBGZguoJyBztLc9GCrwpo8aplMivw70Lbn62bVg6yEJE1MjAckDXJJJBbq9IcGINxB9O/PGUouDn+X8euo/QSesPvqZkTrChCcU8sRRS0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <201CBE20217D8F42AC8DD9235FA65ABD@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7886cc75-9c4d-4118-ef88-08d6b6bfd909
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2019 16:34:02.0043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1565
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-01_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 31, 2019 at 05:04:29PM +0800, hujunwei wrote:
> From: Junwei Hu <hujunwei4@huawei.com>
>=20
> At the beginning of ip6_fragment func, the prevhdr pointer is
> obtained in the ip6_find_1stfragopt func.
> However, all the pointers pointing into skb header may change
> when calling skb_checksum_help func with
> skb->ip_summed =3D CHECKSUM_PARTIAL condition.
> The prevhdr pointe will be dangling if it is not reloaded after
> calling __skb_linearize func in skb_checksum_help func.
>=20
> Here, I add a variable, nexthdr_offset, to evaluate the offset,
> which does not changes even after calling __skb_linearize func.
Acked-by: Martin KaFai Lau <kafai@fb.com>
