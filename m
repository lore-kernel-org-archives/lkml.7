Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BDBC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81A420820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 09:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eInfochipsIndia.onmicrosoft.com header.i=@eInfochipsIndia.onmicrosoft.com header.b="QXMBP+j/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387626AbfDDJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 05:28:01 -0400
Received: from mail-eopbgr1300089.outbound.protection.outlook.com ([40.107.130.89]:27088
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733068AbfDDJ2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 05:28:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eInfochipsIndia.onmicrosoft.com; s=selector1-einfochips-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QJEwPl+CXdreFGjX7hUhAb/B83qjn99ySBy4TnWAbk=;
 b=QXMBP+j/dPNHXsW6tJYHvxmLuObvJoy8gLnpU2EPuy1hFWrXLeOyMGWxP4OB4GXI2MChry09zZxYA9vFVvv00FEOXAZGwOs9iZz0SEBM6IVSAO44ANcidS6DxJWvhdbZFgU5P0bbt6eSFKR5gewmvyJZ1ZXhEI2ShezhDF0JPmA=
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com (20.177.88.78) by
 SG2PR02MB3608.apcprd02.prod.outlook.com (20.177.170.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1771.15; Thu, 4 Apr 2019 09:27:53 +0000
Received: from SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b]) by SG2PR02MB3098.apcprd02.prod.outlook.com
 ([fe80::f432:20e4:2d22:e60b%4]) with mapi id 15.20.1750.017; Thu, 4 Apr 2019
 09:27:53 +0000
From:   Pankaj Suryawanshi <pankaj.suryawanshi@einfochips.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How to calculate instruction executed for function
Thread-Topic: How to calculate instruction executed for function
Thread-Index: AQHU6igi0LAQURcEFkafVLmNd6QLn6YrvLoU
Date:   Thu, 4 Apr 2019 09:27:53 +0000
Message-ID: <SG2PR02MB309878FDF524EAE5F61228B7E8500@SG2PR02MB3098.apcprd02.prod.outlook.com>
References: <SG2PR02MB3098EF270AE08CB19E96C5C4E8570@SG2PR02MB3098.apcprd02.prod.outlook.com>
In-Reply-To: <SG2PR02MB3098EF270AE08CB19E96C5C4E8570@SG2PR02MB3098.apcprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pankaj.suryawanshi@einfochips.com; 
x-originating-ip: [14.98.130.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1e2025e-e65e-4d08-1439-08d6b8dfd0c3
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(7168020)(4627221)(201703031133081)(201702281549075)(8990200)(5600139)(711020)(4605104)(2017052603328)(7193020);SRVR:SG2PR02MB3608;
x-ms-traffictypediagnostic: SG2PR02MB3608:
x-microsoft-antispam-prvs: <SG2PR02MB3608E4ADCC4CF947328DA1F2E8500@SG2PR02MB3608.apcprd02.prod.outlook.com>
x-forefront-prvs: 0997523C40
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(396003)(39850400004)(136003)(366004)(376002)(189003)(199004)(33656002)(186003)(26005)(6436002)(3846002)(2501003)(6116002)(476003)(446003)(105586002)(316002)(68736007)(106356001)(2906002)(11346002)(229853002)(53936002)(25786009)(110136005)(6246003)(305945005)(7736002)(97736004)(74316002)(99286004)(5024004)(486006)(5660300002)(44832011)(66574012)(52536014)(478600001)(14454004)(7696005)(8936002)(8676002)(102836004)(76176011)(53546011)(78486014)(6506007)(71190400001)(86362001)(55016002)(9686003)(71200400001)(55236004)(81166006)(81156014)(14444005)(256004)(66066001)(586874002);DIR:OUT;SFP:1101;SCL:1;SRVR:SG2PR02MB3608;H:SG2PR02MB3098.apcprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: einfochips.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: tRiJbYgaqEl8TEz0/uORLDPaQ2dWghbagmdfWJcv/694uhTNFCz+5bUQlh++zPhsOjwBUUfUc5LSNENYAnxwTkbiaFCzw2KE7gnuW2te51gTe/c3oisn9fhQF+VgmL+oXgJbwyOLkEuXwe2+06W1rHD5c1AAdy3O0n56Fy9C4CKuRlda0+kD6s2joNanEt72P94fqwjTOtN0cUJERtH4Qgp+Ladwan1N5qnk8EmO+/jhl/AjTNKenX72EbjvgbvUNdzpJNW+Yz0WixxiP3wGMVTs58soZtvTLz3qhTXgKIqtuWA3WquyiVdueozcTFbOpoXdhtQeTKIGIrtVnsQW6fsxLqF/9B7HO59uHsrzxJvsXQJ62Mo5M3pI9xbMD7FtCrmXtDrjTl1ZLI+0MuNx2oZjQ2YK5FLkdPO7y/mJv/M=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: einfochips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1e2025e-e65e-4d08-1439-08d6b8dfd0c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2019 09:27:53.7355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0adb040b-ca22-4ca6-9447-ab7b049a22ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3608
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


________________________________________
From: Pankaj Suryawanshi
Sent: 03 April 2019 19:50
To: linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: How to calculate instruction executed for function

Hello,

How to calculate instruction executed for function ?

For eg.

I need to calculate instruction executed for CMA_ALLOC function.
How many instruction executed for cma_alloc ?


CMA_ALLOC :

        for 1 cma_alloc success call there will around 75 instruction is ex=
ecuted, excluding jump, mutex,error case and debug info instruction.

        below are mandatory jump calls that are required for successful all=
ocations.

        cma_bitmap_aligned_mask
        cma_bitmap_aligned_offset
        cma_bitmap_maxno
        cma_bitmap_pages_to_bits
        bitmap_find_next_zero_area_off -> find_next_zero_bit -> find_next_b=
it
        bitmap_set
        alloc_contig_range -> start_isolate_page_range
        __alloc_contig_migrate_range -> isolate_migratepages_range -> recla=
im_clean_pages_from_list -> shrink_page_list -> migrate_pages


        So lets say

        cma_bitmap_aligned_mask  =3D 1 instrs
        cma_bitmap_aligned_offset =3D 1 instrs
        cma_bitmap_maxno                  =3D 1 instrs
        cma_bitmap_pages_to_bits  =3D 1 instrs

        bitmap_find_next_zero_area_off -> find_next_zero_bit -> find_next_b=
it =3D 3 instrs
        bitmap_set  =3D 1 instrs
        alloc_contig_range -> start_isolate_page_range =3D

                                has_unmovable_pages =3D 1 instrs
                                get_pfnblock_flags_mask =3D 1 instrs
                                set_pageblock_migratetype =3D 1 instrs
                                move_freepages_block =3D 1 instrn
                                __mod_zone_page_state =3D 1 instrs store in=
fo in vmstat
                                unset_migratetype_isolate =3D 1 instrs

        __alloc_contig_migrate_range -> isolate_migratepages_range -> recla=
im_clean_pages_from_list -> shrink_page_list -> migrate_pages


        isolate_migratepages_range =3D 3 instrs
        reclaim_clean_pages_from_list =3D 2 instrs
        migrate_pages =3D 1 instrs

        --------------------------------------------------------------
        Total =3D around 20 instrs per page

        20 ns per page on 1ghz processor is minimum excluding any overheads=
 like mutex, variables, failure/error case,debug/prints.

I roughly calculated this.
Is it Correct ?


Any help would be appreciated.

Regards,
Pankaj
***************************************************************************=
***************************************************************************=
******* eInfochips Business Disclaimer: This e-mail message and all attachm=
ents transmitted with it are intended solely for the use of the addressee a=
nd may contain legally privileged and confidential information. If the read=
er of this message is not the intended recipient, or an employee or agent r=
esponsible for delivering this message to the intended recipient, you are h=
ereby notified that any dissemination, distribution, copying, or other use =
of this message or its attachments is strictly prohibited. If you have rece=
ived this message in error, please notify the sender immediately by replyin=
g to this message and please delete it from your computer. Any views expres=
sed in this message are those of the individual sender unless otherwise sta=
ted. Company has taken enough precautions to prevent the spread of viruses.=
 However the company accepts no liability for any damage caused by any viru=
s transmitted by this email. **********************************************=
***************************************************************************=
************************************
