Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEEAC282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F06CB21738
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 18:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfDESjL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 14:39:11 -0400
Received: from mga17.intel.com ([192.55.52.151]:59393 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731739AbfDESjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 14:39:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Apr 2019 11:39:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,313,1549958400"; 
   d="scan'208";a="146929052"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Apr 2019 11:39:09 -0700
Received: from fmsmsx156.amr.corp.intel.com (10.18.116.74) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 5 Apr 2019 11:39:09 -0700
Received: from fmsmsx126.amr.corp.intel.com ([169.254.1.215]) by
 fmsmsx156.amr.corp.intel.com ([169.254.13.6]) with mapi id 14.03.0415.000;
 Fri, 5 Apr 2019 11:39:08 -0700
From:   "Brown, Len" <len.brown@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Len Brown <lenb@kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: [PATCH 09/14] thermal/x86_pkg_temp_thermal: Support
 multi-die/package
Thread-Topic: [PATCH 09/14] thermal/x86_pkg_temp_thermal: Support
 multi-die/package
Thread-Index: AQHUzZt9XVGEFiSV7US9S23DFCIOnKYulScA//+LqiA=
Date:   Fri, 5 Apr 2019 18:39:08 +0000
Message-ID: <1A7043D5F58CCB44A599DFD55ED4C9485C5D6F18@FMSMSX126.amr.corp.intel.com>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <863054888eb8f1a595369c49ec24740501e9c175.1551160674.git.len.brown@intel.com>
 <alpine.DEB.2.21.1904052027280.1802@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1904052027280.1802@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiODg4ZjJmZDUtOWQyZC00NmE4LWE4ZjktYTUwYjQ4MTZkZDk0IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQ1hNZzVJOFFhXC9NcUNjYkNcL1wvTURENFlHNlhRXC9KbWdNYlFxVkNcL3prdmd3dEVhY1p4ZkF5d256NWVVWjBsTHlBIn0=
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.108]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> please add a new helper function topology_max_dies() and retrieve it from that.

I'll do this for Rui -- since his patch is in my x86 branch,
and it is already (very early) Saturday morning for him:-)

FYI, there were a couple of other small changes I made to that branch
in response to list feedback that I pushed, but didn't re-email out the series.

Thomas,
Let me know if you prefer me to re-email the series, or just send a git pull request.

Thanks,
-Len

