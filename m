Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D866BC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CAB02081B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 13:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LkT+fQGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfCGNSd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 08:18:33 -0500
Received: from mail-eopbgr20089.outbound.protection.outlook.com ([40.107.2.89]:16962
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726101AbfCGNSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 08:18:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oM/0jYFLMNol+VgFoOmp6kO1m1Z/ROVBeKTZsGncP1g=;
 b=LkT+fQGmpN3pYRGhJSuqKz6RkZK2LHaRVpW+O1fwpRBrrUfh/Qort29FWcd4bM+mrSDDniHHeZ4V03ukBst+olJF/4VGwLK2pmV7E/JxixR56H5njjrc4dMi5jAvHoO1LWHFH45aeI/NVwikDyIlK9FDAELVUnDluQR+gE4e+i0=
Received: from AM6PR04MB5447.eurprd04.prod.outlook.com (20.178.92.212) by
 AM6PR04MB5749.eurprd04.prod.outlook.com (20.179.1.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1686.17; Thu, 7 Mar 2019 13:17:48 +0000
Received: from AM6PR04MB5447.eurprd04.prod.outlook.com
 ([fe80::f963:78c8:7bed:5b60]) by AM6PR04MB5447.eurprd04.prod.outlook.com
 ([fe80::f963:78c8:7bed:5b60%5]) with mapi id 15.20.1686.016; Thu, 7 Mar 2019
 13:17:48 +0000
From:   Franck Lenormand <franck.lenormand@nxp.com>
To:     David Howells <dhowells@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        Horia Geanta <horia.geanta@nxp.com>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>
Subject: RE: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in
 dmcrypt
Thread-Topic: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use in
 dmcrypt
Thread-Index: AQHU0ElJyiKbG2HSEkeGNjbUGrGl3KX+49qAgAFIFNA=
Date:   Thu, 7 Mar 2019 13:17:48 +0000
Message-ID: <AM6PR04MB54473C2D30DDD7CDC8522DF9924C0@AM6PR04MB5447.eurprd04.prod.outlook.com>
References: <1551456599-10603-1-git-send-email-franck.lenormand@nxp.com>
 <11177.1551893395@warthog.procyon.org.uk>
In-Reply-To: <11177.1551893395@warthog.procyon.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=franck.lenormand@nxp.com; 
x-originating-ip: [81.1.10.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69baca4c-0262-4218-03cf-08d6a2ff4b35
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600127)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB5749;
x-ms-traffictypediagnostic: AM6PR04MB5749:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;AM6PR04MB5749;23:v1va3sz0aFHpH/NLoBpwb6g7PxSFacT1IR2r59r75?=
 =?us-ascii?Q?D+TjgwTP/Pls7IemRaJ8/KHl99vw10gpxn7Ke7+1DxEkGr4G4h9AyFkygQz7?=
 =?us-ascii?Q?xZHEp5aY70/Fp+lF4KLSfk2eCDBCI9nx0OZH7Ty6oFriTodSO/TENald0Vev?=
 =?us-ascii?Q?8g3fzSiD5G51qmsqZBBunDP0JxxEzdKZuAhjWN9LPSaWe1bqMGWVm6pTTxTu?=
 =?us-ascii?Q?UnHIjIjOakhiS5JWMqtdAeDd2o6GgqUQZuYK1Cja1PR3SFOn7frWy03SJ9lc?=
 =?us-ascii?Q?7O/LTKCbw9YQsFzHF9EPZBtallYQc0mk2udCEF/53ucueN7TJYfgIUmv8tFu?=
 =?us-ascii?Q?C9qDABlnhu/PLycfbTGh206O9rqdfOPIH0sg+nUoxw9bGvGKdmd4Y0w0AbDh?=
 =?us-ascii?Q?zGWvj9zE0viOlgwZYjZ8DeHxCgItILSt2pZ4Rs7fE0J5Rpidzh9cgKrm3uIs?=
 =?us-ascii?Q?7CV0Q6V5MHIaoN/Jr5BDlPzD9Yv7QE1piq792d8Q27tSCcLb1KsUCKdHq7ZY?=
 =?us-ascii?Q?wizdVN7adpIfN1VnBGMocUS9XnWFCu8ubscCICyp5VdPhv8PQXAwAIN4UC76?=
 =?us-ascii?Q?Z4CjzzZvglqvnQIO9ayW1JNDFLZIG+ff0ewFMHyjZvqWR8T5YBfPIM0AA+/m?=
 =?us-ascii?Q?VOizNrugLBobmzBz2+jnJUjkUxMUJqqjejaDfwHFOnuEVQ1DnyY4lf4vqjt2?=
 =?us-ascii?Q?xy3pveMdIxWuQrw49b9NM7yijQyb9BGNf2JHjx+ReCq/HzIxbS2lAxUKasbS?=
 =?us-ascii?Q?OtR7vrmSI/KbnHk0ta16/rGv6MYGcsScHNaqsY9uWFEU22lBFGvUmFM64rEx?=
 =?us-ascii?Q?UM3sx7hgmF61bCBiHKJ1kEQA479w7WZQIye6G1frm1lZpLBSnp/NL7Vh2XBH?=
 =?us-ascii?Q?EOAsf7tWvKQtFWzNyuG1zFL21M+PQb4BdjaCHKtid/GGLk5BsK/8nzL26h/9?=
 =?us-ascii?Q?wmFWmoe1II5doyQWUuWDfbXBuem+sExadYFQB9Djr5IE6DFw4miz7KDhy4Hw?=
 =?us-ascii?Q?SUwMk4QlI0PgQ7SmgGXyW2x6RV3zNqn27ENm2xGfbskBGF0W/v/KEJyjIYkS?=
 =?us-ascii?Q?+PTAtNyYhOQkmWPpQwvR6hTlq7kt12XUafctuaFfLzDcK0EM7InIZvWf5MMa?=
 =?us-ascii?Q?l0KXaITCAZu+cTmJ/3jijZqoQ/+28WRpYopozr2rep8S24lwcoZcJJV6TsTn?=
 =?us-ascii?Q?o/XDVSNr50LtXHlaKwqjsLZOYMpKGOYo5XLPDcvWqeZWgxKsmk6ab6k1vEv6?=
 =?us-ascii?Q?1k7qw38bBHhNKAMXX9Mn5Q6wXi9mTM7X0WNL5SAjwwAF9xrj8GC+q94lvxUM?=
 =?us-ascii?B?QT09?=
x-microsoft-antispam-prvs: <AM6PR04MB5749745A7F9D5941A885EB42924C0@AM6PR04MB5749.eurprd04.prod.outlook.com>
x-forefront-prvs: 096943F07A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(396003)(346002)(376002)(13464003)(189003)(199004)(76176011)(7736002)(55016002)(3846002)(66066001)(229853002)(6116002)(7696005)(44832011)(6246003)(53546011)(6506007)(102836004)(446003)(86362001)(11346002)(476003)(486006)(5660300002)(52536013)(74316002)(99286004)(81166006)(8676002)(305945005)(81156014)(68736007)(25786009)(97736004)(53936002)(33656002)(186003)(71200400001)(54906003)(71190400001)(316002)(256004)(9686003)(14444005)(4326008)(105586002)(14454004)(8936002)(6916009)(26005)(478600001)(2906002)(6436002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5749;H:AM6PR04MB5447.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ZkMVf/QUUA4IJiPkAeEmskabQE7/cV28Gz7fQeshMuoXnl5II/IZBpIpM8njngXImHvoc76YGslzT+37Df9DFnuteKy27vKIa+A2gyPX9w1tKCYvOVek+2jvmI6xsVi+NFHRF531YVCklgoyrHeVl6SxKUjc1ZKhjfeLScodu5qn75GlDaumx/pW2ORfndu6k49KLo2Rs3hbjhZqPNhnfe1TqVTty3tFtvNzvWNkEtPwUzLG8GTe5NkREGPfRf41+yjV+s3O0/Jfwaz/lIdt6kiiIAyYAX6TIf1Zor2JvTz1xGzao0ViRQcSBel2QDwtjXdpR9hiHkm50DfRMr8PmNThAr3vy1a+VH6QJM9UgdW+ncn0j629R+lbkABbW/14u+Kw0rNpYtCzmONTLL6QeUogHOcQvBYpK/VWXbpYryI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69baca4c-0262-4218-03cf-08d6a2ff4b35
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2019 13:17:48.1129
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: David Howells <dhowells@redhat.com>
> Sent: Wednesday, March 6, 2019 6:30 PM
> To: Franck Lenormand <franck.lenormand@nxp.com>
> Cc: dhowells@redhat.com; linux-kernel@vger.kernel.org; linux-security-
> module@vger.kernel.org; keyrings@vger.kernel.org; Horia Geanta
> <horia.geanta@nxp.com>; Silvano Di Ninno <silvano.dininno@nxp.com>;
> agk@redhat.com; snitzer@redhat.com; dm-devel@redhat.com;
> jmorris@namei.org; serge@hallyn.com
> Subject: Re: [RFC PATCH 0/2] Create CAAM HW key in linux keyring and use =
in
> dmcrypt
>=20
> Franck LENORMAND <franck.lenormand@nxp.com> wrote:
>=20
> > The capacity to generate or load keys already available in the Linux
> > key retention service does not allows to exploit CAAM capabilities
> > hence we need to create a new key_type. The new key type "caam_tk"
> allows to:
> >  - Create a black key from random
> >  - Create a black key from a red key
> >  - Load a black blob to retrieve the black key
>=20
> Is it possible that this could be done through an existing key type, such=
 as the
> asymmetric, trusted or encrypted key typed?
>=20
> David

Hello David,

I didn't know about asymmetric key type so I looked it up, from my
observation, it would not be possible to use it for the caam_tk as
we must perform operations on the data provided.
The name " asymmetric " is also misleading for the use we would have.

The trusted and encrypted does not provides the necessary
callbacks to do what we would need or require huge modifications.

I would like, for this series to focus on the change related to
dm-crypt. In effect, it is currently not possible to pass a key
from the asymmetric key type to it.

Franck
