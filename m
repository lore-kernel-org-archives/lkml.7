Return-Path: <SRS0=2+op=Y5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943FC49EAB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E934821928
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Nov 2019 10:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="HJgOzCfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbfKEKLh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Nov 2019 05:11:37 -0500
Received: from mga14.intel.com ([192.55.52.115]:52875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730592AbfKEKLg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Nov 2019 05:11:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2019 02:11:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,270,1569308400"; 
   d="scan'208";a="376638443"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 05 Nov 2019 02:11:34 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 5 Nov 2019 02:11:34 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (104.47.33.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Tue, 5 Nov 2019 02:11:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNGQzCax3ThilOfqYgIb351YgjSjfbMJcGa3D7yWbZuQpbijR44wTX4YkiWZ5A8HTM13xMVnAd5c3f6vviHBFWzh8tMLF1bY/BgELJ0MixVnX17lbhmL6B8ZimwNSRNPUhS/rL3HIsW5U7U3itZWCKRXRdl8RquPCzlsTGPvlaexV06NWnl7RglxGC8V930uT4619nbOu/V/Gt1O2Qn4ddWLTuTkmXpGxPbCz83TYUzEXCuJmDEiDbcY/EhNsh3gFshCgl5+PNm4LmjtAdBGoIryIo+/7vF6zrIuQhQT2XSBP8FxigtDn1PxGhqAHeQmWXp5Xzz1X007neC9a1uEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbFvRI+KrRdwKdJpJisSFSGNF4u6QJb26f/cm/AC2Qk=;
 b=agYxdmYjVBQpl9Sp3S2XvU7A6VjIPn4+HOxZ4rv8kKDtINJXNE6/xtpbifdx32A33yZsx+0zvSnlXC2h3E4g56CmsDGKOxtKh3gMmFfvuZOlaDOwuzEf1WQkpkXCh8VyKiH7981AlXlwl3jLddOvw34/JQgMRvZfqheh++ISwgyikeeIjdKdKMkZQFYUiHaT35pmDWhYT4nm2fgILPJTn5qXxZ5N/fxF8YblzJU5EOyc9nlV2l/tpbIxNe2dsq1qsCwHkSb49ojGPwoGLdl2oMVCuFCGaJn3SFqCMuqKyebqALZaU/jV5ZC1ZOYUOOFdJ21+uf4cxi7+LyS8Ger6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbFvRI+KrRdwKdJpJisSFSGNF4u6QJb26f/cm/AC2Qk=;
 b=HJgOzCfoI/70y0mmmuMhM3FipfPqtSly881zdW70HaXwjeGhinuvuNYYF07P8IeVQF2M7lmimHCj3SQGr/pMW9pO23Au+zxZOPn1PDSciklptG9bekkLRFJFskgSeRwMy32EEYomefNoRPw2xxeVS6Uw6paZK+oApMIDzwCru60=
Received: from CY4PR1101MB2360.namprd11.prod.outlook.com (10.173.192.137) by
 CY4PR1101MB2263.namprd11.prod.outlook.com (10.172.76.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.20; Tue, 5 Nov 2019 10:11:32 +0000
Received: from CY4PR1101MB2360.namprd11.prod.outlook.com
 ([fe80::a897:af24:535a:1732]) by CY4PR1101MB2360.namprd11.prod.outlook.com
 ([fe80::a897:af24:535a:1732%3]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 10:11:31 +0000
From:   "Zavras, Alexios" <alexios.zavras@intel.com>
To:     Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: RE: spdxcheck.py complains about the second OR?
Thread-Topic: spdxcheck.py complains about the second OR?
Thread-Index: AQHVkGx97YY5RqhHq0ueYoAqFuykEad7mOCAgAADfoCAAMSpYA==
Date:   Tue, 5 Nov 2019 10:11:31 +0000
Message-ID: <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
 <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
In-Reply-To: <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexios.zavras@intel.com; 
x-originating-ip: [134.191.221.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f364d03-0c7d-4c74-c10a-08d761d8880c
x-ms-traffictypediagnostic: CY4PR1101MB2263:
x-microsoft-antispam-prvs: <CY4PR1101MB226395C90A203139F20C2122897E0@CY4PR1101MB2263.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(396003)(136003)(39860400002)(346002)(366004)(376002)(13464003)(199004)(189003)(6436002)(316002)(110136005)(54906003)(6246003)(478600001)(14454004)(446003)(71200400001)(71190400001)(11346002)(86362001)(186003)(8936002)(25786009)(7736002)(305945005)(74316002)(8676002)(486006)(476003)(81166006)(81156014)(7696005)(6506007)(53546011)(5660300002)(52536014)(76116006)(76176011)(26005)(99286004)(102836004)(256004)(33656002)(2906002)(6116002)(3846002)(4326008)(9686003)(66556008)(66476007)(66946007)(64756008)(66446008)(229853002)(66066001)(55016002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2263;H:CY4PR1101MB2360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhEwdWsx6B5O7CEPJf/Jcq+ATEXyXiPceRZmB3dSL0BclmsJoEjIA5VkfUg/jYJSRu79ydD3pxJdtUgaOUpUhoEOdls5PzX9JQHtmv8JNtF/xIEc3842aY3b8YxxE/bPRw1qoXjRPQKtn37TTbfC0RvwGm5n8Mfp5ZuFL4izo+MOQoEWdCAjL388CCZKKip44cKS4qzm4g24n0rudVGdFzhT/qSiI9mnBHZ4mSacme8eg8jXMStUcot80d6NhCXF4xg+gXCDGSUVVLUSPqW1gi/7lb2SyA0cSo64LE+x1XhGKLNijUoI7K7nqqJm5uaKFocr+uUB1NRJ2piOL7/QymUTyjh97mg2BCdWQkg/9j7tT3cWSJHoPKAjYJV6gzXnnU9ErpZtvJNkGlLTZxYhbj9MStmUV1Uo1cWPJnb4AlmQ3q0oHkT+12tqjuqCim7u
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f364d03-0c7d-4c74-c10a-08d761d8880c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2019 10:11:31.8392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJQWuUcrvqnWC5lOBalzTGwrh8xlpq3dUieDGqsve+REgd+fmJRBpxCIyAdHI8l4ZTFw3XCMx/PLmG0KtgodXGwsEaq78WcvGogwNCW/flc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2263
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is not correct.
Since the grammar includes the production "expr: expr OR expr",
there is absolutely no need to add a rule with more than two operands --
it will be handled recursively.

-- zvr

-----Original Message-----
From: linux-spdx-owner@vger.kernel.org <linux-spdx-owner@vger.kernel.org> O=
n Behalf Of Joe Perches
Sent: Monday, 4 November, 2019 23:24
To: Thomas Gleixner <tglx@linutronix.de>; Masahiro Yamada <yamada.masahiro@=
socionext.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-spdx@vger.kernel=
.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: spdxcheck.py complains about the second OR?

On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > scripts/spdxcheck.py warns the following two files.
> > =

> > $ ./scripts/spdxcheck.py
> > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: =

> > OR
> > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: =

> > OR
> > =

> > I do not understand what is wrong with them.
> > =

> > I think "A OR B OR C" is sane.
> =

> Yes it is, but obviously we did not expect files with 3 possible =

> alternative licenses.

Perhaps just this, but the generic logic obviously isn't complete.
---
 scripts/spdxcheck.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py index 6374e0..00be=
34 100755
--- a/scripts/spdxcheck.py
+++ b/scripts/spdxcheck.py
@@ -150,6 +150,7 @@ class id_parser(object):
                 | ID WITH EXC
                 | expr AND expr
                 | expr OR expr
+                | expr OR expr OR expr
                 | LPAR expr RPAR'''
         pass
 =



Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

