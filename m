Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FD8C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F36A21924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 15:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391459AbfISPvg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 11:51:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:2484 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390134AbfISPvf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 11:51:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Sep 2019 08:51:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,524,1559545200"; 
   d="scan'208";a="388328357"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga006.fm.intel.com with ESMTP; 19 Sep 2019 08:51:35 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 19 Sep 2019 08:51:34 -0700
Received: from orsmsx115.amr.corp.intel.com ([169.254.4.199]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.232]) with mapi id 14.03.0439.000;
 Thu, 19 Sep 2019 08:51:34 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     James Dingwall <james@dingwall.me.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Subject: RE: pstore does not work under xen
Thread-Topic: pstore does not work under xen
Thread-Index: AQHVbtTEG3HZwn8Lm06tueedx7eTRqczJUnA
Date:   Thu, 19 Sep 2019 15:51:33 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7F472015@ORSMSX115.amr.corp.intel.com>
References: <20190919102643.GA9400@dingwall.me.uk>
In-Reply-To: <20190919102643.GA9400@dingwall.me.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYjYwYWNjODgtZDVhOS00ZWQyLWEyNjItNTA1YmZmYTJkNWQyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiQnJzNkJ1NUpKMFRpTnAxb0pxRVlLVkJcLzF0ZXJza1h3Q1pHeVJheXJaUldKWVFZRHpEMFRwYUdHTkZxT3gxdEsifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I have been investigating a regression in our environment where pstore 
> (efi-pstore specifically but I suspect this would affect all 
> implementations) no longer works after upgrading from a 4.4 to 5.0 
> kernel when running under xen.  (This is an Ubuntu kernel but I don't 
> think there are patches which affect this area.)

I don't have any answer for this ... but want to throw out the idea that
VMM systems could provide some hypercalls to guests to save/return
some blob of memory (perhaps the "save" triggers automagically if the
guest crashes?).

That would provide a much better pstore back end than relying on emulation
of EFI persistent variables (which have severe contraints on size, and don't
support some pstore modes because you can't dynamically update EFI variables
hundreds of times per second).

-Tony
