Return-Path: <SRS0=rArk=2Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA0C2D0DA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F34206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Dec 2019 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fujitsu.onmicrosoft.com header.i=@fujitsu.onmicrosoft.com header.b="HtcGR8ca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfLZJ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Dec 2019 04:29:18 -0500
Received: from esa8.fujitsucc.c3s2.iphmx.com ([68.232.159.88]:48703 "EHLO
        esa8.fujitsucc.c3s2.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbfLZJ3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Dec 2019 04:29:18 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Dec 2019 04:29:16 EST
IronPort-SDR: 3e3dm+mIWM53pHXK8cN0DLMJW71Qs8LXkNDNE95zrPYoZy/qGQjy7KGKL39XULvKN0jZQKy7/X
 YWCJmZsEmcZXTDzZPwUi0psEhSU+aFH9Z99kDPFcWRLsmj77639hJjYucaD9fRI7LU4qS4JKuQ
 P+DknUEHItO/yObJIeszX773U43yjhCzD1ahS7g/M/fc0PzXy+en1XIpuyRZYRlNwOIRgE6qXD
 SpugjvG/yN1LSHLk4neC/EuXJ+1kpCETfLPjGD31Dh3g8K/EtC0tj6OKTaMZ2B5S24AIkoZ+cM
 zt4=
X-IronPort-AV: E=McAfee;i="6000,8403,9481"; a="8891497"
X-IronPort-AV: E=Sophos;i="5.69,358,1571670000"; 
   d="scan'208";a="8891497"
Received: from mail-ty1jpn01lp2051.outbound.protection.outlook.com (HELO JPN01-TY1-obe.outbound.protection.outlook.com) ([104.47.93.51])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2019 18:22:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b53+5uPSp0zDOWmkVJGPVcqLBSJIjge02/BnoMMXuvMJbw2+4DhlONJ0jIxEzHB2kWLDbk4tPiTSXHjdaOFPfrHb7wL/2WWNWj9ds1xHQ8mDY/Ebzz0ndvoyGBYV2q95UXh729XccgW0tbwn2WMgivTdOKHoh4q0cZugrxvLaIBvhhOpdpibKBysTwlyBkrzKtlYbU/fn5rY+pQSzju37QWRVxSmS15zo6RCf4r2KbDKxn7EeKLx9iPXgkH6ctLoPqmPZDfUBbBcONOFO0rmYv1t9wF3P4fJRieIHjTUGGN+47jguK3zXHlCOPOffpLgqmBiQL+ul4wOam5o1sgx0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqQUveegD+hiFc89v3ShDRUSDWQymfrPX4C+pt+q5yY=;
 b=JQ3KuPpWh5QxTfnXzLBKUSt4FpbfgujWTS+aoQWS+zmJYLxsHrHLqCOam1MEPUxmp5yaJag0cBDZHaXBDgXZ+TmriDi/uztEczbX5sD7gtnhmVbN9FzGPFFgfTzJBJaWrs4K9+w3EewruStQZKTtpZNq0r4fXmrP4f8/NY8UNRwfoJFvoP0M+ZutQL52e4qLLosAetOVBSDTXse9z2fgDxLMB7Q9d3qFp13E8cM9+EhYZzXHcKuIh721ETUbWaFxkgvFJWfY5RW9tlTVmWO0BUS3USvcJLER6q6ZCjDj+oPfIJWmcz7Eyzfj7avgHH9OGHpiDEd15qTN1qO93Ns4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqQUveegD+hiFc89v3ShDRUSDWQymfrPX4C+pt+q5yY=;
 b=HtcGR8ca97ehn5Y/4ooT7rn3wBV/N+c6mFdQvvBlkUiurAxLCLsWPDSpgaftA9diKlh8CXWJOQgHh4uqC7RPoA5mUlPE3d9kckdGQqncqKvn2jtERN2rnoIwuPmKmhAg8rILAM/frbbe5wPVoZWFvcNiILng1uJltYBaDsIe0PI=
Received: from TYAPR01MB4014.jpnprd01.prod.outlook.com (20.178.136.213) by
 TYAPR01MB2414.jpnprd01.prod.outlook.com (20.177.105.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Thu, 26 Dec 2019 09:22:03 +0000
Received: from TYAPR01MB4014.jpnprd01.prod.outlook.com
 ([fe80::e130:4bfc:a776:60a0]) by TYAPR01MB4014.jpnprd01.prod.outlook.com
 ([fe80::e130:4bfc:a776:60a0%7]) with mapi id 15.20.2581.007; Thu, 26 Dec 2019
 09:22:03 +0000
From:   "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>
To:     "'bhe@redhat.com'" <bhe@redhat.com>
CC:     "'dyoung@redhat.com'" <dyoung@redhat.com>,
        "'vgoyal@redhat.com'" <vgoyal@redhat.com>,
        "'ebiederm@xmission.com'" <ebiederm@xmission.com>,
        "'mingo@kernel.org'" <mingo@kernel.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'kexec@lists.infradead.org'" <kexec@lists.infradead.org>
Subject: RE: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Thread-Topic: [RFD] kdump, kaslr: how to fix the failure of reservation of
 crashkernel low memory due to physical kaslr
Thread-Index: AdW621PrfLWfeSyiSUOQtrg7XKymEQAFX0oAADToRKA=
Date:   Thu, 26 Dec 2019 09:22:02 +0000
Message-ID: <TYAPR01MB4014912D759953FC24D6EE1B952B0@TYAPR01MB4014.jpnprd01.prod.outlook.com>
References: <OSBPR01MB4006AF8B4D355200E385850E95280@OSBPR01MB4006.jpnprd01.prod.outlook.com>
 <20191225065914.GC3355@MiWiFi-R3L-srv>
In-Reply-To: <20191225065914.GC3355@MiWiFi-R3L-srv>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=d.hatayama@fujitsu.com; 
x-originating-ip: [210.170.118.179]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 40d8cd73-3186-485a-030f-08d789e5117e
x-ms-traffictypediagnostic: TYAPR01MB2414:
x-microsoft-antispam-prvs: <TYAPR01MB2414131CD4ADF376C5164EB2952B0@TYAPR01MB2414.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02638D901B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(13464003)(7696005)(316002)(81166006)(54906003)(8936002)(81156014)(9686003)(6916009)(52536014)(71200400001)(85182001)(55016002)(2906002)(86362001)(6506007)(478600001)(66946007)(76116006)(26005)(64756008)(33656002)(8676002)(66476007)(66556008)(4326008)(5660300002)(186003)(66446008)(777600001)(491001);DIR:OUT;SFP:1101;SCL:1;SRVR:TYAPR01MB2414;H:TYAPR01MB4014.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iK0SKF8qjl4UDk5JH8dsUIjo6VpdrYKD/X2TZcgT2acqYQRuluU0rc0VGcpWDDH9oIBJlKxiz7FfEiiC/9uTvP5kJmqLIh59cx3DV6cPQps/9gh8TDWVz8K8ITj60LMnSDoi0o/J8Q3sqhpNkaukakFmoPIrdZQ/RT9MHY2lFeJuyRXQnrZlJI5jD1nhHYjwMRxTt9g3S1hGSY12AQX/uG6AZSF8ilVWnA9NmHojR3StsYhLkaIBBZMgzLtgUv2UnfP+fFjN/GtzNErNYlwz3s87Cq9kca2BwFvszoLyNR6Wi2EqKk2fGrUEGuZBv0wZ5Y9YrkEuiSLcKkHRW40KlrqfHXs6+IxP1GJ9CUtGB8/ylX1hBzhFjZWV6kYJ9UdL+uSJAcGN6KO8S+6wkaPLV8vOAWp0XelY2ZxyWRJRfldh6QHOB1AkN5mIxAGAS6LHkCq1wvB/NapQ2IskYqNwOAwrUFe6t+pTD9Gps8hcgmWbQxcBZ12R/ad0wJnr6sP/sKl2au1JYYLC0keMYMKlODTqEHfuJh2Os3lVVCjriOc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d8cd73-3186-485a-030f-08d789e5117e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Dec 2019 09:22:02.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZS5rxNfGixqu9KHtI8tmFp3Khsgk0vceW5gmFrkElYFAtYKVQz4j+v72iVnRKz+zc51YjlqO/CmabRYIelG9FZMNo+WpsyYT3unNgtwG3PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB2414
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
>=20
> Hi HATAYAMA,
>=20
> On 12/25/19 at 04:26am, d.hatayama@fujitsu.com wrote:
> > Currently, reservation of crashkernel low memory sometimes fails due
> > to a sparse memory caused by physical kaslr with the following
> > message:
> >
> >     Cannot reserve 256MB crashkernel low memory, please try smaller siz=
e.
>=20
> I don't understand, may not get your point. KASLR will randomize the
> position of kernel image. However, kernel image usually takes up 50M
> memory. Under low 4G memory, how come it can't reserve 256M crashkernel
> low memory. Do you have the boot log of the failed case?

Thanks for your comments and sorry for the insufficient explanation.

Low 4GB memory in our system is considerably limited. The size of the large=
st
contiguous free physical pages at the timing when kernel attempts at
reserving low memory for crash kernel is less than 512MB. Hence, if physica=
l
kaslr inserts kernel image into the center of the chunk, every remaining
chunks have less than 256M size. Then, the failure occurs.

>=20
> >
> > Kdump needs low memory, memory area less than 4GB, e.g. for swiotlb.
> > Its size is 256MB for low memory by default. OTOH, physical kaslr
> > loads kernel images in a random physical address for
> > security. Physical kaslr sometimes choose low memory and sparse
> > there and as a result, reservation of crash kernel low memory could fai=
l.
> >
> > This failure seldom occurs on systems with large memory. For example,
> > on our system with 128GB, the issue occurs once in hundreds of
> > reboots. Although it doesn't occur frequently and can be avoided in
> > practice simply by rebooting the system, it definitely occurs once in
> > hundreds of reboots. Once the issue occurs, it's difficult for ordinary
> > users to understand why it failed. I'd like to fix this current behavio=
r.
> >
> > I'm now coming up two ideas but don't know what is best. Please
> > discuss how to fix the issue in better way.
> >
> > 1) Add a kernel parameter to make physical kaslr to avoid specified
> >    memory area
> >
> >   This is the simplest idea I came up with first just like
> >    kaslr_mem_avoid=3D4GB-0, which is similar syntax to memap=3D, meanin=
g
> >    that kaslr, please avoid to load kernel image into the region [0,
> >    4GB).
> >
> >   It looks to me that this can be implemented easily by taking
> >    advantage of the existing code about mem_avoid mechanism in
> >    arch/x86/boot/compressed/kaslr.c.
> >
> >   This mechanism doesn't lose security provided by physical kaslr if
> >    system memory is large enough.
> >
> >   Demerit of this is that users need configuration. Automatic way is
> >    better if possible.
> >
> > 2) Add special handling for crashkernel=3D low in physical kaslr
> >
> >   The second idea I came up with is to add special handling for
> >    crashkernel=3D low in physical kaslr, i.e. physical kaslr recognizes
> >    crashkernel=3D in kernel parameters and keep enough memory for
> >    crashkenrel.
> >
> >   To guarantee that the memory area kept by the special handling in
> >    physical kaslr is used for crashkernel, it is necessary to mark the
> >    area to indicate to the crashkernel code executed after kernel
> >    runs. To implement this, I imagine introducing a new type of memory
> >    a kind of E820_CRASHKERNEL_LOW.
> >
> >   My concern on this idea is whether its worth implementing such
> >    special handling in physical kaslr simply because I don't find such
> >    code in physical kaslr now.
> >
> > 3) Any other better ideas?
>=20
> Someone ever told that some systems may not have low 4G memory since
> they own hardware iommu. In real life, I never see such kind of system,
> and most of them can give 256M crashkernel memory a satisfactory result.
> Unless you reserve more than 1G under low 4G, it could fail because of
> kinds of complicated memory reservations there.

I'm surprised to hear such system without low 4GB memory and I wonder
how such system works well without restriction of memory access range
in early runtime mode on x86 such as real mode.

Thanks.
HATAYAMA, Daisuke

