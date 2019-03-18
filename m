Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69C5C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8971820879
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 10:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="Y05ZkBfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbfCRKFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 06:05:17 -0400
Received: from mail-eopbgr680089.outbound.protection.outlook.com ([40.107.68.89]:49572
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727805AbfCRKFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 06:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YFEqVuevkaQBM/z5LGM9cjHZFRQW9Eci0jyBHKfv9u8=;
 b=Y05ZkBfFJGCofkwkvZmb9THM5G/wFVJzmEsxoV/xCcDraUJOsza+Dh0Jr5ED4MIcF8WbEZzioGrl2C7zbdqoF5r0YBlzs1i9lEebW/W/HzN/gnRUJF99FxewqG8jZJfB1AUCeV4DoiNN66Qb32d2g9MyQhJiQ3sxnGnASuve6bc=
Received: from DM6PR05MB5675.namprd05.prod.outlook.com (20.176.123.144) by
 DM6PR05MB4443.namprd05.prod.outlook.com (20.176.79.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.15; Mon, 18 Mar 2019 10:05:10 +0000
Received: from DM6PR05MB5675.namprd05.prod.outlook.com
 ([fe80::a0d0:4e6:3c33:5a49]) by DM6PR05MB5675.namprd05.prod.outlook.com
 ([fe80::a0d0:4e6:3c33:5a49%3]) with mapi id 15.20.1709.015; Mon, 18 Mar 2019
 10:05:09 +0000
From:   Radoslav Gerganov <rgerganov@vmware.com>
To:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "James.Bottomley@HansenPartnership.com" 
        <James.Bottomley@HansenPartnership.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Radoslav Gerganov <rgerganov@vmware.com>
Subject: [PATCH v2] USB: gadget: f_hid: fix deadlock in f_hidg_write()
Thread-Topic: [PATCH v2] USB: gadget: f_hid: fix deadlock in f_hidg_write()
Thread-Index: AQHU3XIREXrDfledjkiITDo3Fsn1UA==
Date:   Mon, 18 Mar 2019 10:05:09 +0000
Message-ID: <1552903481-14303-1-git-send-email-rgerganov@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0172.eurprd07.prod.outlook.com (10.166.77.20) To
 DM6PR05MB5675.namprd05.prod.outlook.com (20.176.123.144)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rgerganov@vmware.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 1.9.1
x-originating-ip: [146.247.46.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09ff62e6-77b4-4a3b-c25a-08d6ab893436
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:DM6PR05MB4443;
x-ms-traffictypediagnostic: DM6PR05MB4443:
x-microsoft-antispam-prvs: <DM6PR05MB4443B1F3750B96D14B07DF43DC470@DM6PR05MB4443.namprd05.prod.outlook.com>
x-forefront-prvs: 098076C36C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(136003)(376002)(366004)(396003)(199004)(189003)(6512007)(256004)(97736004)(386003)(6116002)(3846002)(14444005)(52116002)(2616005)(486006)(6506007)(186003)(26005)(53936002)(107886003)(4326008)(476003)(316002)(6486002)(2501003)(2201001)(86362001)(25786009)(54906003)(6436002)(106356001)(305945005)(478600001)(5660300002)(7736002)(110136005)(99286004)(36756003)(50226002)(68736007)(66066001)(2906002)(105586002)(102836004)(14454004)(71200400001)(81166006)(8676002)(81156014)(71190400001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR05MB4443;H:DM6PR05MB5675.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DGlVjDe2Uta+yoI692n4s6k8YjPawKkZvJ8R7byxsChhmzZsvm++GgViFgcFrvC1vv8GcTkJ1ACRO5+p7WIOTnG9OrcGLi0go+1qxM2MGNr+saAGLMNpS1LXYMdUEfumX9fMoDiCXPNQt9adBb6g7ikKWSu/p5APrMtbLPd04aLi1HOsHDAQriLlJvEWDKBJn33ZXDhWULqkgp0ZPhmHS6eGyN59WX7sOfesHthCR62gjrUkif//XRoRuTpTCHctXJLK6m0bDg+SYEw5Kz2VrVFbaD/Y4Bfgzoc1gj+JYBLARWFyPO8dv2OeRgjnFsfKEaeel9HfF0JidR/yIgFGGQKzkCG4sL/Y/Nn0P1WmYGE9UleN27vYugFK6mZ+PgDCOrSG90sTITdi3iwBQuDW+jSAf6vNIjpSE0yZF3x9sso=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <51EE359D9DF8B345AFCFAFDE294FAA15@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff62e6-77b4-4a3b-c25a-08d6ab893436
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2019 10:05:09.9100
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR05MB4443
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In f_hidg_write() the write_spinlock is acquired before calling
usb_ep_queue() which causes a deadlock when dummy_hcd is being used.
This is because dummy_queue() callbacks into f_hidg_req_complete() which
tries to acquire the same spinlock. This is (part of) the backtrace when
the deadlock occurs:

  0xffffffffc06b1410 in f_hidg_req_complete
  0xffffffffc06a590a in usb_gadget_giveback_request
  0xffffffffc06cfff2 in dummy_queue
  0xffffffffc06a4b96 in usb_ep_queue
  0xffffffffc06b1eb6 in f_hidg_write
  0xffffffff8127730b in __vfs_write
  0xffffffff812774d1 in vfs_write
  0xffffffff81277725 in SYSC_write

Fix this by releasing the write_spinlock before calling usb_ep_queue()

Signed-off-by: Radoslav Gerganov <rgerganov@vmware.com>
Reviewed-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Tested-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: stable@vger.kernel.org # 4.11+
Fixes: 749494b6bdbb ("usb: gadget: f_hid: fix: Move IN request allocation t=
o set_alt()")
---
In v2 only the commit message is changed.
---
 drivers/usb/gadget/function/f_hid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/funct=
ion/f_hid.c
index 54e859d..492bb44 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -391,20 +391,20 @@ static ssize_t f_hidg_write(struct file *file, const =
char __user *buffer,
 	req->complete =3D f_hidg_req_complete;
 	req->context  =3D hidg;
=20
+	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
+
 	status =3D usb_ep_queue(hidg->in_ep, req, GFP_ATOMIC);
 	if (status < 0) {
 		ERROR(hidg->func.config->cdev,
 			"usb_ep_queue error on int endpoint %zd\n", status);
-		goto release_write_pending_unlocked;
+		goto release_write_pending;
 	} else {
 		status =3D count;
 	}
-	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
=20
 	return status;
 release_write_pending:
 	spin_lock_irqsave(&hidg->write_spinlock, flags);
-release_write_pending_unlocked:
 	hidg->write_pending =3D 0;
 	spin_unlock_irqrestore(&hidg->write_spinlock, flags);
=20
--=20
1.9.1

