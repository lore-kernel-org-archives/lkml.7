Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4B7C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EECD2183E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="Ytxo+6nr";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="NRA4q1eI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbfCTP7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:59:01 -0400
Received: from sessmg22.ericsson.net ([193.180.251.58]:54927 "EHLO
        sessmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:59:01 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 11:58:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553096636; x=1555688636;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=lOQDekfOZLfcAxHlXUgX2i/ch4ZMXloCb7oAYU+cBEE=;
        b=Ytxo+6nrVp6KXypyhuuoCVj58gGB3JLpEAuB2O2UfUvOkyc0X4JkfFYMizYWQ/or
        qHovD8dLY4ln1v4nCZjJ6Q4HnBgKmTI5QUkkd0BEFxcutBH9m7kAhIFXe6tZ4LJX
        i2OyHzzuQPCPb06SWHPsD3/5ARIe3qccBccsI2zkslM=;
X-AuditID: c1b4fb3a-5c9c29e00000672c-7b-5c925fbcdd1d
Received: from ESESBMB504.ericsson.se (Unknown_Domain [153.88.183.117])
        by sessmg22.ericsson.net (Symantec Mail Security) with SMTP id 75.A9.26412.CBF529C5; Wed, 20 Mar 2019 16:43:56 +0100 (CET)
Received: from ESESSMB501.ericsson.se (153.88.183.162) by
 ESESBMB504.ericsson.se (153.88.183.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 20 Mar 2019 16:43:53 +0100
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESSMB501.ericsson.se (153.88.183.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Wed, 20 Mar 2019 16:43:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOQDekfOZLfcAxHlXUgX2i/ch4ZMXloCb7oAYU+cBEE=;
 b=NRA4q1eImoJxmNUWglK4vHL8/qEan8QyEfDkdAcXd3wW8FO1VUBQ8VSSdO9ybAtzPPiu5V+Dktl/prDzYtmXH6EdiNkHmZJ4c1dhNQiV5N1On5TaG23SUdeXn9YIn9uvD8Q4+LUlnuyTHpP/mVg/Ts8ge2WnBmZCvSffFK7S1hA=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB2116.namprd15.prod.outlook.com (52.132.22.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 15:43:49 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 15:43:49 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     syzbot <syzbot+9d4c12bfd45a58738d0a@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "dsahern@gmail.com" <dsahern@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "pablo@netfilter.org" <pablo@netfilter.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>
Subject: RE: general protection fault in dst_dev_put (2)
Thread-Topic: general protection fault in dst_dev_put (2)
Thread-Index: AQHU3nic9t4Vh4CtCkiDKEb8gw78haYUp/aQ
Date:   Wed, 20 Mar 2019 15:43:49 +0000
Message-ID: <BL0PR1501MB200344EF36F7E6EFCE435F4E9A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <000000000000352b7e057cc0a13f@google.com>
 <00000000000060a659058475c57e@google.com>
In-Reply-To: <00000000000060a659058475c57e@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 161e5963-94f4-4642-c9e3-08d6ad4ad8b8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2116;
x-ms-traffictypediagnostic: BL0PR1501MB2116:
x-ms-exchange-purlcount: 7
x-microsoft-antispam-prvs: <BL0PR1501MB2116148BA5532206E26210A69A410@BL0PR1501MB2116.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(376002)(39860400002)(136003)(396003)(13464003)(199004)(189003)(256004)(55016002)(81166006)(97736004)(74316002)(305945005)(2501003)(5660300002)(52536014)(2906002)(86362001)(81156014)(7736002)(2201001)(8676002)(33656002)(71190400001)(6116002)(44832011)(966005)(106356001)(53936002)(76176011)(11346002)(476003)(229853002)(25786009)(7696005)(66066001)(6246003)(105586002)(3846002)(486006)(102836004)(68736007)(316002)(71200400001)(446003)(9686003)(6436002)(8936002)(6506007)(478600001)(6306002)(110136005)(99286004)(53546011)(26005)(186003)(14454004)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB2116;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6qZ6FVEWAeWplNDsDTeEadYYjY/4qO+/Dh84hBrGFu+CLhWT0olj8RTlJYsXEKNaCe5gHZWwh6CpimkX7A65EVEZ6FLvaI0ipxwsa05lLsrBgWGLKaWFvqTCX3O/ijrPX6dQ4yA42lLx5XK/0p5Gh6g7w1UjPkaJXZVCfVprdiqHhzNJhAC3dDCcMLsZqE8Un9ANx5PRWF+Sf9S90RIZaD3YY2cOYMmd4TWiHLXT/aJi7rlx1Joo0HhFoiATaJ4uTkBnPfcva8vwd9JiD04EB4k62IGE8oowrVuS2Tx26oZk/i4Pm5bcfBTM0NOKA/KMc6GunTBX913aHsnnZ2mwaSP1LUZGuc2xU02yAGZwmPY/rl8xvo3rKrxyCYYhjDc3Brp3vx+kikTndVl4Gn0HyuTadEIdPFEPYxQdZsRKUW4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 161e5963-94f4-4642-c9e3-08d6ad4ad8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 15:43:49.3517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2116
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0gUURiGOTOz66y5eFxX/dIS3CgyvCUhU5TYj2oQJCkkDUk3ndRSN3ZM
        KwoNdysVwVuGoimpRVtp2ESmdtHENNMtSy1D8rKtSoqR0c0LOc4G/XvO837f4T1waFL1TOZO
        J6WmcfpUbbJGbk+VRT485dsaUxQdUHPBkakwGyjmweMZinnbXCFnOqtdmaszAyQzXjdKMO+F
        SpIRzMeZiaEhMkTBCrc+EOyj8hE7trWwW862VM8T7OxCF8GWzW5i5xs92QbhARFOH7bfGc8l
        J6Vzev/gWPvEN8LBkyXq05+6+2VZ6LVzLlLQgLeBIBipXGRPq3AHgtGefCQdfiAY6GixJbUE
        fHtoWT1QuICEposGUkquEHBpLsu2Y0XQ31uJxJvleDNMl15eDdS4gIL6qUGZGDhjBgrraleH
        1Hg7PP9ioCQOhLx60ypTeCNMtAvyXETTShwLv2r2ilqFtVDSayBErcBB8DknQtQIu8LPl3cI
        kUnsBsOWKkJ6HIbaVjMpsQtMTyzLxFWEo6Dnc5SkveB271Mk8Xror8qzcRiUdo/IxfaAPyLo
        HF+ykwIfsCx22YbcYbG+mJJYB3O9fTa/DmrMP0lpeVkGS39yZFJ/Dm7eNdqGPMGUP0YVIJ/y
        /3qXr/QjsTc0NPtL2gtK8sbsRFZiJ+gus1DViDIhF57j+ZSEwEA/Tp8Ux/O6VL9ULq0Rrfyr
        NmFhRxNqm9zdjjCNNA7KKbYoWiXTpvNnUtoR0KRGrYzUrChlvPbMWU6vi9GfSub4duRBUxo3
        5aLKKVqFE7Rp3AmOO8np/6UErXDPQkFt6Qc8Aoat57SHfFKqbzz7rlNm38pcawrdMKnRMI6D
        mVZT7pFjs6qvx4oMb8Kv3Q/TGZ3UjS7WfULoxgZjIJE5WRzZ9sLX+v584dH9EbuC3c42O6jZ
        griKNQpzV6Zl9+snvrsy7LKjyv3esTXX6yaZznver/b0FWZMj/9OMcaFaCg+Ubt1C6nntX8B
        b+1geVMDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBvbmUgcG9pbnRzIHRvIGEgYnVnIHRoYXQgd2FzIGZpeGVkIGluIGNvbW1pdCBkYzQ1MDFm
ZjI4NzUgKCJ0aXBjOiBmaXggYSBkb3VibGUgZnJlZSBpbiB0aXBjX2VuYWJsZV9iZWFyZXIoKSIp
LiANClRoYXQgY29tbWl0IHdhcyBhcHBsaWVkIHRvIDQuMjAsIGJ1dCBpcyBub3QgcHJlc2VudCBp
biA0LjE2LCB3aGljaCBjYXVzZWQgdGhpcyBkdW1wLiANClRvIGdldCBmdXJ0aGVyIHdpdGggdGhp
cyBJIG5lZWQgYSBkdW1wIG9mIHRoZSBhY3R1YWwgY3Jhc2ggaW4gNC4yMCBvciA1LjAuDQpNYXli
ZSB3ZSBhcmUgbG9va2luZyBhdCB0d28gZGlmZmVyZW50IHByb2JsZW1zIGhlcmU/DQoNCi8vL2pv
bg0KDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBuZXRkZXYtb3du
ZXJAdmdlci5rZXJuZWwub3JnIDxuZXRkZXYtb3duZXJAdmdlci5rZXJuZWwub3JnPg0KPiBPbiBC
ZWhhbGYgT2Ygc3l6Ym90DQo+IFNlbnQ6IDE5LU1hci0xOSAxODoyNA0KPiBUbzogZGF2ZW1AZGF2
ZW1sb2Z0Lm5ldDsgZHNhaGVybkBnbWFpbC5jb207IEpvbiBNYWxveQ0KPiA8am9uLm1hbG95QGVy
aWNzc29uLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IG5ldGRldkB2Z2Vy
Lmtlcm5lbC5vcmc7IHBhYmxvQG5ldGZpbHRlci5vcmc7IHN5emthbGxlci0NCj4gYnVnc0Bnb29n
bGVncm91cHMuY29tOyB0aXBjLWRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0Ow0KPiB5
aW5nLnh1ZUB3aW5kcml2ZXIuY29tDQo+IFN1YmplY3Q6IFJlOiBnZW5lcmFsIHByb3RlY3Rpb24g
ZmF1bHQgaW4gZHN0X2Rldl9wdXQgKDIpDQo+IA0KPiBzeXpib3QgaGFzIGJpc2VjdGVkIHRoaXMg
YnVnIHRvOg0KPiANCj4gY29tbWl0IDUyZGZhZTVjODVhNGMxMDc4ZTlmMWQ1ZTg5NDdkNGEyNWY3
M2RkODENCj4gQXV0aG9yOiBKb24gTWFsb3kgPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+DQo+IERh
dGU6ICAgVGh1IE1hciAyMiAxOTo0Mjo1MiAyMDE4ICswMDAwDQo+IA0KPiAgICAgIHRpcGM6IG9i
dGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNlIGJ5IGRlZmF1bHQNCj4gDQo+IGJpc2Vj
dGlvbiBsb2c6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2Jpc2VjdC50eHQ/eD0x
NjMxZmMyYjIwMDAwMA0KPiBzdGFydCBjb21taXQ6ICAgNTJkZmFlNWMgdGlwYzogb2J0YWluIG5v
ZGUgaWRlbnRpdHkgZnJvbSBpbnRlcmZhY2UgYnkgZGVmYS4uDQo+IGdpdCB0cmVlOiAgICAgICB1
cHN0cmVhbQ0KPiBmaW5hbCBjcmFzaDogICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20v
eC9yZXBvcnQudHh0P3g9MTUzMWZjMmIyMDAwMDANCj4gY29uc29sZSBvdXRwdXQ6IGh0dHBzOi8v
c3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvbG9nLnR4dD94PTExMzFmYzJiMjAwMDAwDQo+IGtlcm5l
bCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94Ly5jb25maWc/eD04ZjAw
ODAxZDdiN2M0ZmU2DQo+IGRhc2hib2FyZCBsaW5rOg0KPiBodHRwczovL3N5emthbGxlci5hcHBz
cG90LmNvbS9idWc/ZXh0aWQ9OWQ0YzEyYmZkNDVhNTg3MzhkMGENCj4gc3l6IHJlcHJvOiAgICAg
IGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVwcm8uc3l6P3g9MTcyNTQ4NzhjMDAw
MDANCj4gQyByZXByb2R1Y2VyOiAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvcmVw
cm8uYz94PTE3MWNhNWRmNDAwMDAwDQo+IA0KPiBSZXBvcnRlZC1ieTogc3l6Ym90KzlkNGMxMmJm
ZDQ1YTU4NzM4ZDBhQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20NCj4gRml4ZXM6IDUyZGZhZTVj
ICgidGlwYzogb2J0YWluIG5vZGUgaWRlbnRpdHkgZnJvbSBpbnRlcmZhY2UgYnkgZGVmYXVsdCIp
DQo=
