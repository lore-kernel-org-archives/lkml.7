Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2187C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94E562054F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 17:05:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitdefender.onmicrosoft.com header.i=@bitdefender.onmicrosoft.com header.b="FIBXpZlv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfLKRE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 12:04:59 -0500
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:10496
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726313AbfLKRE7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 12:04:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjpZfhHrlGqfiWAF7OgTJ8aPA2b5I8UcjqLJd2pZ5VsHxoVa3+oedU7D27DabQX7Ruc9fgO8LRvYCAkVB5hM+Hu2+Q037W5UdsfOYsQi84c4E/6as9OcLFzdBSkjps5HQlt0AAntm6z5g0gxduOch1Pujpm8oQCsQwB9rcJudLQKj11oEMh4jPKhF9m54VHh8Kch/TZNURTad9oIGSbFGlHd+qLq1/mG6nGRFr4y4tI1hfBXfBqKJrBU29++alvZ+MEoUOo5efUFptEngMifaVqimqkKpKy8ZTEmmmr6t2nsrUKeb/J+HW/6C2vThAIgI+S8r2hlixnB8OJCD/mgWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9tY73nxbKWdS3nBbW/ipqIMI66/HCBb5OK69rpEJ8c=;
 b=nU3XFghOvwzg5jegbTrWKg02G77Jevw7LNxFuVr0Kj6ngNJ/109zDK5Sza/oPm3Q854f+M8Mzu/B0T1Uk8vmemHHb84EJLGnMfd+cDFngKg34snD8c0TPSmbzv8VDZCZ24HxcfIg63NcNI8t9ZSg+8O3CRerB4/LN5aGbAj7a4KqNQejWhPPRALGLIauo93h1ByeWapO6mys8/Q5A1l5Slw12UB0W/7mUyLpbZwwxk9Keq0q9lnQgMaRquAoTdAYZZQX66OmVEniIrVJ3HHpKLSJI26Vx0c0ktb7luPgCYGu3Z8g2VSXg764ihVbOlLD8KCO39IjXaM+NixjKG6Oqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bitdefender.com; dmarc=pass action=none
 header.from=bitdefender.com; dkim=pass header.d=bitdefender.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bitdefender.onmicrosoft.com; s=selector2-bitdefender-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z9tY73nxbKWdS3nBbW/ipqIMI66/HCBb5OK69rpEJ8c=;
 b=FIBXpZlv3wgUjKUKowJyc+pJBYEfCnYb+4MS4oaqYZsUkmlZohd8peW8ZRiSzbRj29pqGR1a6OxtjcBzisczinHuNIv41FNxxQ74KR6qfLf7DP3q8pfojZh9xGFaIOhjJYszG4CR/KHK0cgiWAcpLeNkixociW2TlUpyIto1AY4=
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com (20.177.121.157) by
 DB7PR02MB4506.eurprd02.prod.outlook.com (20.178.42.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Wed, 11 Dec 2019 17:04:55 +0000
Received: from DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06]) by DB7PR02MB3979.eurprd02.prod.outlook.com
 ([fe80::65e5:e5bd:a115:ce06%2]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 17:04:55 +0000
From:   Mircea CIRJALIU - MELIU <mcirjaliu@bitdefender.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "aarcange@redhat.com" <aarcange@redhat.com>
Subject: RE: [RFC PATCH v1 1/4] mm/remote_mapping: mirror a process address
 space
Thread-Topic: [RFC PATCH v1 1/4] mm/remote_mapping: mirror a process address
 space
Thread-Index: AdWwBBdjWL1iwgZWSiiPCON+EPj4xAANsM8AAAFF9fA=
Date:   Wed, 11 Dec 2019 17:04:55 +0000
Message-ID: <DB7PR02MB39792DF9294085D0BE1676E6BB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
References: <DB7PR02MB3979DB548160D2D9D25FE5ADBB5A0@DB7PR02MB3979.eurprd02.prod.outlook.com>
 <20191211155130.gk5qcuahzo2w3qyh@box>
In-Reply-To: <20191211155130.gk5qcuahzo2w3qyh@box>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mcirjaliu@bitdefender.com; 
x-originating-ip: [91.199.104.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eaabf521-7b19-4e8e-a652-08d77e5c3ede
x-ms-traffictypediagnostic: DB7PR02MB4506:|DB7PR02MB4506:|DB7PR02MB4506:
x-microsoft-antispam-prvs: <DB7PR02MB4506281B30BCAB89CB541B66BB5A0@DB7PR02MB4506.eurprd02.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 024847EE92
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(396003)(376002)(136003)(199004)(189003)(81166006)(66556008)(64756008)(71200400001)(8936002)(66476007)(5660300002)(26005)(66446008)(186003)(6506007)(86362001)(52536014)(6916009)(76116006)(66946007)(81156014)(4326008)(54906003)(2906002)(316002)(55016002)(8676002)(33656002)(9686003)(478600001)(7696005);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR02MB4506;H:DB7PR02MB3979.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: bitdefender.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nMwnxgFEzryvlrDjwOttEBw1YEbzONCdFtyYLTeOdSEmuNbOwAUsqRaxcAUBsqFHOLhmH/qbRgQpjV43o2PP42dHz1CpPS6NaTh+D1+WS9ZWyhrkGeFfCJBm4SCZSWrIPxNzHQmrMozgZTIhIW1V4j1ynl+8KqVY++0AEfAN9aj/pVSh0xFppF7tMjUBfvivFwhLPjt1JdCKvQ9qnhPct2wceOSw++07T/sCRXcmefsQPyqybWU6A4o/dSuDefPuVHHMNayy+lizAzuWphMdGxk50hB4fOnZrJGMRRNLZ9YQrxxjjG1Ez1NBc+b97sgoQmf6NioLtYb2Chxh5wnAUZwTxtZ6TsFlW0wSKaGfHqZ1E3Oq6gGl4H7VA0G1JiSA2I5gdzEmQn7hvYF1Mub2PDyzRtZFydqKUcLIRSHghH3r9jIgXmUYEaGNDcpI+vbg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bitdefender.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaabf521-7b19-4e8e-a652-08d77e5c3ede
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2019 17:04:55.1875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 487baf29-f1da-469a-9221-243f830c36f3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHFC+GF2fkIot110iTUM7Kb7cnYOXcL/Buv+stiAjQPToqTY0bcoIisxXAQTSE0Y5ZnToLM9m8MqjTOUAtoUGE7GXh6avXk5zuK3YIXEjCo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR02MB4506
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Dec 11, 2019 at 09:29:17AM +0000, Mircea CIRJALIU - MELIU wrote:
> > Use a device to inspect another process address space via page table
> mirroring.
> > Give this device a source process PID via an ioctl(), then use mmap()
> > to analyze the source process address space like an ordinary file.
> > Process address space mirroring is limited to anon VMAs.
> > The device mirrors page tables on demand (faults) and invalidates them
> > by listening to MMU notifier events.
>=20
> It's way to brief to justify the new interface. Use cases? Why current
> intefaces are not enough?

Its main purpose is virtual machine instrospection.
Could also be used for security software, debuggers, etc.

It gains direct access to another process address space by mirroring its pa=
ge
tables to the local process address space.
The main difference from ptrace is zero-copy read/write.

The use case looks like this:
	fd =3D open("/dev/mirror-proc", O_RDWR);

	/* hook on process 1234 */
	ioctl(fd, REMOTE_PROC_MAP, 1234);

	addr =3D mmap(NULL, length, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset=
);
	/* operate on memory of process 1234 */
	munmap(addr, length);

The address space mirroring is done in a VMA with VM_PFNMAP attributes.
The PFNs are installed in the fault handlers and invalidated via MMU notifi=
er.
So no page management structures are involved.

Observe that the introspector process can mmap() very large regions from=20
the source process address space, sometimes involving holes. If no page is
found at a given address, the introspector gets a SIGBUS.

>=20
> There's nothing in the description that would convince me to look at the
> code.
>=20
> --
>  Kirill A. Shutemov

