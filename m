Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504DDC282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E2D20645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbfDSSvI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:51:08 -0400
Received: from mo-csw-fb1514.securemx.jp ([210.130.202.170]:33634 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfDSSvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:51:06 -0400
X-Greylist: delayed 1505 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Apr 2019 14:51:04 EDT
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1514) id x3J7DcZ8022345; Fri, 19 Apr 2019 16:13:38 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id x3J7DDJw006435; Fri, 19 Apr 2019 16:13:13 +0900
X-Iguazu-Qid: 34trkhapAUMCS5adZx
X-Iguazu-QSIG: v=2; s=0; t=1555657993; q=34trkhapAUMCS5adZx; m=9IbhJiAyufywHvcRRWat0JUJWuATschBB1EP0iNMuxg=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1512) id x3J7DAph027499;
        Fri, 19 Apr 2019 16:13:11 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id x3J7DA4I000172;
        Fri, 19 Apr 2019 16:13:10 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id x3J7D9OG000907;
        Fri, 19 Apr 2019 16:13:10 +0900
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC:     <rdunlap@infradead.org>, <axboe@kernel.dk>, <sashal@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.0 19/93] paride/pcd: cleanup queues when detection fails
Thread-Topic: [PATCH 5.0 19/93] paride/pcd: cleanup queues when detection
 fails
Thread-Index: AQHU9hNHSVpYSssU/UquB1j4yEaZnqZC5Hpr
Date:   Fri, 19 Apr 2019 07:13:07 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB418948D3F208E92CB2C6B32692270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
References: <20190418160436.781762249@linuxfoundation.org>,<20190418160438.746819159@linuxfoundation.org>
In-Reply-To: <20190418160438.746819159@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d2f3522-75ae-4413-2f60-08d6c4967935
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:TYAPR01MB2560;
x-ms-traffictypediagnostic: TYAPR01MB2560:
x-microsoft-antispam-prvs: <TYAPR01MB25609450214CA98560F7D3C792270@TYAPR01MB2560.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(486006)(476003)(2906002)(11346002)(97736004)(99286004)(446003)(6436002)(316002)(74316002)(5660300002)(52536014)(3846002)(6116002)(33656002)(2501003)(74482002)(54906003)(229853002)(110136005)(55016002)(6246003)(81156014)(81166006)(8676002)(66066001)(25786009)(9686003)(53936002)(7736002)(305945005)(14454004)(7696005)(186003)(68736007)(26005)(6506007)(4326008)(102836004)(76176011)(8936002)(478600001)(46636005)(66476007)(14444005)(256004)(86362001)(71200400001)(71190400001)(66446008)(64756008)(66556008)(66946007)(73956011)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB2560;H:TYAPR01MB4189.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JIBNw32+sQWxlqs4JDEHSS8uGNgNZcvgN5050hxzzwU7sEKzKHU0RVn5EeYVEBQxZHkHTrDLjsAaPWwXExzUZ2TkHWxQ2mnAQmlOuj5jq9BDnyHdbS6DjvOEfF1R4k44nc/ZZjo43QmODG1O8Hpl2Of5g45lHfeOs3T/nX2pCKqfB2If5Udfg24eYJfXWyvgV7Mb5F47oy87RAHecdyNw7La3+6EvvfBRr5yHPNQISIB03hA1Be+IJ4uodvcivhlQHOIaX7tZKiKdleXh1TVJWjm6XufYKHX+aaySNzlYb3jLl0K49Y/ldaVIeI3fORrebpjjZe1xNnsktSVO5GBOAyy0+rOT4Kvy8WgN6g97Yy8OYNM0WZScYjYq+G6Xq0+7DUmR+oweewSrmaIFkWVb5gESPDJcI2hBe/SgnUyR+U=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2f3522-75ae-4413-2f60-08d6c4967935
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 07:13:07.6390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2560
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> [ Upstream commit 81b74ac68c28fddb3589ad5d4d5e587baf4bb781 ]
> 
> The driver allocates queues for all the units it potentially
> supports. But if we fail to detect any drives, then we fail
> loading the module without cleaning up those queues. This is
> now evident with the switch to blk-mq, though the bug has
> been there forever as far as I can tell.
> 
> Also fix cleanup through regular module exit.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This commit causes a new problem. And the commit that made the fix
is f0d1762554014ce0ae347b9f0d088f2c157c8c72.
I think this commit needs to be applied together.

Best regards,
  Nobuhiro

________________________________________
差出人: stable-owner@vger.kernel.org <stable-owner@vger.kernel.org> が Greg Kroah-Hartman <gregkh@linuxfoundation.org> の代理で送信
送信日時: 2019年4月19日 2:56
宛先: linux-kernel@vger.kernel.org
CC: Greg Kroah-Hartman; stable@vger.kernel.org; Randy Dunlap; Jens Axboe; Sasha Levin
件名: [PATCH 5.0 19/93] paride/pcd: cleanup queues when detection fails

[ Upstream commit 81b74ac68c28fddb3589ad5d4d5e587baf4bb781 ]

The driver allocates queues for all the units it potentially
supports. But if we fail to detect any drives, then we fail
loading the module without cleaning up those queues. This is
now evident with the switch to blk-mq, though the bug has
been there forever as far as I can tell.

Also fix cleanup through regular module exit.

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/paride/pcd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pcd.c b/drivers/block/paride/pcd.c
index 96670eefaeb2..377a694dc228 100644
--- a/drivers/block/paride/pcd.c
+++ b/drivers/block/paride/pcd.c
@@ -749,8 +749,12 @@ static int pcd_detect(void)
                return 0;

        printk("%s: No CD-ROM drive found\n", name);
-       for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++)
+       for (unit = 0, cd = pcd; unit < PCD_UNITS; unit++, cd++) {
+               blk_cleanup_queue(cd->disk->queue);
+               cd->disk->queue = NULL;
+               blk_mq_free_tag_set(&cd->tag_set);
                put_disk(cd->disk);
+       }
        pi_unregister_driver(par_drv);
        return -1;
 }
--
2.19.1



