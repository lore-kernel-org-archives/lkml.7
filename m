Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B11CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B6C21906
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pY0VaheE";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="pY0VaheE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503072AbfJXPUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:20:09 -0400
Received: from mail-eopbgr150087.outbound.protection.outlook.com ([40.107.15.87]:2277
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2502905AbfJXPUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVRyS5LouQ5sJt3m+yDKy3GrbPgBDqdpcUsCSh9YUgw=;
 b=pY0VaheEQuxunYkiRrD8hv5512qrUAim/LAQ/dl5GdpP3iZ5YmNfRWZI5vOMJxo2YPZlVDI8/IRzWQd7Bmh0PvwMj70lHiyUCb+oDvic8nZ8QkunRP/vetOIFmSKIE9Oa/UAQgh5lJ8nrCh/DkN/np+SGhIaQ0px+4/uihfutiE=
Received: from VI1PR08CA0176.eurprd08.prod.outlook.com (2603:10a6:800:d1::30)
 by AM0PR08MB4596.eurprd08.prod.outlook.com (2603:10a6:208:101::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.24; Thu, 24 Oct
 2019 15:20:01 +0000
Received: from VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e09::206) by VI1PR08CA0176.outlook.office365.com
 (2603:10a6:800:d1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Thu, 24 Oct 2019 15:20:01 +0000
Authentication-Results: spf=fail (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received-SPF: Fail (protection.outlook.com: domain of arm.com does not
 designate 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT052.mail.protection.outlook.com (10.152.19.173) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Thu, 24 Oct 2019 15:20:00 +0000
Received: ("Tessian outbound 081de437afc7:v33"); Thu, 24 Oct 2019 15:19:59 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 8deed213d56a1793
X-CR-MTA-TID: 64aa7808
Received: from 3e2b2aef10d0.2 (cr-mta-lb-1.cr-mta-net [104.47.9.54])
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 684D38F7-0957-42EF-B7AB-A12BDDF5D270.1;
        Thu, 24 Oct 2019 15:19:54 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2054.outbound.protection.outlook.com [104.47.9.54])
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 3e2b2aef10d0.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2019 15:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UEwMDZTf+6PHziz1yLnWHsW68eTCGklo170c/4QRdwcnIIv94S9kTTzG/PUdtzipZO2y6o4Y5LG0W59w+Q7LXaxbC2UOjvfNShMm8A4Zb6zn9eKkKJVaqOO2sXr1CdIWGSg7tfnFTX16Iw2Cqo8nYPaURQUrQAmOekf3cvRJs3De12xNLRgbGF7oRujeHJEkTuTZOUxKh7JmsH6EOU+WCyO3m6EgtwxfRl/jvyzqMz2231QNBEYhv6ZteSRd3xfkMuT6hOi3i9PEmIbIsL5E0oqxlBYe0ozfGvJAbVfoWCpLWM0LaN1yJS2ZpgUU6tvCIV1gfdIY6wB5BPgDyWScgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVRyS5LouQ5sJt3m+yDKy3GrbPgBDqdpcUsCSh9YUgw=;
 b=FhoQMWkuNjL0ARa9UBZeSXJhxc19sP2qGW6BV75lTugaVlpDXyIpaorC327i7vS4s88dlgTdoNV79E9KK7JhQmug4pMRvi0jQXPB2qkakV5iiFgtoqamydhAX2NUYGl9ZM6PkA7S56UnLbCMwAq3lpNYZ58xotjDDCgGDoyKu6bDiQQyqYPEvU/n/usg405AK8b87KhIf5N+zh7UnO/f85dXPPBYuyRrRseS+NfeyVfRUYpMchzlQzQOLNpcVTchU5wI6FwXQLedIKiu0ENqIUQc7HbUyVZ0osvsynnQgpE8abHSrMHmUBqoSiZBVWWa4b8dsgUlhLl2wbbyrbNaWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HVRyS5LouQ5sJt3m+yDKy3GrbPgBDqdpcUsCSh9YUgw=;
 b=pY0VaheEQuxunYkiRrD8hv5512qrUAim/LAQ/dl5GdpP3iZ5YmNfRWZI5vOMJxo2YPZlVDI8/IRzWQd7Bmh0PvwMj70lHiyUCb+oDvic8nZ8QkunRP/vetOIFmSKIE9Oa/UAQgh5lJ8nrCh/DkN/np+SGhIaQ0px+4/uihfutiE=
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com (52.132.215.213) by
 AM0PR08MB5137.eurprd08.prod.outlook.com (10.255.28.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.22; Thu, 24 Oct 2019 15:19:52 +0000
Received: from AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::109c:e558:5074:13e4]) by AM0PR08MB5345.eurprd08.prod.outlook.com
 ([fe80::109c:e558:5074:13e4%6]) with mapi id 15.20.2387.023; Thu, 24 Oct 2019
 15:19:52 +0000
From:   Ayan Halder <Ayan.Halder@arm.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Mihail Atanassov <Mihail.Atanassov@arm.com>,
        "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>, nd <nd@arm.com>
Subject: Re: Question regarding "reserved-memory"
Thread-Topic: Question regarding "reserved-memory"
Thread-Index: AQHVinZwwZsw70agmEe040OUqUpTNqdp3/4AgAAICoA=
Date:   Thu, 24 Oct 2019 15:19:52 +0000
Message-ID: <20191024151951.GA29067@arm.com>
References: <20191024142211.GA29467@arm.com>
 <CAL_JsqJSSYdRyy=Hw4H613fWVyXM3ivFj8mgO6iwvXZQOr=9pA@mail.gmail.com>
In-Reply-To: <CAL_JsqJSSYdRyy=Hw4H613fWVyXM3ivFj8mgO6iwvXZQOr=9pA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: LO2P123CA0004.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::16) To AM0PR08MB5345.eurprd08.prod.outlook.com
 (2603:10a6:208:18c::21)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.140.106.53]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 115ac93a-19e1-4949-3e95-08d75895a35a
X-MS-TrafficTypeDiagnostic: AM0PR08MB5137:|AM0PR08MB5137:|AM0PR08MB4596:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB45964382D4A132CA4220E205E46A0@AM0PR08MB4596.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 0200DDA8BE
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(136003)(39860400002)(189003)(199004)(186003)(76176011)(102836004)(25786009)(86362001)(66946007)(66476007)(66066001)(53546011)(386003)(6506007)(26005)(4326008)(3846002)(6116002)(81166006)(11346002)(81156014)(446003)(2616005)(476003)(486006)(14454004)(66556008)(8676002)(64756008)(66446008)(44832011)(8936002)(478600001)(6486002)(305945005)(7736002)(33656002)(6246003)(14444005)(54906003)(99286004)(316002)(6436002)(229853002)(256004)(5660300002)(2906002)(36756003)(71190400001)(71200400001)(6512007)(52116002)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB5137;H:AM0PR08MB5345.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: a3Al9ZnNHStOjXXtHSw/cApok7f8XWIGCOsza5kVAHhb0xCwtXipE9m1OokkoR+MAOrf3I/Zz0bNocycfWy8G9CotfSHqqi1seHwTKSbjC0+TK3/UP92JG5bVRMwQ8oarMaP3MjkUWHe+Vagr8mnekTSzKUV+F87YU77BU2gGx/+Py8dT5E0HNYfVr/5ltqwyX21ONOGKZPxsXiURWnxlJ1E/wPoVEKnQTengugBfzf80XergA4vQ1qbKfpsdq0BwMEdSKE63Y8sS1DlBQNqS05/9Fj6qH6T+z0NbLj8CAyFyBA7cEyEio/WQWMvsjXetditfgvYKhu0gOAJY87hwsUhpVE4bDl9w4dCWb2UKLW5GcsyiJEV92LcwZBmZqeYls9n/ZHXWZKv6JBA/jjWzGZBzAf4+8CCmh2chPjavpssvzLs9Q0bciz6lcRnJL4a
Content-Type: text/plain; charset="us-ascii"
Content-ID: <47D9427BD490E34687050EE8A7647BE1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5137
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ayan.Halder@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT052.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(1110001)(339900001)(199004)(189003)(3846002)(2906002)(6116002)(4326008)(36906005)(316002)(229853002)(446003)(14444005)(11346002)(305945005)(66066001)(7736002)(8746002)(2616005)(33656002)(5660300002)(336012)(486006)(23726003)(126002)(22756006)(46406003)(476003)(25786009)(356004)(1076003)(478600001)(14454004)(86362001)(50466002)(53546011)(6486002)(76176011)(36756003)(99286004)(26826003)(81166006)(81156014)(8676002)(105606002)(450100002)(8936002)(6862004)(186003)(70206006)(70586007)(386003)(47776003)(76130400001)(54906003)(6246003)(26005)(6512007)(102836004)(97756001)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB4596;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Fail;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7052bbf4-1f77-4373-91ba-08d758959e19
NoDisclaimer: True
X-Forefront-PRVS: 0200DDA8BE
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vKLxqUhbaysqC1kj3VsZz4BT/e3KkCqE0avITqwMZwKXAKDE2d+rZcwvEqjKAzSiJJCp0pIX3dDIIv7l/acoq1hHrRAGZckkxFXnSZud13MaqoM5QYr2xxcMFl3Sgq3TD3xNBiDUFaR+Iiqr/7h3TnkskV1E0qb2TW5pyi6igzvN3hzBTYkdjdoBGYfF72OHEA01NZ3IwAd4URCK7WRruNtgvg4vYY0paKv9AFltMnUVDTM+L/vVRS6CaDIQIcUindaoU8SQ6SI66NYjC7BYaZpq0/N9hVxQK6wPUorshomQt/5+KY7M4pzwHdlvi7gABGAutJyQk77uFzyukpC4yq+xzDV0kImSmn6ggZlqLVon/SRmKpk3veQJHaV5/jMhhrJ6Kl8QDmeq5u5UHlVfB2ftV9uffg0vam9Pftoy9E1O2HgXMgECV8byser51sv
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2019 15:20:00.8785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 115ac93a-19e1-4949-3e95-08d75895a35a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 24, 2019 at 09:51:04AM -0500, Rob Herring wrote:
> On Thu, Oct 24, 2019 at 9:22 AM Ayan Halder <Ayan.Halder@arm.com> wrote:
Hi Bob,

Thanks for your quick response.
> >
> >
> > Hi Folks,
> >
> > I have a question regarding "reserved-memory". I am using an Arm Juno
> > platform which has a chunk of ram in its fpga. I intend to make this
> > memory as reserved so that it can be shared between various devices
> > for passing framebuffer.
> >
> > My dts looks like the following:-
> >
> > / {
> >         .... // some nodes
> >
> >         tlx@60000000 {
> >                 compatible =3D "simple-bus";
> >                 ...
> >
> >                 juno_wrapper {
> >
> >                         ... /* here we have all the nodes */
> >                             /* corresponding to the devices in the fpga=
 */
> >
> >                         memory@d000000 {
> >                                device_type =3D "memory";
> >                                reg =3D <0x00 0x60000000 0x00 0x8000000>=
;
> >                         };
> >
> >                         reserved-memory {
> >                                #address-cells =3D <0x01>;
> >                                #size-cells =3D <0x01>;
> >                                ranges;
> >
> >                                framebuffer@d000000 {
> >                                         compatible =3D "shared-dma-pool=
";
> >                                         linux,cma-default;
> >                                         reusable;
> >                                         reg =3D <0x00 0x60000000 0x00 0=
x8000000>;
> >                                         phandle =3D <0x44>;
> >                                 };
> >                         };
> >                         ...
> >                 }
> >         }
> > ...
> > }
> >
> > Note that the depth of the "reserved-memory" node is 3.
> >
> > Refer __fdt_scan_reserved_mem() :-
> >
> >         if (!found && depth =3D=3D 1 && strcmp(uname, "reserved-memory"=
) =3D=3D 0) {
> >
> >                 if (__reserved_mem_check_root(node) !=3D 0) {
> >                         pr_err("Reserved memory: unsupported node
> > format, ignoring\n");
> >                         /* break scan */
> >                         return 1;
> >                 }
> >                 found =3D 1;
> >
> >                 /* scan next node */
> >                 return 0;
> >         }
> >
> > It expects the "reserved-memory" node to be at depth =3D=3D 1 and so it
> > does not probe it in our case.
> >
> > Niether from the
> > Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> >  nor from commit - e8d9d1f5485b52ec3c4d7af839e6914438f6c285,
> > I could understand the reason for such restriction.
> >
> > So, I seek the community's advice as to whether I should fix up
> > __fdt_scan_reserved_mem() so as to do away with the restriction or
> > put the "reserved-memory" node outside of 'tlx@60000000' (which looks
> >  logically incorrect as the memory is on the fpga platform).
>=20
> For now, I'm going to say it must be at the root level.=20
Can you mention it in the Documentation/.../reserved-memory.txt,
please?

> I'd guess the
> memory@d000000 node is also just ignored (wrong unit-address BTW).
I would request you to ignore the address for the time being. In
juno_wrapper{}, we have a complex remapping of addresses of all the
sub-devices. I deliberately did not put that in the snippet, so as to
prevent any distraction from the core issue.

>=20
> I think you're also forgetting the later unflattened parsing of
> /reserved-memory.
Are you talking about the remaining part of the
__fdt_scan_reserved_mem() ie

       ....
        } else if (found && depth < 2) {
                /* scanning of /reserved-memory has been finished */
                return 1;
        }

        if (!of_fdt_device_is_available(initial_boot_params, node))
                return 0;

        err =3D __reserved_mem_reserve_reg(node, uname);
        if (err =3D=3D -ENOENT && of_get_flat_dt_prop(node, "size", NULL))
                fdt_reserved_mem_save_node(node, uname, 0, 0);

        /* scan next node */
        return 0;

If so, I agree with you that it needs to be changed as well (if we
were to do away with the restriction).

> The other complication IIRC is booting with UEFI
> does it's own reserved memory table which often uses the DT table as
> its source.
I have no knowledge of UEFI booting. So if UEFI expects
"reserved-memory" nodes to be at root level, then we must adhere to
the restriction. :)

Ayan
>=20
> Rob
