Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B76FC072B1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DA5D208CB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 12:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfE1Mew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 08:34:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:36244 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726999AbfE1Mew (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 08:34:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0881DAE86;
        Tue, 28 May 2019 12:34:50 +0000 (UTC)
Message-ID: <1559046886.13873.2.camel@suse.com>
Subject: Re: [RFC PATCH] usb: host: xhci: allow __GFP_FS in dma allocation
From:   Oliver Neukum <oneukum@suse.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jaewon Kim <jaewon31.kim@gmail.com>,
        Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
        gregkh@linuxfoundation.org, Jaewon Kim <jaewon31.kim@samsung.com>,
        m.szyprowski@samsung.com, ytk.lee@samsung.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 28 May 2019 14:34:46 +0200
In-Reply-To: <Pine.LNX.4.44L0.1905231001100.1553-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1905231001100.1553-100000@iolanthe.rowland.org>
Content-Type: multipart/mixed; boundary="=-I2kQBv2Gth4pqYzgYdi+"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-I2kQBv2Gth4pqYzgYdi+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Donnerstag, den 23.05.2019, 10:01 -0400 schrieb Alan Stern:
> On Wed, 22 May 2019, Oliver Neukum wrote:
> 
> > On Mi, 2019-05-22 at 10:56 -0400, Alan Stern wrote:
> > > On Wed, 22 May 2019, Oliver Neukum wrote:
> > > 
> > > > I agree with the problem, but I fail to see why this issue would be
> > > > specific to USB. Shouldn't this be done in the device core layer?
> > > 
> > > Only for drivers that are on the block-device writeback path.  The 
> > > device core doesn't know which drivers these are.
> > 
> > Neither does USB know. It is very hard to predict or even tell which
> > devices are block device drivers. I think we must assume that
> > any device may be affected.
> 
> All right.  Would you like to submit a patch?

Do you like this one?

	Regards
		Oliver

--=-I2kQBv2Gth4pqYzgYdi+
Content-Disposition: attachment;
	filename="0001-base-force-NOIO-allocations-during-unplug.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-base-force-NOIO-allocations-during-unplug.patch";
	charset="UTF-8"

RnJvbSAwZGM5YzdkZmU5OTRmYzljMjhhNjNiYTI4M2U0NDQyYzIzN2Y2OTg5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBUdWUsIDI4IE1heSAyMDE5IDExOjQzOjAyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gYmFzZTog
Zm9yY2UgTk9JTyBhbGxvY2F0aW9ucyBkdXJpbmcgdW5wbHVnCgpUaGVyZSBpcyBvbmUgb3Zlcmxv
b2tlZCBzaXR1YXRpb24gdW5kZXIgd2hpY2ggYSBkcml2ZXIKbXVzdCBub3QgZG8gSU8gdG8gYWxs
b2NhdGUgbWVtb3J5LiBZb3UgY2Fubm90IGRvIHRoYXQKd2hpbGUgZGlzY29ubmVjdGluZyBhIGRl
dmljZS4gQSBkZXZpY2UgYmVpbmcgZGlzY29ubmVjdGVkCmlzIG5vIGxvbmdlciBmdW5jdGlvbmFs
IGluIG1vc3QgY2FzZXMsIHlldCBJTyBtYXkgZmFpbApvbmx5IHdoZW4gdGhlIGhhbmRsZXIgcnVu
cy4KClNpZ25lZC1vZmYtYnk6IE9saXZlciBOZXVrdW0gPG9uZXVrdW1Ac3VzZS5jb20+Ci0tLQog
ZHJpdmVycy9iYXNlL2NvcmUuYyB8IDQgKysrKwogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFzZS9jb3JlLmMgYi9kcml2ZXJzL2Jhc2UvY29y
ZS5jCmluZGV4IGZkNzUxMWUwNGU2Mi4uYTdmNWY0NWJkNzYxIDEwMDY0NAotLS0gYS9kcml2ZXJz
L2Jhc2UvY29yZS5jCisrKyBiL2RyaXZlcnMvYmFzZS9jb3JlLmMKQEAgLTIyMjksNiArMjIyOSw3
IEBAIHZvaWQgZGV2aWNlX2RlbChzdHJ1Y3QgZGV2aWNlICpkZXYpCiAJc3RydWN0IGRldmljZSAq
cGFyZW50ID0gZGV2LT5wYXJlbnQ7CiAJc3RydWN0IGtvYmplY3QgKmdsdWVfZGlyID0gTlVMTDsK
IAlzdHJ1Y3QgY2xhc3NfaW50ZXJmYWNlICpjbGFzc19pbnRmOworCXVuc2lnbmVkIGludCBub2lv
X2ZsYWc7CiAKIAkvKgogCSAqIEhvbGQgdGhlIGRldmljZSBsb2NrIGFuZCBzZXQgdGhlICJkZWFk
IiBmbGFnIHRvIGd1YXJhbnRlZSB0aGF0CkBAIC0yMjU2LDYgKzIyNTcsNyBAQCB2b2lkIGRldmlj
ZV9kZWwoc3RydWN0IGRldmljZSAqZGV2KQogCQlkZXZpY2VfcmVtb3ZlX3N5c19kZXZfZW50cnko
ZGV2KTsKIAkJZGV2aWNlX3JlbW92ZV9maWxlKGRldiwgJmRldl9hdHRyX2Rldik7CiAJfQorCW5v
aW9fZmxhZyA9IG1lbWFsbG9jX25vaW9fc2F2ZSgpOwogCWlmIChkZXYtPmNsYXNzKSB7CiAJCWRl
dmljZV9yZW1vdmVfY2xhc3Nfc3ltbGlua3MoZGV2KTsKIApAQCAtMjI3Nyw2ICsyMjc5LDggQEAg
dm9pZCBkZXZpY2VfZGVsKHN0cnVjdCBkZXZpY2UgKmRldikKIAlkZXZpY2VfcGxhdGZvcm1fbm90
aWZ5KGRldiwgS09CSl9SRU1PVkUpOwogCWRldmljZV9yZW1vdmVfcHJvcGVydGllcyhkZXYpOwog
CWRldmljZV9saW5rc19wdXJnZShkZXYpOworCW1lbWFsbG9jX25vaW9fcmVzdG9yZShub2lvX2Zs
YWcpOworCiAKIAlpZiAoZGV2LT5idXMpCiAJCWJsb2NraW5nX25vdGlmaWVyX2NhbGxfY2hhaW4o
JmRldi0+YnVzLT5wLT5idXNfbm90aWZpZXIsCi0tIAoyLjE2LjQKCg==


--=-I2kQBv2Gth4pqYzgYdi+--

