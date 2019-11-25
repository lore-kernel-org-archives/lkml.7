Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE41C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A27F320733
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 22:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574722544;
	bh=WHtHioel0bsRQzTFMuYfn5v65oeYsWPjetv1FbWL0AM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eaFq+vM46wwVwIatEQ5f5z+/50V5O5pq07INY/hEmYvOFrYG+JuGg6IPDvZtgTLB9
	 lI+2Kdk/HjiZFegRbJzKTrvOX0Jc3/TrclHOu0B2yAhU1iDXyHWCGXccEzdfwZcZYE
	 8XFyV7TGRvV8n1HEHjY3uSb80Y6TxGJuvA0KtFzY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727133AbfKYWzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 17:55:43 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35580 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKYWzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 17:55:43 -0500
Received: by mail-lj1-f195.google.com with SMTP id j6so8847543lja.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4JS6Z7HYZ/VvxWnBUsbcUW6KSH7DL6yvZxNnRDdTyKA=;
        b=e1eWm/AwHAqA3rxd4ofKz1nCgoi0JUekWoWUah8C335gx1aSyBkUkOQfI3KnFae2V3
         fxrjlOIRUzeJCW7kuQW16O15/WCLV1PX1jmugpfKT49pDTku6+SHFVh2Ih6qH1oIkayK
         /GIUXLJ/dQ3wX1ngVOYHm5HTYBXFp13T5aMNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4JS6Z7HYZ/VvxWnBUsbcUW6KSH7DL6yvZxNnRDdTyKA=;
        b=T5ucbh3MggZl1TyTz/K/gD4AjrIttz4EfD8z+eRZu+iuT5wF28FUT9zU2NWA5/Zx9B
         MhakAQL9AQYHbY2RMBzaskGcODPrg4w1E7WgzVzDlb+ePt5Wf673zW1SONMpLPvVFQFB
         1BRQGtlRstBvO2H4w3mmfis6XJMhjXt3fDo41QwMiZPFgkZko/O1wOkiJnH7qv9Rii19
         YUKOnqR2vsCRoU16DvItGYzg9t/eIJaswCEtU0LIQlqMLQSdHqRoASfvrNC2nTftAbVn
         FTErkVG0WOXOUSKDNeV8FsJh6SYph2Ihc5z85bw93jC7zdIX9zasfJk78QW0JHFXhTkc
         5uGQ==
X-Gm-Message-State: APjAAAVgEWZ5jhFsYSFeDOxdT/wgCU34bkGlSMCUMzJshQI8nHvKPVcR
        k7pooNXXSlf4+I50mEsktVNZVEdMkPs=
X-Google-Smtp-Source: APXvYqzU9crSrRILSIUwdxlbZPrweknU46lZrpmySzsljK3R6pwxp6+1AVJmgdwXzXnn2xa+YLrxwg==
X-Received: by 2002:a2e:c42:: with SMTP id o2mr10233417ljd.222.1574722540719;
        Mon, 25 Nov 2019 14:55:40 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id z19sm4584475ljk.66.2019.11.25.14.55.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2019 14:55:39 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id n21so17823001ljg.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 14:55:39 -0800 (PST)
X-Received: by 2002:a2e:9a8f:: with SMTP id p15mr10381412lji.148.1574722539181;
 Mon, 25 Nov 2019 14:55:39 -0800 (PST)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1911251322160.2408@hp-x360n>
In-Reply-To: <alpine.DEB.2.21.1911251322160.2408@hp-x360n>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 25 Nov 2019 14:55:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
Message-ID: <CAHk-=wj_nbDN3piDJBEteUrjyrZCTA+CCk15NfV=5D2xFfGJGw@mail.gmail.com>
Subject: Re: Commit 0be0ee71 ("fs: properly and reliably lock f_pos in
 fdget_pos()") breaking userspace
To:     "Kenneth R. Crudup" <kenny@panix.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000091866d059833a9bb"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000091866d059833a9bb
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 25, 2019 at 1:30 PM Kenneth R. Crudup <kenny@panix.com> wrote:
>
> FYI. Don't know if the fault lies with these subsystems or not, but I know
> it's been a goal to keep things working. In both cases, reverting this commit
> fixes both these issues. If you need additional information from me, please
> let me know.

Do you have any way to figure out what file descriptor we have in
those two cases?

It's almost certainly trivial to fix - if I were to know just what
kind of file we're blocking on that just needs to be marked
FMODE_STREAM.

The commit itself is also trivial enough to just revert if we can't
figure it out, but that's why I applied it first thing in the merge
window - to see the problems quickly and hopefully get them fixed. It
obviously showed no problems on my machines, but I have neither vmware
nor KDE upower...

Anyway, here's a TOTALLYT UNTESTED patch that may help pinpoint which
thing it is that causes issues.

It might also be so noisy as to be useless, I didn't think it through
a lot. Mind trying it out if you can't immediately see "ahh, vmware fd
#N is a file of type XYZ"?

                    Linus

--00000000000091866d059833a9bb
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_k3f14pxw0>
X-Attachment-Id: f_k3f14pxw0

IGZzL29wZW4uYyB8IDE2ICsrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNl
cnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvb3Blbi5jIGIvZnMvb3Blbi5jCmluZGV4IDVjNjgy
ODJlYTc5ZS4uNWRmZTdjZGU0ZmY1IDEwMDY0NAotLS0gYS9mcy9vcGVuLmMKKysrIGIvZnMvb3Bl
bi5jCkBAIC0xMDc1LDYgKzEwNzUsMjEgQEAgc3RydWN0IGZpbGUgKmZpbGVfb3Blbl9yb290KHN0
cnVjdCBkZW50cnkgKmRlbnRyeSwgc3RydWN0IHZmc21vdW50ICptbnQsCiB9CiBFWFBPUlRfU1lN
Qk9MKGZpbGVfb3Blbl9yb290KTsKIAorLyogSGFja3kgaGFjayBoYWNrICovCitzdGF0aWMgdm9p
ZCBjaGVja19pZl9zdHJlYW0oc3RydWN0IGZpbGUgKmYsIGNvbnN0IGNoYXIgKm5hbWUpCit7CisJ
LyogQWxyZWFkeSBtYXJrZWQgYXMgRk1PREVfU1RSRUFNICovCisJaWYgKGYtPmZfbW9kZSAmIEZN
T0RFX1NUUkVBTSkKKwkJcmV0dXJuOworCisJLyogRG9lcyBpdCBoYXZlIGEgcmVhbCBsc2VlayBp
bXBsZW1lbnRhdGlvbj8gTm90IGEgc3RyZWFtICovCisJaWYgKGYtPmZfb3AgJiYgZi0+Zl9vcC0+
bGxzZWVrICYmIGYtPmZfb3AtPmxsc2VlayAhPSBub19sbHNlZWspCisJCXJldHVybjsKKworCXBy
X2luZm8oIiVzOiBmaWxlICclcycgd2l0aCBvcHMgJWx4ICglcFMpIG1pZ2h0IGJlIGEgc3RyZWFt
IGZpbGVcbiIsCisJCWN1cnJlbnQtPmNvbW0sIG5hbWUsICh1bnNpZ25lZCBsb25nKWYtPmZfb3As
IGYtPmZfb3ApOworfQorCiBsb25nIGRvX3N5c19vcGVuKGludCBkZmQsIGNvbnN0IGNoYXIgX191
c2VyICpmaWxlbmFtZSwgaW50IGZsYWdzLCB1bW9kZV90IG1vZGUpCiB7CiAJc3RydWN0IG9wZW5f
ZmxhZ3Mgb3A7CkBAIC0xMDk3LDYgKzExMTIsNyBAQCBsb25nIGRvX3N5c19vcGVuKGludCBkZmQs
IGNvbnN0IGNoYXIgX191c2VyICpmaWxlbmFtZSwgaW50IGZsYWdzLCB1bW9kZV90IG1vZGUpCiAJ
CX0gZWxzZSB7CiAJCQlmc25vdGlmeV9vcGVuKGYpOwogCQkJZmRfaW5zdGFsbChmZCwgZik7CisJ
CQljaGVja19pZl9zdHJlYW0oZiwgdG1wLT5uYW1lKTsKIAkJfQogCX0KIAlwdXRuYW1lKHRtcCk7
Cg==
--00000000000091866d059833a9bb--
