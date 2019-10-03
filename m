Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA458C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9378620700
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 15:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="hYJPVTKq";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="FrmfKRTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbfJCPxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 11:53:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38010 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727024AbfJCPxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 11:53:02 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x93FhLlN012508;
        Thu, 3 Oct 2019 08:52:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=it5wuNYRK2CPolBrO6UFbeGk3uU/+HHBtj+qJcYaKgo=;
 b=hYJPVTKqBPr1rXOK6WVic5ANRFOWcs5JamfSl3UwhMx7II/0QCTGieeA46yv2MuK5hmW
 HkoBwqMBVWcfz/SMsxbY3bPVw2uhPjaevDQhIE3SyydVj//Pnu7Qe6vVH37tAtscOyOY
 qwC3uCVKjue0kIN69CX4ae3DM1Xt7kkpxvE= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vcc6rtfqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 03 Oct 2019 08:52:28 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub01.TheFacebook.com (2620:10d:c081:35::125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 3 Oct 2019 08:52:27 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 3 Oct 2019 08:52:27 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Oct 2019 08:52:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzBDXGEuhy1txsViZARi2nueLEXzFBNHGhDxMPMPwGJ5w9T4PUcD6QYEHCidR3PnKGDcz0DvDg+4xPA8GurnIlNJRJ1xzN5G3COd/nnDzsD/GsacmlVd/5E2uPw7zVfkiEPHUxTzLYw91S+sqmYu7jiGYCyOSCo5MGoZyHuoUhlC7F/uTzJN7wAVJnW9Rrp0hMsl9ImahW2Qvd9vlFD93pbx9tGq+5xLfyktXluTrmfQ7FLhnlzpODZscT5JHkl54w7kbm5IWhmniHBD6X5cslFY1cIBjyvvIOvT8R+dyB3HlZ7VDiYGK8xN/EIAUhbnUEY4wXRyqBQWLkFsjctbZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it5wuNYRK2CPolBrO6UFbeGk3uU/+HHBtj+qJcYaKgo=;
 b=oAz/KxkOH38mxXIHbn7C3c8IT7byXGK1iqyXI7/xNhlUhoGcrLGMEbP6CdoXQ9TQQaFez3DzQkX3T4QU98dkm3a/mm8Dy9ITv6XBkmTF6eyTPAIQCdCNtYFnjG4jouA8RoDikZZ4wubOqHqIsyJ/2z9lp9A+POBWmPD/GBzVQAz+NMZLcNf7+DENWv0Mt18dWae22LbjHFKyTtqzJAtmGB9gwF4TmJoWfIVdeHHzJxDkgt74dhW6C6UshrXpj42/6aj+yjXghN9FUGYgRt2ap/y0jy85aprhJ8shzC7oqi/nPv6pv6y0V2IW6LReRZlZpHPFb7sJ+MAY4gi6Br0VdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=it5wuNYRK2CPolBrO6UFbeGk3uU/+HHBtj+qJcYaKgo=;
 b=FrmfKRTzz9cr6zYUm546ne7HDKtfCkcGTt4DEdBNdDNkCJgtZ8i+afGLE++L6oSYQm1yuFyg8D0kR7PyYmQVJKD7Xl0q5aHJxuect+JShysJUk6n8cMMTHxJRa4fjdmJc0WtGSTNYzUHMrxYoTZAEx4b7w4zzmCaMEsXyc8cwvM=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2578.namprd15.prod.outlook.com (20.179.139.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2305.20; Thu, 3 Oct 2019 15:52:24 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2305.023; Thu, 3 Oct 2019
 15:52:24 +0000
From:   Roman Gushchin <guro@fb.com>
To:     =?iso-8859-1?Q?Michal_Koutn=FD?= <mkoutny@suse.com>
CC:     Suleiman Souhlal <suleiman@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kernel Team <Kernel-team@fb.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Waiman Long <longman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC 00/14] The new slab memory controller
Thread-Topic: [PATCH RFC 00/14] The new slab memory controller
Thread-Index: AQHVZDNwmo4dH7vFVEWbwj6k0KVokadGDMAAgABCQ4CAASs3gIABbVSAgABVHAA=
Date:   Thu, 3 Oct 2019 15:52:24 +0000
Message-ID: <20191003155218.GA13950@castle.DHCP.thefacebook.com>
References: <20190905214553.1643060-1-guro@fb.com>
 <20191001151202.GA6678@blackbody.suse.cz>
 <20191002020906.GB6436@castle.dhcp.thefacebook.com>
 <CABCjUKBZxJJrUzpgXafqtXOYXZbYXEh0ku8fZLpPHXWnrTw1hg@mail.gmail.com>
 <20191003104741.GB6678@blackbody.suse.cz>
In-Reply-To: <20191003104741.GB6678@blackbody.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:300:4b::12) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::2898]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 589d61a2-5e8e-4321-014f-08d74819aeb8
x-ms-traffictypediagnostic: BN8PR15MB2578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR15MB2578CC716EEA98713E0DE8EDBE9F0@BN8PR15MB2578.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01792087B6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39860400002)(376002)(366004)(346002)(189003)(199004)(99286004)(8936002)(71190400001)(52116002)(25786009)(8676002)(71200400001)(81166006)(81156014)(76176011)(6116002)(6916009)(316002)(2906002)(33656002)(54906003)(186003)(14454004)(66446008)(6512007)(6246003)(66476007)(6486002)(9686003)(1076003)(66556008)(476003)(486006)(6436002)(46003)(446003)(11346002)(64756008)(86362001)(4326008)(14444005)(229853002)(256004)(7736002)(305945005)(478600001)(5660300002)(386003)(102836004)(66946007)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2578;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f59BgjkGZmfs4O4Gs8leQN4oC8eMToDqBa0Hv9sRhcOuKpqDNxpqwJRKnUqBjg24Gjqwq6Rgaw1NZ2giTOSFCqsRAFPCxlbgd8FEg/I7WFpm2lYPCzA3jxgT0fheFZ89Agcqf+HJk23SyuVLD6KiuhIM0mYE6YaLnnpqtgZFoP9vSRbJeUHrNQi2Mn1kG+WuTmryf0zj6G9gda1z/BJ+JQMkv63FnfQw+f4dwlctco5J0qHOcqwWb7wTTHGUJPC158eGerNtAwqOzrXYGFc5KNCrm4oru4A2/wIzrX7XeCDFZjCX4H60yMRznTB0xpdmHju6ukUuXFeFc5KB+GjDoc25YAYoY1t3hQe5oJpHCWoAyBrwJW0X8/gGturUugZyvFcOE2xDNgKKTNvKra5RACvtIB8DFb4VtwPXWKCwx14=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D1E7D32ED58D714698C8597EF06DE8DB@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 589d61a2-5e8e-4321-014f-08d74819aeb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2019 15:52:24.2949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0rwhRdnaUPPYcLLhONVyHb/MJh1vtIja6oueOJeBCo9e0E823u/YxTVoxuq9Q1dL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2578
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-03_06:2019-10-03,2019-10-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 malwarescore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910030143
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2019 at 12:47:41PM +0200, Michal Koutn=FD wrote:
> On Wed, Oct 02, 2019 at 10:00:07PM +0900, Suleiman Souhlal <suleiman@goog=
le.com> wrote:
> > kmem.slabinfo has been absolutely invaluable for debugging, in my exper=
ience.
> > I am however not aware of any automation based on it.
> My experience is the same. However, the point is that this has been
> exposed since ages, so the safe assumption is that there may be users.

Yes, but kernel memory accounting was an opt-in feature for years,
and also it can be disabled on boot time, so displaying an empty
memory.slabinfo file doesn't break the interface.

>=20
> > Maybe it might be worth adding it to cgroup v2 and have a CONFIG
> > option to enable it?
> I don't think v2 file is necessary given the cost of obtaining the
> information. But I concur the idea of making the per-object tracking
> switchable at boot time or at least CONFIGurable.

As I said, the cost is the same and should be paid in any case,
no matter if cgroup v1 or v2 is used. A user can dynamically switch
between v1 and v2, and there is no way to obtain this information
afterwards, so we need to collect it from scratch.

Another concern I have is that it will require adding a non-trivial amount
of new code (as we don't have dynamically creating and destroying kmem_cach=
es
anymore). It's perfectly doable, but I'm not sure we need it so much
to postpone the merging of the main thing. But I'm happy to hear
any arguments why it's not true.

Thanks!
