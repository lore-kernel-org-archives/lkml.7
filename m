Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF18AC10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B294205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 17:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="Hmty6jLv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbfCRRAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 13:00:30 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:62499 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726626AbfCRRA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 13:00:29 -0400
Received: from [85.158.142.194] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 66/94-05904-AAECF8C5; Mon, 18 Mar 2019 17:00:26 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCJsWRWlGSWpSXmKPExsWSoc9oorvqXH+
  MwYZzLBarPz5mtLi8aw6bA5PHzll32T0+b5ILYIpizcxLyq9IYM24MKW24CxTxZ7mDywNjCeY
  uhi5OFgE1jNL7H64kQXEERKYwCSx/vgSdgjnPqPE3wOzgDKcHGwChhLz3rxnBLFFBNQklh/9w
  wpiMws4Stze+5YJxBYWiJZonriIBaImRuLY5EYo20pi15pZ7CA2i4CqxI0p08Dm8ArESjy7cA
  TMFhIoklgz/yRzFyMHB6eArcSHFgWQMKOArMSXxtXMEKvEJW49mQ+2SkJAQGLJnvPMELaoxMv
  H/1gh6uMl2ve/ZYeI60icvf6EEcJWklh2YxYrhC0rcWl+N1TcV2LVhy1sIP9KCNxilJh17zvU
  UC2JB9/OQzXkSHRsvQHVICNx+cRCJoiGO6wSLTNOsUE8kCzxYe5ZqM1yEqt6H7JAFF1glvjb0
  cIC8hmzgKbE+l36EN8oSkzpfsg+gVFjFpLnZiFUzUJSNQscXIISJ2c+YVnAyLKK0SKpKDM9oy
  Q3MTNH19DAQNfQ0FjXVNfUWC+xSjdJL7VUNzk1r6QoESipl1herFdcmZuck6KXl1qyiRGYalI
  KWU13ML5tTz/EKMnBpCTKm3qiP0aILyk/pTIjsTgjvqg0J7X4EKMMB4eSBG/GWaCcYFFqempF
  WmYOMOnBpCU4eJREePecAUrzFhck5hZnpkOkTjFachxY9HAuM8fbg8+B5IKbv+YxC7Hk5eelS
  onz/gCZJwDSkFGaBzcOlpgvMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmXQYyhSczrwRu6y
  ugg5iADlo3D+ygkkSElFQDo8Mkna62HSrfoqcd4e4on83jdNNMo7KHOy8v/MVLC/dnb5+8Z2y
  w6ZK+/Oj6qYakIIZ7y17PvN+9PTy/gVGopXuC0eyf3z/lactbamyIi/R6unVZK9uqj/IPc9by
  h5Scm3xWPifc88+Mdy02j5uCj6+z2fdcI6hwcrLSO2bOsoIVlWE1L2+9VGIpzkg01GIuKk4EA
  AaJJ+HHAwAA
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-28.tower-239.messagelabs.com!1552928425!2738237!1
X-Originating-IP: [104.47.1.52]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16320 invoked from network); 18 Mar 2019 17:00:26 -0000
Received: from mail-ve1eur01lp2052.outbound.protection.outlook.com (HELO EUR01-VE1-obe.outbound.protection.outlook.com) (104.47.1.52)
  by server-28.tower-239.messagelabs.com with AES256-SHA256 encrypted SMTP; 18 Mar 2019 17:00:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Hkdcg7QAxHw984ftqDtqW3MpOdwBk9K+Lag+cyTbXc=;
 b=Hmty6jLvGkiNKaLE7D9LhVTVlUasVvVPTfGzU5cJxfLgg++jwXO7QeSUmtJG9Idgd5+VxExfjZwHCM31fMHTxAiybnGanq2JZc5HO0FdJJ7q0KolguGyp9bpKguMXRvxYoJbdU8Ided6fIjmOsDFvZQT7oigDJ5ryxsT2yGMDeg=
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM (20.177.62.92) by
 VI1PR10MB1744.EURPRD10.PROD.OUTLOOK.COM (10.165.194.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Mon, 18 Mar 2019 17:00:24 +0000
Received: from VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7]) by VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e426:c8bc:d222:5cd7%4]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 17:00:24 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] regulator: core: fix error path for
 regulator_set_voltage_unlocked
Thread-Topic: [PATCH v2] regulator: core: fix error path for
 regulator_set_voltage_unlocked
Thread-Index: AQHU3agQcne47P81WEuv3uS4Pt0cWKYRl2aAgAAE8+A=
Date:   Mon, 18 Mar 2019 17:00:24 +0000
Message-ID: <VI1PR10MB23524E29BC6C1000C5CF1A27FE470@VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM>
References: <20190318163132.1BB633FBA2@swsrvapps-01.diasemi.com>
 <c3a02cd7-3cd3-b1a5-45fb-278c3391336e@gmail.com>
In-Reply-To: <c3a02cd7-3cd3-b1a5-45fb-278c3391336e@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d766f614-ad51-4448-29a1-08d6abc336d8
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:VI1PR10MB1744;
x-ms-traffictypediagnostic: VI1PR10MB1744:
x-microsoft-antispam-prvs: <VI1PR10MB17441FBA1A1F34C1D22C9561F5470@VI1PR10MB1744.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39850400004)(396003)(346002)(199004)(189003)(81166006)(52536014)(81156014)(3846002)(97736004)(1411001)(86362001)(14454004)(6116002)(7736002)(305945005)(6436002)(186003)(11346002)(446003)(99286004)(9686003)(55016002)(476003)(7696005)(2906002)(486006)(6246003)(6916009)(33656002)(74316002)(102836004)(53546011)(6506007)(26005)(76176011)(105586002)(14444005)(256004)(25786009)(8936002)(106356001)(316002)(68736007)(5660300002)(4326008)(71200400001)(71190400001)(8676002)(53936002)(229853002)(66066001)(558084003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR10MB1744;H:VI1PR10MB2352.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P1Ml8+DOCZNbCyIUl6KOPy9uTCrNESp4qb73bYO39GwEqnmNvWtMrPkK3ZvKK/Kme88X9Kb1F6+gadvmsVWx9+w1mhWNWJJ1oZPkqri9xVmmR7tkRv9v6wvpUPSKr5+CJFRso+SgUGLBiwpKroZmZaWHEFZGjxUcl9VUyGsuCLqPMEK2U8j0sQIqfl2VNaN83+5DMnh7xCwHjoNvZXNi6t0CQM4vnTJ6bGka+80clCIljpTIAgLP7RdUdNgAU7j/zuchpGY42XN87/SL3uxk38RKbbIJ3jBh0+ugXe+Qw2hPRGyVwHbGEVWRtTuWHsoI5Gtk0A1IzV9MSHrPJT3Uzu7WkacbaTkyIYQm+H8Eyi0dr7h07u8KAJnt4tEmmounKv95phLgey1ATa6Ym+h6495VKfQ4Jc4UPSF6aR8hVIs=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d766f614-ad51-4448-29a1-08d6abc336d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 17:00:24.5331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB1744
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAxOCBNYXJjaCAyMDE5IDE2OjQxLCBEbWl0cnkgT3NpcGVua28gd3JvdGU6DQoNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2Ml0gcmVndWxhdG9yOiBjb3JlOiBmaXggZXJyb3IgcGF0aCBmb3IN
Cj4gcmVndWxhdG9yX3NldF92b2x0YWdlX3VubG9ja2VkDQoNClsuLi5dDQoNCj4gUmV2aWV3ZWQt
Ynk6IERtaXRyeSBPc2lwZW5rbyA8ZGlnZXR4QGdtYWlsLmNvbT4NCg0KVGhhbmtzIERtaXRyeS4N
ClJlZ2FyZHMsDQpTdGV2ZQ0K
