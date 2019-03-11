Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42F4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF6C2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 16:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="W9RARtBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbfCKQdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 12:33:20 -0400
Received: from mx07-00287e01.pphosted.com ([91.207.212.151]:30014 "EHLO
        mx08-00287e01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726675AbfCKQdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 12:33:20 -0400
Received: from pps.filterd (m0111314.ppops.net [127.0.0.1])
        by mx08-00287e01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2BGFAlW007479;
        Mon, 11 Mar 2019 17:32:53 +0100
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2050.outbound.protection.outlook.com [104.47.13.50])
        by mx08-00287e01.pphosted.com with ESMTP id 2r44kfsykh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:32:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SePcOq2dRZ9v7eBVlQHrAcAGF3CRW5R4cmdt+RO9+lE=;
 b=W9RARtBuDI/kfp2NqQP2KjfDxyAz2cDWRqLy0lpR8xBoqGw068D1ylelv+BdnjDgZn7bnqNhMZUkO7HsUHZWmQrYGQLxgJEcCO1SnDJCSI/VmRkt6cjvWD413zeUOPbe5RCD1euylnmh6oqPQ2xUxAEZmY7fMZVAkerwt/Vq5Ww=
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com (20.178.125.158) by
 VI1PR04MB2078.eurprd04.prod.outlook.com (10.166.43.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Mon, 11 Mar 2019 16:32:50 +0000
Received: from VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec]) by VI1PR04MB5629.eurprd04.prod.outlook.com
 ([fe80::4574:93ab:72b8:d1ec%3]) with mapi id 15.20.1686.021; Mon, 11 Mar 2019
 16:32:50 +0000
From:   Erwan Velu <e.velu@criteo.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Borislav Petkov <bp@alien8.de>
CC:     stable <stable@vger.kernel.org>,
        "linux-tip-commits@vger.kernel.org" 
        <linux-tip-commits@vger.kernel.org>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "jiaxun.yang@flygoat.com" <jiaxun.yang@flygoat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sherry.hurwitz@amd.com" <sherry.hurwitz@amd.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "hpa@zytor.com" <hpa@zytor.com>
Subject: Re: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Thread-Topic: [tip:x86/cpu] x86/CPU/AMD: Set the CPB bit unconditionally on
 F17h
Thread-Index: AQHUyPnNxHGAOyBVuE60Dv7o6J+NAqXqJeQAgAAJMICAF3HWgIAFHTqA
Date:   Mon, 11 Mar 2019 16:32:50 +0000
Message-ID: <3aa41b12-c796-fce4-41ee-cee0de7979cc@criteo.com>
References: <20181120030018.5185-1-jiaxun.yang@flygoat.com>
 <tip-0237199186e7a4aa5310741f0a6498a20c820fd7@git.kernel.org>
 <20190220085334.GA5177@zn.tnic> <20190221115230.GB25198@kroah.com>
 <20190221122523.GB12997@zn.tnic> <20190308102647.GA19469@kroah.com>
In-Reply-To: <20190308102647.GA19469@kroah.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0098.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::39) To VI1PR04MB5629.eurprd04.prod.outlook.com
 (2603:10a6:803:de::30)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [71.6.57.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bbf17409-67c8-4769-802d-08d6a63f33fa
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB2078;
x-ms-traffictypediagnostic: VI1PR04MB2078:
x-microsoft-exchange-diagnostics: =?utf-8?B?MTtWSTFQUjA0TUIyMDc4OzIzOlZSYkFacFBVcnJYSEJUOG5xSnpmRjNYakRL?=
 =?utf-8?B?UWtyM2U5ckpud1hxczR1QnJkclovMHZKeHZmQ2lVTnE1MXRKSUR6R0JHTnFu?=
 =?utf-8?B?SzQ4SnJVVzAvRXNqbHJHUjF4emRxYXJQdTU5c2I1WkxLOC85QXhjRTRNVTVD?=
 =?utf-8?B?OFB1WmF0UTlHWFRLRk54RnVGQkoyVGxyT3Z5ZHVyQmx2MHZKeUlNSy9UN2RK?=
 =?utf-8?B?ZUZyNWQvek9jb1hGUkhGemh2R0laZG9WSWJyU281MS9VTnphUnFoT3FrQnpU?=
 =?utf-8?B?aStIZm10L0hSTDNLd2l6b2laUCtrWU9Dc2VneFRSNGNielJyZ2lXbHhNeTI0?=
 =?utf-8?B?NWZYTFNpK1puWXF5a1hJejRHb3VGMzR1NStCbnJOZmxESnZ6YzNOZW9XWlZN?=
 =?utf-8?B?UCtjdlJyWFBBMmZ3Z3NNT3FrWUlEb2wwb3RpZ1Q5c2loTWJTMnhjRW5QWEVk?=
 =?utf-8?B?VTJYV1M3d3dBWFZ6ZGhJWGxrbGRRdG5CakNjWEdNUjliL3RDRXZWMlNGUDN5?=
 =?utf-8?B?ck9UeFFTdDF0N1p0TDdRR01CTWE0a2NRcEE1MzdmSW1PY05sMEFIdHhkSEEx?=
 =?utf-8?B?SzRHbDNiWTNUeWQ2MFFLZnNndWVIZXlhUmp4ZU5HbWhrUmFyd0hjOVZlTlhO?=
 =?utf-8?B?eHREYnZMQnp3SUMxZ1NnN2pIOWVaLytwL0lhMCttWU14K3l0b0hXeUtWV3pm?=
 =?utf-8?B?ZDZMRlYyOVVoZUhGSmNra0dXOElQT1NwMSt6S1BVSThpSGY0bHN1WFMwbWto?=
 =?utf-8?B?SnJ3MXQ1bXBLMU1SeWpRczc3NFgyOTFTREFNLzFlWDRxSTZkZ2granRsdnNG?=
 =?utf-8?B?bjdWOCs1L0xEUWxyejFaRFUrUk13dzlzaCtvU3FzVUJxOUc2WEdtVmlOUUxB?=
 =?utf-8?B?RnJETnFhK0ZyZkNKWmRmOXczWEdManFOSU4rN29PTmhlSUNjK3NQT3NSeHBO?=
 =?utf-8?B?d0xhdm9OMHF2a3RFRUN5NkhFMkNQU2JwTEJGd3ZLbDBmWVhMcUpEUHlqYVA0?=
 =?utf-8?B?WWJvdC9CYzk2Q1RqeDlUMEhtNVczb2M1M1pnYVNpRG8yOFZUMEkxS1BtTzFq?=
 =?utf-8?B?bUZUR05LaUJ4KzlTT1NoVUhEOUZKKzdmazlXTUc5VTNINVN1TmtyT2kvQWcw?=
 =?utf-8?B?ZVgvMDArZ1V1bmx0aHJzd3cvQnBJaWNNSjAvNzZOYThkZjIydXN4L3VXK3lS?=
 =?utf-8?B?NkxSaXUwcTVnTmJSZGNxalJSd0t2R0VMQ2RuOU01YWVteHhnSWZpNUsvWmhZ?=
 =?utf-8?B?ZU1TOG03NHBsYjdDRENYelBucU9rZEdlU1dSWFNMWXB3SUQyTjF4bnM1Ykp2?=
 =?utf-8?B?Y0RGTG9uQzRqTXFtbGFyYjFmVzVrUTQrNXh5SkgzZS9PdHBUc01FSngrWnY0?=
 =?utf-8?B?RlRQdU9qcVYwTTFZK29Ja3h6b2QzQWR6TkRYZU5YUEl0aVJtSHZ4SStqQXdB?=
 =?utf-8?B?VTJXSlRkYkJtSmZ2c1dra1dqQ1hqVjBPdFRQZGVIR282MWx0em1NTVlFVGdM?=
 =?utf-8?B?TU51eERydlUraC9HZGFEMzdTNVpNQWhXU09qNmM3WWFzbXd0cTBVT1hMTU9M?=
 =?utf-8?B?aGVWdUJxaTkvV25xR2VEVGE5SllyTkdrdXZwVWhDMlphR3J4eHhpbGNYaTRk?=
 =?utf-8?B?M1gyUHVObnVPZFZVMkRXWTdZQzJ6RW54R0pBcSs1TEZFSGozay9aZ3VJcVJM?=
 =?utf-8?B?NCtQUmxaT3VWdW55bGZhUXM5aHMyYy81K2ZXbExoUkxqUVY1WmVuaHhrbnFn?=
 =?utf-8?B?b2lLR09IMTBOc25PVUhrekk1bzBJSHQzbkI3b3FVWm1uSExnRUY5Q25vYmpJ?=
 =?utf-8?Q?fvIyczFoZWmdq?=
x-microsoft-antispam-prvs: <VI1PR04MB2078783FD926E8E9611CAECFF2480@VI1PR04MB2078.eurprd04.prod.outlook.com>
x-forefront-prvs: 09730BD177
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(346002)(376002)(366004)(199004)(189003)(2906002)(316002)(486006)(6116002)(476003)(36756003)(3846002)(14454004)(478600001)(97736004)(446003)(93886005)(11346002)(53936002)(7416002)(66066001)(6512007)(229853002)(71190400001)(71200400001)(6486002)(6246003)(86362001)(6436002)(2616005)(8676002)(5660300002)(68736007)(4744005)(81156014)(81166006)(54906003)(31686004)(7736002)(31696002)(106356001)(305945005)(105586002)(110136005)(256004)(76176011)(186003)(386003)(8936002)(52116002)(102836004)(6346003)(26005)(99286004)(4326008)(6506007)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR04MB2078;H:VI1PR04MB5629.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kiXRLqAkhd0eetcZZDhpEihPRCbNH4I8iURx1Q9AdjIksSMW1/CGjXGtxAgA0wG/Ci26VXb70WiCqlvnkixVRLumGSIz+OVC7myS5Aby5J8BHKQHUVGPnf1OTrylPQcq/b1U3GVvi2NL6f1rxfjvvWsSQ2JGSnLXNjAsRAgAKpa2XwUWkeD4zohMuRq9cYM6GS4dvVVPXTs9lwcUMtB8Rj6/nVSVMKMr5jMoffEUDiMJkMWtMGVmNLucrSU0l3F5bAVuykXzRJxjmvbfW2D0ojdtXM1f21u8SZ64kOXpvPuQwbUczOJ7cGvj7iuGN8akvbVhuOhXcJ5OedPB4JPnaM+Eafb/HL+C3RykA6u0ryPkurNxBqOmiXztPPv3y5jJu7tm3jIBn4qGkMUfIOWLrskIcE9A0pMP7gnL+AAWCC4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1D984D7E82381744BDA3C59B51912628@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbf17409-67c8-4769-802d-08d6a63f33fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2019 16:32:50.8011
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB2078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpMZSAwOC8wMy8yMDE5IMOgIDExOjI2LCBHcmVnIEtIIGEgw6ljcml0wqA6DQo+IE9uIFRodSwg
RmViIDIxLCAyMDE5IGF0IDAxOjI1OjIzUE0gKzAxMDAsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToN
Cj4+IE9uIFRodSwgRmViIDIxLCAyMDE5IGF0IDEyOjUyOjMwUE0gKzAxMDAsIEdyZWcgS0ggd3Jv
dGU6DQo+Pj4gSSB3b3VsZCwgYnV0IEkgZG8gbm90IHNlZSB0aGlzIHBhdGNoIGluIExpbnVzJ3Mg
dHJlZSB5ZXQgOikNCj4+IFlvdSB3aWxsIHNvb24gOikNCj4gSSBzZWUgaXQgbm93LCBzbyBpdCdz
IG5vdyBxdWV1ZWQgdXAsIHRoYW5rcy4NCj4NCj4gZ3JlZyBrLWgNClRoYW5rcyBncmVnICENCg==
