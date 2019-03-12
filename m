Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4711C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764BB214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 00:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="G9ml4em5";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="bF+DyOyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbfCLAWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 20:22:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51246 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726209AbfCLAWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 20:22:47 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2C0Jx8X017217;
        Mon, 11 Mar 2019 17:22:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=EZUqru2XFA5VyKAwuANLKreMYk6ZO87OW0FfveLT9y4=;
 b=G9ml4em5BCO/lqLZGZt5AvoH7hA6+qsLgHLzABO+2Vueb3GfZ4wIH4oJOu3MYtuz48mg
 j1Z5cXS0VpGhhEOwlz/E7jWIL+N8SOUyLNGb649+M/9LX7Cd86Gpd5ADaTSNEgyDQJZ6
 E4tt9aYU/0/3dPTL+EcYilykz8qjiEAkUUI= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r61ckr7db-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 11 Mar 2019 17:22:33 -0700
Received: from prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) by
 prn-hub02.TheFacebook.com (2620:10d:c081:35::126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:22:33 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx05.TheFacebook.com (2620:10d:c081:6::19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 11 Mar 2019 17:22:32 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Mar 2019 17:22:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZUqru2XFA5VyKAwuANLKreMYk6ZO87OW0FfveLT9y4=;
 b=bF+DyOySXhu+4pwXikPEc4GJsCWTZL0xJ5kxyBMuxWeSSZsB1jHm8Y+nbOyPoCobst3S9mjrxGExJQSRyg6eY4QVBu1ceDGMs/GTolx9CJ/a8IfhPjan1HgZFKZXHZU4k0J85qDOWwsjpT5fC22D3+DihSyt4aDkcGJ06fLJuxA=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2277.namprd15.prod.outlook.com (52.135.197.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.18; Tue, 12 Mar 2019 00:22:23 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 00:22:23 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Topic: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Index: AQHU16bt6o0Uju0YQ0mKx1ZofK0W1KYGcySAgACefICAABJggA==
Date:   Tue, 12 Mar 2019 00:22:23 +0000
Message-ID: <20190312002217.GA31718@tower.DHCP.thefacebook.com>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
In-Reply-To: <20190311231633.GF19508@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0051.namprd12.prod.outlook.com
 (2603:10b6:300:103::13) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:b487]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99105728-2c96-4369-0985-08d6a680cc2b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2277;
x-ms-traffictypediagnostic: BYAPR15MB2277:
x-microsoft-exchange-diagnostics: 1;BYAPR15MB2277;20:j2HEAzGPQrT12A5YakqCjunL279UwwJ2XjS9VQcb0yDsReL20QOPljntn9jVIBhFN3QhA1W5x7BsI5q6nv9lNb8yuV6cL/yfMBZcNzHvBupLRAanCywaYW9+TeUmYNdjWC7IRw7kXRM3Pvf11VgLpz20edHOd3DtWSxIFKLGswI=
x-microsoft-antispam-prvs: <BYAPR15MB2277084A6807D17C1D90A778BE490@BYAPR15MB2277.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(366004)(136003)(346002)(189003)(199004)(6506007)(105586002)(76176011)(386003)(8936002)(316002)(6246003)(99286004)(4326008)(8676002)(14454004)(25786009)(54906003)(478600001)(52116002)(33656002)(106356001)(86362001)(6486002)(229853002)(256004)(81156014)(6916009)(81166006)(2906002)(53936002)(5660300002)(6436002)(9686003)(486006)(446003)(476003)(71200400001)(71190400001)(6512007)(46003)(102836004)(7736002)(97736004)(6116002)(305945005)(68736007)(1076003)(186003)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2277;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FDh92YlZhSWl4jGk6TDt7nuSmVStS1n3fSuB75VwysyYmEiCP/CndcMBMn37ptykSxzFFa7Do4fa3m9XjUrV3542EKEbUppSaei8CkOmYJEN8hGVId8QqBOCM+7UD5qMem9xuw2bRu6MLdnjGNmGkP9E+m4eg35ux3YRC4ZNIDY45/kNnG0V+2jJr6eZgyklIseI5DZDEGNKEb2w+AJnSujmZeJHOLvBzYzTt2vDfOFfLV1EYvlIR+y4etXrjszX/L541m4PigyHMbfVMP11aMlsHqi0RWwiHcY+4ep5SzFDfM+F2j4YJDxhSLzdvZlIU/zxhIft9J6MHMdj8vvDftN/3RbWKOUNsSkUR6BWG6rv4JzxgsQGi2qGuErlNrdBQjc53C0MxSqBX4y5wpkOYzE1in7ExI1ECLZn09G0x8I=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C0F0C1D7F614A47853BB28A21E359F7@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 99105728-2c96-4369-0985-08d6a680cc2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 00:22:23.3192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2277
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-11_17:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 04:16:33PM -0700, Matthew Wilcox wrote:
> On Mon, Mar 11, 2019 at 08:49:23PM +0000, Roman Gushchin wrote:
> > The patchset looks good to me, however I'd add some clarifications
> > why switching from lru to slab_list is safe.
> >=20
> > My understanding is that the slab_list fields isn't currently in use,
> > but it's not that obvious that putting slab_list and next/pages/pobject=
s
> > fields into a union is safe (for the slub case).
>=20
> It's already in a union.
>=20
> struct page {
>         union {
>                 struct {        /* Page cache and anonymous pages */
>                         struct list_head lru;
> ...
>                 struct {        /* slab, slob and slub */
>                         union {
>                                 struct list_head slab_list;     /* uses l=
ru */
>                                 struct {        /* Partial pages */
>                                         struct page *next;
>=20
> slab_list and lru are in the same bits.  Once this patch set is in,
> we can remove the enigmatic 'uses lru' comment that I added.

Ah, perfect, thanks! Makes total sense then.

Tobin, can you, please, add a note to the commit message?
With the note:
Reviewed-by: Roman Gushchin <guro@fb.com>

Thank you!
