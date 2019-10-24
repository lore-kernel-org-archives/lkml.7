Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFC8CA9EBC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73BCE2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kRQHeISS";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="kRQHeISS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409377AbfJXOYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 10:24:12 -0400
Received: from mail-eopbgr150084.outbound.protection.outlook.com ([40.107.15.84]:9454
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732393AbfJXOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 10:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bWSXpHVt5DZLtbWFpEQs17bQXwyKpBC3A5Qfyd13DA=;
 b=kRQHeISSWSIBgQ9c/0CfMucWfph2LATP5fDruNRSEeOFAqvC2xlFOuJyvdpw9tqAr1S3xZuuuIymDdQBX6bLm9zYYuQ+OVWF+S1QSWDFOYIpSPW7BeNaYIdSs5WDNiYsn+7cSPGECam8sO5WOEJy7z10ALxkBWIhThRwXOClZ+Y=
Received: from VI1PR0802CA0029.eurprd08.prod.outlook.com
 (2603:10a6:800:a9::15) by VI1PR0802MB2352.eurprd08.prod.outlook.com
 (2603:10a6:800:9e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.23; Thu, 24 Oct
 2019 14:22:27 +0000
Received: from DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR0802CA0029.outlook.office365.com
 (2603:10a6:800:a9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.22 via Frontend
 Transport; Thu, 24 Oct 2019 14:22:27 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT041.mail.protection.outlook.com (10.152.21.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.23 via Frontend Transport; Thu, 24 Oct 2019 14:22:27 +0000
Received: ("Tessian outbound 3fba803f6da3:v33"); Thu, 24 Oct 2019 14:22:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: a46a090b7d5ff0b1
X-CR-MTA-TID: 64aa7808
Received: from d3b659b80781.1 (cr-mta-lb-1.cr-mta-net [104.47.10.52])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0C5D601C-A2E2-4716-BF28-C4B6F1CAE254.1;
        Thu, 24 Oct 2019 14:22:20 +0000
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03lp2052.outbound.protection.outlook.com [104.47.10.52])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d3b659b80781.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2019 14:22:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoiLPZn7/VUCbLBigVvSxvgs4SYYPzjsJD9wbQZg9iy7yHqv1P88aWdFqA/tGGqiCbqiiFDzOpg6N0cTpLgBtjA/xz/1LkyEOhX0PX7y2w1jIkkn0kypXl4bS1PdVqubcHjvmk1Mq8lJoyE5m0ixhFwJaEqLHgVZHqQq8NwlfBSjzq9MUP8gveBWSyOlhHv4Iq2Whg7zhDuwGve/GCaHep1jU1qa/1JUGNk4nNbUmnwtQrwALUnnpU3Crhf3D/4Qg6OKYrK4D2MIGX45/JeIFvUmN6VuaSvRYVz5rLOMQGHbQGIY3FXYMQhrhTjCKCZ6HYo8PJe199EQfVGc/ePq9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bWSXpHVt5DZLtbWFpEQs17bQXwyKpBC3A5Qfyd13DA=;
 b=llrnglQZ/yWsf6UCJoSotDA1yslRbABgiwHV/AxYscNxPWMToNzt8nrUA23fmcA9SV6zmTgGFFELH8kmO/rrk3ore0cfpnI7Iqja8uj+Gzy+8gZTJ+VId9dSJDh6QarSPEmlzEgF/QyYs28kbIHVOisoYKVdkvCH9U0lpXe/klcTh264LLdcZJjqcyl8QEhjl9UPcn0n9wZhBWLL92qW2APCJCk4Hg9GNbSjLYjYnf6dBkG3gYO0MUXd9iwIyjhxXgOwcRxyDfEWRnBHY9i0BjjT5jC1LMbu+3xxQRPYsjfdyF729o0WFCjSGSVfhOLpuSwlT0GgTuhQYoaeNORccg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bWSXpHVt5DZLtbWFpEQs17bQXwyKpBC3A5Qfyd13DA=;
 b=kRQHeISSWSIBgQ9c/0CfMucWfph2LATP5fDruNRSEeOFAqvC2xlFOuJyvdpw9tqAr1S3xZuuuIymDdQBX6bLm9zYYuQ+OVWF+S1QSWDFOYIpSPW7BeNaYIdSs5WDNiYsn+7cSPGECam8sO5WOEJy7z10ALxkBWIhThRwXOClZ+Y=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB2963.eurprd08.prod.outlook.com (52.134.90.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Thu, 24 Oct 2019 14:22:17 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::109c:e558:5074:13e4]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::109c:e558:5074:13e4%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 14:22:17 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>
Subject: Question regarding "reserved-memory"
Thread-Topic: Question regarding "reserved-memory"
Thread-Index: AQHVinZwwZsw70agmEe040OUqUpTNg==
Date:   Thu, 24 Oct 2019 14:22:17 +0000
Message-ID: <20191024142211.GA29467@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0021.namprd04.prod.outlook.com
 (2603:10b6:803:21::31) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e0fd860-bd3f-42f6-e305-08d7588d98b9
X-MS-TrafficTypeDiagnostic: AM0PR08MB2963:|AM0PR08MB2963:|VI1PR0802MB2352:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2352BA3B43D44D9518475D15E46A0@VI1PR0802MB2352.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:6790;OLM:6790;
x-forefront-prvs: 0200DDA8BE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(346002)(39860400002)(199004)(189003)(478600001)(64756008)(66556008)(66066001)(66476007)(66946007)(66446008)(6512007)(6116002)(3846002)(52116002)(256004)(36756003)(386003)(25786009)(71190400001)(2906002)(26005)(71200400001)(99286004)(2501003)(110136005)(14454004)(6436002)(102836004)(6486002)(8936002)(86362001)(2201001)(1076003)(316002)(6506007)(8676002)(81166006)(81156014)(5660300002)(476003)(2616005)(4326008)(33656002)(54906003)(44832011)(486006)(305945005)(7736002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB2963;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8dhQVxRaBb/sp5o2cVcz5KlnDwpjzPWTSde+J6miwkedTvku9JuIST5RgEch6ATBYTShICNSdrxI8dJANSnttYF5MzaOiMi3+BhxImApAfc2/kUSoV/1O3XfESoEmlgPZ+oeHiaG0qJ4GI2yeTBdsGMKPBbLWbdTkWMTv/VB7WrLuEi3HUqXwKoRsoDBwei1JQpXAn0mqIxGAEWG+DdPaW7OMnIcuXQrEHwZcnFTWimmP9BJfXPUvZPcc2tgyzCU4WSA/d/28C3IX8WxI1JYsfwdY3NE7jKCzWirElBm653LZNRgFljQzCX9tDzIl7d5CawLI8iJ5mocsKLbiQpA+RFNvAbwz83++aSZzfA5dKksqa/RxCoB0QtZiykCg4ImDXLnxlcbNe06xgUoqBzPl0k23PnZ+7FE6FJCXxhJ+WyiYVnifkrHCgl69o6SlBZu
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E985F4C5AB3F24080778754F54A2885@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB2963
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(39860400002)(346002)(1110001)(339900001)(199004)(189003)(76130400001)(2201001)(81156014)(81166006)(2501003)(110136005)(102836004)(8936002)(386003)(8746002)(36756003)(97756001)(70206006)(99286004)(70586007)(2906002)(6506007)(26005)(86362001)(186003)(6486002)(6512007)(8676002)(54906003)(47776003)(33656002)(105606002)(22756006)(25786009)(26826003)(316002)(478600001)(23726003)(1076003)(4326008)(6116002)(3846002)(5660300002)(336012)(356004)(2616005)(7736002)(305945005)(486006)(126002)(476003)(46406003)(50466002)(66066001)(14454004)(450100002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0802MB2352;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e555e31c-9c5f-48ff-2af3-08d7588d92f0
NoDisclaimer: True
X-Forefront-PRVS: 0200DDA8BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+4nx0fNVZjooN0qPoNmRCKZ2EGklpK+Byndz0ZlLn/kKnUfYbQ5+7Jos/CUQfO4UL/gMLfJCEv444enlCeSohrBqgLk3v+N0U4up0hCHMvFzjs54uK0Z9KxiiRBE/GJh64IOaZ2zLGu23lV0hTyRcqSl12YRz+gwVaR1BxA6zFneW2uHG66MMnuwuTyJSEXEqAsFHuNj2T3H3lygrOkEd7CnX0Ot0bNNCFt/3P6yMPZ7SAaTP6vdy6TRtMunY8J75WYwjVoOUdbEfZqQTNI9gNlJXsOR5bM+HbhOVF1ylgV00Es9TJiMcJBKpdo640OdrDqt0ZbAzTQAolqSAurH6Ltgc2KQblEiXLhl6DRxdrGAG6F0I26/kWzFGvXzBZgVaXpKv1opH6KFxoN70REm3QhT+CNN6Pu/N8PT/Lt1zFfux8kUGB3BjeuzSB/F2ZN
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 14:22:27.1446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0fd860-bd3f-42f6-e305-08d7588d98b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2352
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Folks,

I have a question regarding "reserved-memory". I am using an Arm Juno
platform which has a chunk of ram in its fpga. I intend to make this
memory as reserved so that it can be shared between various devices
for passing framebuffer.

My dts looks like the following:-

/ {
        .... // some nodes

        tlx@60000000 {
                compatible =3D "simple-bus";
                ...

                juno_wrapper {

                        ... /* here we have all the nodes */
                            /* corresponding to the devices in the fpga */

                        memory@d000000 {
                               device_type =3D "memory";
                               reg =3D <0x00 0x60000000 0x00 0x8000000>;
                        };

                        reserved-memory {
                               #address-cells =3D <0x01>;
                               #size-cells =3D <0x01>;
                               ranges;

                               framebuffer@d000000 {
                                        compatible =3D "shared-dma-pool";
                                        linux,cma-default;
                                        reusable;
                                        reg =3D <0x00 0x60000000 0x00 0x800=
0000>;
                                        phandle =3D <0x44>;
                                };
                        };
                        ...
                }
        }
...
}

Note that the depth of the "reserved-memory" node is 3.

Refer __fdt_scan_reserved_mem() :-

        if (!found && depth =3D=3D 1 && strcmp(uname, "reserved-memory") =
=3D=3D 0) {

                if (__reserved_mem_check_root(node) !=3D 0) {
                        pr_err("Reserved memory: unsupported node
format, ignoring\n");
                        /* break scan */
                        return 1;
                }
                found =3D 1;

                /* scan next node */
                return 0;
        }

It expects the "reserved-memory" node to be at depth =3D=3D 1 and so it
does not probe it in our case.

Niether from the
Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
 nor from commit - e8d9d1f5485b52ec3c4d7af839e6914438f6c285,
I could understand the reason for such restriction.

So, I seek the community's advice as to whether I should fix up
__fdt_scan_reserved_mem() so as to do away with the restriction or
put the "reserved-memory" node outside of 'tlx@60000000' (which looks
 logically incorrect as the memory is on the fpga platform).


Thanks,
Ayan

