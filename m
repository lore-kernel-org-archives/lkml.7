Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F8AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161602084D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfK1Ovp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:51:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:53283 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfK1Ovo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:51:44 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 06:51:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208,223";a="234456064"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by fmsmga004.fm.intel.com with ESMTP; 28 Nov 2019 06:51:43 -0800
Message-ID: <2859c017f515695eae1de47fdcf34db35bc5be39.camel@linux.intel.com>
Subject: Re: unchecked MSR access error in throttle_active_work()
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Date:   Thu, 28 Nov 2019 06:51:42 -0800
In-Reply-To: <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
References: <20191128085447.GA3682@owl.dominikbrodowski.net>
         <20191128094419.GB17745@zn.tnic>
         <20191128102930.jgra6igtp4rppmis@isilmar-4.linta.de>
Content-Type: multipart/mixed; boundary="=-9m5BaBsyY40I/dcVJNyE"
X-Mailer: Evolution 3.28.5 (3.28.5-3.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9m5BaBsyY40I/dcVJNyE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Thu, 2019-11-28 at 11:29 +0100, Dominik Brodowski wrote:
> On Thu, Nov 28, 2019 at 10:44:19AM +0100, Borislav Petkov wrote:
> > On Thu, Nov 28, 2019 at 09:54:47AM +0100, Dominik Brodowski wrote:
> > > On most recent mainline kernels (such as 5.5-rc0 up to
> > > a6ed68d6468b), I see
> > > the following output in dmesg during startup:
> > > 
> > > [   78.016676] unchecked MSR access error: WRMSR to 0x19c (tried
> > > to write 0x00000000880f3a80) at rIP: 0xffffffff84ab5742
> > > (throttle_active_work+0xf2/0x230)
> > > [   78.016686] Call Trace:
> > > [   78.016694]  process_one_work+0x247/0x590
> > > [   78.016703]  worker_thread+0x50/0x3b0
> > > [   78.016710]  kthread+0x10a/0x140
> > > [   78.016715]  ? process_one_work+0x590/0x590
> > > [   78.016735]  ? kthread_park+0x90/0x90
> > > [   78.016740]  ret_from_fork+0x3a/0x50
> > > 
> > > Any clues?
> > 
> > Most likely
> > 
> > f6656208f04e ("x86/mce/therm_throt: Optimize notifications of
> > thermal throttle")
> > 
> > I guess we're missing some X86_FEATURE_ check for that MSR to
> > exist.
> 
> Thanks. FWIW, it's a i7-8650U.
> 
Please try the attached patch. 

Thanks,
Srinivas

> Best,
> 	Dominik

--=-9m5BaBsyY40I/dcVJNyE
Content-Disposition: attachment;
	filename*0=0001-x86-mce-therm_throt-Avoid-updating-RO-and-reserved-b.pat;
	filename*1=ch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name="0001-x86-mce-therm_throt-Avoid-updating-RO-and-reserved-b.patch";
	charset="UTF-8"

RnJvbSA5NDVhMDA2MWFhZjUxNjRlN2FjOGZmNmMwZWUzOWJlMmMwMzVjNTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTcmluaXZhcyBQYW5kcnV2YWRhIDxzcmluaXZhcy5wYW5kcnV2
YWRhQGxpbnV4LmludGVsLmNvbT4KRGF0ZTogVGh1LCAyOCBOb3YgMjAxOSAwNjoyMDo1NyAtMDgw
MApTdWJqZWN0OiBbUEFUQ0hdIHg4Ni9tY2UvdGhlcm1fdGhyb3Q6IEF2b2lkIHVwZGF0aW5nIFJP
IGFuZCByZXNlcnZlZCBiaXRzCgpXaGlsZSB3cml0aW5nIHRvIE1TUiBJQTMyX1RIRVJNX1NUQVRV
Uy9JQTMyX1BLR19USEVSTV9TVEFUVVMgYXZvaWQKd3JpdGluZyAxIHRvIHJlYWQgb25seSBhbmQg
cmVzZXJ2ZWQgZmllbGRzLiBVcGRhdGluZyBzb21lIGZpZWxkcwpnZW5lcmF0ZXMgZXhjZXB0aW9u
LgoKRml4ZXM6IGY2NjU2MjA4ZjA0ZSAoIng4Ni9tY2UvdGhlcm1fdGhyb3Q6IE9wdGltaXplIG5v
dGlmaWNhdGlvbnMgb2YgdGhlcm1hbCB0aHJvdHRsZSIpClNpZ25lZC1vZmYtYnk6IFNyaW5pdmFz
IFBhbmRydXZhZGEgPHNyaW5pdmFzLnBhbmRydXZhZGFAbGludXguaW50ZWwuY29tPgotLS0KIGFy
Y2gveDg2L2tlcm5lbC9jcHUvbWNlL3RoZXJtX3Rocm90LmMgfCAxMyArKysrKysrKysrLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS90aGVybV90aHJvdC5jIGIvYXJjaC94ODYva2Vy
bmVsL2NwdS9tY2UvdGhlcm1fdGhyb3QuYwppbmRleCBkMDFlMGRhMDE2M2EuLjgwYmU0YTVhYzMw
MyAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tY2UvdGhlcm1fdGhyb3QuYworKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21jZS90aGVybV90aHJvdC5jCkBAIC0xOTUsMTcgKzE5NSwy
NCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGF0dHJpYnV0ZV9ncm91cCB0aGVybWFsX2F0dHJfZ3Jv
dXAgPSB7CiAjZGVmaW5lIFRIRVJNX1RIUk9UX1BPTExfSU5URVJWQUwJSFoKICNkZWZpbmUgVEhF
Uk1fU1RBVFVTX1BST0NIT1RfTE9HCUJJVCgxKQogCisjZGVmaW5lIFRIRVJNX1NUQVRVU19DTEVB
Ul9DT1JFX01BU0sgKEJJVCgxKSB8IEJJVCgzKSB8IEJJVCg1KSB8IEJJVCg3KSB8IEJJVCg5KSB8
IEJJVCgxMSkgfCBCSVQoMTMpIHwgQklUKDE1KSkKKyNkZWZpbmUgVEhFUk1fU1RBVFVTX0NMRUFS
X1BLR19NQVNLIChCSVQoMSkgfCBCSVQoMykgfCBCSVQoNSkgfCBCSVQoNykgfCBCSVQoOSkgfCBC
SVQoMTEpKQorCiBzdGF0aWMgdm9pZCBjbGVhcl90aGVybV9zdGF0dXNfbG9nKGludCBsZXZlbCkK
IHsKIAlpbnQgbXNyOwotCXU2NCBtc3JfdmFsOworCXU2NCBtYXNrLCBtc3JfdmFsOwogCi0JaWYg
KGxldmVsID09IENPUkVfTEVWRUwpCisJaWYgKGxldmVsID09IENPUkVfTEVWRUwpIHsKIAkJbXNy
ID0gTVNSX0lBMzJfVEhFUk1fU1RBVFVTOwotCWVsc2UKKwkJbWFzayA9IFRIRVJNX1NUQVRVU19D
TEVBUl9DT1JFX01BU0s7CisJfSBlbHNlIHsKIAkJbXNyID0gTVNSX0lBMzJfUEFDS0FHRV9USEVS
TV9TVEFUVVM7CisJCW1hc2sgPSBUSEVSTV9TVEFUVVNfQ0xFQVJfUEtHX01BU0s7CisJfQogCiAJ
cmRtc3JsKG1zciwgbXNyX3ZhbCk7CisJbXNyX3ZhbCAmPSBtYXNrOwogCXdybXNybChtc3IsIG1z
cl92YWwgJiB+VEhFUk1fU1RBVFVTX1BST0NIT1RfTE9HKTsKIH0KIAotLSAKMi4xNy4yCgo=


--=-9m5BaBsyY40I/dcVJNyE--

