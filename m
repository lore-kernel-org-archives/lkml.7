Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D8CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3573214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 16:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728399AbfDVQs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 12:48:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:34221 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfDVQs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 12:48:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Apr 2019 09:48:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,382,1549958400"; 
   d="scan'208";a="293580568"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2019 09:43:58 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 22 Apr 2019 09:43:58 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.4.183]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.17]) with mapi id 14.03.0415.000;
 Mon, 22 Apr 2019 09:43:58 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Cong Wang <xiyou.wangcong@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Topic: [PATCH] RAS/CEC: Add debugfs switch to disable at run time
Thread-Index: AQHU9jKBC6KJVSji90+B+N/k56qJIaZC+16AgAAKogCAAAgoAIAAB+6AgAHqtYCAADq4gIAAmG0AgAAIIQCAAofRkIAAdskA//+NmhA=
Date:   Mon, 22 Apr 2019 16:43:58 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7E90A5E7@ORSMSX104.amr.corp.intel.com>
References: <20190418220229.32133-1-tony.luck@intel.com>
 <CAM_iQpUAfiP2pitFpc-wSy4f_JQo_Wh3BQDxEsT2wwSHDPERow@mail.gmail.com>
 <20190418232910.GR27160@zn.tnic>
 <CAM_iQpVWvg-U6hzKsCPXdObiwKJhQ=BkGDDeP+p671cCWK7QFA@mail.gmail.com>
 <20190419002645.GA559@zn.tnic>
 <CAM_iQpVk564gCu_FBKvYVQjA1hGZ4YXB6ogrSFt=qZwiWen2tw@mail.gmail.com>
 <20190420091313.GA29704@zn.tnic>
 <CAM_iQpUaBOS92u7K+hzzRX5hw0Kbrp-0o0DSfLwSGBhenntVjA@mail.gmail.com>
 <20190420184751.GE29704@zn.tnic>
 <3908561D78D1C84285E8C5FCA982C28F7E90A49F@ORSMSX104.amr.corp.intel.com>
 <20190422163138.GF21457@zn.tnic>
In-Reply-To: <20190422163138.GF21457@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNWM0MTM5MTctZDI4OC00ODgwLTk0OWQtYTc1NjBmNWJkZGViIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnV0U0dla1VCb1NlSVhJUGxxS3hjNSt5dDlQcGhPcXAyRFlZTzI0Q2Z4bmJVZ2o3UE1MR2xwandoSzdzXC9VeXYifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.600.7
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pj4gUmVib290aW5nIGlzbid0IHBvcHVsYXIgaW4gbWFueSBlbmQgdXNlciBzaXR1YXRpb25zLiBN
YW55IENTUCAoY2xvdWQNCj4+IHNlcnZpY2UgcHJvdmlkZXJzKSB2ZWhlbWVudGx5IGhhdGUgdGhl
IGlkZWEgb2YgcmVib290aW5nLg0KPg0KPiBJIG1lYW50IGRpc2FibGUgaW4gS2NvbmZpZyAtIG5v
dCBidWlsZCBpdCBpbiBhdCBhbGwuDQoNCklmIHJlYm9vdGluZyBpcyBiYWQsIHRoZW4gcmUtY29t
cGlsaW5nIGFuZCByZWJvb3RpbmcgaXMgMTAweCB3b3JzZS4gOi0pDQoNCi1Ub255DQo=
