Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641E0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29AD12087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="N5ZisgsO";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="YJZ6QoXh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbfCYRBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:01:05 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:42402 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726182AbfCYRBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:01:05 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x2PGvYQB027594;
        Mon, 25 Mar 2019 10:00:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=WCo8XuhCJLkrn0CWeVoXS0xHN9gjFuxpdP/0GdlREII=;
 b=N5ZisgsOjTSehfGAasbav7Icjdyka9OsQ33h2Zw+8HGYTpVmwnz792lgIeEwcZkkkPsx
 TNn2iZIsWCsfcQdfntz/+VZLF3YDnGzdLjrX3POgo6LsxlXx+a/OhFTcJfQn3QgSU21g
 irhWMgVkCxh6OBsYxzwqtyT0gsL1jVkI6cQ= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2repxtk37r-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 25 Mar 2019 10:00:43 -0700
Received: from frc-hub03.TheFacebook.com (2620:10d:c021:18::173) by
 frc-hub05.TheFacebook.com (2620:10d:c021:18::175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Mon, 25 Mar 2019 09:59:55 -0700
Received: from NAM03-BY2-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Mon, 25 Mar 2019 09:59:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCo8XuhCJLkrn0CWeVoXS0xHN9gjFuxpdP/0GdlREII=;
 b=YJZ6QoXhxoyt1i0zmmGcjs8PfHYn6lhVZGeIY7Kz/porEOYr54YOkEsH99WOoUvJZgkFbnitKlAQSu2TLpgj0YFTj6dJefcpAYHjfnUcM9smyVtoJonWTcH2i59RGQxd6Wt4qhw+0BmIepW5ceUaPKrSZqN94QBhSUaVkiDPxec=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2981.namprd15.prod.outlook.com (20.178.237.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 16:59:53 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::790e:7294:b086:9ded%3]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 16:59:53 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Oleg Nesterov <oleg@redhat.com>
CC:     Tejun Heo <tj@kernel.org>, Kernel Team <Kernel-team@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 0/9] freezer for cgroup v2
Thread-Topic: [PATCH v9 0/9] freezer for cgroup v2
Thread-Index: AQHU3CHYYz2jTdHUTkCKKsc1tAa+J6YcoAyA
Date:   Mon, 25 Mar 2019 16:59:53 +0000
Message-ID: <20190325165946.GA30208@tower.DHCP.thefacebook.com>
References: <20190316175812.6787-1-guro@fb.com>
In-Reply-To: <20190316175812.6787-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MW2PR2101CA0027.namprd21.prod.outlook.com
 (2603:10b6:302:1::40) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::3:faef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25fc8ab9-6cc3-4546-7a37-08d6b1434ccf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:BYAPR15MB2981;
x-ms-traffictypediagnostic: BYAPR15MB2981:
x-microsoft-antispam-prvs: <BYAPR15MB2981556BF21D4849ED0E81FABE5E0@BYAPR15MB2981.namprd15.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(53936002)(476003)(81156014)(106356001)(71200400001)(105586002)(6916009)(99286004)(86362001)(68736007)(229853002)(97736004)(5660300002)(6486002)(81166006)(316002)(54906003)(14454004)(6246003)(6512007)(9686003)(6116002)(486006)(256004)(8676002)(52116002)(6436002)(76176011)(7736002)(4326008)(446003)(386003)(11346002)(6506007)(102836004)(46003)(478600001)(25786009)(71190400001)(1076003)(186003)(8936002)(305945005)(2906002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2981;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: a9iXQgKpTkLc/I37Ymp83TYaqB5HIBxEnDiIaJhWUrQX+3J1nfNr4jBxviXJR8KRtoRWL/ePUjTyHAwd5mZFh8mt3/IGHTWTs8hNvlMNK4zyfg9J1eIPJiSY7McygdLrUArY2nPrAFkvnu611ul2K1gGP6CVrr1mA/J4gYXBiXfsZ/eGL+JneLzz+F2dEt64RghaQ2kLxh4HizCm+V1RIm/gqTesIrPp3Utp04vJceyZ9UPVlDWm3BGtAApK322vx95uX0h7FrWZQgW3sdMCw2ZRPQs9ZoM0Udwx2+vxSE0RH90RHMl6PqUjTZ9WkXgv87QVzDIKQb2vs017jSm9ozKEEcaKbK7EpfOb28ksq6eTG8V389b0U7yUJA5nK0wqIjI6VeU6FD9FVNHuo8S02YjFxNpDaMbV/z4rOhXrMGY=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7171DD08BCF0849BF8181C3DE19B0C8@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 25fc8ab9-6cc3-4546-7a37-08d6b1434ccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 16:59:53.4978
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2981
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-03-25_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Oleg!

Can you, please, take a look at the latest version of the patchset?
I'd really appreciate it!

Thank you!

Roman

On Sat, Mar 16, 2019 at 10:58:03AM -0700, Roman Gushchin wrote:
> This patchset implements freezer for cgroup v2.
>=20
> It provides similar functionality as v1 freezer, but the interface
> conforms to the cgroup v2 interface design principles, and it
> provides a better user experience: tasks can be killed, ptrace works,
> there is no separate controller, which has to be enabled, etc.
>=20
> Patches (1), (2) and (3) are some preparational work, patch (4) contains
> the implementation, patch (5) is a small cgroup kselftest fix,
> patch (6) covers freezer adds 6 new kselftests to cover the freezer
> functionality. Patchse (7) and (8) adding tracing points to simplify
> the debugging process. Patch (9) adds corresponding docs.
>=20
> v9->v8:
>   - added support for vfork
>   - added a kselftest test for vfork case
>   - several tests fixes/improvements
>   - renamed stopped* into frozen* across the patchset
>   - added trace points
>   - other minor fixes
