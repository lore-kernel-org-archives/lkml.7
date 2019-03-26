Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 716F1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D92C2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plantronics.onmicrosoft.com header.i=@plantronics.onmicrosoft.com header.b="WTaybTUF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731754AbfCZWn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:43:29 -0400
Received: from mail-eopbgr810113.outbound.protection.outlook.com ([40.107.81.113]:27328
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727422AbfCZWn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:43:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=plantronics.onmicrosoft.com; s=selector1-plantronics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XP1J7xoBxcCrwuf5zbSW4dCvWu67w/ri+jTRUbE2mYg=;
 b=WTaybTUFR3Fuwq6WITRs1jMFzWBWv7uVhdzzpEQ2MsjrR5usqbWogh3s0IYcN5elSFTUHtpabJ/hUa4uG1bChMUvFXK43UNp+Slv/NkvrYw2PLl2dAuXit86Fd1/MqDhAhDGkiKCQXZqXRVOBeUcgf8u5ylvQa8udY6bVv9bYlU=
Received: from BYAPR02MB5607.namprd02.prod.outlook.com (20.177.230.93) by
 BYAPR02MB5336.namprd02.prod.outlook.com (20.177.124.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.19; Tue, 26 Mar 2019 22:43:24 +0000
Received: from BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd]) by BYAPR02MB5607.namprd02.prod.outlook.com
 ([fe80::25a1:583a:a978:21fd%4]) with mapi id 15.20.1750.014; Tue, 26 Mar 2019
 22:43:24 +0000
From:   "Junge, Terry" <terry.junge@poly.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
CC:     "oneukum@suse.de" <oneukum@suse.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] HID: core: move Usage Page concatenation to Main item
Thread-Topic: [PATCH v3] HID: core: move Usage Page concatenation to Main item
Thread-Index: AQHU5A8I6NMzWfyYe0eJghAdMnvCeqYeYnkw
Date:   Tue, 26 Mar 2019 22:43:24 +0000
Message-ID: <BYAPR02MB560738248E330DF46CAA199A8A5F0@BYAPR02MB5607.namprd02.prod.outlook.com>
References: <20190326200331.25934-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190326200331.25934-1-nsaenzjulienne@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=terry.junge@poly.com; 
x-originating-ip: [198.231.9.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb1dc2fd-1a05-4210-3d2b-08d6b23c74c0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BYAPR02MB5336;
x-ms-traffictypediagnostic: BYAPR02MB5336:
x-microsoft-antispam-prvs: <BYAPR02MB53360D77D1D2E28549D0EB828A5F0@BYAPR02MB5336.namprd02.prod.outlook.com>
x-forefront-prvs: 09888BC01D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(136003)(346002)(396003)(376002)(199004)(189003)(256004)(6246003)(53546011)(86362001)(99286004)(66066001)(11346002)(7696005)(14444005)(74316002)(6436002)(14454004)(186003)(7736002)(71190400001)(305945005)(53936002)(54906003)(316002)(110136005)(8676002)(9686003)(6116002)(105586002)(8936002)(4326008)(5660300002)(55016002)(71200400001)(106356001)(52536014)(25786009)(102836004)(476003)(486006)(26005)(76176011)(81156014)(81166006)(6506007)(97736004)(2906002)(33656002)(446003)(68736007)(3846002)(229853002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR02MB5336;H:BYAPR02MB5607.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: poly.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: IyFnl+V8h5usafTmzKTdBxPMWKEkojIkHYPmjMPiGOf7XlF39zNG50tL6eTCmtheu7uh78rxSlgdctwckKBBf0pijlcG9NAW/40lE8M+Hch+1qmkDqX2EyoRhyNlOqVKtoIzu9o5kk6GUQt+Tzz7RN4ZeTQVVTVMusjwIPFVbGghziP/QHZxzw+Wo5BzM9RbvE3fMopkEo80tZRVafuWZ5YEFVe/F/p+Dh+EGV1IYSQWP9e+plzIrytAGr/ypWT1k6dzWd4kjAWxsaFLnTsIXG3ofvM8m4GGJDWrT3BBw8NO54JSHjViMbbIaadhEloFEF/7G96rYceyjPfAB4dFgt0FiVlLOiuCPZxDjRhmUBToKlZhhz/Gig+nM8X1VziPlAZcNT3gCDBUvcANIIotqz0VTP/T5r2bNgre6rnzyXs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: poly.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb1dc2fd-1a05-4210-3d2b-08d6b23c74c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2019 22:43:24.4250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bc7c5f16-c55e-417d-aac0-ff6bbfc27f76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5336
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

This patch looks good except for one comment/question below.

Thanks,
Terry

On Tuesday, March 26, 2019 1:04 PM Nicolas Saenz Julienne <nsaenzjulienne@s=
use.de> wrote:
>
>As seen on some USB wireless keyboards manufactured by Primax, the HID
>parser was using some assumptions that are not always true. In this case i=
t's s
>the fact that, inside the scope of a main item, an Usage Page will always
>precede an Usage.
>
>The spec is not pretty clear as 6.2.2.7 states "Any usage that follows is
>interpreted as a Usage ID and concatenated with the Usage Page".
>While 6.2.2.8 states "When the parser encounters a main item it concatenat=
es
>the last declared Usage Page with a Usage to form a complete usage value."
>Being somewhat contradictory it was decided to match Window's
>implementation, which follows 6.2.2.8.
>
>In summary, the patch moves the Usage Page concatenation from the local
>item parsing function to the main item parsing function.
>
>Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>---
>
>v2->v3: - Update patch title
>
>v1->v2: - Add usage concatenation to hid_scan_main()
>	- Rework tests in hid-tools, making sure no-one is failing
>
> drivers/hid/hid-core.c | 40 ++++++++++++++++++++++++++++------------
> include/linux/hid.h    |  1 +
> 2 files changed, 29 insertions(+), 12 deletions(-)
>
>diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c index
>9993b692598f..40c836ce3248 100644
>--- a/drivers/hid/hid-core.c
>+++ b/drivers/hid/hid-core.c
>@@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct
>hid_parser *parser, unsigned type)
>  * Add a usage to the temporary parser table.
>  */
>
>-static int hid_add_usage(struct hid_parser *parser, unsigned usage)
>+static int hid_add_usage(struct hid_parser *parser, unsigned usage,
>+__u8 size)
> {
> 	if (parser->local.usage_index >=3D HID_MAX_USAGES) {
> 		hid_err(parser->device, "usage index exceeded\n");
> 		return -1;
> 	}
> 	parser->local.usage[parser->local.usage_index] =3D usage;
>+	parser->local.usage_size[parser->local.usage_index] =3D size;
> 	parser->local.collection_index[parser->local.usage_index] =3D
> 		parser->collection_stack_ptr ?
> 		parser->collection_stack[parser->collection_stack_ptr - 1] : 0;
>@@ -486,10 +487,7 @@ static int hid_parser_local(struct hid_parser *parser=
,
>struct hid_item *item)
> 			return 0;
> 		}
>
>-		if (item->size <=3D 2)
>-			data =3D (parser->global.usage_page << 16) + data;
>-
>-		return hid_add_usage(parser, data);
>+		return hid_add_usage(parser, data, item->size);
>
> 	case HID_LOCAL_ITEM_TAG_USAGE_MINIMUM:
>
>@@ -498,9 +496,6 @@ static int hid_parser_local(struct hid_parser *parser,
>struct hid_item *item)
> 			return 0;
> 		}
>
>-		if (item->size <=3D 2)
>-			data =3D (parser->global.usage_page << 16) + data;
>-
> 		parser->local.usage_minimum =3D data;
> 		return 0;
>
>@@ -511,9 +506,6 @@ static int hid_parser_local(struct hid_parser *parser,
>struct hid_item *item)
> 			return 0;
> 		}
>
>-		if (item->size <=3D 2)
>-			data =3D (parser->global.usage_page << 16) + data;
>-
> 		count =3D data - parser->local.usage_minimum;
> 		if (count + parser->local.usage_index >=3D HID_MAX_USAGES) {
> 			/*
>@@ -533,7 +525,7 @@ static int hid_parser_local(struct hid_parser *parser,
>struct hid_item *item)
> 		}
>
> 		for (n =3D parser->local.usage_minimum; n <=3D data; n++)
>-			if (hid_add_usage(parser, n)) {
>+			if (hid_add_usage(parser, n, item->size)) {
> 				dbg_hid("hid_add_usage failed\n");
> 				return -1;
> 			}
>@@ -547,6 +539,26 @@ static int hid_parser_local(struct hid_parser *parser=
,
>struct hid_item *item)
> 	return 0;
> }
>
>+/*
>+ * Concatenate Usage Pages into Usages where relevant:
>+ * As per specification, 6.2.2.8: "When the parser encounters a main
>+item it
>+ * concatenates the last declared Usage Page with a Usage to form a
>+complete
>+ * usage value."
>+ */
>+
>+static void hid_concatenate_usage_page(struct hid_parser *parser) {
>+	unsigned usages;
>+	int i;
>+
>+	usages =3D max_t(unsigned, parser->local.usage_index,
>+				 parser->global.report_count);

I don't think we need to worry about global.report_count here,
just concatenate for the usages currently in the local queue so could
this be simplified by removing usages and just using local.usage_index?

        for (i =3D 0; i < local.usage_index; i++)

>+
>+	for (i =3D 0; i < usages; i++)
>+		if (parser->local.usage_size[i] <=3D 2)
>+			parser->local.usage[i] +=3D parser->global.usage_page
><< 16; }
>+
> /*
>  * Process a main item.
>  */
>@@ -556,6 +568,8 @@ static int hid_parser_main(struct hid_parser *parser,
>struct hid_item *item)
> 	__u32 data;
> 	int ret;
>
>+	hid_concatenate_usage_page(parser);
>+
> 	data =3D item_udata(item);
>
> 	switch (item->tag) {
>@@ -765,6 +779,8 @@ static int hid_scan_main(struct hid_parser *parser,
>struct hid_item *item)
> 	__u32 data;
> 	int i;
>
>+	hid_concatenate_usage_page(parser);
>+
> 	data =3D item_udata(item);
>
> 	switch (item->tag) {
>diff --git a/include/linux/hid.h b/include/linux/hid.h index
>f9707d1dcb58..d1fb4b678873 100644
>--- a/include/linux/hid.h
>+++ b/include/linux/hid.h
>@@ -417,6 +417,7 @@ struct hid_global {
>
> struct hid_local {
> 	unsigned usage[HID_MAX_USAGES]; /* usage array */
>+	__u8 usage_size[HID_MAX_USAGES]; /* usage size array */
> 	unsigned collection_index[HID_MAX_USAGES]; /* collection index
>array */
> 	unsigned usage_index;
> 	unsigned usage_minimum;
>--
>2.21.0

