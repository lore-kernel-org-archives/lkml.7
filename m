Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A660CC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:05:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6922721881
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 18:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="2JXH62tQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387643AbfHZSFi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 14:05:38 -0400
Received: from mail-eopbgr800078.outbound.protection.outlook.com ([40.107.80.78]:15968
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732707AbfHZSFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 14:05:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KAaZssxXOxY5qDe1rx2z1JrAXQpgd3T3BJwDvhZsWAtyCl6iJ5Qkn6HgpDgCBQ1QBlklVnwxBV5pbincFq4oMwpHHl0OzsmkoWicLQMgbi7gWYDssK2PkVaPieVB3qO8gSChjqtDkV+3NvAdYJpRh7vDNZrglEG4CWznOAU+MeRWZLuLMyUlYCjnPZwReGG8mymCgDYBj+iw6nwgd1smN+ebwjdWFXi4eKU+MyiId/2DIoiibkROgDxfGlbl36IS8ZalSHzj6HM9OhvZJECQcoRZ40IibIqDYUZUuatLzsiXvACUMp6axGg4Pw+lXA0f+NoSX3sZcBRNY+tyFXBXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoro5Ncpx93BRZRcBG9y0cyhQ1FZd3tVQsqjiB0ANlE=;
 b=WwGwtb7dwytVl59L0OiIFP7XX/iEZvC8+Xjr9BaOuJzFMauv66Ch6Q3G3hHnHCJh0ODYYHOn9Og+FPG4O7Lv1C4qNqLNldhSjjwtQzRYkCbJ2YhOLIxCU34a5p+GZlh5XO4jCsM+KHVckWAozxRG4gh18kJsZwbNynPl/qkqzHcJOO2Lc5SW59uhHD6XnBNUcXmYG5eR8QO5DJqwc6w6qzBVZ2hUXp4IfoYisBFRH+rbda9fu4m5VwKU7H4dOJImbNLbeQjWJKaMlEezZHbOTRSGfIJMWcUPMgaBkt9l2nrtPyu6aR6pvLeewT1U4OLQmwdWv3ZJUFXDD+gq6TjxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aoro5Ncpx93BRZRcBG9y0cyhQ1FZd3tVQsqjiB0ANlE=;
 b=2JXH62tQjELCulvsbXr9MJGiJSbbdBbJ9V9g+Gy8h4XtbpE9FBIqI3x2hIQP5WB6sHnMYC/oLWL4dILaiRQJRjkhOvtVpO/YZ3OZ8bgzb4jUMY9JlbIxi4NKvwpiBDHh5caKvrHptGMXubEMxGzYVLkTzEynw6W/eTAg325gsJQ=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (52.135.233.146) by
 BYAPR05MB4312.namprd05.prod.outlook.com (52.135.202.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.7; Mon, 26 Aug 2019 18:05:23 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::5163:1b6f:2d03:303d%3]) with mapi id 15.20.2220.013; Mon, 26 Aug 2019
 18:05:23 +0000
From:   Nadav Amit <namit@vmware.com>
To:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Pv-drivers <Pv-drivers@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Hellstrom <thellstrom@vmware.com>
Subject: Re: [PATCH] vmw_balloon: Fix offline page marking with compaction
Thread-Topic: [PATCH] vmw_balloon: Fix offline page marking with compaction
Thread-Index: AQHVV64d1HOoTmjqTUG8P4f8QvU0pacFRgSAgAh8RwA=
Date:   Mon, 26 Aug 2019 18:05:23 +0000
Message-ID: <76F0FD32-C8AD-4418-8DF0-92380E4A3F05@vmware.com>
References: <20190820160121.452-1-namit@vmware.com>
 <291b8bcd-df68-3f5e-2985-fcaa46c1ff38@redhat.com>
In-Reply-To: <291b8bcd-df68-3f5e-2985-fcaa46c1ff38@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [66.170.99.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9019cb1c-2758-4057-5b6b-08d72a4ff768
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600166)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR05MB4312;
x-ms-traffictypediagnostic: BYAPR05MB4312:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB43125E464B8B5354B471BA84D0A10@BYAPR05MB4312.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-forefront-prvs: 01415BB535
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(39860400002)(396003)(346002)(376002)(189003)(51234002)(199004)(33656002)(6436002)(81166006)(81156014)(107886003)(8676002)(6116002)(53936002)(3846002)(25786009)(66066001)(14454004)(64756008)(76116006)(486006)(7736002)(4326008)(66476007)(66446008)(5660300002)(66556008)(86362001)(6486002)(2906002)(8936002)(36756003)(6512007)(476003)(229853002)(110136005)(66946007)(316002)(76176011)(54906003)(6246003)(53546011)(186003)(102836004)(26005)(6506007)(256004)(305945005)(14444005)(71200400001)(2616005)(446003)(478600001)(11346002)(71190400001)(99286004);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR05MB4312;H:BYAPR05MB4776.namprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CjbdPVwpXrSD7chrWlitbP/PF9fs9L/uCQaR6CBXwaCSyzIwn9ZMQPxg6AHud2uheiaF7jpblRSHmDRf9iX8ZvLZJUp/0jPNdCxGpA84t+8v7WTi/TpFds+hFkjMx+1F5CvcJ0LOn2jl/INggHgoqk1/6eGP2nasj97FGFhGefOBo/KCoX7yQ4To3kMfYnA/tDqEqbjhCoExSvlT191WY2O4XA8GSnHKR1pGq7gqIa7RurkBkh5oSLVzhKxjDwz7mTKZuZ3YlOlHk2XdLmfL+T2tzw+oewgtAWSDkrwLS5wNP1Xo/F+0scY7TQjvrFoI301z3sDQk5aIO5cZoP+7Lrf5hmx6mMI8VZu51xHEQdqU4sqTMh+XNw1JgE0IA3/81QUzZ/lCOiwCq/GYAHXBDlVDiigNHtUFpct2QCPC+j8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D9B31EDE650E748B5F08CB89CB5C914@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9019cb1c-2758-4057-5b6b-08d72a4ff768
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2019 18:05:23.4790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGflq8oBEmNn8b0CvRuh10t0SYSXBZPuDiMJGXg2luXhoLYBdWwVFSJUe0mRDSkp3cHaF+r5AGyUKXHy/9YmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4312
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Aug 21, 2019, at 1:30 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 20.08.19 18:01, Nadav Amit wrote:
>> The compaction code already marks pages as offline when it enqueues
>> pages in the ballooned page list, and removes the mapping when the pages
>> are removed from the list. VMware balloon also updates the flags,
>> instead of letting the balloon-compaction logic handle it, which causes
>> the assertion VM_BUG_ON_PAGE(!PageOffline(page)) to fire, when
>> __ClearPageOffline is called the second time. This causes the following
>> crash.
>>=20
>> [  487.104520] kernel BUG at include/linux/page-flags.h:749!
>> [  487.106364] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC PTI
>> [  487.107681] CPU: 7 PID: 1106 Comm: kworker/7:3 Not tainted 5.3.0-rc5b=
alloon #227
>> [  487.109196] Hardware name: VMware, Inc. VMware Virtual Platform/440BX=
 Desktop Reference Platform, BIOS 6.00 12/12/2018
>> [  487.111452] Workqueue: events_freezable vmballoon_work [vmw_balloon]
>> [  487.112779] RIP: 0010:vmballoon_release_page_list+0xaa/0x100 [vmw_bal=
loon]
>> [  487.114200] Code: fe 48 c1 e7 06 4c 01 c7 8b 47 30 41 89 c1 41 81 e1 =
00 01 00 f0 41 81 f9 00 00 00 f0 74 d3 48 c7 c6 08 a1 a1 c0 e8 06 0d e7 ea =
<0f> 0b 44 89 f6 4c 89 c7 e8 49 9c e9 ea 49 8d 75 08 49 8b 45 08 4d
>> [  487.118033] RSP: 0018:ffffb82f012bbc98 EFLAGS: 00010246
>> [  487.119135] RAX: 0000000000000037 RBX: 0000000000000001 RCX: 00000000=
00000006
>> [  487.120601] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9a85=
b6bd7620
>> [  487.122071] RBP: ffffb82f012bbcc0 R08: 0000000000000001 R09: 00000000=
00000000
>> [  487.123536] R10: 0000000000000000 R11: 0000000000000000 R12: ffffb82f=
012bbd00
>> [  487.125002] R13: ffffe97f4598d9c0 R14: 0000000000000000 R15: ffffb82f=
012bbd34
>> [  487.126463] FS:  0000000000000000(0000) GS:ffff9a85b6bc0000(0000) knl=
GS:0000000000000000
>> [  487.128110] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  487.129316] CR2: 00007ffe6e413ea0 CR3: 0000000230b18001 CR4: 00000000=
003606e0
>> [  487.130812] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000=
00000000
>> [  487.132283] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000=
00000400
>> [  487.133749] Call Trace:
>> [  487.134333]  vmballoon_deflate+0x22c/0x390 [vmw_balloon]
>> [  487.135468]  vmballoon_work+0x6e7/0x913 [vmw_balloon]
>> [  487.136711]  ? process_one_work+0x21a/0x5e0
>> [  487.138581]  process_one_work+0x298/0x5e0
>> [  487.139926]  ? vmballoon_migratepage+0x310/0x310 [vmw_balloon]
>> [  487.141610]  ? process_one_work+0x298/0x5e0
>> [  487.143053]  worker_thread+0x41/0x400
>> [  487.144389]  kthread+0x12b/0x150
>> [  487.145582]  ? process_one_work+0x5e0/0x5e0
>> [  487.146937]  ? kthread_create_on_node+0x60/0x60
>> [  487.148637]  ret_from_fork+0x3a/0x50
>>=20
>> Fix it by updating the PageOffline indication only when a 2MB page is
>> enqueued and dequeued. The 4KB pages will be handled correctly by the
>> balloon compaction logic.
>>=20
>> Fixes: 83a8afa72e9c ("vmw_balloon: Compaction support")
>> Cc: David Hildenbrand <david@redhat.com>
>> Reported-by: Thomas Hellstrom <thellstrom@vmware.com>
>> Signed-off-by: Nadav Amit <namit@vmware.com>
>> ---
>> drivers/misc/vmw_balloon.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/misc/vmw_balloon.c b/drivers/misc/vmw_balloon.c
>> index 8840299420e0..5e6be1527571 100644
>> --- a/drivers/misc/vmw_balloon.c
>> +++ b/drivers/misc/vmw_balloon.c
>> @@ -691,7 +691,6 @@ static int vmballoon_alloc_page_list(struct vmballoo=
n *b,
>> 		}
>>=20
>> 		if (page) {
>> -			vmballoon_mark_page_offline(page, ctl->page_size);
>> 			/* Success. Add the page to the list and continue. */
>> 			list_add(&page->lru, &ctl->pages);
>> 			continue;
>> @@ -930,7 +929,6 @@ static void vmballoon_release_page_list(struct list_=
head *page_list,
>>=20
>> 	list_for_each_entry_safe(page, tmp, page_list, lru) {
>> 		list_del(&page->lru);
>> -		vmballoon_mark_page_online(page, page_size);
>> 		__free_pages(page, vmballoon_page_order(page_size));
>> 	}
>>=20
>> @@ -1005,6 +1003,7 @@ static void vmballoon_enqueue_page_list(struct vmb=
alloon *b,
>> 					enum vmballoon_page_size_type page_size)
>> {
>> 	unsigned long flags;
>> +	struct page *page;
>>=20
>> 	if (page_size =3D=3D VMW_BALLOON_4K_PAGE) {
>> 		balloon_page_list_enqueue(&b->b_dev_info, pages);
>> @@ -1014,6 +1013,11 @@ static void vmballoon_enqueue_page_list(struct vm=
balloon *b,
>> 		 * for the balloon compaction mechanism.
>> 		 */
>> 		spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
>> +
>> +		list_for_each_entry(page, pages, lru) {
>> +			vmballoon_mark_page_offline(page, VMW_BALLOON_2M_PAGE);
>> +		}
>> +
>> 		list_splice_init(pages, &b->huge_pages);
>> 		__count_vm_events(BALLOON_INFLATE, *n_pages *
>> 				  vmballoon_page_in_frames(VMW_BALLOON_2M_PAGE));
>> @@ -1056,6 +1060,8 @@ static void vmballoon_dequeue_page_list(struct vmb=
alloon *b,
>> 	/* 2MB pages */
>> 	spin_lock_irqsave(&b->b_dev_info.pages_lock, flags);
>> 	list_for_each_entry_safe(page, tmp, &b->huge_pages, lru) {
>> +		vmballoon_mark_page_online(page, VMW_BALLOON_2M_PAGE);
>> +
>> 		list_move(&page->lru, pages);
>> 		if (++i =3D=3D n_req_pages)
>> 			break;
>=20
> Or check in vmballoon_mark_page_online/vmballoon_mark_page_offline if
> already properly marked, adding a comment. But what you have should also
> work.

I prefer to have the correct behavior, and avoid such a change, especially
since this is a regression.

Greg, can you get it into 5.3?

Thanks,
Nadav


