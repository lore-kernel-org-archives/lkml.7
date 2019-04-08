Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BC2C10F14
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A2D217F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 17:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="XeJlXlZv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbfDHRfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 13:35:11 -0400
Received: from mail-eopbgr680047.outbound.protection.outlook.com ([40.107.68.47]:37910
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfDHRfK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 13:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAQfi1uf9nlcY03MOAa0mD3o5jGz0a+BDKd+WEYUYWA=;
 b=XeJlXlZv3xulQ2Yr4zy2gZC3dtPL2gb73Ha1oPD7xWXFPfex5KX8nh580yZx7WrY57KzuI2tFIapR1leUHjDFyPZYbw+VnQRtZlLHeLXRVTVIihDvu3Hz26fC1Hu6GyvU5IwdNVgXfkBw++JJV5kBZWAVJGcEbYfLMrbWE/TvIs=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB5240.namprd05.prod.outlook.com (20.177.231.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1792.8; Mon, 8 Apr 2019 17:35:00 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::4140:b8f2:8e3:f5fd%4]) with mapi id 15.20.1792.009; Mon, 8 Apr 2019
 17:35:00 +0000
From:   Nadav Amit <namit@vmware.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Pv-drivers <Pv-drivers@vmware.com>,
        Julien Freche <jfreche@vmware.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
Thread-Topic: [PATCH v2 1/4] mm/balloon_compaction: list interfaces
Thread-Index: AQHU5L/fQHqTTJNOzkOghmdzHIOs1aYymUeA
Date:   Mon, 8 Apr 2019 17:35:00 +0000
Message-ID: <679D6F11-07D7-4227-9D02-41F9F8901E61@vmware.com>
References: <20190328010718.2248-1-namit@vmware.com>
 <20190328010718.2248-2-namit@vmware.com>
In-Reply-To: <20190328010718.2248-2-namit@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c34b376-8f74-4cef-37cf-08d6bc488704
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:BYAPR05MB5240;
x-ms-traffictypediagnostic: BYAPR05MB5240:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <BYAPR05MB5240F2FA3DBBA7F7A637AFFFD02C0@BYAPR05MB5240.namprd05.prod.outlook.com>
x-forefront-prvs: 0001227049
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(366004)(136003)(376002)(346002)(189003)(199004)(5660300002)(486006)(53936002)(33656002)(6246003)(25786009)(53546011)(6506007)(229853002)(76176011)(11346002)(6116002)(3846002)(6512007)(66066001)(476003)(446003)(82746002)(6486002)(316002)(305945005)(4326008)(2616005)(6436002)(7736002)(2906002)(256004)(71200400001)(71190400001)(81166006)(6916009)(106356001)(36756003)(83716004)(8936002)(68736007)(186003)(81156014)(8676002)(99286004)(478600001)(86362001)(4744005)(54906003)(14454004)(102836004)(105586002)(97736004)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB5240;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mH91q6AQ0GhnZ2PSC6QH7gXuC8+Qbt9fHvuYhNxDpd8U69Sc2mWXMaDh1SqLIJqD1Tj+eo+13ncY/GtofcJBXvK1hGsZasEes/jAVd35OsLa5G60JKpY92NcBG+9xAbMcE2RuYMlBjEbpjUYtKWwQI3YL8KfF9yNgBDoCFactv+iEgx8vHyY6NE25Gu1kf5ScoxRkkP0GfXgczKKSsv+JJKV0nYp1KQB8IzxeMlV8SBingiNNtpPQf1MoLSiYJ4U0Ez9VJDKkCSBpdYHWQovzfhF1Zd2u7BclerQ3iiQtdU3EaATEEI6EJ71xdcXNzgM9S28Pih5ilLpCNfcbbu0rWbgzk2EpEldetNC2wgds/f2hnHKun+UjQgAtJUfkrAXhhc5tBpMaTSev0cPLttHpOnzXVLUSdG8wfT48VdWraQ=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <49C9D19A64CC2A4D9009D73284BA2801@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c34b376-8f74-4cef-37cf-08d6bc488704
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2019 17:35:00.6520
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB5240
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mar 27, 2019, at 6:07 PM, Nadav Amit <namit@vmware.com> wrote:
>=20
> Introduce interfaces for ballooning enqueueing and dequeueing of a list
> of pages. These interfaces reduce the overhead of storing and restoring
> IRQs by batching the operations. In addition they do not panic if the
> list of pages is empty.
>=20
> Cc: "Michael S. Tsirkin" <mst@redhat.com>

Michael, may I ping for your ack?

