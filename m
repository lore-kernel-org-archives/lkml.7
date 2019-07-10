Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D985BC74A2B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A861A208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 16:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728418AbfGJQU4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 12:20:56 -0400
Received: from m4a0041g.houston.softwaregrp.com ([15.124.2.87]:44631 "EHLO
        m4a0041g.houston.softwaregrp.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727377AbfGJQU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 12:20:56 -0400
X-Greylist: delayed 2090 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Jul 2019 12:20:02 EDT
Received: FROM m4a0041g.houston.softwaregrp.com (15.120.17.146) BY m4a0041g.houston.softwaregrp.com WITH ESMTP;
 Wed, 10 Jul 2019 16:19:52 +0000
Received: from M9W0067.microfocus.com (2002:f79:be::f79:be) by
 M4W0334.microfocus.com (2002:f78:1192::f78:1192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 10 Jul 2019 15:26:04 +0000
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (15.124.72.11) by
 M9W0067.microfocus.com (15.121.0.190) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10 via Frontend Transport; Wed, 10 Jul 2019 15:26:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9X8jDCKGhL7vIGJw80VKuAughKxm+U3ZDVfl0no8f825xmZlWHcCWSKfsrx8nLY3HeZMqw4wHzwoka61fZuItF8Bg0ZdNoA6vYrC5AJfNrEjHGEBX9bk6cz0hWzWYPK6XLNkDCIJblxC6f3rBlDi++9i4om7WczJvJ+BRmi9X8NWaXZhPGjgEXlhQcC/OEWlctyyHogs+SbY8leAdLn4ivaJ2ECPfyObdRrewZFK5kmyVfZW0Pi/ipX055+QxoxopO6rUbj/dQp44pnHto+DZs42He4VLl2EakUlp7iZU5ucKFgSTkxGhIkNWlBZw6kKw6j2DQMJ1E2JdUrzZJRLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTt3N137NfPoRDi/y3O0RFORyFm1UZDYTHsKxAtBcxU=;
 b=WRhaKsPL0ddaLcXsf9ah/oP//k1nZluJLqg+qQR+Q/ZI8qXMRRKTH3/ZNUUuv9g8BOqhreP+tABQzhhyYakgZZms7a37G62tcSdsTIuM+QhTiR22xazr8PMhou5DDM+Rsy8zOze3cRmCnJIXt5/S+cFSU7JI+5wVJHT185xeD8WnLu3a7gq20EPa1FKZz8/J94GtnnzzvGDWOF673EAvPF+SoZ5AjpJiU8KZf/7vPxhMd3kR2g+Pd5MLpjHbp0d7pnv4Gl1JELzHIyQMqzUj1URumU7pZFbICvdoYtkw1clmsvpzQdNe43cmdFB33RHWQ8P0uxzYbcJEB01oPTKTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=suse.com;dmarc=pass action=none header.from=suse.com;dkim=pass
 header.d=suse.com;arc=none
Received: from BYAPR18MB2725.namprd18.prod.outlook.com (20.179.56.95) by
 BYAPR18MB2952.namprd18.prod.outlook.com (20.179.59.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Wed, 10 Jul 2019 15:26:02 +0000
Received: from BYAPR18MB2725.namprd18.prod.outlook.com
 ([fe80::9c11:600:7b6b:6a32]) by BYAPR18MB2725.namprd18.prod.outlook.com
 ([fe80::9c11:600:7b6b:6a32%7]) with mapi id 15.20.2073.008; Wed, 10 Jul 2019
 15:26:02 +0000
From:   Joey Lee <JLee@suse.com>
To:     Jiri Kosina <jikos@kernel.org>
CC:     Pavel Machek <pavel@ucw.cz>,
        Matthew Garrett <matthewgarrett@google.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@fedoraproject.org>,
        "David Howells" <dhowells@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
Thread-Topic: [PATCH V34 10/29] hibernate: Disable when the kernel is locked
 down
Thread-Index: AQHVNzPImMFF/5PBvEamjEIg+L0CxQ==
Date:   Wed, 10 Jul 2019 15:26:02 +0000
Message-ID: <20190710152547.GQ11107@linux-l9pv.suse>
References: <20190622000358.19895-1-matthewgarrett@google.com>
 <20190622000358.19895-11-matthewgarrett@google.com>
 <20190622175208.GB30317@amd>
 <nycvar.YFH.7.76.1906241520500.27227@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1906241520500.27227@cbobk.fhfr.pm>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DB3PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:8::30) To BYAPR18MB2725.namprd18.prod.outlook.com
 (2603:10b6:a03:103::31)
authentication-results: spf=none (sender IP is ) smtp.mailfrom=JLee@suse.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [124.11.22.254]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 07506e7d-26ce-47f0-4cfc-08d7054aeaf2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BYAPR18MB2952;
x-ms-traffictypediagnostic: BYAPR18MB2952:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR18MB2952B346C50EF33585D3D476A3F00@BYAPR18MB2952.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0094E3478A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(376002)(39860400002)(366004)(396003)(189003)(199004)(2906002)(14454004)(66446008)(66556008)(4326008)(11346002)(64756008)(446003)(66476007)(66946007)(1076003)(486006)(186003)(86362001)(305945005)(71200400001)(102836004)(478600001)(7416002)(6916009)(76176011)(966005)(229853002)(9686003)(81156014)(6512007)(81166006)(54906003)(6246003)(68736007)(3846002)(6116002)(25786009)(386003)(8936002)(7736002)(476003)(66066001)(36756003)(80792005)(4744005)(5660300002)(6436002)(99286004)(53936002)(6506007)(8676002)(52116002)(316002)(6306002)(71190400001)(6486002)(33656002)(14444005)(26005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR18MB2952;H:BYAPR18MB2725.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: suse.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hiKQ1IQsNuUV2S7ta13UgQBfp1hWIIs8SgzgRcq9d651ornEXB/gQNKkRD4WY1Db5cSXNfYVTjSwadtmRYTtCMkxCzzhRFCbOUV+QY4AILGJQb6r9j49g1V7L74001p6DhK0QMzw6287VPnAgtMkGxae6sQW0Nrz78DhuZpu7WqTyUs9GHKEnqNUFQNl4JSZOzI/n5jvq1mS0T4S/HR+yr0tJ3ktT0AyQDE5jtT26lFk7OB899PlFmRxgCYsRu0sVGg2zvkmLgtqqtNBJrPd+5mCGQEs/Ltbz2LQ4ZkCJOFh3di0w/9/GoKvDdcu8WtRL+6coC1qWaBjELWFwcEZh9gHXbQf8xh1FJ6ghLgdO+UHn7Y3kJHlNCVqSp/E23qJz0lrZhc+6mGmNu/39kmRSk95cpLJ2ZddQC2hn2JtXow=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <570ACDF99ABAD3428E41574A4B38E684@namprd18.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 07506e7d-26ce-47f0-4cfc-08d7054aeaf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2019 15:26:02.5570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 856b813c-16e5-49a5-85ec-6f081e13b527
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JLee@suse.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR18MB2952
X-OriginatorOrg: suse.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 24, 2019 at 03:21:23PM +0200, Jiri Kosina wrote:
> On Sat, 22 Jun 2019, Pavel Machek wrote:
> 
> > > There is currently no way to verify the resume image when returning
> > > from hibernate.  This might compromise the signed modules trust model,
> > > so until we can work with signed hibernate images we disable it when the
> > > kernel is locked down.
> > 
> > I keep getting these...
> > 
> > IIRC suse has patches to verify the images.
> 
> Yeah, Joey Lee is taking care of those. CCing.
>

The last time that I sent for hibernation encryption and authentication is
here:
    https://lkml.org/lkml/2019/1/3/281 

It needs some big changes after review:
 - Simplify the design: remove keyring dependency and trampoline. 
 - Encrypted whole snapshot image instead of only data pages.
 - Using TPM:
	- Direct use TPM API in hibernation instead of keyring
	- Localities (suggested by James Bottomley)

I am still finding enough time to implement those changes, especial TPM
parts.

Thanks
Joey Lee
