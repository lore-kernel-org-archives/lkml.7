Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB7C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9B1206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 11:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731423AbfCZLWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 07:22:12 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:64003 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfCZLWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 07:22:09 -0400
Received: from 79.184.253.239.ipv4.supernova.orange.pl (79.184.253.239) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id a2f188b4c0f8b91b; Tue, 26 Mar 2019 12:22:07 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux PM <linux-pm@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH v3 0/4] cpufreq: intel_pstate: Handle _PPC updates on global turbo disable/enable
Date:   Tue, 26 Mar 2019 12:12:35 +0100
Message-ID: <11953735.uMqeHy63Iu@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLAoKVGhpcyBpcyBhIG5ldyB2ZXJzaW9uIG9mIHRoZSBmb2xsb3dpbmcgd2l0aCBvbmUg
cGF0Y2ggYWRkZWQ6Cgo+IFRoaXMgaXMgYSBmb2xsb3ctdXAgdG8gdGhlIFJGVCBwYXRjaCBzZXQg
cG9zdGVkIHByZXZpb3VzbHk6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC85OTU2MDc2
LkY0bHVVRG0xRHFAYXNwaXJlLnJqdy5sYW4vCj4gCj4gUGF0Y2ggWzEvM10gY2F1c2VzIGludGVs
X3BzdGF0ZSB0byB1cGRhdGUgYWxsIHBvbGljaWVzIGlmIGl0IGdldHMgYSBfUFBDCj4gY2hhbmdl
IG5vdGlmaWNhdGlvbiBhbmQgc2VlcyBhIGdsb2JhbCB0dXJibyBkaXNhYmxlL2VuYWJsZSBjaGFu
Z2UuCj4gCj4gUGF0Y2ggWzIvM10gYWRkcyBjcHVmcmVxX2NwdV9hY3F1aXJlKCkgYW5kIGNwdWZy
ZXFfY3B1X3JlbGVhc2UoKSB0byByZWR1Y2UKPiBjb2RlIGR1cGxpY2F0aW9uIGFmdGVyIHRoZSBu
ZXh0IHBhdGNoIGEgYml0IChhbmQgU3Jpbml2YXMgd2FudGVkIHRoZSByd3NlbQo+IG1hbmlwdWxh
dGlvbiB0byBub3QgYmUgZG9uZSBkaXJlY3RseSBieSB0aGUgZHJpdmVyKS4KPiAKPiBQYXRjaCBb
My8zXSBtYWtlcyBpbnRlbF9wc3RhdGUgdXBkYXRlIGNwdWluZm8ubWF4X2ZyZXEgZm9yIGFsbCBw
b2xpY2llcyBpbgo+IHRob3NlIGNhc2VzLgo+IAo+IEkndmUgYXR0ZWQgVGVzdGVkLWJ5IHRhZ3Mg
dG8gcGF0Y2hlcyBbMS8zXSBhbmQgWzMvM10sIGJlY2F1c2UgdGhlcmUgYXJlIG9ubHkKPiBjb3Nt
ZXRpYyBkaWZmZXJlbmNlcyBiZXR3ZWVuIHRoZW0gYW5kIHdoYXQgaGFzIGJlZW4gdGVzdGVkLgAK
ClRoZSBuZXcgcGF0Y2ggZ29lcyAoYXMgdGhlIG5ldyBbMy80XSkgYmVmb3JlIHRoZSBvbGQgWzMv
M10gKHdoaWNoIGJlY29tZXMgdGhlCm5ldyBbNC80XSBvYnZpb3VzbHkpIGFuZCBpdCBtb2RpZmll
cyB0aGUgc2NoZWR1dGlsIGdvdmVybm9yIHRvIHByZXZlbnQgaXQKZnJvbSBjYWNoaW5nIHZhbHVl
cyB0aGF0IGRlcGVuZCBvbiBjcHVpbmZvLm1heF9mcmVxLgoKVGhlIG90aGVyIHBhdGNoZXMgYXJl
IHRoZSBzYW1lIGFzIGJlZm9yZS4KClRoYW5rcywKUmFmYWVsCgoK


