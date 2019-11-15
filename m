Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697B6C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41B4A20659
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 02:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKtEGk4J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfKOCcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 21:32:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38608 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfKOCcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 21:32:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so9254490wro.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 18:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:references:mime-version:message-id
         :content-transfer-encoding;
        bh=DsTkCQ/ohhtSbtgPw9/+ZG8W9s9T76Y4sc0b60saEW0=;
        b=RKtEGk4JEwBV2XhqkozLTQH+k9FfYgGr/z8BKwXVlepZDcnpMJqb8bSIPvlUdaEHsc
         MXBJOTicMekRUJHdoejg5cC+w/5pwewboyNPJQ+poIFU/0uJy7rXSr7CldAG1qgv38xZ
         L3qChf52eu6cKLxo1cNlFb2ZPCKo+tCVzU18new65p4ZuQPuk6EdkmViRrMteJWd+0r5
         2tRREkM95aH8fQw0znal756wVjTbWXbwXdwPjWnpkiA8YVemLTLnFUY/sSU+zWdLDtB4
         p/anBabp7Zd0jfjMjx16HYllxMEfGq8HPIBG9DXJRSJiEhj3PrfXvRjZZsh8m4jEvI4E
         VD6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:references:mime-version
         :message-id:content-transfer-encoding;
        bh=DsTkCQ/ohhtSbtgPw9/+ZG8W9s9T76Y4sc0b60saEW0=;
        b=Xumjyd7uKI7N+PRWTkpGs2x6Xti9V5ysFKzUlfZcIwXZvu5NSU1k7uJv/EaVn0KibR
         KewSC8zfhEWRsdg/vecStHLbkar4+XzB9pUdvq+6NsDTYrZByoNBvOn1QvQntodLpVDz
         VxBcQ36z/b2TZ8FAvi5lY7d9HsjfXDchV3o5ECTQkTvYInvv5T++aXYGEtGySN2IkSOJ
         D+ID4KcRD3cins8B9gPIfaynQCTlGsrBD0GTN+Mx2KjCfy8j+8hvMGM9hSfDyS/cBbuT
         WEptsu97IuT11Xm2rpQqbPgFopyJlJFTdz78XfWmp0bxOp4a8mByk4ggnTXJuJAkJjtT
         kuUw==
X-Gm-Message-State: APjAAAXpHUWTIOftrtN7S2xUl1C9gB5IKiok86JbTpvN558LRpb57VxX
        wOknop9ra2Xb4zhc0NtKaOg=
X-Google-Smtp-Source: APXvYqyQwrsCkWED7q+NXdq9Wn2LRvqqcZFNKgAWZUOoyRpn7bkXmfRLWPdJxXihdIx7y4kWVrVt0w==
X-Received: by 2002:adf:c00a:: with SMTP id z10mr12452590wre.81.1573785129787;
        Thu, 14 Nov 2019 18:32:09 -0800 (PST)
Received: from N-20L6PF1KTYA2 ([131.228.2.20])
        by smtp.gmail.com with ESMTPSA id o5sm9294252wrx.15.2019.11.14.18.32.07
        (version=TLS1_2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2019 18:32:09 -0800 (PST)
Date:   Fri, 15 Nov 2019 10:32:07 +0800
From:   "lixinhai.lxh@gmail.com" <lixinhai.lxh@gmail.com>
To:     "Michal Hocko" <mhocko@kernel.org>,
        "Ralph Campbell" <rcampbell@nvidia.com>
Cc:     akpm <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/debug: PageAnon() is true for PageKsm() pages
References: <20191113000651.20677-1-rcampbell@nvidia.com>, 
        <20191114135948.GB1356@dhcp22.suse.cz>
X-Priority: 3
X-GUID: 17C6F490-B4FF-4295-B405-E35367296597
X-Has-Attach: no
X-Mailer: Foxmail 7.2.13.365[cn]
Mime-Version: 1.0
Message-ID: <2019111510320597353014@gmail.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAxOS0xMS0xNMKgYXQgMjE6NTnCoE1pY2hhbCBIb2Nrb8Kgd3JvdGU6Cj5PbiBUdWUgMTIt
MTEtMTkgMTY6MDY6NTEsIFJhbHBoIENhbXBiZWxsIHdyb3RlOgo+PiBQYWdlQW5vbigpIGFuZCBQ
YWdlS3NtKCkgdXNlIHRoZSBsb3cgdHdvIGJpdHMgb2YgdGhlIHBhZ2UtPm1hcHBpbmcgcG9pbnRl
cgo+PiB0byBpbmRpY2F0ZSB0aGUgcGFnZSB0eXBlLiBQYWdlQW5vbigpIG9ubHkgY2hlY2tzIHRo
ZSBMU0Igd2hpbGUgUGFnZUtzbSgpCj4+IGNoZWNrcyB0aGUgbGVhc3Qgc2lnbmlmaWNhbnQgMiBi
aXRzIGFyZSBlcXVhbCB0byAzLiBUaGVyZWZvcmUsIFBhZ2VBbm9uKCkKPj4gaXMgdHJ1ZSBmb3Ig
S1NNIHBhZ2VzLgo+PiBfX2R1bXBfcGFnZSgpIGluY29ycmVjdGx5IHdpbGwgbmV2ZXIgcHJpbnQg
ImtzbSIgYmVjYXVzZSBpdCBjaGVja3MKPj4gUGFnZUFub24oKSBmaXJzdC4gRml4IHRoaXMgYnkg
Y2hlY2tpbmcgUGFnZUtzbSgpIGZpcnN0Lgo+Cj5UaGFua3MgZm9yIHNwb3R0aW5nIHRoaXMKPgo+
Rml4ZXM6IDFjNmZiMWQ4OWU3MyAoIm1tOiBwcmludCBtb3JlIGluZm9ybWF0aW9uIGFib3V0IG1h
cHBpbmcgaW4gX19kdW1wX3BhZ2UiKQo+Cj4+IFNpZ25lZC1vZmYtYnk6IFJhbHBoIENhbXBiZWxs
IDxyY2FtcGJlbGxAbnZpZGlhLmNvbT4KPgo+QWNrZWQtYnk6IE1pY2hhbCBIb2NrbyA8bWhvY2tv
QHN1c2UuY29tPgo+ClRoZSBmb3VyIHZhbHVlcyBmcm9tIHRob3NlIHR3byBsb3dlc3QgYml0cyBo
YXZlIGRpZmZlcmVudCBtZWFuaW5nLCBzbyBQYWdlS3NtIGlzIAp0cnVlwqBkb2VzIG5vdCBtZWFu
IHdlIGNhbiBjb25zaWRlciBQYWdlQW5vbiBpcyBhbHNvIHRydWUgb3IgUGFnZU1vdmFibGUgaXMg
YWxzbyAKdHJ1ZS4KSW1wcm92ZSBQYWdlQW5vbigpIHdvdWxkIGJlIGJldHRlciwgc28gdXNlcnMg
b2YgdGhvc2UgQVBJcyBkbyBub3QgbmVlZCB0byAKcmVtZW1iZXIgdGhpcyBpbXBsaWN0IGNoZWNr
aW5nIHNlcXVlbmNlIGF0IG90aGVyIHBsYWNlcy4KCi0gWGluaGFp

