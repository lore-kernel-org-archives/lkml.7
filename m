Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3046DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41E5218D4
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 19:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbfCUTrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 15:47:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:9045 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbfCUTrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 15:47:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 12:47:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,253,1549958400"; 
   d="scan'208";a="129023007"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga006.jf.intel.com with ESMTP; 21 Mar 2019 12:47:51 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 21 Mar 2019 12:47:51 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX121.amr.corp.intel.com ([169.254.10.155]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 12:47:51 -0700
From:   "DSouza, Nelson" <nelson.dsouza@intel.com>
To:     Tony Jones <tonyj@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Topic: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Index: AQHU2meCJVx8rY9sAUm4QKznrmaLf6YS+ruAgABNOYCAAHF+gIAACAKAgAG7WACAABqBAIAA702AgABE+YCAAAcDgIAAAb6AgAARpoCAABcZgP//i2fg
Date:   Thu, 21 Mar 2019 19:47:50 +0000
Message-ID: <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A745@ORSMSX101.amr.corp.intel.com>
References: <CABPqkBT9=XRLinbhA0T5iztM6NGd5fO39-kQoB5j3Evfvfh2yA@mail.gmail.com>
 <20190319110549.GC5996@hirez.programming.kicks-ass.net>
 <CABPqkBQapZFCyJNRjP-GUjfOy62=rJU=Fv=cYPxPTnVFBkqtVA@mail.gmail.com>
 <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
 <20190321182011.GT5996@hirez.programming.kicks-ass.net>
 <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
In-Reply-To: <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2NjYWNkMjMtNjkxMS00Mjg1LWJiZWMtZTJmYjFhZDU5YzFjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoicStxbTFMazdqd1pZUXhhQTd5TjMwXC8zdEs5eFwvZWF0alNIdDU4bDM0ZHhIQVY5YVNFNWdGYmxGTGNCS1dTZWY2In0=
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SXMgdGhlIHJlcXVlc3QgdG8gY2hlY2sgd2hldGhlciB0aGUgbXNyIGdldHMgcmVzZXQgdG8gZGVm
YXVsdCB1cG9uIHJlYm9vdCBvZiB0aGUgbWFjaGluZSA/DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2Fn
ZS0tLS0tDQpGcm9tOiBUb255IEpvbmVzIFttYWlsdG86dG9ueWpAc3VzZS5jb21dIA0KU2VudDog
VGh1cnNkYXksIE1hcmNoIDIxLCAyMDE5IDEyOjQzIFBNDQpUbzogUGV0ZXIgWmlqbHN0cmEgPHBl
dGVyekBpbmZyYWRlYWQub3JnPjsgVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+
DQpDYzogU3RlcGhhbmUgRXJhbmlhbiA8ZXJhbmlhbkBnb29nbGUuY29tPjsgSW5nbyBNb2xuYXIg
PG1pbmdvQGtlcm5lbC5vcmc+OyBKaXJpIE9sc2EgPGpvbHNhQHJlZGhhdC5jb20+OyBMS01MIDxs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRFNvdXphLCBOZWxzb24gPG5lbHNvbi5kc291
emFAaW50ZWwuY29tPg0KU3ViamVjdDogUmU6IFtQQVRDSCAxLzhdIHBlcmYveDg2L2ludGVsOiBG
aXggbWVtb3J5IGNvcnJ1cHRpb24NCg0KT24gMy8yMS8xOSAxMToyMCBBTSwgUGV0ZXIgWmlqbHN0
cmEgd3JvdGU6DQoNCj4gTWlnaHQgYmUgYmVzdCB0byBoYXZlIHNvbWVvbmUgdGVzdCB0aGlzLi4g
c29tZW9uZSB3aXRoIHVjb2RlIGFuZCBhIA0KPiBtYWNoaW5lIGV0Yy4uIDotKQ0KDQpJZiB5b3Vy
IG93biBjb21wYW55IGNhbid0IG9ibGlnZSB5b3UgaGVyZSBQZXRlciA6LSkgSSdtIHN1cmUgSSBj
YW4gbWFrZSBzb21lIHRpbWUgdG8gdGVzdCBpdC4NCg==
