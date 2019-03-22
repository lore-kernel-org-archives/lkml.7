Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E1C10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0F8218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="fQpDE2K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbfCVP2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:28:41 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.114]:33863 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726767AbfCVP2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:28:40 -0400
Received: from [85.158.142.201] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-b.eu-central-1.aws.symcld.net id 82/D3-05904-42FF49C5; Fri, 22 Mar 2019 15:28:36 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUhTYRTHfe6b13B1m4qnkRLDqNS7XCWs6EM
  glB+KpD4UUdndvG2LOXV3khqUGTFfqNRW2soyKSktFsPKysqXXsiwJDNNUZHEzDTLRhKkdu/u
  Kvv25/z+5znn/3BoXPmQUtF8lp23WTmLmppHmFZS69ioWefuOO/UIp3jS3WgruP+BUp3+9MXT
  Pes9i2lO/lq0wYy8eKNQ4nDl91E4ndPZBK+izRb9WlZ+0hTx3E3nt6KZXXOdGC5qAwrRPNogn
  HjUDrwjSxEQbSSKcHgmydBAkqmD0F/6ZQPUIwWLo5NIEmHMmkw8+oMLplw5juC9+1eHwhhtkF
  vXp3YQIum7eC4Ey77V8HMj6eBkiaYpdB7agqXtILZAx8a+/yDc2BiZICQdBCTADdHvL46YiLA
  e7TW58eZcOgZuoRJGhgGrjS8xmUdBp8+zPj9yeB4PB4o12OhrWsIyVoN1d0uUtYR8OZSkb++B
  RxnW0gpCzA9CLx11wgZRMNY+4S/wQJN3uf+hsWQ11Tub+gn4Vl5AyUnMMDXijb/5EioOTFIyK
  Z2HK7WTmJyhFiofDBJyToGqi9/xovRctecdK45Ntccm8v3YwvhxbkhohIRNUint5mNJnsqZ7a
  w2rg4Vqtdzcaz8as1XA6r1/CZrIG32m2cCDXcQUEjZKcaLCkaK2/3IPGUUjLI+Ho07jA2o0U0
  pg5TxE46dyvn69NSsk2cYEq2ZVp4oRktpmk1KMZ+iWyhjTfyWfvNFvEe/2Cgg9Whii4JK4R0L
  lUwG2XUili6sWqwAlcS1jQrrwpXOKdFEyOZTJnWv0/8ueo3KEIVokABAQHK4HTelmq2/89HUT
  iN1CGKCumVYLPV/nfSqLgEJi6hd56WlrBz/5AqF0XR7wx7j5dUatw7HbktRRmdedcKHm4M0Ja
  XDa831MSvDTnUXtExfGPvAtX1rqgdT0wv6n8SReeP1HU+LzgwUvWoeCsEJ38cj47JaTbur0nv
  bpwurmOXZd9LjuwOpdaQ044qISk2KeEY71QtSXg6C6OelM35pIW82zB16/D2l/kr1IRg4rTRu
  E3gfgP82Q670AMAAA==
X-Env-Sender: stwiss.opensource@diasemi.com
X-Msg-Ref: server-7.tower-246.messagelabs.com!1553268515!3375656!1
X-Originating-IP: [104.47.6.58]
X-SYMC-ESS-Client-Auth: mailfrom-relay-check=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26577 invoked from network); 22 Mar 2019 15:28:36 -0000
Received: from mail-ve1eur02lp2058.outbound.protection.outlook.com (HELO EUR02-VE1-obe.outbound.protection.outlook.com) (104.47.6.58)
  by server-7.tower-246.messagelabs.com with AES256-SHA256 encrypted SMTP; 22 Mar 2019 15:28:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com; s=selector1-diasemi-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kSnmIwKpG9I9geE1U/2oPY1qNHSkOSrfv2/NVrUyzd8=;
 b=fQpDE2K1DJE+J9DMblKv4sgKtbKSca9efReQ1lCX2euTOIfUOxMNt0OduttOhFWwMC0DHuM6WgWyLrweS7WH5U+QK6ERSAbu/S+5EeZnI0K0H1px8aKC2oA61Y3VTMN9ncPg/1ExJIoyGcKSHXynC8ImeGJpkSCywX/w2Vs6MrM=
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (20.177.121.154) by
 DB7PR10MB2025.EURPRD10.PROD.OUTLOOK.COM (52.134.102.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Fri, 22 Mar 2019 15:28:33 +0000
Received: from DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf]) by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f8d2:d5b6:cca:1bcf%5]) with mapi id 15.20.1730.017; Fri, 22 Mar 2019
 15:28:33 +0000
From:   Steve Twiss <stwiss.opensource@diasemi.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH 2/2] rtc: da9063: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Thread-Topic: [PATCH 2/2] rtc: da9063: switch to
 rtc_time64_to_tm/rtc_tm_to_time64
Thread-Index: AQHU388zAHbhZUdtHEOPL3sVK9HfsqYXx+aQ
Date:   Fri, 22 Mar 2019 15:28:33 +0000
Message-ID: <DB7PR10MB234899881F4D933C2839A91FFE430@DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM>
References: <20190321101557.26857-1-alexandre.belloni@bootlin.com>
 <20190321101557.26857-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20190321101557.26857-2-alexandre.belloni@bootlin.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [193.240.73.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84085cf7-eda6-4cdd-818d-08d6aedb0ba7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:DB7PR10MB2025;
x-ms-traffictypediagnostic: DB7PR10MB2025:
x-microsoft-antispam-prvs: <DB7PR10MB2025B096928136216552F246F5430@DB7PR10MB2025.EURPRD10.PROD.OUTLOOK.COM>
x-forefront-prvs: 09840A4839
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39850400004)(376002)(136003)(366004)(346002)(199004)(189003)(2906002)(8936002)(74316002)(305945005)(7736002)(66066001)(256004)(8676002)(6116002)(186003)(71200400001)(6246003)(316002)(81166006)(81156014)(97736004)(99286004)(110136005)(54906003)(53936002)(3846002)(68736007)(7696005)(106356001)(2501003)(105586002)(4326008)(76176011)(86362001)(558084003)(55016002)(9686003)(71190400001)(102836004)(6436002)(476003)(52536014)(446003)(478600001)(11346002)(6506007)(33656002)(53546011)(486006)(25786009)(229853002)(26005)(5660300002)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR10MB2025;H:DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:0;MX:1;
received-spf: None (protection.outlook.com: diasemi.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vA2tQwNUDOWMEIlIBovLkEKAHabukKJhFBwS58eZerimIbLL7HaRnmwxew4oyYYUjwbpUuOURsWPYY+ggJjfPXra5NOEENY1WlA+GtLY6Kn3NwRykbnFfpo6OG+lR0D5IkkXVTO50vplT0wYG/f8WUC5hEXFjn04QCcnYd4mKRJw7F8ciUYDo1f4jU1hnJc7HdiCop/dU+aMi7pwoHz2uhlTTO0O8KwZMbtG796ubDWxFmkb45SYIN+64TxZM7/slMCrkHR9sZTByyfy7lQ003vFP9XV7xwc2m6a9yC/jvfR2h36wnaJVLgh6qk/fONNpva3f+HLC3jTrKqykoTQ9exO+mlkaUuz8WMKMti8BgeX7wb31zhl3texTCWGg0rTNpLtRIXI/vlTsMaS6Wsy6/7ApRHl70wbD7/HJdmPTV8=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84085cf7-eda6-4cdd-818d-08d6aedb0ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2019 15:28:33.4080
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2025
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 March 2019 10:16, Alexandre Belloni wrote:

> Subject: [PATCH 2/2] rtc: da9063: switch to rtc_time64_to_tm/rtc_tm_to_ti=
me64
>=20
> Call the 64bit versions of rtc_tm time conversion now that the range is
> enforced by the core.
>=20

Thanks Alexandre,

Acked-by: Steve Twiss <stwiss.opensource@diasemi.com>

Regards,
Steve
