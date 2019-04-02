Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1DC4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682322082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 15:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="fWk/BPzn";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="aKjmWCvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbfDBPgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 11:36:02 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38816 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729322AbfDBPgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 11:36:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x32FTccT025652;
        Tue, 2 Apr 2019 08:35:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=GC263lz6SEPClihDzLqKbPyPtwufaVvZBQx+CnE4sxs=;
 b=fWk/BPznWsNUlId80PQHjYaNJUgHJkUCSUbMe3tf5jIuKMAUH3425WFu1Ryc97yojSJe
 99nDIIut3TlFqHKIro2eoRGUajjOA8yxvadPctyJtNhZgRer8wgtdGMPpfuahYaYuTCP
 oJ5+FSs7NlnIH80+OBNrAgeeQRPRFrQvzwE= 
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2rma2p83v1-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Apr 2019 08:35:05 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 2 Apr 2019 08:34:53 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Apr 2019 08:34:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GC263lz6SEPClihDzLqKbPyPtwufaVvZBQx+CnE4sxs=;
 b=aKjmWCvXqzGCxwuerBotOB6tF/H2h5z/4lwvEcnP3hU1DOSayy32kwEi79pCaKyKWBM99+JbAa4JnjzHFB58KUq6wf9OaSwytF7AVFJM6vCYsjiP9FbcjZhiknN2P7wxEFShI9al4aL0piwAL7TbrbVkYhXJRtT/ueYPfj+Qa58=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.255.19) by
 MWHPR15MB1182.namprd15.prod.outlook.com (10.175.2.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1750.16; Tue, 2 Apr 2019 15:34:50 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::d13:8c3d:9110:b44a%8]) with mapi id 15.20.1750.014; Tue, 2 Apr 2019
 15:34:50 +0000
From:   Martin Lau <kafai@fb.com>
To:     hujunwei <hujunwei4@huawei.com>
CC:     kbuild test robot <lkp@intel.com>,
        "kbuild-all@01.org" <kbuild-all@01.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "kuznet@ms2.inr.ac.ru" <kuznet@ms2.inr.ac.ru>,
        "yoshfuji@linux-ipv6.org" <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingfangsen@huawei.com" <mingfangsen@huawei.com>,
        "liuzhiqiang26@huawei.com" <liuzhiqiang26@huawei.com>,
        "zhangwenhao8@huawei.com" <zhangwenhao8@huawei.com>,
        "wangxiaogang3@huawei.com" <wangxiaogang3@huawei.com>
Subject: Re: [PATCH v3 net] ipv6: Fix dangling pointer when ipv6 fragment
Thread-Topic: [PATCH v3 net] ipv6: Fix dangling pointer when ipv6 fragment
Thread-Index: AQHU6QGY41iFqXtDK0KeXAA72741FKYosVyAgABPzwA=
Date:   Tue, 2 Apr 2019 15:34:50 +0000
Message-ID: <20190402153413.wyg5w4x33qvzqpm6@kafai-mbp.dhcp.thefacebook.com>
References: <44e8dcf8-bf64-0407-65bb-122d0853c672@huawei.com>
 <201904021813.GLngbeGC%lkp@intel.com>
In-Reply-To: <201904021813.GLngbeGC%lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:4e::19)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:ca89]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47743cbc-08b6-4ad8-965f-08d6b780be64
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600139)(711020)(4605104)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:MWHPR15MB1182;
x-ms-traffictypediagnostic: MWHPR15MB1182:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <MWHPR15MB1182FEFB2FAF6BAB9F158295D5560@MWHPR15MB1182.namprd15.prod.outlook.com>
x-forefront-prvs: 0995196AA2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(189003)(199004)(1076003)(52116002)(446003)(11346002)(229853002)(68736007)(5024004)(14444005)(256004)(71200400001)(86362001)(8676002)(6506007)(97736004)(6116002)(4326008)(76176011)(6916009)(386003)(478600001)(71190400001)(5660300002)(14454004)(6306002)(7736002)(486006)(9686003)(476003)(316002)(25786009)(102836004)(99286004)(53936002)(8936002)(966005)(81156014)(2906002)(46003)(6486002)(7416002)(81166006)(54906003)(6436002)(105586002)(106356001)(186003)(305945005)(6512007)(6246003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1182;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: JE4jIs3SbntMF1E+BXbbf0m+96vfK6O3jfN0kJ1rzHmneZy1V7sW+EWuOaa8lv64PPFZlPATzoEhLnQn+9ASpxomw+Ipfj9Qe/TQ6eJM1QHjf8VKTdL7GeToP+QYbgAXwxMZ4LoC8rgCzOo4242r7a00Y4AzfDQmvxq925z/8pKFzjHsbl5QIOL7soEzrKV5sRnfxDjdz2pjAjR3hSYhuMb5FmU7PGwh5GcoiQ6j+S6lgGuoBWtL4nDVs5kty5rrbUVG7fPfCTQm38Tw63RkjXDz6kVrcXPs50AveHozM62WDfPhXF9n/DOimJoK7cneJBQPRT0fPCg37SsCDzi7MCgVcpNKFp1vNYC/mnBullmMkX+qWQio0K3uA46sSwEAs1F723uUjt7j6WDYMzJTpeutGTsjqr+Sqy4e5Hpd4Q0=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DB02E98D8F64D46BBB9C54AD140FA3E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 47743cbc-08b6-4ad8-965f-08d6b780be64
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2019 15:34:50.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1182
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-04-02_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 02, 2019 at 06:49:03PM +0800, kbuild test robot wrote:
> Hi hujunwei,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on net/master]
>=20
> url:    https://github.com/0day-ci/linux/commits/hujunwei/ipv6-Fix-dangli=
ng-pointer-when-ipv6-fragment/20190402-175602
> config: i386-randconfig-x005-201913 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> All warnings (new ones prefixed by >>):
>=20
>    net//ipv6/ip6_output.c: In function 'ip6_fragment':
> >> net//ipv6/ip6_output.c:609:27: warning: 'prevhdr' is used uninitialize=
d in this function [-Wuninitialized]
>      nexthdr_offset =3D prevhdr - skb_network_header(skb);
>                       ~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> vim +/prevhdr +609 net//ipv6/ip6_output.c
>=20
>    594=09
>    595	int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff =
*skb,
>    596			 int (*output)(struct net *, struct sock *, struct sk_buff *))
>    597	{
>    598		struct sk_buff *frag;
>    599		struct rt6_info *rt =3D (struct rt6_info *)skb_dst(skb);
>    600		struct ipv6_pinfo *np =3D skb->sk && !dev_recursion_level() ?
>    601					inet6_sk(skb->sk) : NULL;
>    602		struct ipv6hdr *tmp_hdr;
>    603		struct frag_hdr *fh;
>    604		unsigned int mtu, hlen, left, len, nexthdr_offset;
>    605		int hroom, troom;
>    606		__be32 frag_id;
>    607		int ptr, offset =3D 0, err =3D 0;
>    608		u8 *prevhdr, nexthdr =3D 0;
>  > 609		nexthdr_offset =3D prevhdr - skb_network_header(skb);
hmm... This line has been moved up since v2. :(

>    610=09
>    611		err =3D ip6_find_1stfragopt(skb, &prevhdr);
>    612		if (err < 0)
>    613			goto fail;
>    614		hlen =3D err;
>    615		nexthdr =3D *prevhdr;
>    616=09
>    617		mtu =3D ip6_skb_dst_mtu(skb);
>    618=09
>    619		/* We must not fragment if the socket is set to force MTU discove=
ry
>    620		 * or if the skb it not generated by a local socket.
>    621		 */
>    622		if (unlikely(!skb->ignore_df && skb->len > mtu))
>    623			goto fail_toobig;
>    624=09
>    625		if (IP6CB(skb)->frag_max_size) {
>    626			if (IP6CB(skb)->frag_max_size > mtu)
>    627				goto fail_toobig;
>    628=09
>    629			/* don't send fragments larger than what we received */
>    630			mtu =3D IP6CB(skb)->frag_max_size;
>    631			if (mtu < IPV6_MIN_MTU)
>    632				mtu =3D IPV6_MIN_MTU;
>    633		}
>    634=09
>    635		if (np && np->frag_size < mtu) {
>    636			if (np->frag_size)
>    637				mtu =3D np->frag_size;
>    638		}
>    639		if (mtu < hlen + sizeof(struct frag_hdr) + 8)
>    640			goto fail_toobig;
>    641		mtu -=3D hlen + sizeof(struct frag_hdr);
>    642=09
>    643		frag_id =3D ipv6_select_ident(net, &ipv6_hdr(skb)->daddr,
>    644					    &ipv6_hdr(skb)->saddr);
>    645=09
>    646		if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
>    647		    (err =3D skb_checksum_help(skb)))
>    648			goto fail;
>    649=09
>    650		prevhdr =3D skb_network_header(skb) + nexthdr_offset;
>    651		hroom =3D LL_RESERVED_SPACE(rt->dst.dev);
>    652		if (skb_has_frag_list(skb)) {
>    653			unsigned int first_len =3D skb_pagelen(skb);
>    654			struct sk_buff *frag2;
>    655=09
>    656			if (first_len - hlen > mtu ||
>    657			    ((first_len - hlen) & 7) ||
>    658			    skb_cloned(skb) ||
>    659			    skb_headroom(skb) < (hroom + sizeof(struct frag_hdr)))
>    660				goto slow_path;
>    661=09
>    662			skb_walk_frags(skb, frag) {
>    663				/* Correct geometry. */
>    664				if (frag->len > mtu ||
>    665				    ((frag->len & 7) && frag->next) ||
>    666				    skb_headroom(frag) < (hlen + hroom + sizeof(struct frag_hdr=
)))
>    667					goto slow_path_clean;
>    668=09
>    669				/* Partially cloned skb? */
>    670				if (skb_shared(frag))
>    671					goto slow_path_clean;
>    672=09
>    673				BUG_ON(frag->sk);
>    674				if (skb->sk) {
>    675					frag->sk =3D skb->sk;
>    676					frag->destructor =3D sock_wfree;
>    677				}
>    678				skb->truesize -=3D frag->truesize;
>    679			}
>    680=09
>    681			err =3D 0;
>    682			offset =3D 0;
>    683			/* BUILD HEADER */
>    684=09
>    685			*prevhdr =3D NEXTHDR_FRAGMENT;
>    686			tmp_hdr =3D kmemdup(skb_network_header(skb), hlen, GFP_ATOMIC);
>    687			if (!tmp_hdr) {
>    688				err =3D -ENOMEM;
>    689				goto fail;
>    690			}
>    691			frag =3D skb_shinfo(skb)->frag_list;
>    692			skb_frag_list_init(skb);
>    693=09
>    694			__skb_pull(skb, hlen);
>    695			fh =3D __skb_push(skb, sizeof(struct frag_hdr));
>    696			__skb_push(skb, hlen);
>    697			skb_reset_network_header(skb);
>    698			memcpy(skb_network_header(skb), tmp_hdr, hlen);
>    699=09
>    700			fh->nexthdr =3D nexthdr;
>    701			fh->reserved =3D 0;
>    702			fh->frag_off =3D htons(IP6_MF);
>    703			fh->identification =3D frag_id;
>    704=09
>    705			first_len =3D skb_pagelen(skb);
>    706			skb->data_len =3D first_len - skb_headlen(skb);
>    707			skb->len =3D first_len;
>    708			ipv6_hdr(skb)->payload_len =3D htons(first_len -
>    709							   sizeof(struct ipv6hdr));
>    710=09
>    711			for (;;) {
>    712				/* Prepare header of the next frame,
>    713				 * before previous one went down. */
>    714				if (frag) {
>    715					frag->ip_summed =3D CHECKSUM_NONE;
>    716					skb_reset_transport_header(frag);
>    717					fh =3D __skb_push(frag, sizeof(struct frag_hdr));
>    718					__skb_push(frag, hlen);
>    719					skb_reset_network_header(frag);
>    720					memcpy(skb_network_header(frag), tmp_hdr,
>    721					       hlen);
>    722					offset +=3D skb->len - hlen - sizeof(struct frag_hdr);
>    723					fh->nexthdr =3D nexthdr;
>    724					fh->reserved =3D 0;
>    725					fh->frag_off =3D htons(offset);
>    726					if (frag->next)
>    727						fh->frag_off |=3D htons(IP6_MF);
>    728					fh->identification =3D frag_id;
>    729					ipv6_hdr(frag)->payload_len =3D
>    730							htons(frag->len -
>    731							      sizeof(struct ipv6hdr));
>    732					ip6_copy_metadata(frag, skb);
>    733				}
>    734=09
>    735				err =3D output(net, sk, skb);
>    736				if (!err)
>    737					IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
>    738						      IPSTATS_MIB_FRAGCREATES);
>    739=09
>    740				if (err || !frag)
>    741					break;
>    742=09
>    743				skb =3D frag;
>    744				frag =3D skb->next;
>    745				skb_mark_not_on_list(skb);
>    746			}
>    747=09
>    748			kfree(tmp_hdr);
>    749=09
>    750			if (err =3D=3D 0) {
>    751				IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
>    752					      IPSTATS_MIB_FRAGOKS);
>    753				return 0;
>    754			}
>    755=09
>    756			kfree_skb_list(frag);
>    757=09
>    758			IP6_INC_STATS(net, ip6_dst_idev(&rt->dst),
>    759				      IPSTATS_MIB_FRAGFAILS);
>    760			return err;
>    761=09
>    762	slow_path_clean:
>    763			skb_walk_frags(skb, frag2) {
>    764				if (frag2 =3D=3D frag)
>    765					break;
>    766				frag2->sk =3D NULL;
>    767				frag2->destructor =3D NULL;
>    768				skb->truesize +=3D frag2->truesize;
>    769			}
>    770		}
>    771=09
>    772	slow_path:
>    773		left =3D skb->len - hlen;		/* Space per frame */
>    774		ptr =3D hlen;			/* Where to start from */
>    775=09
>    776		/*
>    777		 *	Fragment the datagram.
>    778		 */
>    779=09
>    780		troom =3D rt->dst.dev->needed_tailroom;
>    781=09
>    782		/*
>    783		 *	Keep copying data until we run out.
>    784		 */
>    785		while (left > 0)	{
>    786			u8 *fragnexthdr_offset;
>    787=09
>    788			len =3D left;
>    789			/* IF: it doesn't fit, use 'mtu' - the data space left */
>    790			if (len > mtu)
>    791				len =3D mtu;
>    792			/* IF: we are not sending up to and including the packet end
>    793			   then align the next start on an eight byte boundary */
>    794			if (len < left)	{
>    795				len &=3D ~7;
>    796			}
>    797=09
>    798			/* Allocate buffer */
>    799			frag =3D alloc_skb(len + hlen + sizeof(struct frag_hdr) +
>    800					 hroom + troom, GFP_ATOMIC);
>    801			if (!frag) {
>    802				err =3D -ENOMEM;
>    803				goto fail;
>    804			}
>    805=09
>    806			/*
>    807			 *	Set up data on packet
>    808			 */
>    809=09
>    810			ip6_copy_metadata(frag, skb);
>    811			skb_reserve(frag, hroom);
>    812			skb_put(frag, len + hlen + sizeof(struct frag_hdr));
>    813			skb_reset_network_header(frag);
>    814			fh =3D (struct frag_hdr *)(skb_network_header(frag) + hlen);
>    815			frag->transport_header =3D (frag->network_header + hlen +
>    816						  sizeof(struct frag_hdr));
>    817=09
>    818			/*
>    819			 *	Charge the memory for the fragment to any owner
>    820			 *	it might possess
>    821			 */
>    822			if (skb->sk)
>    823				skb_set_owner_w(frag, skb->sk);
>    824=09
>    825			/*
>    826			 *	Copy the packet header into the new buffer.
>    827			 */
>    828			skb_copy_from_linear_data(skb, skb_network_header(frag), hlen);
>    829=09
>    830			fragnexthdr_offset =3D skb_network_header(frag);
>    831			fragnexthdr_offset +=3D prevhdr - skb_network_header(skb);
>    832			*fragnexthdr_offset =3D NEXTHDR_FRAGMENT;
>    833=09
>    834			/*
>    835			 *	Build fragment header.
>    836			 */
>    837			fh->nexthdr =3D nexthdr;
>    838			fh->reserved =3D 0;
>    839			fh->identification =3D frag_id;
>    840=09
>    841			/*
>    842			 *	Copy a block of the IP datagram.
>    843			 */
>    844			BUG_ON(skb_copy_bits(skb, ptr, skb_transport_header(frag),
>    845					     len));
>    846			left -=3D len;
>    847=09
>    848			fh->frag_off =3D htons(offset);
>    849			if (left > 0)
>    850				fh->frag_off |=3D htons(IP6_MF);
>    851			ipv6_hdr(frag)->payload_len =3D htons(frag->len -
>    852							    sizeof(struct ipv6hdr));
>    853=09
>    854			ptr +=3D len;
>    855			offset +=3D len;
>    856=09
>    857			/*
>    858			 *	Put this fragment into the sending queue.
>    859			 */
>    860			err =3D output(net, sk, frag);
>    861			if (err)
>    862				goto fail;
>    863=09
>    864			IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
>    865				      IPSTATS_MIB_FRAGCREATES);
>    866		}
>    867		IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
>    868			      IPSTATS_MIB_FRAGOKS);
>    869		consume_skb(skb);
>    870		return err;
>    871=09
>    872	fail_toobig:
>    873		if (skb->sk && dst_allfrag(skb_dst(skb)))
>    874			sk_nocaps_add(skb->sk, NETIF_F_GSO_MASK);
>    875=09
>    876		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
>    877		err =3D -EMSGSIZE;
>    878=09
>    879	fail:
>    880		IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
>    881			      IPSTATS_MIB_FRAGFAILS);
>    882		kfree_skb(skb);
>    883		return err;
>    884	}
>    885=09
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists.01.org_piper=
mail_kbuild-2Dall&d=3DDwIBAg&c=3D5VD0RTtNlTh3ycd41b3MUw&r=3DVQnoQ7LvghIj0gV=
EaiQSUw&m=3DVM2d9MD3GON8eQRY0bYRU7OGyFCoSiaFiYJJa6-3rDU&s=3Dp3p0GnDqN_d4cCU=
IgH993sIXi_Sw8tUInnni3uMPXKk&e=3D                   Intel Corporation


