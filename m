Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555B6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A212064A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 20:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="CrvbxuOt";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kNZfoRny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCKUuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 16:50:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55576 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727304AbfCKUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 16:50:20 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BKnbWv027553;
        Mon, 11 Mar 2019 13:50:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=qNOCRcXNifgCe+zDOWlAZ2PFj0XbUZP5zYv+FdQ7m1I=;
 b=CrvbxuOtjKJeCOTQaOjtOjOWBPvqfqZ3iiDKlS8Yg6TjejA1RTUvmMu5qUN4DGeRDnV9
 V6KL8wE1PzmwarJ3eRfVgNJbGq0p12scYCVWrFAHxFAs7cMX+Kzg1GujBhLDBcDYKHZY
 1WYnhQsvpi34uRBUWliMRx8oq/ToLE3VXF8= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r5xupg1ng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 13:50:04 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 13:49:26 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 13:49:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNOCRcXNifgCe+zDOWlAZ2PFj0XbUZP5zYv+FdQ7m1I=;
 b=kNZfoRnyF0aeko7feUlByu6Zt3wU/vjsorxt8t+49w/qGe/vKEO/NGIrCdsPo+oVDql3OO+B+3DgV2v/hHkSMtv2aou4WYa7K3sYDmMwri8jWmSDsFRRTs/dASuLJjugG1+NIQxZwzusPKZspv5w6VeVio4G3lGv2CiHPc+Dk/M=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3238.namprd15.prod.outlook.com (20.179.57.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Mon, 11 Mar 2019 20:49:24 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 20:49:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <tobin@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Topic: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Index: AQHU16bt6o0Uju0YQ0mKx1ZofK0W1KYG6H2A
Date:   Mon, 11 Mar 2019 20:49:23 +0000
Message-ID: <20190311204919.GA20002@tower.DHCP.thefacebook.com>
References: <20190311010744.5862-1-tobin@kernel.org>
In-Reply-To: <20190311010744.5862-1-tobin@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR16CA0010.namprd16.prod.outlook.com (2603:10b6:907::23)
 To BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1513610c-37d5-48a2-42b0-08d6a6630b07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3238;
x-ms-traffictypediagnostic: BYAPR15MB3238:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB3238;20:w3xRwUjIi+NTnsrogAPt1myxQYxymgia9zadw3C+I2fZSq8tZc2qo5SyNFKZmZkfzwmJY5adfHowZCMtSXgHG29ixcXmaXVM1GdN6UvblxJP66WJagBL6WD0pRFdofpSN0hw/7ppKYyG+MCGQTTsRpLY9QWM4vZw1M8CdoBEKY0=
x-microsoft-antispam-prvs: <BYAPR15MB323838FA26119A5B1F2722FDBE480@BYAPR15MB3238.namprd15.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(376002)(346002)(396003)(199004)(189003)(33656002)(6116002)(9686003)(86362001)(4326008)(7736002)(25786009)(305945005)(68736007)(2906002)(6512007)(476003)(71200400001)(71190400001)(486006)(446003)(53936002)(97736004)(6246003)(14454004)(11346002)(478600001)(256004)(316002)(81166006)(46003)(1076003)(6916009)(8676002)(54906003)(81156014)(5660300002)(105586002)(106356001)(6436002)(8936002)(6486002)(99286004)(76176011)(52116002)(229853002)(6506007)(386003)(102836004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3238;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0mlUCiGzU42LsFyAb0lZMkFztYdHCnQvroCw4B7saadbY7/94FEsNTsnJSTJ1yoMQq3pI1g3mG6BIuzR2E9AQoF2KReMqBb4fmsH33xytcHJY9bpHalU1MNyvlV7dPW2ylVWHjuxQwLiKi2OrA39wlt46x4Mj7Mpx/6hHOdn+B751lVxeMBDQldNjmJl2zoyo5tC0rAggRE+ea3PDUvheHTxXCItEXgMdKvccRJoc76g0eLAvZb6ozC0cWa0Tdlec0qh6D/QCwXn8aUjUI+0CS995W47VYUlAXrHsCNErSbhnZc+sUWAw3EtZy9MtpPDuXdggzCFvqyUdCE3U5QuuTSmKMDMLxMWxAailOPTIpbDqRR4lM6kOj/gKNXIr7OTlXvGXszcM0+Zpt3wVmC6x6e9/QNAnlxMPfGS1uxOFVw=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0067C8991FF0D646978183C4E83070A5@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1513610c-37d5-48a2-42b0-08d6a6630b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 20:49:23.9654
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3238
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_16:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 12:07:40PM +1100, Tobin C. Harding wrote:
> Currently the slab allocators (ab)use the struct page 'lru' list_head.
> We have a list head for slab allocators to use, 'slab_list'.
>=20
> Clean up all three allocators by using the 'slab_list' list_head instead
> of overloading the 'lru' list_head.
>=20
> Initial patch makes no code changes, adds comments to #endif statements.
>=20
> Final 3 patches do changes as a patch per allocator, tested by building
> and booting (in Qemu) after configuring kernel to use appropriate
> allocator.  Also build and boot with debug options enabled (for slab
> and slub).

Hi Tobin!

The patchset looks good to me, however I'd add some clarifications
why switching from lru to slab_list is safe.

My understanding is that the slab_list fields isn't currently in use,
but it's not that obvious that putting slab_list and next/pages/pobjects
fields into a union is safe (for the slub case).

Please, add a clarification/comment.

For patches 1, 3 and 4:
Reviewed-by: Roman Gushchin <guro@fb.com>

Thanks!
