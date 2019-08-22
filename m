Return-Path: <SRS0=/WLL=WS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C3ACC3A5A2
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B19214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Aug 2019 07:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="AFlhnsKl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfHVHSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Aug 2019 03:18:20 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48834 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727476AbfHVHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Aug 2019 03:18:20 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7M7HnkY025732;
        Thu, 22 Aug 2019 09:17:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=oVgJvQsPM5uwDHjpfeIZOdzAAgSti1coKyBfUwZGJIY=;
 b=AFlhnsKlcLff90I7OHojSuwyL2oy2rYruOezE27q3xG2Bj1ZGPONJvddSX0SyeBaYew0
 Y5M4f2lcvnHLXTXr14kdbskyofTMvQchdwziah2wddoa9kOdJ5wOSXw+4GK1+ABepSY/
 qD7fnrKIUY6cq56Pz25u3+GKvbMfb6q0yuhf1bJrbQ7Ms0KsTslqjCoDAJuRJyKC3Y2E
 g/xhaul0Rht1Pb4f+ZoyLqlkIcYf8f9ZyClZUxzL2gklto2cs6iBv92O+cTYZlQGdlt6
 2eb+FCaa6uOwPgb3wrDc5Al5dVkFVccZ/Htptu+EaadefRh6LjKjoxbC8Jylpmc73OJ9 dg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2ue8fh333m-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 22 Aug 2019 09:17:52 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D7A641;
        Thu, 22 Aug 2019 07:17:42 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node3.st.com [10.75.127.9])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F146C2B3429;
        Thu, 22 Aug 2019 09:17:41 +0200 (CEST)
Received: from SFHDAG5NODE1.st.com (10.75.127.13) by SFHDAG3NODE3.st.com
 (10.75.127.9) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 22 Aug
 2019 09:17:41 +0200
Received: from SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6]) by
 SFHDAG5NODE1.st.com ([fe80::cc53:528c:36c8:95f6%20]) with mapi id
 15.00.1473.003; Thu, 22 Aug 2019 09:17:41 +0200
From:   Gerald BAEZA <gerald.baeza@st.com>
To:     "acme@kernel.org" <arnaldo.melo@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
Subject: RE: perf tool issue following 'perf stat: Fix --no-scale' patch
 integration
Thread-Topic: perf tool issue following 'perf stat: Fix --no-scale' patch
 integration
Thread-Index: AdVYKdLDPGQJ05vWQp+GPnpQmBTpIQAApzCAAAdGDIAAG+0v0A==
Date:   Thu, 22 Aug 2019 07:17:41 +0000
Message-ID: <dc163c5ae1d3418c95e02e13a6205719@SFHDAG5NODE1.st.com>
References: <f686372a96ea490785c0a76cc96b3434@SFHDAG5NODE1.st.com>
 <20190821162635.GB36669@tassilo.jf.intel.com>
 <20190821195451.GG3929@kernel.org>
In-Reply-To: <20190821195451.GG3929@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.44]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-22_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Arnaldo and Andi

Indeed, 'aligned(8)' instead of 'aligned(64)'.
Thanks for your quick feedbacks and I am going to prepare the patch.

G=E9rald
=20


> Em Wed, Aug 21, 2019 at 09:26:35AM -0700, Andi Kleen escreveu:
> > >
> > >    +             char contents[] __attribute__((aligned(64)));
> >
> > I think you want aligned(8). The parameter is bytes, not bits.
> >
> > >
> > >
> > >    But the xyarray structure is generic so I think this patch cannot =
be the
> > >    final one.
> >
> > I think it's fine actually to just apply this generically (with 8). It
> > will only waste a few bytes on other 32bit architectures and should be
> > a nop on 64bit, not worth doing anything more sophisticated.
> >
> > I would just submit a patch to do that.
>=20
> Agreed.
>=20
> - Arnaldo
