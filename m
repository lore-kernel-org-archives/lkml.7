Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B972C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29232075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="tw/qW979"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKJhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:37:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:40081 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726804AbfKKJhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:37:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Nov 2019 01:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,292,1569308400"; 
   d="scan'208";a="234416991"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 11 Nov 2019 01:37:35 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 11 Nov 2019 01:37:35 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 11 Nov 2019 01:37:35 -0800
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 11 Nov 2019 01:37:35 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.56) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 11 Nov 2019 01:37:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4PSbfVocvnf92HlzAicZlyo+8TLfhkO+XIh+Z7pS1xc2grgo3sj4yEXrjml5QpMXT+v1isirw7uOMCcMqw8uuOppPK4oRz/lGscnfKGZCFKwE7bYaxV6Bl4dgZBSjEV5VSQkRTcS6OlZlt/2MRM5bZcd3cwmHZUrHBCUzbV+kM3yTYIr6JiQriy3Vday7S/gF+aGKJhdu2SzXWxPqnPrQ6dSwaf+p9RniCkR6OLygq8Z1xdWTQIpefox4LqM3ccfaKCuD8o5OUaOFOVfM8s512NHUrDl2oSXZjzQMTEJ4u8hjRXLrroUGPIJtmzx9u8xWOQXmevk+yvHYjes5M6xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFacM4CLq16Uj2xxGo5nbzX5+CiMj2Pxw2pL6Be3SWM=;
 b=XXNd6mMPlWkeC8WVnq49jqUJPI6oV2KsVKkAoqZDb7D+kY/KBr03P6LHLgK64X8H+zHcGd1FnI7ayxsmvEnCJKRuUG/nBiYL+baVddZXng0Sq6AGDkYgntSm1QybPRartU5FMkln+S2qo7c1WlqcOFgczOscxoS6h7C9LFgcfmM0s18vKU38byGopf2stzFVB5VEjwN2FriE9uX41dyJd0nSGsJzQvNaNsDhTwo+Fy7kdillsG4K/c0yfG4Mkg2M9EqF0DA0iwMup74oKo/D9lmqF6WfFkikNTdHnibMetZNoua3nTqJME7cGi9RpzFA2LcH1I5llaX8imYTXP3cCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iFacM4CLq16Uj2xxGo5nbzX5+CiMj2Pxw2pL6Be3SWM=;
 b=tw/qW979uwDcHSuSEhZ73LYbhnF5Ygit3732NSeIQsCNd1Y/qd22hRgKucJA0Kb2QUZcmWbco26487taMYbmPd1gCDDJmF1cjFuIb7x8VdwVSFl5B4euwyDm+cRcpEnfIom586nZQTPjPRKVfJnUZ2O70xGUs7BLw1O7vuVJ7bU=
Received: from CY4PR1101MB2360.namprd11.prod.outlook.com (10.173.192.137) by
 CY4PR1101MB2120.namprd11.prod.outlook.com (10.172.79.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.22; Mon, 11 Nov 2019 09:37:33 +0000
Received: from CY4PR1101MB2360.namprd11.prod.outlook.com
 ([fe80::a897:af24:535a:1732]) by CY4PR1101MB2360.namprd11.prod.outlook.com
 ([fe80::a897:af24:535a:1732%3]) with mapi id 15.20.2430.027; Mon, 11 Nov 2019
 09:37:33 +0000
From:   "Zavras, Alexios" <alexios.zavras@intel.com>
To:     Joe Perches <joe@perches.com>, Thomas Gleixner <tglx@linutronix.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-spdx@vger.kernel.org" <linux-spdx@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: spdxcheck.py complains about the second OR?
Thread-Topic: spdxcheck.py complains about the second OR?
Thread-Index: AQHVkGx97YY5RqhHq0ueYoAqFuykEad7mOCAgAADfoCAAMSpYIAAVI0AgAkKDLA=
Date:   Mon, 11 Nov 2019 09:37:32 +0000
Message-ID: <CY4PR1101MB236097D5F60B4AD344413FCD89740@CY4PR1101MB2360.namprd11.prod.outlook.com>
References: <CAK7LNASwF9y+MkhkvCRATu0qXSJkxx8fZ-DUjQTfWOi9+1YrfQ@mail.gmail.com>
         <alpine.DEB.2.21.1911042310040.17054@nanos.tec.linutronix.de>
         <46615f063c973eee649e3fdb8261978102c89108.camel@perches.com>
         <CY4PR1101MB2360AB7647D9E2FA15044EE4897E0@CY4PR1101MB2360.namprd11.prod.outlook.com>
 <ec20c751ac1e4156aca0b02dfa0cef4b70cb8ec5.camel@perches.com>
In-Reply-To: <ec20c751ac1e4156aca0b02dfa0cef4b70cb8ec5.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-reaction: no-action
dlp-product: dlpe-windows
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=alexios.zavras@intel.com; 
x-originating-ip: [88.217.180.120]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dba886a6-3296-4674-aa78-08d7668ac738
x-ms-traffictypediagnostic: CY4PR1101MB2120:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <CY4PR1101MB2120B5868CEA8370B764C2D989740@CY4PR1101MB2120.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0218A015FA
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(136003)(39850400004)(346002)(396003)(199004)(189003)(13464003)(66556008)(7696005)(53546011)(33656002)(6506007)(6436002)(476003)(76116006)(66066001)(26005)(446003)(76176011)(11346002)(4326008)(66446008)(64756008)(486006)(66476007)(66946007)(102836004)(15974865002)(256004)(6246003)(55016002)(186003)(71200400001)(71190400001)(9686003)(8936002)(74316002)(2906002)(8676002)(14454004)(478600001)(81166006)(81156014)(316002)(110136005)(7736002)(305945005)(229853002)(52536014)(25786009)(99286004)(86362001)(5660300002)(6116002)(3846002)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2120;H:CY4PR1101MB2360.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5nk31mnc1c1j8gBUDr/jW3WMKeLKYh7epUlt1tnSSmt/x3T+6AXPXhxqEbn6RN8t0bK2vtI7I1SmKJGwRnH/tu97mnslekX2ytQVNPJ+FYPc2vCgLPGRjoyCHmWyWMJfxb2Mx4eKdcbd/+T4iulzZgCGwlMpcYkjGn7C/REIpk6jfdp0h1hdFC+ZzrR1d/inY8dfUrlrnikvDcskGvtCp6+T0gDxgdTdRybVZoybfavYxqAOMsR5VBukU4eD9TQ/JLw5cOScp/9Q4+J9Mw6PDat93c03umU/wcYlTln6joQ5l6Mml7rOuCjrddlNVkVEzET7OqKelY3XX9VvPzP67w9mymn89ZsEq+44AacUUzvvnpxYokL3KrXIf0hN11JD2tzxNUw5l+zu6buveT1EhrA894YZLaCtSlDtOcaCHh731z3zHlvpZn4lQHrSZM8Pawdc6usG/ikRWqdCrTszfxA47Co/KSUmbSQQioDbP0E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: dba886a6-3296-4674-aa78-08d7668ac738
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2019 09:37:32.8844
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vyeTb8uvU2aCmC5NqAsFiuePyH8+md2n8KITCVHK7E6VETjFhFw96qf0zPBglP43WjyI6t1KMB96SkG7viwc6NNnUtfn2ZnaXhYFDFG3Gek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2120
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the delay in replying.
I've never used PLY before, but I do know lex and yacc, so I'm confident th=
at an expression with two (or more) "OR" terms will be handled recursively.

The problem with spdxcheck.py is, I think, that it specifies "nonassoc" in =
the precedence variable, which effectively means that constructs like "a OR=
 b OR c" are not allowed and need to be "(a OR b) OR c". I expect simply de=
leting this string would make everything pass.

The following standalone test code shows that there is no need for any addi=
tional rule in the grammar (the first tests succeed, the last two fail with=
 lexical and parsing errors, respectively):

#!/usr/bin/env python3

import ply.lex as lex
import ply.yacc as yacc

tokens =3D ( 'ID', 'OR', 'AND', 'LPAR', 'RPAR',)

t_ID =3D r'[a-z]+'
t_OR =3D 'OR'
t_AND =3D 'AND'
t_LPAR  =3D r'\('
t_RPAR  =3D r'\)'
t_ignore  =3D ' \t\n'

def p_expr(p):
    '''expr : ID
        | expr AND expr
        | expr OR expr
        | LPAR expr RPAR'''

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

def p_error(p):
    print("Syntax error in input!", p)


lexer =3D lex.lex()
parser =3D yacc.yacc()

tests =3D ( 'a', 'a OR b', 'a AND b', 'a OR b OR c', 'a OR b AND c OR d',
        'a AND @', 'a OR OR b')
for s in tests:
    print(s)
    parser.parse(s)

#EOF----------------------------------------------------------------

-- zvr

-----Original Message-----
From: Joe Perches <joe@perches.com> =

Sent: Tuesday, 5 November, 2019 16:11
To: Zavras, Alexios <alexios.zavras@intel.com>; Thomas Gleixner <tglx@linut=
ronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; linux-spdx@vger.kernel=
.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>; Masahiro Ya=
mada <yamada.masahiro@socionext.com>
Subject: Re: spdxcheck.py complains about the second OR?

On Tue, 2019-11-05 at 10:11 +0000, Zavras, Alexios wrote:
> This is not correct.
> Since the grammar includes the production "expr: expr OR expr", there =

> is absolutely no need to add a rule with more than two operands -- it =

> will be handled recursively.

You sure about the recursion?

It does work and spdxcheck no longer emits a message for these two files.

> -- zvr
> =

> -----Original Message-----
> From: linux-spdx-owner@vger.kernel.org =

> <linux-spdx-owner@vger.kernel.org> On Behalf Of Joe Perches
> Sent: Monday, 4 November, 2019 23:24
> To: Thomas Gleixner <tglx@linutronix.de>; Masahiro Yamada =

> <yamada.masahiro@socionext.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; =

> linux-spdx@vger.kernel.org; Linux Kernel Mailing List =

> <linux-kernel@vger.kernel.org>
> Subject: Re: spdxcheck.py complains about the second OR?
> =

> On Mon, 2019-11-04 at 23:11 +0100, Thomas Gleixner wrote:
> > On Fri, 1 Nov 2019, Masahiro Yamada wrote:
> > > scripts/spdxcheck.py warns the following two files.
> > > =

> > > $ ./scripts/spdxcheck.py
> > > drivers/net/ethernet/pensando/ionic/ionic_if.h: 1:52 Syntax error: =

> > > OR
> > > drivers/net/ethernet/pensando/ionic/ionic_regs.h: 1:52 Syntax error: =

> > > OR
> > > =

> > > I do not understand what is wrong with them.
> > > =

> > > I think "A OR B OR C" is sane.
> > =

> > Yes it is, but obviously we did not expect files with 3 possible =

> > alternative licenses.
> =

> Perhaps just this, but the generic logic obviously isn't complete.
> ---
>  scripts/spdxcheck.py | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/scripts/spdxcheck.py b/scripts/spdxcheck.py index =

> 6374e0..00be34 100755
> --- a/scripts/spdxcheck.py
> +++ b/scripts/spdxcheck.py
> @@ -150,6 +150,7 @@ class id_parser(object):
>                  | ID WITH EXC
>                  | expr AND expr
>                  | expr OR expr
> +                | expr OR expr OR expr
>                  | LPAR expr RPAR'''
>          pass
>  =

> =

> =

> Intel Deutschland GmbH
> Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
> Tel: +49 89 99 8853-0, www.intel.de
> Managing Directors: Christin Eisenschmid, Gary Kershaw Chairperson of =

> the Supervisory Board: Nicole Lau Registered Office: Munich Commercial =

> Register: Amtsgericht Muenchen HRB 186928
> =


Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

