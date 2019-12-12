Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EB0C2D0C9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E845B21655
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 17:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqznNKDF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbfLLRbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 12:31:06 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43093 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730061AbfLLRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 12:31:05 -0500
Received: by mail-lj1-f196.google.com with SMTP id a13so3168813ljm.10;
        Thu, 12 Dec 2019 09:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=pwcDuyQ5H/LeRcpzHWQQ5LPkKEAPYr1LrdRtOV1GNCg=;
        b=fqznNKDF+97BNXhX0xT1avM+7NbUfhXB8lgQUji0tZcAqYWaZxoGnbFjs0dy521YOc
         sfk8GSXNgI2dQkBlBPgZWSALhTs5K0s/jsAzKmjuLXw+9bkhTYTuhPbS7XtX6xyjQ1pL
         u/CMyxQGDWiApJeiYWtF2lmMs3nN92pw9ItmSg2SYehR6+nuvf489VENLcGI7W8DJy4C
         8/R+0xPPWBI2rghv+zJUDpgApdgBz+kGaYPCURhKoMGgIWJyvEqNcpryKduNKVExeHXq
         zr3gK5Be7c4xIaSZLj9qptQ3LUxBFRxrvnB2IrhCgm8kxTcumf2m3rjQgGxeQNLCyCXP
         qGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=pwcDuyQ5H/LeRcpzHWQQ5LPkKEAPYr1LrdRtOV1GNCg=;
        b=T6y1urimeHuTCNpC9lD/dAZE9H5kuKr2DD168rh8DuLgX74FlIeq4ZxgkaJY5lbkXp
         HE7dVNIVR7jDpVDMIpc9+ca3zW55+KMZWEHQKYUeLuwL+lhD4y+iq7d8ZmKfH+3rB8xH
         XkiiGIlhnRAMhZAd+CBJi7mVojrt4fF/RAjOGBndbzDlimX2gRy6Qp5vjDazObiVGueX
         Nf//t5nVQ79+JFJsI3e12JwXNgSDNN0a8V48eKddB1oz42xuyhujTRwFLdPgfnfdX6mY
         0FT2FgvTQ1JnoYfx8bG+dyzH5959LsNEPGnPekCf6WYolhd7st0xcpOqkUN2z38FvtwN
         tVKw==
X-Gm-Message-State: APjAAAWJf/VM0KHrwW0efBUxIi7aOAF/rRnKKve8MIm3mqKDh8oV7XyT
        vWzpgnG1s9CF/HhnBM2jjz9Wjhp1/Y95VFLezyn5saGs
X-Google-Smtp-Source: APXvYqxAjspAhxct45txPMuGxP8n581H7r4DjRSv0XoxKkAFeCDgWkvoP6X0+farZhsuWhWNpr1lDrirmmNr7wPsxZA=
X-Received: by 2002:a2e:8606:: with SMTP id a6mr6723056lji.119.1576171862453;
 Thu, 12 Dec 2019 09:31:02 -0800 (PST)
MIME-Version: 1.0
References: <20191127142707.GB2889@paulmck-ThinkPad-P72> <20191129182823.8710-1-sjpark@amazon.de>
 <CAEjAshoczVRTavYmEb82xh+aJzQ30sKJRTuj=os7nZfFQ3AFfg@mail.gmail.com>
In-Reply-To: <CAEjAshoczVRTavYmEb82xh+aJzQ30sKJRTuj=os7nZfFQ3AFfg@mail.gmail.com>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Thu, 12 Dec 2019 18:30:35 +0100
Message-ID: <CAEjAshoe3HunF4=0LQduZ=QW3mFQVNZQY6xXYJ1TwA1byMrGDQ@mail.gmail.com>
Subject: Re: [PATCH] docs/memory-barriers.txt.kokr: Minor wordsmith
To:     Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8gSm9uLA0KDQpPbiBGcmksIERlYyA2LCAyMDE5IGF0IDY6MjEgUE0gU2VvbmdKYWUgUGFy
ayA8c2ozOC5wYXJrQGdtYWlsLmNvbT4gd3JvdGU6DQo+DQo+IEhlbGxvIEpvbiBhbmQgUGF1bCwN
Cj4NCj4gT24gRnJpLCBOb3YgMjksIDIwMTkgYXQgNzoyOSBQTSBTZW9uZ0phZSBQYXJrIDxzajM4
LnBhcmtAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEFzIHN1Z2dlc3RlZCBieSBQYXVsLCBJ
IGdvdCBhIHJldmlldyBmcm9tIGFub3RoZXIgS29yZWFuIGhhY2tlciBZdW5qYWUuDQo+ID4gIEZy
b20gdGhlIHJldmlldywgSSBnb3Qgbm90IG9ubHkgJ1Jldmlld2VkLWJ5OicgdGFncywgYnV0IGFs
c28gZm91bmQgYQ0KPiA+IGZldyBtaW5vciBuaXRzLiAgU28gSSBtYWRlIGEgc2Vjb25kIHZlcnNp
b24gb2YgdGhlIHBhdGNoc2V0IGJ1dCBqdXN0DQo+ID4gcmVhbGl6ZWQgdGhhdCB0aGUgZmlyc3Qg
dmVyc2lvbiBoYXMgYWxyZWFkeSBzZW50IHRvIExpbnVzLiAgSSB0aGVyZWZvcmUNCj4gPiBzZW5k
IG9ubHkgdGhlIG5pdCBmaXhlcyBhcyBhbm90aGVyIHBhdGNoLg0KPg0KPiBNYXkgSSBhc2sgeW91
ciBjb21tZW50cz8NCg0KTWF5IEkgYXNrIHlvdXIgY29tbWVudHM/DQoNCg0KVGhhbmtzLA0KU2Vv
bmdKYWUgUGFyaw0KDQo+DQo+DQo+IFRoYW5rcywNCj4gU2VvbmdKYWUgUGFyaw0KPg0KPiA+DQo+
ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gPjggLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IGRvY3MvbWVtb3J5LWJhcnJpZXJzLnR4dC5rb2tyOiBN
aW5vciB3b3Jkc21pdGgNCj4gPg0KPiA+IFRoaXMgY29tbWl0IGZpeGVzIGEgY291cGxlIG9mIG1p
bm9yIG5pdHMgaW4gdGhlIEtvcmVhbiB0cmFuc2xhdGlvbiBvZg0KPiA+ICdtZW1vcnktYmFycmll
cnMudHh0Jy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFNlb25nSmFlIFBhcmsgPHNqcGFya0Bh
bWF6b24uZGU+DQo+ID4gUmV2aWV3ZWQtYnk6IFl1bmphZSBMZWUgPGx5ajc2OTRAZ21haWwuY29t
Pg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9tZW1vcnkt
YmFycmllcnMudHh0IHwgNCArKy0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMva29fS1IvbWVtb3J5LWJhcnJpZXJzLnR4dCBiL0RvY3VtZW50YXRpb24vdHJh
bnNsYXRpb25zL2tvX0tSL21lbW9yeS1iYXJyaWVycy50eHQNCj4gPiBpbmRleCBhOGQyNmRmOTM2
MGIuLjI5ZTc2YTczYWU1OSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0
aW9ucy9rb19LUi9tZW1vcnktYmFycmllcnMudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi90
cmFuc2xhdGlvbnMva29fS1IvbWVtb3J5LWJhcnJpZXJzLnR4dA0KPiA+IEBAIC0yNDEzLDcgKzI0
MTMsNyBAQCBf7JWK7Iq164uI64ukXy4NCj4gPiAg7JWM6rOgIOyeiOuKlCwgLSBpbmIoKSDrgpgg
d3JpdGVsKCkg6rO8IOqwmeydgCAtIOyggeygiO2VnCDslaHshLjsiqQg66Oo7Yu07J2EIO2Gte2V
tCDsnbTro6jslrTsoLjslbzrp4wNCj4gPiAg7ZWp64uI64ukLiAg7J206rKD65Ok7J2AIOuMgOu2
gOu2hOydmCDqsr3smrDsl5DripQg66qF7Iuc7KCBIOuplOuqqOumrCDrsLDrpqzslrQg7JmAIO2V
qOq7mCDsgqzsmqnrkKAg7ZWE7JqU6rCADQo+ID4gIOyXhuyKteuLiOuLpOunjCwg7JmE7ZmU65Cc
IOuplOuqqOumrCDslaHshLjsiqQg7IaN7ISx7Jy866GcIEkvTyDrqZTrqqjrpqwg7JyI64+E7Jqw
66Gc7J2YIOywuOyhsOulvCDsnITtlbQNCj4gPiAt7JWh7IS47IqkIO2VqOyImOqwgCDsgqzsmqnr
kJzri6TrqbQg7Iic7ISc66W8IOqwleygnO2VmOq4sCDsnITtlbQgX21hZGF0b3J5XyDrqZTrqqjr
pqwg67Cw66as7Ja06rCADQo+ID4gK+yVoeyEuOyKpCDtlajsiJjqsIAg7IKs7Jqp65Cc64uk66m0
IOyInOyEnOulvCDqsJXsoJztlZjquLAg7JyE7ZW0IF9tYW5kYXRvcnlfIOuplOuqqOumrCDrsLDr
pqzslrTqsIANCj4gPiAg7ZWE7JqU7ZWp64uI64ukLg0KPiA+DQo+ID4gIOuNlCDrp47snYAg7KCV
67O066W8IOychO2VtOyEoCBEb2N1bWVudGF0aW9uL2RyaXZlci1hcGkvZGV2aWNlLWlvLnJzdCDr
pbwg7LC46rOg7ZWY7Iut7Iuc7JikLg0KPiA+IEBAIC0yNTI4LDcgKzI1MjgsNyBAQCBJL08g7JWh
7IS47Iqk66W8IO2Gte2VnCDso7zrs4DsnqXsuZjsmYDsnZgg7Ya17Iug7J2AIOyVhO2CpO2Fjeyz
kOyZgCDquLDquLDsl5ANCj4gPiAgICAgICAgIOydtOqyg+uTpOydgCByZWFkWCgpIOyZgCB3cml0
ZVgoKSDrnpEg67mE7Iq37ZWY7KeA66eMLCDrjZQg7JmE7ZmU65CcIOuplOuqqOumrCDsiJzshJwN
Cj4gPiAgICAgICAgIOuztOyepeydhCDsoJzqs7Xtlanri4jri6QuICDqtazssrTsoIHsnLzroZws
IOydtOqyg+uTpOydgCDsnbzrsJjsoIEg66mU66qo66asIOyVoeyEuOyKpOuCmCBkZWxheSgpDQo+
ID4gICAgICAgICDro6jtlIQgKOyYiDrslZ7snZggMi01IO2VreuqqSkg7JeQIOuMgO2VtCDsiJzs
hJzrpbwg67O07J6l7ZWY7KeAIOyViuyKteuLiOuLpOunjCDrlJTtj7TtirggSS9PDQo+ID4gLSAg
ICAgICDquLDriqXsnLzroZwg66ek7ZWR65CcIF9faW9tZW0g7Y+s7J247YSw7JeQIOuMgO2VtCDr
j5nsnpHtlaAg65WMLCDqsJnsnYAgQ1BVIOyTsOugiOuTnOyXkCDsnZjtlbQNCj4gPiArICAgICAg
IOq4sOuKpeycvOuhnCDrp6TtlZHrkJwgX19pb21lbSDtj6zsnbjthLDsl5Ag64yA7ZW0IOuPmeye
ke2VoCDrlYwsIOqwmeydgCBDUFUg7JOw66CI65Oc7JeQIOydmO2VnA0KPiA+ICAgICAgICAg6rCZ
7J2AIOyjvOuzgOyepey5mOuhnOydmCDslaHshLjsiqTsl5DripQg7Iic7ISc6rCAIOunnuy2sOyn
iCDqsoPsnbQg67O07J6l65Cp64uI64ukLg0KPiA+DQo+ID4gICAoKikgcmVhZHNYKCksIHdyaXRl
c1goKToNCj4gPiAtLQ0KPiA+IDIuMTcuMg0KPiA+DQo=
