Return-Path: <SRS0=Io4T=22=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A906C33C8C
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 15:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9CE22085B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jan 2020 15:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="v24SKuap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgAEPFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jan 2020 10:05:54 -0500
Received: from mail-eopbgr50137.outbound.protection.outlook.com ([40.107.5.137]:45894
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726212AbgAEPFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jan 2020 10:05:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOJBP2R7upV0wq7Khv++5Q8GG0chDP5pTBeIj0ghj2bDWiMXXuqE85yM/cQPceO3CYhxa14lPzkrR+cLUOn/VFp+5nfdx1TOsBvbZQCXqVyxI4hPNAX4+RtuwU//tCcinhSjZ8zNugNCqsUySUdx1blj8CnBctpAP97Hva1kgbTx5vGIi8iPpsbN5oIqYsYn70X8UXQiZDOu/dUuanBO+3yrF0jZRL83o+sW7e8tUVabEdV4n+9MUKusaePKPio5ycn3H52+TPIFhUZUydr59RJbHZpEhrrXWkQAFUbMrsDEIm7/yZuXpcOMlLGyYACjcVSzIuNHfmHwKcS2VfAr0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFfVea57HIuBXGAxrM6K05xlNIQjgO1br5BWZHQXnF0=;
 b=YstszbZfrCb6byXylHW2mgj1z5+R6rC2ksFutsx2JGcRHNyK2AGFXLXmutyDCRKnUidKIOFj0Awk9WRxTU41XyGJICIZQzNSTpBzoIREgrRiNgFq2EWLNq7AsFmYtRcYa6upCtbUuSAkHX9ImF57dXyHrhCfS4xLHehFRSYQMSc55F7ga9zqFR/jJd/VykzGYz1fEa5TmvmnhZwGfz+eh0dyAd8stn0MrlHqZL0bgL5edPayi/b9WfBv+tUkCXoRdNvF8YtLYgKhokxnGbO6AcqxvQfxm5lOr9D9x6u1vvrKEYT3Cf+wR9fq249GrG638B6T77Ol8rjO5slaUnQ0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFfVea57HIuBXGAxrM6K05xlNIQjgO1br5BWZHQXnF0=;
 b=v24SKuapQJ5TgVgBjEGdRShfwen+tQZhMz7DzCZWFofK0RFWFQE7hSiLhz3hWeL5cyzimFA8Q+S7wL42OKnxBTlHs/83hZOEQhKY3rNg290ATakX1I8z6Ho4OYMajtzIyLP46RsdN+/EFttoELaNx25rWye8H1iw6T23F3/872s=
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com (10.170.242.32) by
 HE1PR02MB3018.eurprd02.prod.outlook.com (10.170.241.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Sun, 5 Jan 2020 15:05:47 +0000
Received: from HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf]) by HE1PR02MB3258.eurprd02.prod.outlook.com
 ([fe80::24fe:bc90:5c45:acbf%7]) with mapi id 15.20.2602.015; Sun, 5 Jan 2020
 15:05:47 +0000
Received: from ttayar-VM.habana-labs.com (31.154.190.6) by FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2602.11 via Frontend Transport; Sun, 5 Jan 2020 15:05:46 +0000
From:   Tomer Tayar <ttayar@habana.ai>
To:     "oded.gabbay@gmail.com" <oded.gabbay@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] habanalabs: Modify CS jobs counter to u16
Thread-Topic: [PATCH] habanalabs: Modify CS jobs counter to u16
Thread-Index: AQHVw9mb1soBQfTZhEaR+xHuSqa3nw==
Date:   Sun, 5 Jan 2020 15:05:46 +0000
Message-ID: <20200105150539.7404-1-ttayar@habana.ai>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: FR2P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::12) To HE1PR02MB3258.eurprd02.prod.outlook.com
 (2603:10a6:7:37::32)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ttayar@habana.ai; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [31.154.190.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78b52f92-1be5-42df-2d4d-08d791f0be45
x-ms-traffictypediagnostic: HE1PR02MB3018:
x-microsoft-antispam-prvs: <HE1PR02MB3018AB0D51E3E615031947FCD23D0@HE1PR02MB3018.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 027367F73D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39840400004)(366004)(376002)(346002)(199004)(189003)(6506007)(26005)(66556008)(2906002)(4744005)(66446008)(66946007)(66476007)(64756008)(36756003)(956004)(6486002)(5660300002)(6512007)(2616005)(4326008)(86362001)(8936002)(1076003)(71200400001)(316002)(52116002)(16526019)(478600001)(8676002)(186003)(81156014)(6916009)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR02MB3018;H:HE1PR02MB3258.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: habana.ai does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R680GpSyJ1PRHhqqP7JRiTC8rSka8SzqumHq7CMruR3HeHMapZjTgsu8vZ/W1BP3Z/gDU3XUOhHqWD92GEeaaClboo8vD3kwBRK1HZeBEbBDGQSIrt73ABnwPTAD0hI9cLf1MVxyB9UMqXlvlL2vB5BcH/0DAk/L6oqBEbdGzYXtLn6DBta9K+wDmM3M19tj5WBsKO696fYodw3N2DNdudfBsx1QtDKjX40gRWX4Gn9qxlNdQiHhC4eUZ90dDhpfFQFQbrbnx9NrfIjn4D718kUuHgcHcWYVu9tx3pbYvqZSECbSTD1otgDOa6n5/0eioZViWEMTk5MlH99l4xiosUeG/PJkJiSktxOZrh2KdTHrw//Gz+FnAcPB654IydRqglmksk/OKpNe9jJ6XIGavJHC9vqQabVr0qCbNrgsNS5R4Rhg/XXe76UxwSTyxAgU
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b52f92-1be5-42df-2d4d-08d791f0be45
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2020 15:05:46.8646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V6nWMcaHCWdYEgooDhKoRIP1ltjTOY63vSRY+o3RyRauZtiJoO3oaxQdBxdVTXHPwKYqNkPZLHTj/JB9wqmipQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB3018
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As HL_MAX_JOBS_PER_CS is 512, it is possible that more than 255 CS jobs
will be submitted for a certain queue. Hence, modify the
"jobs_in_queue_cnt" parameter of the "hl_cs" structure to be u16 instead
of u8.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
---
 drivers/misc/habanalabs/habanalabs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs=
/habanalabs.h
index df34227dea31..77fe4315dbee 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -763,7 +763,7 @@ struct hl_userptr {
  * @aborted: true if CS was aborted due to some device error.
  */
 struct hl_cs {
-	u8			jobs_in_queue_cnt[HL_MAX_QUEUES];
+	u16			jobs_in_queue_cnt[HL_MAX_QUEUES];
 	struct hl_ctx		*ctx;
 	struct list_head	job_list;
 	spinlock_t		job_lock;
--=20
2.17.1

