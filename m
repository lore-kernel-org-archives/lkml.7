Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1108CC2BD09
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D58A8206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAlEystg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFRWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:22:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43683 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFRWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:22:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id 9so5826947lfq.10;
        Fri, 06 Dec 2019 09:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vPJ3MO7Yf0j9k3EPymnkoJwuolgnVRyKBM9MzJXsk8I=;
        b=kAlEystgAw0RRScHY9vGP3b+f+lN/Gz0ZNmKZyfdKAhevM+oc5ZnzQhhW7D0Q1VtMT
         1pGgdmwCDxyUgPBXbotwZSSPsJCmCoUUGJvuTOgSVLOhVexXL/Z9y2FPOV22BkUGfxFh
         NdfYCHGSsBVVkMHNPOjMhWrOTiLI0KaEAgmoABs+Q3prbIDGC6J3Sb+qhsiC4Rc2xNcp
         5Ufr1Fome7Gm4lfNTD0OcfW8+0KqB5z5MTN5jToYhTuk7uRA5fXMof8cSsb8iJfh4KdL
         SiSbocscRVqOZJMe9vtxWYW1NhYRqljbCFS5RM19nNJKwivxc2ud325MVkSV15QVzraN
         PFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vPJ3MO7Yf0j9k3EPymnkoJwuolgnVRyKBM9MzJXsk8I=;
        b=a9DDzQvTjOkpGEopdyO4jKqOGYiqTJuEAHnwuilHPWRRwBZSgJo6wxeUey6rLygPEM
         J44YwoOFXbSgx6+sy8bTeN09LAJfcFacxMm+m323zcpYBtY4oHJof0mMqrQftetZVPVi
         H1X7BPPrPeUbhfswiyUmg155wZHQVMn4dqOTMaYpy7VrerM7XkQinvNzpQhtmymJXknU
         J4T3qOwxyeK3DCQAGOEMQRIgVgUcdfuRvBH5yqpd9Yl1dGiUcJxDDpIIePKpuKFcyrxb
         zKI6Lv4Nky1PKjEw4GVrgtp8Y5zKKSNm13BIFukZQcMJp5tNBNP7H9W+CwaGtjuNHp8F
         tX4w==
X-Gm-Message-State: APjAAAWb7+EGRmxPJ1CXjelEpR6KLAQC+n8RXjhfGRP/ps3p1uunSLgE
        kjZUCzk/fXk/469O4wAh0ISeBgxFF5Nc3zdkZhqQVA==
X-Google-Smtp-Source: APXvYqzv5Dfbg7QcFrM5OCM5W4DrTWX93I/PMuGdvE2DjYs2haTvnfPrd7leZndxa5wv5EaI2WQo+hXG0eVeQ4d3ANI=
X-Received: by 2002:a19:7015:: with SMTP id h21mr8446933lfc.68.1575652931117;
 Fri, 06 Dec 2019 09:22:11 -0800 (PST)
MIME-Version: 1.0
References: <20191127142707.GB2889@paulmck-ThinkPad-P72> <20191129182823.8710-1-sjpark@amazon.de>
In-Reply-To: <20191129182823.8710-1-sjpark@amazon.de>
From:   SeongJae Park <sj38.park@gmail.com>
Date:   Fri, 6 Dec 2019 18:21:44 +0100
Message-ID: <CAEjAshoczVRTavYmEb82xh+aJzQ30sKJRTuj=os7nZfFQ3AFfg@mail.gmail.com>
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

SGVsbG8gSm9uIGFuZCBQYXVsLA0KDQpPbiBGcmksIE5vdiAyOSwgMjAxOSBhdCA3OjI5IFBNIFNl
b25nSmFlIFBhcmsgPHNqMzgucGFya0BnbWFpbC5jb20+IHdyb3RlOg0KPg0KPiBBcyBzdWdnZXN0
ZWQgYnkgUGF1bCwgSSBnb3QgYSByZXZpZXcgZnJvbSBhbm90aGVyIEtvcmVhbiBoYWNrZXIgWXVu
amFlLg0KPiAgRnJvbSB0aGUgcmV2aWV3LCBJIGdvdCBub3Qgb25seSAnUmV2aWV3ZWQtYnk6JyB0
YWdzLCBidXQgYWxzbyBmb3VuZCBhDQo+IGZldyBtaW5vciBuaXRzLiAgU28gSSBtYWRlIGEgc2Vj
b25kIHZlcnNpb24gb2YgdGhlIHBhdGNoc2V0IGJ1dCBqdXN0DQo+IHJlYWxpemVkIHRoYXQgdGhl
IGZpcnN0IHZlcnNpb24gaGFzIGFscmVhZHkgc2VudCB0byBMaW51cy4gIEkgdGhlcmVmb3JlDQo+
IHNlbmQgb25seSB0aGUgbml0IGZpeGVzIGFzIGFub3RoZXIgcGF0Y2guDQoNCk1heSBJIGFzayB5
b3VyIGNvbW1lbnRzPw0KDQoNClRoYW5rcywNClNlb25nSmFlIFBhcmsNCg0KPg0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLSA+OCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQo+IGRvY3MvbWVtb3J5LWJhcnJpZXJzLnR4dC5rb2tyOiBNaW5vciB3b3Jkc21p
dGgNCj4NCj4gVGhpcyBjb21taXQgZml4ZXMgYSBjb3VwbGUgb2YgbWlub3Igbml0cyBpbiB0aGUg
S29yZWFuIHRyYW5zbGF0aW9uIG9mDQo+ICdtZW1vcnktYmFycmllcnMudHh0Jy4NCj4NCj4gU2ln
bmVkLW9mZi1ieTogU2VvbmdKYWUgUGFyayA8c2pwYXJrQGFtYXpvbi5kZT4NCj4gUmV2aWV3ZWQt
Ynk6IFl1bmphZSBMZWUgPGx5ajc2OTRAZ21haWwuY29tPg0KPiAtLS0NCj4gIERvY3VtZW50YXRp
b24vdHJhbnNsYXRpb25zL2tvX0tSL21lbW9yeS1iYXJyaWVycy50eHQgfCA0ICsrLS0NCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9tZW1vcnktYmFycmllcnMu
dHh0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvbWVtb3J5LWJhcnJpZXJzLnR4
dA0KPiBpbmRleCBhOGQyNmRmOTM2MGIuLjI5ZTc2YTczYWU1OSAxMDA2NDQNCj4gLS0tIGEvRG9j
dW1lbnRhdGlvbi90cmFuc2xhdGlvbnMva29fS1IvbWVtb3J5LWJhcnJpZXJzLnR4dA0KPiArKysg
Yi9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy9rb19LUi9tZW1vcnktYmFycmllcnMudHh0DQo+
IEBAIC0yNDEzLDcgKzI0MTMsNyBAQCBf7JWK7Iq164uI64ukXy4NCj4gIOyVjOqzoCDsnojripQs
IC0gaW5iKCkg64KYIHdyaXRlbCgpIOqzvCDqsJnsnYAgLSDsoIHsoIjtlZwg7JWh7IS47IqkIOuj
qO2LtOydhCDthrXtlbQg7J2066Oo7Ja07KC47JW866eMDQo+ICDtlanri4jri6QuICDsnbTqsoPr
k6TsnYAg64yA67aA67aE7J2YIOqyveyasOyXkOuKlCDrqoXsi5zsoIEg66mU66qo66asIOuwsOum
rOyWtCDsmYAg7ZWo6ruYIOyCrOyaqeuQoCDtlYTsmpTqsIANCj4gIOyXhuyKteuLiOuLpOunjCwg
7JmE7ZmU65CcIOuplOuqqOumrCDslaHshLjsiqQg7IaN7ISx7Jy866GcIEkvTyDrqZTrqqjrpqwg
7JyI64+E7Jqw66Gc7J2YIOywuOyhsOulvCDsnITtlbQNCj4gLeyVoeyEuOyKpCDtlajsiJjqsIAg
7IKs7Jqp65Cc64uk66m0IOyInOyEnOulvCDqsJXsoJztlZjquLAg7JyE7ZW0IF9tYWRhdG9yeV8g
66mU66qo66asIOuwsOumrOyWtOqwgA0KPiAr7JWh7IS47IqkIO2VqOyImOqwgCDsgqzsmqnrkJzr
i6TrqbQg7Iic7ISc66W8IOqwleygnO2VmOq4sCDsnITtlbQgX21hbmRhdG9yeV8g66mU66qo66as
IOuwsOumrOyWtOqwgA0KPiAg7ZWE7JqU7ZWp64uI64ukLg0KPg0KPiAg642UIOunjuydgCDsoJXr
s7Trpbwg7JyE7ZW07ISgIERvY3VtZW50YXRpb24vZHJpdmVyLWFwaS9kZXZpY2UtaW8ucnN0IOul
vCDssLjqs6DtlZjsi63si5zsmKQuDQo+IEBAIC0yNTI4LDcgKzI1MjgsNyBAQCBJL08g7JWh7IS4
7Iqk66W8IO2Gte2VnCDso7zrs4DsnqXsuZjsmYDsnZgg7Ya17Iug7J2AIOyVhO2CpO2FjeyzkOyZ
gCDquLDquLDsl5ANCj4gICAgICAgICDsnbTqsoPrk6TsnYAgcmVhZFgoKSDsmYAgd3JpdGVYKCkg
656RIOu5hOyKt+2VmOyngOunjCwg642UIOyZhO2ZlOuQnCDrqZTrqqjrpqwg7Iic7IScDQo+ICAg
ICAgICAg67O07J6l7J2EIOygnOqzte2VqeuLiOuLpC4gIOq1rOyytOyggeycvOuhnCwg7J206rKD
65Ok7J2AIOydvOuwmOyggSDrqZTrqqjrpqwg7JWh7IS47Iqk64KYIGRlbGF5KCkNCj4gICAgICAg
ICDro6jtlIQgKOyYiDrslZ7snZggMi01IO2VreuqqSkg7JeQIOuMgO2VtCDsiJzshJzrpbwg67O0
7J6l7ZWY7KeAIOyViuyKteuLiOuLpOunjCDrlJTtj7TtirggSS9PDQo+IC0gICAgICAg6riw64ql
7Jy866GcIOunpO2VkeuQnCBfX2lvbWVtIO2PrOyduO2EsOyXkCDrjIDtlbQg64+Z7J6R7ZWgIOuV
jCwg6rCZ7J2AIENQVSDsk7DroIjrk5zsl5Ag7J2Y7ZW0DQo+ICsgICAgICAg6riw64ql7Jy866Gc
IOunpO2VkeuQnCBfX2lvbWVtIO2PrOyduO2EsOyXkCDrjIDtlbQg64+Z7J6R7ZWgIOuVjCwg6rCZ
7J2AIENQVSDsk7DroIjrk5zsl5Ag7J2Y7ZWcDQo+ICAgICAgICAg6rCZ7J2AIOyjvOuzgOyepey5
mOuhnOydmCDslaHshLjsiqTsl5DripQg7Iic7ISc6rCAIOunnuy2sOyniCDqsoPsnbQg67O07J6l
65Cp64uI64ukLg0KPg0KPiAgICgqKSByZWFkc1goKSwgd3JpdGVzWCgpOg0KPiAtLQ0KPiAyLjE3
LjINCj4NCg==
