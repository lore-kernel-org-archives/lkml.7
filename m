Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA92C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21D922177E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 17:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="YYmQhan9";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="kh5zUL2P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfCLRWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 13:22:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46476 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729768AbfCLRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 13:20:59 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2CHAxb9010310;
        Tue, 12 Mar 2019 10:20:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=nLdvTJ8DuRYxmovRcs3ePtRy9Whv8C1bohC+P15QScE=;
 b=YYmQhan9Vc2h0M+jGyFTjfgPxqqkklFMW8rjhxZxHlPrIv/rKOjKndGcsxk3X3QNkXwW
 7ygSSAphZgC2rT1bEBBmlZooPDCKgYIPMJCLwTxeLBR7G0n6RjiUp3VRfmhXuqGDZ+lE
 ZPbrYPURHEINuxQatp+TluwzZqhcaZY3dwM= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2r6epjrnv6-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 12 Mar 2019 10:20:38 -0700
Received: from frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) by
 frc-hub04.TheFacebook.com (2620:10d:c021:18::174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 10:19:28 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-mbx01.TheFacebook.com (2620:10d:c0a1:f82::25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 12 Mar 2019 10:19:27 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 12 Mar 2019 10:19:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLdvTJ8DuRYxmovRcs3ePtRy9Whv8C1bohC+P15QScE=;
 b=kh5zUL2Pk0UCCHg/+j7t6TPqkk3oLUScdVAJTkhSvv1AKDzkz4yAWQdxQX+rq66mwYmgaVzbSIpCXdhJBBezX+4m7mXhmFec9YzrSQeigDYI+FgWItWO9KNIhTIcipjd7X/PEx4+jmuOkcykSPb4hUPaAwTcaGF2SR6hpuonxZc=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB3221.namprd15.prod.outlook.com (20.179.56.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Tue, 12 Mar 2019 17:19:26 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%2]) with mapi id 15.20.1686.021; Tue, 12 Mar 2019
 17:19:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     "Tobin C. Harding" <me@tobin.cc>
CC:     Matthew Wilcox <willy@infradead.org>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christoph Lameter" <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Topic: [PATCH 0/4] mm: Use slab_list list_head instead of lru
Thread-Index: AQHU16bt6o0Uju0YQ0mKx1ZofK0W1KYGcySAgACefID//50HgIAAkSuAgAEAVoA=
Date:   Tue, 12 Mar 2019 17:19:25 +0000
Message-ID: <20190312171921.GB32504@tower.DHCP.thefacebook.com>
References: <20190311010744.5862-1-tobin@kernel.org>
 <20190311204919.GA20002@tower.DHCP.thefacebook.com>
 <20190311231633.GF19508@bombadil.infradead.org>
 <20190312002217.GA31718@tower.DHCP.thefacebook.com>
 <20190312020153.GJ9362@eros.localdomain>
In-Reply-To: <20190312020153.GJ9362@eros.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0171.namprd04.prod.outlook.com
 (2603:10b6:104:4::25) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:d3a0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40cde56f-a354-4186-06ba-08d6a70ee066
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB3221;
x-ms-traffictypediagnostic: BYAPR15MB3221:
x-microsoft-antispam-prvs: <BYAPR15MB32213138F8B80CBE8D7F2FEBBE490@BYAPR15MB3221.namprd15.prod.outlook.com>
x-forefront-prvs: 09749A275C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(346002)(376002)(366004)(396003)(189003)(199004)(71190400001)(71200400001)(14454004)(256004)(6246003)(5660300002)(86362001)(4326008)(102836004)(1076003)(97736004)(2906002)(478600001)(229853002)(25786009)(54906003)(9686003)(186003)(81156014)(81166006)(8936002)(486006)(6506007)(386003)(6116002)(6436002)(7416002)(46003)(76176011)(52116002)(68736007)(8676002)(6486002)(6512007)(11346002)(446003)(105586002)(53936002)(99286004)(476003)(7736002)(305945005)(93886005)(106356001)(316002)(33656002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB3221;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nR0JGRbIjxclYKjrhZiFxv8t4YzrNck+IEycBNzmypPGog8sUgmcV47DVA6cITuCzB/OeL+HQjrxWyXuX5UM0PIilgnO81oLO/tkVuaScvzx3adg73rHAtmbghH1oMaz/h4UCWcn47zXs9u/CcSvJzX/b9D9kjJQZNKqCqQmFnJLqSBndDoaElevygdA/l/dcS7c4GwHdjqnBAIXzrsNhM4Jo7RRDsL3CdQ3dpEcmFEXgGCr0Xh6lGzjfmi5C1vOBqcy4HWF3l/+BsRkWSAjo/agP+LqVQ3e3h5bMJttA2uFITXVLvDUQal7LJ2UE0FsbNMag1oPomoQ+64DUcaugxgLcYNjQHMn5sl26YjgPRSDzfwjbLVKjHm8zZVSi7AD8RrCvNTyS4wAIQ50SNiQSfNINTXdOxjee10PAVZJioY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BCB53A89903AC4AB1F543465A340C20@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 40cde56f-a354-4186-06ba-08d6a70ee066
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2019 17:19:25.8429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3221
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-12_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2019 at 01:01:53PM +1100, Tobin C. Harding wrote:
> On Tue, Mar 12, 2019 at 12:22:23AM +0000, Roman Gushchin wrote:
> > On Mon, Mar 11, 2019 at 04:16:33PM -0700, Matthew Wilcox wrote:
> > > On Mon, Mar 11, 2019 at 08:49:23PM +0000, Roman Gushchin wrote:
> > > > The patchset looks good to me, however I'd add some clarifications
> > > > why switching from lru to slab_list is safe.
> > > >=20
> > > > My understanding is that the slab_list fields isn't currently in us=
e,
> > > > but it's not that obvious that putting slab_list and next/pages/pob=
jects
> > > > fields into a union is safe (for the slub case).
> > >=20
> > > It's already in a union.
> > >=20
> > > struct page {
> > >         union {
> > >                 struct {        /* Page cache and anonymous pages */
> > >                         struct list_head lru;
> > > ...
> > >                 struct {        /* slab, slob and slub */
> > >                         union {
> > >                                 struct list_head slab_list;     /* us=
es lru */
> > >                                 struct {        /* Partial pages */
> > >                                         struct page *next;
> > >=20
> > > slab_list and lru are in the same bits.  Once this patch set is in,
> > > we can remove the enigmatic 'uses lru' comment that I added.
> >=20
> > Ah, perfect, thanks! Makes total sense then.
> >=20
> > Tobin, can you, please, add a note to the commit message?
> > With the note:
> > Reviewed-by: Roman Gushchin <guro@fb.com>
>=20
> Awesome, thanks.  That's for all 4 patches or excluding 2?

To all 4, given that you'll add some explanations to the commit message.

Thanks!
