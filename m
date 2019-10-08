Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C42C4360C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2DFB217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 17:27:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="Zp27gLcu";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="lbck9SKk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfJHR1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 13:27:19 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22830 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726057AbfJHR1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 13:27:18 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x98HEQ0l028305;
        Tue, 8 Oct 2019 10:27:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=j+znaRlxTtlUheuS8RtCrxlz61am0n7VhSGPJnLSTms=;
 b=Zp27gLcuNTJu/Lm8rL9tcfxLb1zUix8grQ4LtDKDc38woDASWJ0FOegvSNtJAQaPgFov
 rec669UXkXYvdMJLauuHHkGQ3HjXunKnExDsqbYr5v59HZY83+WmT6BV0kGey+9ZLEi0
 VQYp0TX8Lio9blwuPXvbCTxHRWdQsaw/Tr4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2vg6ms6jgr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Oct 2019 10:27:14 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 8 Oct 2019 10:27:12 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 8 Oct 2019 10:27:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ucs9p0Q4RuZaw3pBcvRP7Hp83EdhfUqh7WuGkwtJ8vQZRzsnzkhrm1+CNOPpd+dOFB1N88K/jAztVSzMP+ot0OGI6nz6Fp+zH2PVoyQxupgphD/uQ2XgcIyTf/DN0o2eFnD/uhDVpEpWUdGYVAJcQ8YwQg0fPBqfaYCJ/mOFnHAZEIAJtAZdJ9IiOHKekPU1EFyMhNoSiV90R7ML84xWaSSbxAor8pUA+PpLglybay7L0T6xqbGtLSGxg5lnQEsuGNu5xINyJrxMo/5sBIkvblX9Ci8nTZ2/OU6/BPb+YIZOi/zETvnQnlnrNvoMfc5Ghqaai94fJGlvQmQ/yp30mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+znaRlxTtlUheuS8RtCrxlz61am0n7VhSGPJnLSTms=;
 b=JwH+CWNvCNv9A4Op3CGMsdSvUhbZpWPLYp7244Ol4Yj4slxZqfAr49WkOE6mtTvcGglQizc1FHOc3uvmTMvXCDlz7braQgEm9ex42FTvrqsoZpDJAQpYCdVsBWxmbSK9bIuScw7wD6Y8uINzZViIn89qBi3vCNfagovtO7dGGujVey8LiV8974d6Ho48NtDGUarASVqK7skZXw+Ye0jEuKJ9to/ktJzjWwq8NK6dCiqwFXitCWSJ9tx5AX2UoRUGiGjfWIUNMuUVtDmqlOBaXYZ2m43Tl27KGGG9NtJklThrldVPD0T+nzhI11y7hNmZxmupTVhuIjT0WDq3eMD4qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+znaRlxTtlUheuS8RtCrxlz61am0n7VhSGPJnLSTms=;
 b=lbck9SKkF4z8ILhlXt1chsLrqYgNP61FpIqBpl5JDVxSGGJYHn1G0MCDW7aVE7W775pdpeHGCb7w8HdUZbociLc/q7ePFHfmSTCv4+leqHwi5qZRctIdOeRHDIQfb9NWW3X0iym2rUzijfFjPyZ2AOM+U51ley3FOJDO1rcUoPA=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3156.namprd15.prod.outlook.com (20.179.75.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 17:27:10 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::dde5:821f:4571:dea4%5]) with mapi id 15.20.2327.026; Tue, 8 Oct 2019
 17:27:10 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Bruce Ashfield <bruce.ashfield@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "Richard Purdie" <richard.purdie@linuxfoundation.org>
Subject: Re: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Topic: ptrace/strace and freezer oddities and v5.2+ kernels
Thread-Index: AQHVeHNRdeEItaYf7UK2FXG2TrAmk6dGmZIAgAAmiACAAOrJAIAAPZIAgAG2jICABYy1AIAAehiA///BpwCAAUsZgIAABm2AgABRVAA=
Date:   Tue, 8 Oct 2019 17:27:10 +0000
Message-ID: <20191008172706.GA9392@tower.DHCP.thefacebook.com>
References: <20191002020100.GA6436@castle.dhcp.thefacebook.com>
 <CADkTA4Mbai=Q5xgKH9-md_g73UsHiKnEauVgMWev+-sG8FVNSA@mail.gmail.com>
 <20191002181914.GA7617@castle.DHCP.thefacebook.com>
 <CADkTA4PmGBR7YdOXvi6sEDJ+uztuB7x2G95TCcW2u_iqjwhUNQ@mail.gmail.com>
 <20191004000913.GA5519@castle.DHCP.thefacebook.com>
 <CADkTA4OJok3cmYCcDKtxBXQ5xtK1EMujh7_AgLnVaeRr18TH9w@mail.gmail.com>
 <CADkTA4PKc6VEQYvXk4-EWMJPyOrzWQEsk4p6O_BMFo6kvT2jYg@mail.gmail.com>
 <20191007232754.GB11171@tower.DHCP.thefacebook.com>
 <CADkTA4NKDn4jd2BQaGk+JEnM3B5GMDudsBi6V4YwK3Soq9q9pA@mail.gmail.com>
 <20191008123601.GA28621@redhat.com>
In-Reply-To: <20191008123601.GA28621@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:300:117::21) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::2:f613]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6cee64-4775-45df-244e-08d74c14c039
x-ms-traffictypediagnostic: BN8PR15MB3156:
x-microsoft-antispam-prvs: <BN8PR15MB3156A9460CD19B2C16C4E464BE9A0@BN8PR15MB3156.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(189003)(199004)(8676002)(476003)(9686003)(6512007)(81156014)(6486002)(8936002)(229853002)(4326008)(33656002)(6246003)(486006)(6436002)(66946007)(66556008)(66446008)(66476007)(64756008)(305945005)(99286004)(81166006)(498600001)(7736002)(86362001)(4744005)(6916009)(1076003)(6116002)(25786009)(76176011)(46003)(11346002)(186003)(52116002)(5660300002)(6506007)(386003)(2906002)(102836004)(14454004)(14444005)(256004)(71190400001)(54906003)(71200400001)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3156;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hU04NO92ruFzg12aHRvcR6YbltIVtcXhEhs9Nt0hAe8ALkVdx2yIt+fV9I3X2M5CzSuogCszT4keUSjMWXaGLlhIpAFFcdXQphNAW78O/339h/DjtvC2OfAWePbdOzdTPWhADdt8FjTwV9ZFPqoSQIGVHjoEy3TFjSv7YCt6WoPdbXalM8CVXka2qx2eqQtzraBuYBpSoI+CkVCcLjXb9fjJeDNMc2qulQWzUXHj3O1gtNgUP0kZnakMcoy0a8A9sHI0cIhrCsWq0LmvELIQELKFbYbxsAsdFetltEBhzv/HaOVdWNrayf2+NLhz7dUa2DOyhC52jbNdHzqji2rFclqehCVl4DaaAuwtLmILgP4a/7KnxwesJQfh/fSDYNcurvvJtM6WLTvWLE5llsgcW44JS4RRO7NYv3klo1Xyr1o=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <75796FB749715747939E0988A52C95CA@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6cee64-4775-45df-244e-08d74c14c039
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 17:27:10.6990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8MAhviv6VqdsI+dzNKKU55sPfKMMUF2CzkBxeeg01CqO98ojxx6E5KZDa1zxR1id
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3156
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-08_06:2019-10-08,2019-10-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=978 clxscore=1015 spamscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910080141
X-FB-Internal: deliver
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2019 at 02:36:01PM +0200, Oleg Nesterov wrote:
> On 10/08, Bruce Ashfield wrote:
> >
> > So I've been looking through the config delta's and late last night, I =
was
> > able to move the runtime back to a failed 4 minute state by adding the
> > CONFIG_PREEMPT settings that we have by default in our reference
> > kernel.

Ah, yeah, I don't have CONFIG_PREEMPT on any of my machines.
Good catch, Bruce!

>=20
> Aha... Can you try the patch below?
>=20
> Oleg.
>=20
> --- x/kernel/signal.c
> +++ x/kernel/signal.c
> @@ -2205,8 +2205,8 @@ static void ptrace_stop(int exit_code, int why, int=
 clear_code, kernel_siginfo_t
>  		 */
>  		preempt_disable();
>  		read_unlock(&tasklist_lock);
> -		preempt_enable_no_resched();
>  		cgroup_enter_frozen();
> +		preempt_enable_no_resched();
>  		freezable_schedule();
>  		cgroup_leave_frozen(true);
>  	} else {
>=20

That was fast! Thank you, Oleg!
