Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B1EC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2621993
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbfGCAaC convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:30:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:56863 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727287AbfGCA36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:29:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jul 2019 17:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,444,1557212400"; 
   d="scan'208";a="184617637"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga001.fm.intel.com with ESMTP; 02 Jul 2019 17:20:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 2 Jul 2019 17:20:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 2 Jul 2019 17:20:52 -0700
Received: from crsmsx103.amr.corp.intel.com (172.18.63.31) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 2 Jul 2019 17:20:52 -0700
Received: from crsmsx101.amr.corp.intel.com ([169.254.1.124]) by
 CRSMSX103.amr.corp.intel.com ([169.254.4.76]) with mapi id 14.03.0439.000;
 Tue, 2 Jul 2019 18:20:50 -0600
From:   "Bae, Chang Seok" <chang.seok.bae@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>
Subject: Re: [PATCH] selftests/x86/fsgsbase: Fix some test case bugs
Thread-Topic: [PATCH] selftests/x86/fsgsbase: Fix some test case bugs
Thread-Index: AQHVMR6idqkf2SQVKkywk8XhSQW+kaa4bKyA
Date:   Wed, 3 Jul 2019 00:20:49 +0000
Message-ID: <77F4123B-C10E-4EC0-AD2B-F7F3223BA3BA@intel.com>
References: <46e6a60f8992fd54da12203e820c35daadaeffb5.1562103506.git.luto@kernel.org>
In-Reply-To: <46e6a60f8992fd54da12203e820c35daadaeffb5.1562103506.git.luto@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.192.184]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DCB9B83EF095F141AEB935CC0833E756@intel.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jul 2, 2019, at 14:38, Andy Lutomirski <luto@kernel.org> wrote:
> 
> @@ -494,16 +489,24 @@ static void test_ptrace_write_gsbase(void)
> 		 * selector value is changed or not by the GSBASE write in
> 		 * a ptracer.
> 		 */
> -		if (gs != 0x7) {
> +		if (gs != *shared_scratch) {
> 			nerrs++;
> 			printf("[FAIL]\tGS changed to %lx\n", gs);

There is one more point to be fixed like this.
So, this diff also needs to be applied:

diff --git a/tools/testing/selftests/x86/fsgsbase.c b/tools/testing/selftests/x86/fsgsbase.c
index de8c80a..c9da4c5 100644
--- a/tools/testing/selftests/x86/fsgsbase.c
+++ b/tools/testing/selftests/x86/fsgsbase.c
@@ -472,7 +472,7 @@ static void test_ptrace_write_gsbase(void)
 
                gs = ptrace(PTRACE_PEEKUSER, child, gs_offset, NULL);
 
-               if (gs != 0x7) {
+               if (gs != *shared_scratch) {
                        nerrs++;
                        printf("[FAIL]\tGS is not prepared with nonzero\n");
                        goto END;

Thanks for the cleanup & the fix!
