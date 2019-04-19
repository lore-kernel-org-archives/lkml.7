Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EEEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3C6620645
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 19:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729726AbfDSTIr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 15:08:47 -0400
Received: from mo-csw-fb1114.securemx.jp ([210.130.202.173]:51070 "EHLO
        mo-csw-fb.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728830AbfDSTIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 15:08:45 -0400
Received: by mo-csw-fb.securemx.jp (mx-mo-csw-fb1114) id x3J7Dx8c013632; Fri, 19 Apr 2019 16:13:59 +0900
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id x3J7DmbI023090; Fri, 19 Apr 2019 16:13:48 +0900
X-Iguazu-Qid: 2wHHotYFIamwaIlaaH
X-Iguazu-QSIG: v=2; s=0; t=1555658028; q=2wHHotYFIamwaIlaaH; m=yWOvaXCXfz3oISZHCnM5/k5i9EdhP7QcrJ96Y6zp/2g=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1113) id x3J7DiOc023312;
        Fri, 19 Apr 2019 16:13:47 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id x3J7DhYi000455;
        Fri, 19 Apr 2019 16:13:43 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id x3J7DgAR001368;
        Fri, 19 Apr 2019 16:13:42 +0900
From:   <nobuhiro1.iwamatsu@toshiba.co.jp>
To:     <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC:     <rdunlap@infradead.org>, <axboe@kernel.dk>, <sashal@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5.0 18/93] paride/pf: cleanup queues when detection fails
Thread-Topic: [PATCH 5.0 18/93] paride/pf: cleanup queues when detection fails
Thread-Index: AQHU9hH6d8kOxFEmAk6VY1v1ku2z46ZC5tIe
Date:   Fri, 19 Apr 2019 07:13:40 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB4189C6A8BFFF81A47F6FE92792270@TYAPR01MB4189.jpnprd01.prod.outlook.com>
References: <20190418160436.781762249@linuxfoundation.org>,<20190418160438.663257972@linuxfoundation.org>
In-Reply-To: <20190418160438.663257972@linuxfoundation.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=nobuhiro1.iwamatsu@toshiba.co.jp; 
x-originating-ip: [103.91.184.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65bd461a-b9b9-4998-e94e-08d6c4968cb3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(2017052603328)(7193020);SRVR:TYAPR01MB2560;
x-ms-traffictypediagnostic: TYAPR01MB2560:
x-microsoft-antispam-prvs: <TYAPR01MB256079AE5B3AFC6C9CEAE9AE92270@TYAPR01MB2560.jpnprd01.prod.outlook.com>
x-forefront-prvs: 0012E6D357
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(366004)(396003)(376002)(39860400002)(136003)(189003)(199004)(486006)(476003)(2906002)(11346002)(97736004)(99286004)(446003)(6436002)(316002)(74316002)(5660300002)(52536014)(3846002)(6116002)(33656002)(2501003)(74482002)(54906003)(229853002)(110136005)(55016002)(6246003)(81156014)(81166006)(8676002)(66066001)(25786009)(9686003)(53936002)(7736002)(305945005)(14454004)(7696005)(186003)(68736007)(26005)(6506007)(4326008)(102836004)(76176011)(8936002)(478600001)(46636005)(66476007)(14444005)(256004)(86362001)(71200400001)(71190400001)(66446008)(64756008)(66556008)(66946007)(73956011)(76116006);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB2560;H:TYAPR01MB4189.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toshiba.co.jp does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: dgLJ1Z8mDmphuERqIUW/NSEsRCLlwpYLj/AGv/WKXK+2g0Ar0oInItQx4kHy6x6ITiMJyWyguq24i7kxD22eYDYDKSk8DSUW//ndbVgwe7YVVBbT6v2IjYBxYLqun3dBEPV362Mhpp1mPY8Zq7TY97LKlG4epQvNLS87q6X2kPZEvEtYQuYk6bHWzXHz/1/X4PGIyZSei5J51YCzzkWSYBEIc/k0MkO1vES+sxWSqs3W5ay8SObBAcZWCXG8qxmltx+IiixJbmUcQx/IWv429aUsnrpnEfw0OKkNhkV+FwDvqORJWYAPW0eubsnDRKC6mCRA9u1a6DKScQ9Bw7xkqA+u9bCXWKFiyxu5qXBZgcSACB0UVAWL1JEByCztrCflyeEa8XcSy+kLJ32Xqk77pYl4dO/pNMd++7zTIfZU+WM=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 65bd461a-b9b9-4998-e94e-08d6c4968cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2019 07:13:40.3042
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

> [ Upstream commit 6ce59025f1182125e75c8d121daf44056b65dd1f ]
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
is 58ccd2d31e502c37e108b285bf3d343eb00c235b.
I think this commit needs to be applied together.

Best regards,
  Nobuhiro

________________________________________
差出人: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> が Greg Kroah-Hartman <gregkh@linuxfoundation.org> の代理で送信
送信日時: 2019年4月19日 2:56
宛先: linux-kernel@vger.kernel.org
CC: Greg Kroah-Hartman; stable@vger.kernel.org; Randy Dunlap; Jens Axboe; Sasha Levin
件名: [PATCH 5.0 18/93] paride/pf: cleanup queues when detection fails

[ Upstream commit 6ce59025f1182125e75c8d121daf44056b65dd1f ]

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
 drivers/block/paride/pf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index e92e7a8eeeb2..103b617cdc31 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -761,8 +761,12 @@ static int pf_detect(void)
                return 0;

        printk("%s: No ATAPI disk detected\n", name);
-       for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++)
+       for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
+               blk_cleanup_queue(pf->disk->queue);
+               pf->disk->queue = NULL;
+               blk_mq_free_tag_set(&pf->tag_set);
                put_disk(pf->disk);
+       }
        pi_unregister_driver(par_drv);
        return -1;
 }
@@ -1047,13 +1051,15 @@ static void __exit pf_exit(void)
        int unit;
        unregister_blkdev(major, name);
        for (pf = units, unit = 0; unit < PF_UNITS; pf++, unit++) {
-               if (!pf->present)
-                       continue;
-               del_gendisk(pf->disk);
+               if (pf->present)
+                       del_gendisk(pf->disk);
+
                blk_cleanup_queue(pf->disk->queue);
                blk_mq_free_tag_set(&pf->tag_set);
                put_disk(pf->disk);
-               pi_release(pf->pi);
+
+               if (pf->present)
+                       pi_release(pf->pi);
        }
 }

--
2.19.1



