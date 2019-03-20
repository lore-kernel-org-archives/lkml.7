Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74D3C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FA42184D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 15:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="fY2E9jRR";
	dkim=pass (1024-bit key) header.d=ericsson.com header.i=@ericsson.com header.b="kZu4x6Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbfCTP7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 11:59:06 -0400
Received: from sessmg22.ericsson.net ([193.180.251.58]:54927 "EHLO
        sessmg22.ericsson.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfCTP7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 11:59:05 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 11:58:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=ericsson.com; s=mailgw201801; c=relaxed/relaxed;
        q=dns/txt; i=@ericsson.com; t=1553097543; x=1555689543;
        h=From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uR/B/lhQmsF3KU8utbx0liY+5bGiF+DeRehdpgWESdY=;
        b=fY2E9jRR1PWmrYnK9pEyAsg/a2bopWUk5wH6x6SxgF2ejh7Yakcnjwd9LSY5xRHg
        S4Qb9CsmncH8qIZzJJTbK8vSb0fsfcx4+wJsZas6r8u1X2XbS6WJg+8sPLM/hC4T
        xlDh3qGJLf98XxE76KmeHY1IkDt89SAtF5Q6QEf0kqs=;
X-AuditID: c1b4fb3a-14fff7000000672c-b4-5c9263474a29
Received: from ESESSMB505.ericsson.se (Unknown_Domain [153.88.183.123])
        by sessmg22.ericsson.net (Symantec Mail Security) with SMTP id E8.BC.26412.743629C5; Wed, 20 Mar 2019 16:59:03 +0100 (CET)
Received: from ESESBMB503.ericsson.se (153.88.183.170) by
 ESESSMB505.ericsson.se (153.88.183.166) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 20 Mar 2019 16:59:02 +0100
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (153.88.183.157)
 by ESESBMB503.ericsson.se (153.88.183.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5 via Frontend Transport; Wed, 20 Mar 2019 16:59:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uR/B/lhQmsF3KU8utbx0liY+5bGiF+DeRehdpgWESdY=;
 b=kZu4x6WaVlIE17olhEKZnNVe9oCAWiif1+D2EEteBeEIpyyTqrKBDmJ/iaZdwxWDD8dXl6UwdFcz7RjpY/xpHS/EwUbHw81u4Lnzb200OjICKYEl+8+pgfJ84Y9v/ppn+eJlA+/42Hja0DyJ+oVZVyn2fWh1kBi4WkqI0cBlFMo=
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com (52.132.21.33) by
 BL0PR1501MB1972.namprd15.prod.outlook.com (52.132.21.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.14; Wed, 20 Mar 2019 15:58:40 +0000
Received: from BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047]) by BL0PR1501MB2003.namprd15.prod.outlook.com
 ([fe80::54bc:4aab:4230:3047%4]) with mapi id 15.20.1730.013; Wed, 20 Mar 2019
 15:58:40 +0000
From:   Jon Maloy <jon.maloy@ericsson.com>
To:     syzbot <syzbot+a25307ad099309f1c2b9@syzkaller.appspotmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        "tipc-discussion@lists.sourceforge.net" 
        <tipc-discussion@lists.sourceforge.net>,
        "ying.xue@windriver.com" <ying.xue@windriver.com>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>
Subject: RE: general protection fault in fib6_purge_rt
Thread-Topic: general protection fault in fib6_purge_rt
Thread-Index: AQHU3Vwdjz3ygVPNV0SvlVexcwldMqYUrNfQ
Date:   Wed, 20 Mar 2019 15:58:40 +0000
Message-ID: <BL0PR1501MB20039998B662DCC11E2B38D79A410@BL0PR1501MB2003.namprd15.prod.outlook.com>
References: <000000000000dbe73a057cd65da2@google.com>
 <00000000000010f4270584595484@google.com>
In-Reply-To: <00000000000010f4270584595484@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jon.maloy@ericsson.com; 
x-originating-ip: [195.39.71.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6475e1cb-b6ab-48b9-add8-08d6ad4ceb9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB1972;
x-ms-traffictypediagnostic: BL0PR1501MB1972:
x-ms-exchange-purlcount: 7
x-microsoft-antispam-prvs: <BL0PR1501MB1972185844B0F7553F33901D9A410@BL0PR1501MB1972.namprd15.prod.outlook.com>
x-forefront-prvs: 098291215C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(13464003)(199004)(189003)(71190400001)(478600001)(2501003)(97736004)(110136005)(6246003)(25786009)(55016002)(26005)(6306002)(9686003)(186003)(966005)(6436002)(53936002)(316002)(6506007)(3846002)(14454004)(53546011)(6116002)(105586002)(33656002)(66066001)(7696005)(229853002)(102836004)(76176011)(476003)(99286004)(11346002)(106356001)(7736002)(14444005)(256004)(86362001)(486006)(74316002)(2906002)(305945005)(2201001)(81156014)(8936002)(68736007)(8676002)(71200400001)(5660300002)(44832011)(446003)(52536014)(81166006)(99710200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR1501MB1972;H:BL0PR1501MB2003.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ericsson.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Wib76rYgRNC0efCx5Mg5sIMVu2icaObHrSScrgKpWm0WRMuz6C4GZB/5MtzUvq9NOLqG/rW9GUayBOH+wP3TAjFKlsFHZEjNj6jYm5NL4eS4TKETkq8Hnv+63dCa/RZ+mAgkgG4i72JdmLUU1hOA3nPhIK54gd9Shio3HUNCn1j5Uk/cKCo5DcwV/mj9ocslTWGKDEndwFl3zDFPoE9VrR+jmn+2b0kFJzZvu3unFMabWv0+C56KxYlLVLbfAXmIy0I44A+BStE8lTZawdTQ5Yz1uAHG+dieJdnb+1v87sKg/E3ln+7jYJPqsBSBF8QkuctV9U41FC3WJkSdyQJJ3zREVqx4I28HydkctO+OnSQGYK7fb1RuJ/+u+bUi9++3u3PKlVUquGRMlR4762Oyu/03eMcHcClfDzB8gpGR3qQ=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6475e1cb-b6ab-48b9-add8-08d6ad4ceb9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2019 15:58:40.1183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB1972
X-OriginatorOrg: ericsson.com
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRjmO+fbdlyOvubSF7uAg0zDtMTsJCUJkedHQf+6YOTUg9dm7Kio
        YUia2EZhdhHNcpAprRvWvOA1p5Y2bWXltAtlmmYUkWIaprbtLOjf877P8z7v+3x8DK20SHyZ
        ZG0Gr9Nq0tRSOS4/1Hhyc3R8acyWph7CVtoKMfu86KuEfdlcKWUfG73Zpg+DMnbYfI1mzbYU
        dsxup9nZNj3e7cGZb41QXOuFPilXNGSiuBbjDMWZF+akXPl3f27mwXruvrmeOsAcke9M4NOS
        s3hdSGSsPEk/fxufMKqyl6rtVD5656VHHgyQMHg/OY/0SM4oSTcCi7WLEotfCKwTZbRTpSTV
        FPQOJjgJTEposBfUyETVZQoajDewWEwgeHbzGXKOSEkATF0pdhmrSCWGF3O12El4kXAYfTJA
        ObGKbIerTY1uHAq2b7MuDSYb4MeYaKQgsVBS9wOLd2ig/XqBC3s4fBYNF1yziHjD3NM7LkwT
        H3gzXkWJ6QhUt9poEa+GqbEliR4xDv1hsH4+LLb94PZABxLxOhisMrjxfjBMLLpSAnnrCLZs
        k4lEEHQWLLv9feHPvYtYxOkwMNDl3rUWbtjmaHG4WArlj2bcAXiovXvGvWE9mM6N4hIUVPHf
        3RWO+2gSCPebQ8S2H1wyjMoqXE+xCvrKx7ERYRNaLfCCcDwxNDSY1yXHC0K6NljLZzxAjp/V
        aV6IaEKdk1EWRBik9lR84UpjlBJNlpBz3IKAodUqxSG1o6VI0OTk8rr0Y7rMNF6woDUMVvso
        /ihXxShJoiaDT+X5E7zuH0sxHr75aO/z5W/2g4Hthd15MZW32uY7MpOThn/LV4S3vVZFTqsF
        61BUbphnXT9URA9v822pSj2/x5RdmI0v7UobOdW/UhYXFHh6Og9/6kmpefXdELHVv+CobWFi
        TNKwOK6wTg9N1wfYa35e39CTf9ToGZf4dvvSbm3vtbJ9OzZmf5Q+9D9bp8ZCkmbrJlonaP4C
        F9RB8lUDAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBvbmUgaWRlbnRpZmllcyB0aGUgc2FtZSBjdWxwcml0IGFzIHN5emJvdCs5ZDRjMTJiZmQ0
NWE1ODczOGQwYUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tLCBidXQgcG9pbnRzIHRvIGEgZGlm
ZmVyZW50IGJ1Zy4NClRoYXQgYnVnIGhhcyBhbHNvIGJlZW4gZml4ZWQsIGluIGNvbW1pdCBhZGJh
NzViZTBkMjMgICgidGlwYzogZml4IGxvY2tkZXAgd2FybmluZyB3aGVuIHJlaW5pdGlsYWl6aW5n
IHNvY2tldHMiKSwgYXBwbGllZCBpbiA0LjIwIGJ1dCBub3QgcHJlc2VudCBpbiA0LjE2LCAtIHRo
ZSBzb3VyY2Ugb2YgdGhlIGR1bXAuDQpPbmNlIGFnYWluLCBhIGR1bXAgZnJvbSA0LjIwLzUuMCBt
aWdodCBiZSBhIGhlbHAuDQoNCi8vL2pvbg0KDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4gRnJvbTogc3l6Ym90IDxzeXpib3QrYTI1MzA3YWQwOTkzMDlmMWMyYjlAc3l6a2FsbGVy
LmFwcHNwb3RtYWlsLmNvbT4NCj4gU2VudDogMTgtTWFyLTE5IDA4OjI4DQo+IFRvOiBkYXZlbUBk
YXZlbWxvZnQubmV0OyBKb24gTWFsb3kgPGpvbi5tYWxveUBlcmljc3Nvbi5jb20+Ow0KPiBrdXpu
ZXRAbXMyLmluci5hYy5ydTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbmV0ZGV2
QHZnZXIua2VybmVsLm9yZzsgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xlZ3JvdXBzLmNvbTsgdGlwYy0N
Cj4gZGlzY3Vzc2lvbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQ7IHlpbmcueHVlQHdpbmRyaXZlci5j
b207IHlvc2hmdWppQGxpbnV4LQ0KPiBpcHY2Lm9yZw0KPiBTdWJqZWN0OiBSZTogZ2VuZXJhbCBw
cm90ZWN0aW9uIGZhdWx0IGluIGZpYjZfcHVyZ2VfcnQNCj4gDQo+IHN5emJvdCBoYXMgYmlzZWN0
ZWQgdGhpcyBidWcgdG86DQo+IA0KPiBjb21taXQgNTJkZmFlNWM4NWE0YzEwNzhlOWYxZDVlODk0
N2Q0YTI1ZjczZGQ4MQ0KPiBBdXRob3I6IEpvbiBNYWxveSA8am9uLm1hbG95QGVyaWNzc29uLmNv
bT4NCj4gRGF0ZTogICBUaHUgTWFyIDIyIDE5OjQyOjUyIDIwMTggKzAwMDANCj4gDQo+ICAgICAg
dGlwYzogb2J0YWluIG5vZGUgaWRlbnRpdHkgZnJvbSBpbnRlcmZhY2UgYnkgZGVmYXVsdA0KPiAN
Cj4gYmlzZWN0aW9uIGxvZzogIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL3gvYmlzZWN0
LnR4dD94PTExMTZkMmEzMjAwMDAwDQo+IHN0YXJ0IGNvbW1pdDogICA1MmRmYWU1YyB0aXBjOiBv
YnRhaW4gbm9kZSBpZGVudGl0eSBmcm9tIGludGVyZmFjZSBieSBkZWZhLi4NCj4gZ2l0IHRyZWU6
ICAgICAgIGxpbnV4LW5leHQNCj4gZmluYWwgY3Jhc2g6ICAgIGh0dHBzOi8vc3l6a2FsbGVyLmFw
cHNwb3QuY29tL3gvcmVwb3J0LnR4dD94PTEzMTZkMmEzMjAwMDAwDQo+IGNvbnNvbGUgb3V0cHV0
OiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L2xvZy50eHQ/eD0xNTE2ZDJhMzIwMDAw
MA0KPiBrZXJuZWwgY29uZmlnOiAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC8uY29u
ZmlnP3g9YzhiNjA3M2Q5OTJlODIxNw0KPiBkYXNoYm9hcmQgbGluazoNCj4gaHR0cHM6Ly9zeXpr
YWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPWEyNTMwN2FkMDk5MzA5ZjFjMmI5DQo+IHN5eiBy
ZXBybzogICAgICBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS94L3JlcHJvLnN5ej94PTE2
YjJjNTZmMjAwMDAwDQo+IEMgcmVwcm9kdWNlcjogICBodHRwczovL3N5emthbGxlci5hcHBzcG90
LmNvbS94L3JlcHJvLmM/eD0xM2I4ODkwYjIwMDAwMA0KPiANCj4gUmVwb3J0ZWQtYnk6IHN5emJv
dCthMjUzMDdhZDA5OTMwOWYxYzJiOUBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tDQo+IEZpeGVz
OiA1MmRmYWU1YyAoInRpcGM6IG9idGFpbiBub2RlIGlkZW50aXR5IGZyb20gaW50ZXJmYWNlIGJ5
IGRlZmF1bHQiKQ0K
