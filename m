Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE82C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8256E206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 10:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbfG3KFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 06:05:36 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48237 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732243AbfG3KFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 06:05:17 -0400
Received: from 79.184.255.110.ipv4.supernova.orange.pl (79.184.255.110) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id f0558f930501a169; Tue, 30 Jul 2019 12:05:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 0/8] PM / ACPI: sleep: Additional changes related to suspend-to-idle
Date:   Tue, 30 Jul 2019 11:51:28 +0200
Message-ID: <7528887.mqcfy9PZua@kreacher>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLAoKPiBPbiB0b3Agb2YgdGhlICJTaW1wbGlmeSB0aGUgc3VzcGVuZC10by1pZGxlIGNv
bnRyb2wgZmxvdyIgcGF0Y2ggc2VyaWVzCj4gcG9zdGVkIHByZXZpb3VzbHk6Cj4gCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC83MTA4NTIyMC56NkZLa3ZZUVBYQGtyZWFjaGVyLwo+IAo+
IHNhbml0aXplIHRoZSBzdXNwZW5kLXRvLWlkbGUgZmxvdyBldmVuIGZ1cnRoZXIuCj4gCj4gRmly
c3Qgb2ZmLCBkZWNvdXBsZSBFQyB3YWtldXAgZnJvbSB0aGUgTFBTMCBfRFNNIHByb2Nlc3Npbmcg
KHBhdGNoIDEpLgo+IAo+IE5leHQsIHJlb3JkZXIgdGhlIGNvZGUgdG8gaW52b2tlIExQUzAgX0RT
TSBGdW5jdGlvbnMgNSBhbmQgNiBpbiB0aGUKPiBzcGVjaWZpY2F0aW9uLWNvbXBsaWFudCBvcmRl
ciB3aXRoIHJlc3BlY3QgdG8gc3VzcGVuZGluZyBhbmQgcmVzdW1pbmcKPiBkZXZpY2VzIChwYXRj
aCAyKS4KPiAKPiBGaW5hbGx5LCByZWFycmFuZ2UgbHBzMF9kZXZpY2VfYXR0YWNoKCkgKHBhdGNo
IDMpIGFuZCBhZGQgYSBjb21tYW5kIGxpbmUKPiBzd2l0Y2ggdG8gcHJldmVudCB0aGUgTFBTMCBf
RFNNIGZyb20gYmVpbmcgdXNlZC4ACgpUaGUgdjIgaXMgYmVjYXVzZSBJIGZvdW5kIGEgKG1pbm9y
KSBidWcgaW4gcGF0Y2ggMSwgZGVjaWRlZCB0byB1c2UgYSBtb2R1bGUgcGFyYW1ldGVyCmluc3Rl
YWQgb2YgYSBrZXJuZWwgY29tbWFuZCBsaW5lIG9wdGlvbiBpbiBwYXRjaCA0LiAgQWxzbywgdGhl
cmUgYXJlIDQgbmV3IHBhdGNoZXM6CgpQYXRjaCA1OiBTd2l0Y2ggdGhlIEVDIG92ZXIgdG8gcG9s
bGluZyBkdXJpbmcgIm5vaXJxIiBzdXNwZW5kIGFuZCBiYWNrIGR1cmluZyAibm9pcnEiCnJlc3Vt
ZS4KClBhdGNoIDY6IEVsaW1pbmF0ZSBhY3BpX3NsZWVwX25vX2VjX2V2ZW50cygpLgoKUGF0Y2gg
NzogQ29uc29saWRhdGUgc29tZSBFQyBjb2RlIGRlcGVuZGluZyBvbiBQTV9TTEVFUC4KClBhdGNo
IDg6IEFkZCBFQyBHUEUgZGlzcGF0Y2hpbmcgZGVidWcgbWVzc2FnZS4KClBsZWFzZSByZWZlciB0
byB0aGUgY2hhbmdlbG9ncyBmb3IgZGV0YWlscy4KClRoYW5rcywKUmFmYWVsCgoKCg==




