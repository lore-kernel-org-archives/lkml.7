Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF801C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A26A20731
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 05:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5It5hUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfKOFr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 00:47:26 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39990 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfKOFr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 00:47:26 -0500
Received: by mail-wr1-f65.google.com with SMTP id i10so9567107wrs.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 21:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=PWnOMb8SIa8Ws7tbMTcbPlxrUtm76/thqR/4ahziM3Q=;
        b=g5It5hUvKJAQYVtG3W8aFDs1ecL+pPWB73G+Fu42DSEhOS775YEKGMtftlW9OKgEot
         wwGXPo/VIB79xh1csBY7MHQ9vtQmJk55FLky0VxDlAzBXtKkY63C0zyyDL+8H/aSclUD
         TdgbH4jpCp7onzw4pefftqmjHdeuNce9uFytytPRSjQCF0Zt8iGbjH+fltboyiQItF79
         HOp7mPx24XKI614F17ArU6u4mbHIpLOuM0pBHHYEcn39QzRaIG9uYM9CeFQiohg6AIz+
         gv2j03c+SCH0q6LgUatx9QBEfZu3qaeYJ/KmHlvNJnYv4mAg2VLLr5vXOmRz9iMid9+E
         8l2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=PWnOMb8SIa8Ws7tbMTcbPlxrUtm76/thqR/4ahziM3Q=;
        b=bOGatT1WVnd/P0jkrvAINkqstcNp8QeBLeetugwozMZhzyC1uvP28oTA1oHKCkrtFn
         6/vso18dX9bqRfkyY1LzegiAh8FZopOOzMu2De//R7NH6itR9u1hC0ur1GCiEdP5JBtx
         S8jEg8mXRBhVzO7Wjp8J1QmouKsW/pX/9pUIDdNECridnvgp+jbkV9Ld5p+79rSoX16d
         BgbXfdyv8nFNoai9TDoK3OtSweHKPQ61mOluM8tfSpZ+aCZ6fj+sIvNk9D4T5veumSCl
         c8yqwsHDW9mK+dzgRINJ7w7O1XH4Rbwdb6lENJvKtQpiEY+TKt+3hYV27yPq1a1KeeTI
         XBJA==
X-Gm-Message-State: APjAAAWduz5D7EeCDdxyV5eWnQEmFlpws7v17skfCLlk26U/Oe5POOW5
        pXElRcpsVA4XLvo7uGapnzQ=
X-Google-Smtp-Source: APXvYqyl6Rnzz3Z0+OKW/hSAFdo9QP7Gwys5zVizrhPRviix56wD/C3vQMeArhD22SnqNSGBqh/Hig==
X-Received: by 2002:a5d:4688:: with SMTP id u8mr2593646wrq.40.1573796843908;
        Thu, 14 Nov 2019 21:47:23 -0800 (PST)
Received: from N-20L6PF1KTYA2 ([131.228.2.20])
        by smtp.gmail.com with ESMTPSA id n23sm8440449wmc.18.2019.11.14.21.47.21
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 21:47:23 -0800 (PST)
Date:   Fri, 15 Nov 2019 13:47:21 +0800
From:   "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>
To:     "Michal Hocko" <mhocko@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Cc:     akpm <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug: PageAnon() is true for PageKsm() pages
References: <20191113000651.20677-1-rcampbell@nvidia.com>, 
        <20191114135948.GB1356@dhcp22.suse.cz>, 
        <2019111510320597353014@gmail.com>
X-Priority: 3
X-GUID: D39CEE16-C913-440B-9C52-B947EE7F4E23
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2019111513472001709128@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMS0xNcKgYXQgMTA6MzLCoGxpeGluaGFpLmx4aMKgd3JvdGU6Cj5PbiAyMDE5LTEx
LTE0wqBhdCAyMTo1OcKgTWljaGFsIEhvY2tvwqB3cm90ZToKPj5PbiBUdWUgMTItMTEtMTkgMTY6
MDY6NTEsIFJhbHBoIENhbXBiZWxsIHdyb3RlOgo+Pj4gUGFnZUFub24oKSBhbmQgUGFnZUtzbSgp
IHVzZSB0aGUgbG93IHR3byBiaXRzIG9mIHRoZSBwYWdlLT5tYXBwaW5nIHBvaW50ZXIKPj4+IHRv
IGluZGljYXRlIHRoZSBwYWdlIHR5cGUuIFBhZ2VBbm9uKCkgb25seSBjaGVja3MgdGhlIExTQiB3
aGlsZSBQYWdlS3NtKCkKPj4+IGNoZWNrcyB0aGUgbGVhc3Qgc2lnbmlmaWNhbnQgMiBiaXRzIGFy
ZSBlcXVhbCB0byAzLiBUaGVyZWZvcmUsIFBhZ2VBbm9uKCkKPj4+IGlzIHRydWUgZm9yIEtTTSBw
YWdlcy4KPj4+IF9fZHVtcF9wYWdlKCkgaW5jb3JyZWN0bHkgd2lsbCBuZXZlciBwcmludCAia3Nt
IiBiZWNhdXNlIGl0IGNoZWNrcwo+Pj4gUGFnZUFub24oKSBmaXJzdC4gRml4IHRoaXMgYnkgY2hl
Y2tpbmcgUGFnZUtzbSgpIGZpcnN0Lgo+Pgo+PlRoYW5rcyBmb3Igc3BvdHRpbmcgdGhpcwo+Pgo+
PkZpeGVzOiAxYzZmYjFkODllNzMgKCJtbTogcHJpbnQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBt
YXBwaW5nIGluIF9fZHVtcF9wYWdlIikKPj4KPj4+IFNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBi
ZWxsIDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KPj4KPj5BY2tlZC1ieTogTWljaGFsIEhvY2tvIDxt
aG9ja29Ac3VzZS5jb20+Cj4+Cj5UaGUgZm91ciB2YWx1ZXMgZnJvbSB0aG9zZSB0d28gbG93ZXN0
IGJpdHMgaGF2ZSBkaWZmZXJlbnQgbWVhbmluZywgc28gUGFnZUtzbSBpcwo+dHJ1ZcKgZG9lcyBu
b3QgbWVhbiB3ZSBjYW4gY29uc2lkZXIgUGFnZUFub24gaXMgYWxzbyB0cnVlIG9yIFBhZ2VNb3Zh
YmxlIGlzIGFsc28KPnRydWUuCj5JbXByb3ZlIFBhZ2VBbm9uKCkgd291bGQgYmUgYmV0dGVyLCBz
byB1c2VycyBvZiB0aG9zZSBBUElzIGRvIG5vdCBuZWVkIHRvCj5yZW1lbWJlciB0aGlzIGltcGxp
Y3QgY2hlY2tpbmcgc2VxdWVuY2UgYXQgb3RoZXIgcGxhY2VzLgo+Cj4tIFhpbmhhaSAKCkxvb2tl
ZCB0aGUgcmVmZXJlbmNlIHRvIFBhZ2VBbm9uKCkgYWdhaW4sIHRoZXJlIGFyZSBtYW55IHVzZSBv
ZiBQYWdlQW5vbigpIHRvwqAKY292ZXIgY2FzZXMgZm9yIGJvdGggQW5vbiB3aXRob3V0IEtTTSBh
bmQgQW5vbiB3aXRoIEtTTS4gQ2hhbmdlIFBhZ2VBbm9uKCnCoAppbXBsZW1lbnRhdGlvbiByZXF1
aXJlIGNoYW5nZSB0aG9zZSBwbGFjZXMsIHNvIGtlZXAgdGhpcyBwYXRjaCBmb3IgY3VycmVudCBp
c3N1ZSBpc8KgCmVub3VnaC4KCi0gWGluaGFpCgo=

