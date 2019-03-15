Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA2FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B300218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfCOV2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:28:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:31787 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbfCOV2g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:28:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 Mar 2019 14:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,483,1544515200"; 
   d="scan'208";a="127373996"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2019 14:28:35 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 15 Mar 2019 14:28:35 -0700
Received: from orsmsx110.amr.corp.intel.com ([169.254.10.179]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.183]) with mapi id 14.03.0415.000;
 Fri, 15 Mar 2019 14:28:35 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Thread-Topic: [PATCH] EDAC, {skx|i10nm}_edac: Fix randconfig build error
Thread-Index: AQHU1EYnRLMb+hIXd0e5wgyhdUkr26X/kCyAgAqos4CAAP2NAIAAQbCAgABB1wCAATn/AP//8wkAgACRTAD//44tAIAAeL8A//+NLQAAFLIpgAAN6p7g
Date:   Fri, 15 Mar 2019 21:28:34 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7D53BD42@ORSMSX110.amr.corp.intel.com>
References: <CAK8P3a3MV=0BbOpjwM+2q+7Oehc=4B+u0hka1YdBnJmikfqCig@mail.gmail.com>
 <20190313230137.GA12529@agluck-desk>
 <CAK8P3a0aDdEt323i=z4BGuh71ntPqm-L33U4q+FiQOdMUin6wg@mail.gmail.com>
 <20190314110413.GA32277@zn.tnic> <20190314215952.GA303@agluck-desk>
 <20190315094341.GA12523@zn.tnic> <20190315155718.GA17775@agluck-desk>
 <20190315173720.GC12523@zn.tnic> <20190315174956.GA20831@agluck-desk>
 <20190315180206.GD12523@zn.tnic> <20190315181108.GA21111@agluck-desk>
 <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
In-Reply-To: <CAK8P3a2CFyF5wExbZPb20E56sJ=3DpsP+0m2Px6D5Sw_L3pKXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDVkYzNmYTMtMDEyZS00ZjYwLWI2NGEtMzJkZDllMDFjNDY0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiN1JFcjVuUHc5NlFmQ0xGSVd3UHpnc0FkY3NyMzZoY2I2MGRLQWpRQlJLb1wvNVZ0dWJic1N0WkFwN1BFdVZEQlEifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBCYXNpY2FsbHkgSSBjaGVhdCBLY29uZmlnLCBzbyBpZiBvbmUgZHJpdmVyIGlzIGJ1aWx0LWlu
IGFuZA0KPiB0aGUgb3RoZXIgaXMgYSBsb2FkYWJsZSBtb2R1bGUsIHdlIGNvbXBpbGUgYm90aCBh
cyBidWlsdC1pbi4NCg0KTXkgbWFpbCBjbGllbnQgbWF5IGhhdmUgbXVuZ2VkIHRoYXQgcGF0aC4g
Qm90aCAiZ2l0IGFtIiBhbmQgInBhdGNoIC1wMSINCmJhcmYgd2hlbiBJIHRyeSB0byBhcHBseSBp
dC4gIFNpbmNlIGl0IHdhcyBzbWFsbCBJIHRyaWVkIHRvIHJlcGxpY2F0ZSBtYW51YWxseSwNCmJ1
dCBJIG11c3QgaGF2ZSBtZXNzZWQgdXAgc29tZXRoaW5nIGJlY2F1c2UgS2NvbmZpZyBzdGlsbCBz
ZWVtcyBjb250ZW50DQp0byBsZXQgbWUgaGF2ZSBDT05GSUdfRURBQ19TS1g9eSB3aXRoIENPTkZJ
R19FREFDX0kxME5NPW0NCg0KOi0oDQoNCi1Ub255DQo=
