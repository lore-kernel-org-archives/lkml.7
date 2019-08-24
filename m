Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C23CC3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E142A2133F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 03:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="YArdq8BC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbfHXDxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 23:53:18 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:57341 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfHXDxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 23:53:18 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hmQtjf2MZcRamiRFLggSxrfPiifiO3MRKwZXJLaTlVBvnJHz4G1uLVUBrTJHYSp6oqfdNXQA4l
 I1CoGgMlf8Yit6m7uEA56qN+EVy95n9dvd6oecaQKjkZmPDQMC5d/WBqOheYccWktQhP+WjCVA
 kfk7LPRxmr+zvEqxKmNXwqfB+d6HOTc/YwV5FLZpdPM9im56ff+jZREP7hnc8ChTP2JdFI3VUv
 QQz16YxzedmSroBhEKr65betzV/BX5sAiNkLWoUmYWgduBIgD+7XxnDzg2K8WqDxPqtiq6Kgrm
 AkQ=
X-IronPort-AV: E=Sophos;i="5.64,423,1559545200"; 
   d="scan'208";a="45455468"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Aug 2019 20:53:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 23 Aug 2019 20:53:16 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 23 Aug 2019 20:53:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fGPf0C6UvAFPBvCtBdVru4Dl/uvTNSNk6dXxuGmK8u8G1bFx2B82A8ttWf9s6oFt5dDAXVe9GOMWN3YNB75rShUeLh9ftcFX4D8/CqylmT39U8BII5B6mLhoGVh4cRSv5PuH08K8F2zHQRcWBJN0cuPjt4HynBNSm5tGuGDQ6cej5biveUoBN+y8OEE8Ky7UTQ+SJvWS+kxMOhUFQueIhFczmBHkL/4ZBavBO9rMLmoyDito5PYqHYLMQ+N+MqPnHDFr7ys8SaLUAIOx40hmDKlAMgCnfghhx0Qft4coVMRed3IQDzgm7N04sg9OsO8GhFhufP6gd+VfTgFcuM0cUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyKL1h7cMFpaK86NLg6wh/Iwcahh74iIcrSK1sKmCEg=;
 b=N6K8h6rO+nm8A3aiAJ5vKuFFjVTTfGwiu/3T8JOPV7+hHlp7WjurlJzD61g9YVBxj8u05Ebp7zmxKOPbMel0Ps04I2kIYeCL6GGru2sqEOoiDm4dA87UToIus1CGX5XBOMnlHbFueA6W2MEJOZ5AbI8PV1MJclvFeGgtmND8O1bTNRxvcZapC/uJcEfFZTo4qHwd1JLyO+parm7/U/584BcQMwotSBMvklZyG7zfV3u7mUzM7s9lNzg9zpK+BQgbkV1ew9yxkfyRlz/IYoiDdALrrO8Z/Uqc7H6H/b7MM91pD35y5leuZpM6/h6nEu5emBoBUMyzUNdUamkcBHj8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyKL1h7cMFpaK86NLg6wh/Iwcahh74iIcrSK1sKmCEg=;
 b=YArdq8BCw8ynGY59qq1f3eYO2gnvO9OaHwnGICPmJljci2d0sYkwUveOhoGIeiIT1AHdjF/3gJkyG1t44FLCKC2xs1xfNbms6fjHYdk+e8rvH8ScWgSBdsDiQlYPIBVodFPaRBYFMO9VkqYbN+E1ZqXpwVbCSknwyVDSmgUGP10=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3998.namprd11.prod.outlook.com (10.255.181.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Sat, 24 Aug 2019 03:53:13 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 03:53:13 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <marek.vasut@gmail.com>, <vigneshr@ti.com>,
        <boris.brezillon@collabora.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] mtd: spi-nor: Move clear_sr_bp() to 'struct
 spi_nor_flash_parameter'
Thread-Topic: [PATCH 4/5] mtd: spi-nor: Move clear_sr_bp() to 'struct
 spi_nor_flash_parameter'
Thread-Index: AQHVWcrvkrm6wR4a/Ey8Wo3jUNa/D6cJq0iA
Date:   Sat, 24 Aug 2019 03:53:13 +0000
Message-ID: <03c88dab-4394-4dfd-98ce-34988cdf686b@microchip.com>
References: <20190823155325.13459-1-tudor.ambarus@microchip.com>
 <20190823155325.13459-5-tudor.ambarus@microchip.com>
In-Reply-To: <20190823155325.13459-5-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0292.eurprd07.prod.outlook.com
 (2603:10a6:800:130::20) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5acb0848-b26c-4933-0b04-08d728469640
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3998;
x-ms-traffictypediagnostic: MN2PR11MB3998:
x-microsoft-antispam-prvs: <MN2PR11MB3998539A7E9C489279295827F0A70@MN2PR11MB3998.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(136003)(396003)(366004)(199004)(189003)(6246003)(229853002)(3846002)(31696002)(6506007)(26005)(6116002)(478600001)(102836004)(316002)(66476007)(110136005)(6436002)(66946007)(36756003)(31686004)(6486002)(64756008)(53936002)(8936002)(14454004)(256004)(66446008)(66556008)(76176011)(52116002)(6512007)(86362001)(71200400001)(71190400001)(81166006)(8676002)(305945005)(7736002)(11346002)(5660300002)(558084003)(476003)(2616005)(386003)(99286004)(53546011)(2501003)(2201001)(66066001)(25786009)(486006)(81156014)(446003)(2906002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3998;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1nKmDNxaiWmRYqkjluWmKSA8qFUTtE47VVpukUK7D2FeduXNwCCm/FEjoW0HpfByQPEUEYTgwinw+KKQFKoZNpQ/jbhh0b34i6Jpi+nefYVxi5tPH1DD3qEjvG8yzkvidRobu36MHjGpduxhYT4XTqLSsMq/gJ7E4jY9VFViYlQJ9YYsep3f2toRbTQq3tPJ5QvB+Kqwzja1Bp0aB+kZ5ZZlsqGC03mAT50wNbiN0k+AtfDSZn+PA7hLqaLMuTElVTUz4X1vDDWfwWJog+zG92QFaHiQCxt0psGRqfjJd/Q9Iyn8I4e/NtTSCioxO6CtRhZQCdk0BWwXgWSfgNW1tfSVRsLIv7NQirxEBbb7QgqRasX2zXGMpfcDKLTSIkBa1lOU/CMQQWrAcBUItipASGbYwN18+snY38Ll7028QN0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7298CCAF410ED3429B43339A9E76FE2A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acb0848-b26c-4933-0b04-08d728469640
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 03:53:13.2893
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZY9k9eEwbbbB0UldsaTx/hz+mWucgclxIViqUP6wnPupkIQjpbJrGQdObON+dL0rtAor9+iaUsLk11Q0EGT+CzMQiNlNP7XzBLlZZWfCQ7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA4LzIzLzIwMTkgMDY6NTMgUE0sIFR1ZG9yIEFtYmFydXMgLSBNMTgwNjQgd3JvdGU6
DQo+ICsJICogY29uZmlndXJhdGlvbiByZWdpc3RlciBRdWFkIEVuYWJsZSBiaXQgaXMgb25lLCBv
bmx5IHRoZSB0aGUNCgkJCQkJCQkJXmR1cGxpY2F0aW9uDQo=
