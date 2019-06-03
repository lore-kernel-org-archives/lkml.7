Return-Path: <SRS0=cV2B=UC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10677C04AB5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA92026EC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Jun 2019 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="ZJMk1TOp";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="Mb3ec1DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfFCUbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Jun 2019 16:31:43 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49600 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726163AbfFCUbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jun 2019 16:31:42 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x53KM55Y020253;
        Mon, 3 Jun 2019 13:30:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Cm7ryaXuFUYiWgw+pjH9SnNqXBRoDlGHD9r3IrqhOtk=;
 b=ZJMk1TOpd7ignu9o7qpsv0AddPqjSHpovo3Bjwjfrbqowhj0l6L1uNRgDJfQQNOVwc2u
 gF5v8fSd/e/VdaI9xOce6iMNjCaN6wecJHtEQvYuhEVLj7TDSrISOw2SvT0m83+dnnV8
 CWHt09kG4eJxpOf+u9I3TIGioZhqJzyn8qo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0b-00082601.pphosted.com with ESMTP id 2swa6s037u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 03 Jun 2019 13:30:29 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Jun 2019 13:30:29 -0700
Received: from ash-exhub201.TheFacebook.com (2620:10d:c0a8:83::7) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Jun 2019 13:30:28 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 3 Jun 2019 13:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cm7ryaXuFUYiWgw+pjH9SnNqXBRoDlGHD9r3IrqhOtk=;
 b=Mb3ec1DCQWQC69evhHHRH7NmLyoUrjgg534+Z6jo7IagfIdtcn6l0HARgsp0LXIUN+Vzt2zhU+SvLwsim9m8FW9mZx3vAdbLxl34t5XjB579YLvoGvvrg8zi1X7a2m/3AHr9OxP7cibOu86Gkq9XLMylgCIr3Gdn++0qzI3yXJ4=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2856.namprd15.prod.outlook.com (20.178.206.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Mon, 3 Jun 2019 20:30:26 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1943.018; Mon, 3 Jun 2019
 20:30:26 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Garnier <thgarnie@google.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joelaf@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Thread-Topic: [PATCH v3 4/4] mm/vmap: move BUG_ON() check to the unlink_va()
Thread-Index: AQHVFHAFBgyZ0nJ640yaup+zuj/dD6aAsSSAgAFzHYD//7QaAIAIZDwAgAAw3YA=
Date:   Mon, 3 Jun 2019 20:30:26 +0000
Message-ID: <20190603203021.GB14526@tower.DHCP.thefacebook.com>
References: <20190527093842.10701-1-urezki@gmail.com>
 <20190527093842.10701-5-urezki@gmail.com>
 <20190528225001.GI27847@tower.DHCP.thefacebook.com>
 <20190529135817.tr7usoi2xwx5zl2s@pc636>
 <20190529162638.GB3228@tower.DHCP.thefacebook.com>
 <20190603173528.7ukfgznmiypzfyze@pc636>
In-Reply-To: <20190603173528.7ukfgznmiypzfyze@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR22CA0047.namprd22.prod.outlook.com
 (2603:10b6:300:69::33) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::5409]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0540a03-11a9-44f2-6b64-08d6e8624f77
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR15MB2856;
x-ms-traffictypediagnostic: BYAPR15MB2856:
x-microsoft-antispam-prvs: <BYAPR15MB28563D2D2B2A01CF1E689819BE140@BYAPR15MB2856.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0057EE387C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(136003)(39860400002)(52314003)(199004)(189003)(1076003)(102836004)(4326008)(316002)(14454004)(81166006)(229853002)(2906002)(6506007)(99286004)(81156014)(386003)(6486002)(52116002)(86362001)(6246003)(186003)(8676002)(7736002)(305945005)(6916009)(66476007)(25786009)(66556008)(73956011)(46003)(6116002)(54906003)(71200400001)(71190400001)(66946007)(66446008)(1411001)(6436002)(68736007)(64756008)(14444005)(6512007)(9686003)(8936002)(53936002)(11346002)(76176011)(476003)(7416002)(486006)(256004)(446003)(478600001)(5660300002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2856;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: L2+W3h8eSLnW/xCIlERNceR3DgzH8STZwI4pUiqd/JwEshArlLF5MOEI/gbIUk/zo+38P6wRxgta3NZdkiebe+O+qnAgfOb7YMN6yB0Q1OwYnfSyl4BXVEyupLejNw+XoLJZNxmJHVn8UQgxyoj4QtswuLPhxS1NZIhwVNJDtGCGtgYzDjveU5w5jpn6lNj5hfB6K/GnoeH5dFTS0C1cqBpZbZRjUL/BkqvWzHQKOw3GFCwp4CBPenoutxU+z3jKEHNS6O2XZIK30/2EJgLo7XBl4AJ5npZFCf5MDLvjKrjMc4hREoe85+XVoqyjGjTIb7Pl7QEBL++DAuyZ4rXuNmLcrcNn+MTGwFtUFBFZ2qi6XSuK35wu/xmDPVAbEB82eAPXElu6RQRoyWc+lerevQOsGjkioybrCPeAo5Yckhc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <624474166666AE4E9974023247D462FF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a0540a03-11a9-44f2-6b64-08d6e8624f77
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2019 20:30:26.0957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2856
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-03_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906030137
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 03, 2019 at 07:35:28PM +0200, Uladzislau Rezki wrote:
> Hello, Roman!
>=20
> On Wed, May 29, 2019 at 04:26:43PM +0000, Roman Gushchin wrote:
> > On Wed, May 29, 2019 at 03:58:17PM +0200, Uladzislau Rezki wrote:
> > > Hello, Roman!
> > >=20
> > > > > Move the BUG_ON()/RB_EMPTY_NODE() check under unlink_va()
> > > > > function, it means if an empty node gets freed it is a BUG
> > > > > thus is considered as faulty behaviour.
> > > >=20
> > > > It's not exactly clear from the description, why it's better.
> > > >=20
> > > It is rather about if "unlink" happens on unhandled node it is
> > > faulty behavior. Something that clearly written in stone. We used
> > > to call "unlink" on detached node during merge, but after:
> > >=20
> > > [PATCH v3 3/4] mm/vmap: get rid of one single unlink_va() when merge
> > >=20
> > > it is not supposed to be ever happened across the logic.
> > >=20
> > > >
> > > > Also, do we really need a BUG_ON() in either place?
> > > >=20
> > > Historically we used to have the BUG_ON there. We can get rid of it
> > > for sure. But in this case, it would be harder to find a head or tail
> > > of it when the crash occurs, soon or later.
> > >=20
> > > > Isn't something like this better?
> > > >=20
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index c42872ed82ac..2df0e86d6aff 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -1118,7 +1118,8 @@ EXPORT_SYMBOL_GPL(unregister_vmap_purge_notif=
ier);
> > > > =20
> > > >  static void __free_vmap_area(struct vmap_area *va)
> > > >  {
> > > > -       BUG_ON(RB_EMPTY_NODE(&va->rb_node));
> > > > +       if (WARN_ON_ONCE(RB_EMPTY_NODE(&va->rb_node)))
> > > > +               return;
> > > >
> > > I was thinking about WARN_ON_ONCE. The concern was about if the
> > > message gets lost due to kernel ring buffer. Therefore i used that.
> > > I am not sure if we have something like WARN_ONE_RATELIMIT that
> > > would be the best i think. At least it would indicate if a warning
> > > happens periodically or not.
> > >=20
> > > Any thoughts?
> >=20
> > Hello, Uladzislau!
> >=20
> > I don't have a strong opinion here. If you're worried about losing the =
message,
> > WARN_ON() should be fine here. I don't think that this event will happe=
n often,
> > if at all.
> >
>=20
>=20
> If it happens then we are in trouble :) I prefer to keep it here as of no=
w,
> later on will see. Anyway, let's keep it and i will update it with:
>=20
> <snip>
>     if (WARN_ON(RB_EMPTY_NODE(&va->rb_node)))
>         return;
> <snip>

Works for me. Thank you!

>=20
> Thank you for the comments!

You're welcome!

Roman
