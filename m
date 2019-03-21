Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5103AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26943218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 23:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfCUXQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 19:16:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:54160 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfCUXQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 19:16:20 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Mar 2019 16:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,254,1549958400"; 
   d="txt'?scan'208";a="157200803"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 21 Mar 2019 16:16:19 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.133]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.179]) with mapi id 14.03.0415.000;
 Thu, 21 Mar 2019 16:16:18 -0700
From:   "DSouza, Nelson" <nelson.dsouza@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Tony Jones <tonyj@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>, "Jiri Olsa" <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Topic: [PATCH 1/8] perf/x86/intel: Fix memory corruption
Thread-Index: AQHU2meCJVx8rY9sAUm4QKznrmaLf6YS+ruAgABNOYCAAHF+gIAACAKAgAG7WACAABqBAIAA702AgABE+YCAAAcDgIAAAb6AgAARpoCAABcZgP//i2fggAB7WAD//7y0YA==
Date:   Thu, 21 Mar 2019 23:16:17 +0000
Message-ID: <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801@ORSMSX101.amr.corp.intel.com>
References: <20190319182041.GO5996@hirez.programming.kicks-ass.net>
 <CABPqkBQgmT+V29+eD6_rABzNBCo-R22N3PvPX4rWxSWEC0wPPg@mail.gmail.com>
 <20190320222220.GA2490@worktop.programming.kicks-ass.net>
 <20190321123849.GN6521@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211741120.1784@nanos.tec.linutronix.de>
 <20190321171047.GR5996@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1903211815300.1784@nanos.tec.linutronix.de>
 <20190321182011.GT5996@hirez.programming.kicks-ass.net>
 <fa2d8695-f87c-b141-a19b-2ed4b80df987@suse.com>
 <BC9B17E68BB84346BEE0B491BDB7D8AE28A6A745@ORSMSX101.amr.corp.intel.com>
 <20190321200700.GD2490@worktop.programming.kicks-ass.net>
In-Reply-To: <20190321200700.GD2490@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU3YjFmMDktZGNjNi00NDcyLTkyYjktNGY2YzYyZDNjYzllIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiZFlDNE9YWktFUG8zYm9KSDFXRkF5a3BZamxhQkYyYk5ENkN1T1NyRGFIMldzQndaZWxXd2huV3R3bEU2SVRKRiJ9
x-originating-ip: [10.22.254.139]
Content-Type: multipart/mixed;
        boundary="_002_BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801ORSMSX101amrcor_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801ORSMSX101amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Attached cpu hotplug test output while perf is running in the background. N=
o WARN messages seen.

When I run the kexec command, it boots to bios. Haven't used kexec before. =
Still trying to figure that one out.

-----Original Message-----
From: Peter Zijlstra [mailto:peterz@infradead.org]=20
Sent: Thursday, March 21, 2019 1:07 PM
To: DSouza, Nelson <nelson.dsouza@intel.com>
Cc: Tony Jones <tonyj@suse.com>; Thomas Gleixner <tglx@linutronix.de>; Step=
hane Eranian <eranian@google.com>; Ingo Molnar <mingo@kernel.org>; Jiri Ols=
a <jolsa@redhat.com>; LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] perf/x86/intel: Fix memory corruption

On Thu, Mar 21, 2019 at 07:47:50PM +0000, DSouza, Nelson wrote:
> Is the request to check whether the msr gets reset to default upon reboot=
 of the machine ?

basically:

 - apply patch
 - start workload with 4 counter (on all CPUs), such that tfa-msr=3D1
 - try the following:
   o cpu hotplug
   o kexec

to see if the new WARN will trigger -- it should not.

--_002_BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801ORSMSX101amrcor_
Content-Type: text/plain; name="cpu_hotplug.txt"
Content-Description: cpu_hotplug.txt
Content-Disposition: attachment; filename="cpu_hotplug.txt"; size=921;
	creation-date="Thu, 21 Mar 2019 21:02:48 GMT";
	modification-date="Thu, 21 Mar 2019 21:02:48 GMT"
Content-Transfer-Encoding: base64

DQpyb290QGpmMS1vdGMtM0FSMy0zMzp+IyBjYXQgL3N5cy9kZXZpY2VzL2NwdS9hbGxvd190c3hf
Zm9yY2VfYWJvcnQNCjENCnJvb3RAamYxLW90Yy0zQVIzLTMzOn4jIHBlcmYgc3RhdCAtZSBjcywn
e2NhY2hlLW1pc3NlcyxjYWNoZS1yZWZlcmVuY2VzLGJyYW5jaGVzLGJyYW5jaC1taXNzZXN9JyAt
LW5vLW1lcmdlIC1hIHNsZWVwIDYwICYNClsxXSAzMDI1DQpyb290QGpmMS1vdGMtM0FSMy0zMzp+
IyBlY2hvIDAgPiAvc3lzL2RldmljZXMvc3lzdGVtL2NwdS9jcHU0L29ubGluZQ0Kcm9vdEBqZjEt
b3RjLTNBUjMtMzM6fiMgZWNobyAwID4gL3N5cy9kZXZpY2VzL3N5c3RlbS9jcHUvY3B1NS9vbmxp
bmUNCnJvb3RAamYxLW90Yy0zQVIzLTMzOn4jIGVjaG8gMCA+IC9zeXMvZGV2aWNlcy9zeXN0ZW0v
Y3B1L2NwdTYvb25saW5lDQpyb290QGpmMS1vdGMtM0FSMy0zMzp+IyBlY2hvIDAgPiAvc3lzL2Rl
dmljZXMvc3lzdGVtL2NwdS9jcHU3L29ubGluZQ0Kcm9vdEBqZjEtb3RjLTNBUjMtMzM6fiMNCiBQ
ZXJmb3JtYW5jZSBjb3VudGVyIHN0YXRzIGZvciAnc3lzdGVtIHdpZGUnOg0KDQogICAgICAgICAg
ICAgNCw4MDAgICAgICBjcw0KICAgICA8bm90IGNvdW50ZWQ+ICAgICAgY2FjaGUtbWlzc2VzDQog
ICAgIDxub3QgY291bnRlZD4gICAgICBjYWNoZS1yZWZlcmVuY2VzDQogICAgIDxub3QgY291bnRl
ZD4gICAgICBicmFuY2hlcw0KICAgICA8bm90IGNvdW50ZWQ+ICAgICAgYnJhbmNoLW1pc3Nlcw0K
DQogICAgICA2MC4wMDkwOTgxNTAgc2Vjb25kcyB0aW1lIGVsYXBzZWQNCg0KDQoNClsxXSsgIERv
bmUgICAgICAgICAgICAgICAgICAgIHBlcmYgc3RhdCAtZSBjcywne2NhY2hlLW1pc3NlcyxjYWNo
ZS1yZWZlcmVuY2VzLGJyYW5jaGVzLGJyYW5jaC1taXNzZXN9JyAtLW5vLW1lcmdlIC1hIHNsZWVw
IDYwDQoNCg0K

--_002_BC9B17E68BB84346BEE0B491BDB7D8AE28A6A801ORSMSX101amrcor_--
