Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6453CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A5205ED
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 14:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440494AbfJYOnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 10:43:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:59704 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436853AbfJYOnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 10:43:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Oct 2019 07:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; 
   d="scan'208";a="228921327"
Received: from pgsmsx107.gar.corp.intel.com ([10.221.44.105])
  by fmsmga002.fm.intel.com with ESMTP; 25 Oct 2019 07:43:14 -0700
Received: from pgsmsx108.gar.corp.intel.com ([169.254.8.51]) by
 PGSMSX107.gar.corp.intel.com ([169.254.7.221]) with mapi id 14.03.0439.000;
 Fri, 25 Oct 2019 22:43:13 +0800
From:   "Lu, Brent" <brent.lu@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Subhransu S . Prusty" <subhransu.s.prusty@intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "M, Naveen" <naveen.m@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
Thread-Topic: [alsa-devel] [PATCH] ASoC: eve: implement set_bias_level
 function for rt5514
Thread-Index: AQHVixSpuo5KyaaW0kmhCX7+/fo7hqdq3ikAgACJfMA=
Date:   Fri, 25 Oct 2019 14:43:12 +0000
Message-ID: <CF33C36214C39B4496568E5578BE70C740320822@PGSMSX108.gar.corp.intel.com>
References: <1571994691-20199-1-git-send-email-brent.lu@intel.com>
 <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
In-Reply-To: <3ce80285-ddb5-653d-cf60-febc9fd0bdee@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiM2M5NGUzY2ItYWE2Mi00M2I1LWE3ZTgtZGY4N2NjOWQ0N2NlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiYmw5bnFvdWdlOWk0RG9KZXN1SE9lZ0RjbUJ1R0IwTWo3M2djNU05dE1wd0w0OTlFNXcwZUF1UUdMNm9HdGt3NyJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [172.30.20.206]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiAxMC8yNS8xOSA0OjExIEFNLCBCcmVudCBMdSB3cm90ZToNCj4gPiBUaGUgZmlyc3QgRE1J
QyBjYXB0dXJlIGFsd2F5cyBmYWlsICh6ZXJvIHNlcXVlbmNlIGRhdGEgZnJvbSBQQ00gcG9ydCkN
Cj4gPiBhZnRlciB1c2luZyBEU1AgaG90d29yZGluZyBmdW5jdGlvbiAoaS5lLiBHb29nbGUgYXNz
aXN0YW50KS4NCj4gDQo+IENhbiB5b3UgY2xhcmlmeSB3aGVyZSB0aGUgRFNQIGhvdHdvcmRpbmcg
aXMgZG9uZT8gSW50ZWwgRFNQIG9yIHJ0NTUxND8NCj4gDQo+IFR1cm5pbmcgb24gdGhlIE1DTEsg
d2l0aCB0aGUgQklBUyBpbmZvIG1pZ2h0IGZvcmNlIHRoZSBJbnRlbCBEU1AgdG8gcmVtYWluDQo+
IG9uLCB3aGljaCB3b3VsZCBpbXBhY3QgcG93ZXIgY29uc3VtcHRpb24gaWYgaXQgd2FzIHN1cHBv
c2VkIHRvIHJlbWFpbiBvZmYuDQo+IA0KDQpIaSBQaWVycmUsDQoNCkl0J3MgZG9uZSBpbiBydDU1
MTQncyBEU1AgYW5kIHRoZSBpbnRlcmZhY2UgaXMgU1BJIGluc3RlYWQgb2YgSTJTIGZvciB0aGUg
dm9pY2Ugd2FrZSANCnVwIGZ1bmN0aW9uLg0KDQpUaGVyZSBpcyBhIGRyaXZlciBydDU1MTQtc3Bp
LmMgd2hpY2ggcHJvdmlkZXMgcGxhdGZvcm0gZHJpdmVyIGFuZCBEQUkuIFVzZXIgc3BhY2UgDQph
cHBsaWNhdGlvbiBmaXJzdCB1c2VzIHRoZSBtaXhlciB0byB0dXJuIG9uIHRoZSB2b2ljZSB3YWtl
IHVwIGZ1bmN0aW9uOg0KDQphbWl4ZXIgLWMwIGNzZXQgbmFtZT0nRFNQIFZvaWNlIFdha2UgVXAn
IG9uDQoNClRoZW4gb3BlbiBhbmQgcmVhZCBkYXRhIGZyb20gdGhlIFBDTSBwb3J0IHdoaWNoIGdv
ZXMgdG8gdGhlIFNQSSBwbGF0Zm9ybSBhbmQgDQpkYWkgY29kZS4gRmluYWxseSBpdCB1c2VzIHNh
bWUgbWl4ZXIgdG8gdHVybiBvZmYgdGhlIGZ1bmN0aW9uIGFuZCByZXR1cm4gdG8gbm9ybWFsIA0K
Y29kZWMgbW9kZS4gVGhlIERNSUMgcmVjb3JkaW5nIChmcm9tIEkyUykgYW5kIHRoZSB2b2ljZSB3
YWtlIG9uIGZ1bmN0aW9uIHNob3VsZCANCmJlIG11dHVhbGx5IGV4Y2x1c2l2ZSBhY2NvcmRpbmcg
dG8gdGhlIGRyaXZlciBkZXNpZ24uDQoNCkluIHRoZSBjb2RlYyBkcml2ZXIgcnQ1NTE0LmMgdGhl
cmUgaXMgYSBydDU1MTRfc2V0X2JpYXNfbGV2ZWwgZnVuY3Rpb24uIEl0J3MgZXhwZWN0ZWQgdG8g
DQp0dXJuIG9uL29mZiBtY2xrIGhlcmUgYWNjb3JkaW5nIHRvIFJlYWx0ZWsgcGVvcGxlJ3Mgc2F5
IGJ1dCBvdXIgc3NwIGNsb2NrIHJlcXVpcmVzIHNldCANCnJhdGUgZnVuY3Rpb24gdG8gYmUgY2Fs
bGVkIGluIGFkdmFuY2Ugc28gSSBpbXBsZW1lbnQgdGhlIGNvZGUgaW4gbWFjaGluZSBkcml2ZXIu
DQoNCg0KUmVnYXJkcywNCkJyZW50DQo+ID4gVGhpcyBydDU1MTQgY29kZWMgcmVxdWlyZXMgdG8g
Y29udHJvbCBtY2xrIGRpcmVjdGx5IGluIHRoZQ0KPiA+IHNldF9iaWFzX2xldmVsIGZ1bmN0aW9u
LiBJbXBsZW1lbnQgdGhpcyBmdW5jdGlvbiBpbiBtYWNoaW5lIGRyaXZlciB0bw0KPiA+IGNvbnRy
b2wgdGhlIHNzcDFfbWNsayBjbG9jayBleHBsaWNpdGx5IGNvdWxkIGZpeCB0aGlzIGlzc3VlLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQnJlbnQgTHUgPGJyZW50Lmx1QGludGVsLmNvbT4NCg0K
