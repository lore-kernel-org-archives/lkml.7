Return-Path: <SRS0=py8C=WU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC408C3A59E
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE192082F
	for <linux-kernel@archiver.kernel.org>; Sat, 24 Aug 2019 12:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="PDM60BEq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfHXM1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 24 Aug 2019 08:27:14 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:7770 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbfHXM1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Aug 2019 08:27:14 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Tudor.Ambarus@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="Tudor.Ambarus@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Tudor.Ambarus@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Tudor.Ambarus@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: vnQIt12T4Uls+N6F2FI7Qb2Z1AeBHJya3glr4gP3yTFrZLrP4BVMDab64uLWycDqsfW1wBrmXH
 +MkHRKAdrJxXouDtT9/WP2xLmxDKo8NttcbQ/J3RMeBqDs9Lr2ldahF1sciYYeWgjL+yEW2n90
 uDdqY+AVDfVJPCQAicQjBu7Ik/SVd4ucBWL/oWHQ5WiaiSUSlKLeM7VJWXoQtUmVmxPJxS4ApE
 5vk0BYBVe4PEN55FDktO/jfYFilBtyDlHzzFpFCtpJZvfYNo1PKWoS3EHTj7Ne8HwqOGhb3Ivw
 /hk=
X-IronPort-AV: E=Sophos;i="5.64,425,1559545200"; 
   d="scan'208";a="43549131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2019 05:27:12 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 24 Aug 2019 05:27:12 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 24 Aug 2019 05:27:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fH/Dp5sSDlouIOCgk+J4ujMoH+9Zoxag+TVLlzRp/2dtLudsxwCMnu0m3tusWHQnhj3ub1OBNSa7OHpBH+bZn4dhC60vvHQhJAV+S4SiWUrhzD+9lfy4+4RmQOc7Yi8920hhDLV2uuf66uhV42lt6Ey/sEwwIoGgKFOHvMTBb1vSLmkwbjdFz/ULGvHRbcasrlz2mZOaRzriTi3oHUgobTklERFGggcDXt6ox6vDcG1bBs//YVEiCVDfcjV9kC8Gp+KQF3fgkMqdRSAZ6e8I9j2+k85iz4xr/CH4zuLWeUnf8+C1OexZ8hzRIUI7Jd7G5/54htddtNSwAvzMjhJqIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nxJcHaNeA/yPG2kHwnUvf2teMt3BEJFdf20flB/oBk=;
 b=aHOdymDMSxcL4WvsBSjGGijNUyHbB+PpZzmWq/j1G3BudqWr9pn4Az2YVgIg4tlzTXvoWwIn1iSqoaKLjMCy/04zSaK8pHnjG4ivPwrFXEL/DHI0+o9IvXXj5wwHNjLEsNwXqTggfwn5GS3a42FmuGpAFJa6yEz7uNuy4s8wI9mbIHtud6VfHSDBGBICjVl3HANcG5BEmce3FfnA7+tUEZRrGv2ZKJ13x4DIykIVPz19FwX5sWSTjjb1NI0nN3F5kge3en+obSCe1wAQDF6cg2LOuk02t/pu1jo9MQnABXdFAlzCiNXJkO+sGe3Kc/p/rIodoKQ2wore5e/Dd4oK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/nxJcHaNeA/yPG2kHwnUvf2teMt3BEJFdf20flB/oBk=;
 b=PDM60BEqhtuoq3wXI51fw2cUnPYE74vAbXLjW2eTj3zUjQFHMRd4wKuCozgpeOxsJ//Gyn9Pb5OEakcBWAGun/nXam+IowMijzopKKlXJXPoKZ5q91MhAlCQDxx8mLJkD04hF8tTD4jFapiGMRm/gkfyGh4KbCmD+2wvJ76WOx4=
Received: from MN2PR11MB4448.namprd11.prod.outlook.com (52.135.39.157) by
 MN2PR11MB3854.namprd11.prod.outlook.com (20.178.252.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 24 Aug 2019 12:27:10 +0000
Received: from MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5]) by MN2PR11MB4448.namprd11.prod.outlook.com
 ([fe80::70c3:e929:4da2:60a5%7]) with mapi id 15.20.2178.020; Sat, 24 Aug 2019
 12:27:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <boris.brezillon@collabora.com>, <marek.vasut@gmail.com>,
        <vigneshr@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <Tudor.Ambarus@microchip.com>
Subject: [PATCH v2 0/2] mtd: spi-nor: add Global Block Unlock support
Thread-Topic: [PATCH v2 0/2] mtd: spi-nor: add Global Block Unlock support
Thread-Index: AQHVWndAYVHRO2wYkke/GPaXf6i9zg==
Date:   Sat, 24 Aug 2019 12:27:10 +0000
Message-ID: <20190824122700.23558-1-tudor.ambarus@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR04CA0129.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::27) To MN2PR11MB4448.namprd11.prod.outlook.com
 (2603:10b6:208:193::29)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.9.5
x-originating-ip: [86.127.53.184]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5740c08e-30ce-4a3d-851d-08d7288e62cf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MN2PR11MB3854;
x-ms-traffictypediagnostic: MN2PR11MB3854:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB38544B6597422A396DEDBBFFF0A70@MN2PR11MB3854.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0139052FDB
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(39860400002)(396003)(199004)(189003)(256004)(66946007)(966005)(81156014)(81166006)(186003)(2201001)(64756008)(66446008)(66556008)(26005)(478600001)(486006)(50226002)(6306002)(2616005)(6512007)(386003)(102836004)(8676002)(86362001)(2501003)(6506007)(1076003)(14454004)(316002)(476003)(6116002)(66476007)(99286004)(110136005)(6486002)(305945005)(6436002)(7736002)(71200400001)(2906002)(8936002)(25786009)(53936002)(66066001)(107886003)(3846002)(71190400001)(4326008)(5660300002)(52116002)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR11MB3854;H:MN2PR11MB4448.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UQM7XSHb9itnqIEaYFN5YnxmLGfrrJELHRyHnTGjcgfFurHCFH7OVXSDpZGs0jqHY+UwOh7vKCwM4TdMTF4ixkXIyEnA9xdVL3mNr1RjtPHeHArGqMV+lP1KWRpb2GcXPLyK0BYW/thjleG1gdt7rm3iy+ddYa8T55RnnLd12SI4rmoDajkE2qiT54TyeyWZ3dF6pMsj7qYysOxOObNO4TIErfRXVhA0glnWCj7+uj92beS1J8XPmZWdn9S0cFvaW6xIPGydxser8KTCq9lyYsVAVMaKKEsTkxjnYuh2O3QURV6/iBnuo5+m+OX1xNk60XAyaODgyEOEZIvp1x6C0nNpjaVPRdyB09FmyeSVQR0LUkoIYbF+M9DTJh5nhak/lxPfS75OaPKQA7/l7o3cT67p48L6DnzBlle3RWZJulg=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5740c08e-30ce-4a3d-851d-08d7288e62cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2019 12:27:10.7377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhRJ9LFPbUtJSbHgtjD6sSAqTubtCBU0j/nGdB8zJNVjfEmO/ptFH9TKf6NQN6OoBYL+ngjxMGOWoBFYgMK7bxBk748j4xyZL06/vKWfFM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tudor Ambarus <tudor.ambarus@microchip.com>

v2: the check for UNLOCK_GLOBAL_BLOCK should be done the first
thing in spi_nor_disable_block_protection(). We use it for a faster
throughput, a single command cycle that unlocks the entire memory
array. Fix it.

This is similar with what other nor flashes are doing by clearing the
block protection bits from the status register: disable the write
protection after a power-on reset cycle.

The Global Block-Protection Unlock command offers a single command cycle
that unlocks the entire memory array. Prefer this method for higher
throughput.

Tested on the sst26vf064b flash using the atmel-quadspi driver.

This has nothing to do with the move manufacturer out of the spi-nor core
pursue, but depends on 'mtd: spi-nor: move manuf out of the core - batch 0'
https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D127030

Tudor Ambarus (2):
  mtd: spi-nor: add Global Block Unlock support
  mtd: spi-nor: unlock global block protection on sst26vf064b

 drivers/mtd/spi-nor/spi-nor.c | 50 +++++++++++++++++++++++++++++++++++++++=
++--
 include/linux/mtd/spi-nor.h   |  1 +
 2 files changed, 49 insertions(+), 2 deletions(-)

--=20
2.9.5

