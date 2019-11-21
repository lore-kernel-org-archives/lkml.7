Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF18C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 902A5206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 22:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="y+Cx4cCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfKUWYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:24:25 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:44258 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWYZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 17:24:25 -0500
Received: by mail-pj1-f66.google.com with SMTP id w8so2135766pjh.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 14:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=nuY8UNpMRJXSxqxTXzTq8RcrjbUCVRts4xYxAh2Zw8M=;
        b=y+Cx4cCNn5xgO0nDXLC0BI4Of9z8MkQpUSru1gRF5QsGlWCznI2XRsSZUDHP6b3RWY
         4Ry1i2kE7J9ARo4w0HcYOZGlCj9ZbzYAoUgMyVO+d9RaiW7GfHe5WdNZpiZi2MWs072N
         j5Pl/NrtgmPWvSAA1nbmcLMyOMMvorF1VuGFWY3p2fdyWndyDBPX7jkq3FxcbNzV9V77
         EdAUTLtm+Bm4HTCii3QsypMNNFyuIk0Pt72M4CXBI1vQLuJWLgmUscWdfUgsdkaH4sac
         AMPTL9uRtmHZCGOt8VJOw2HQb28q3lmotM9TsbQoTXnZlPWO2251HSfoveoEYtSAU7ju
         P3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nuY8UNpMRJXSxqxTXzTq8RcrjbUCVRts4xYxAh2Zw8M=;
        b=X6pn8tMOx3LXcJVsWoGgtsqtVYz4lb5rURKnGl/o9Qo85kxfZI8ppqYYJgFmyWdnlx
         OMvh9u+sjLH+Z+/3LWS5jGSLUu5ohhKvIcRRD9ODNdowWLF30VIxZ7XKiLGu97tVzwIq
         CT99Sb7mCW0cFy11+ix3EcK2D/Hpc470xf4uVAwp4Qk4KPqIoht8BmfXYXE3SqF/NNsW
         UceA1cfVCq2kJQ1CHq02HA7YwXJX7H9XdHPVZzVsjShnmPitx1Lr3XNfIg3pHeV7/ARe
         2BSPyfzsBzHUBfvybjeuslRcgzPJS+EscypSS/RIDrIttYHzDbsqYSq8s7fWd4q0guow
         ATkA==
X-Gm-Message-State: APjAAAXUCirqXfsjU8pckbD9hz2OTPo+Uk2VfF3s3LaQiwXpjmWTDc9O
        Ukcil/H3vayxgo/urS7BAl6vMg==
X-Google-Smtp-Source: APXvYqy2Hs5OjH6w1+8YypLA88ewT6R7RiKsDsJdWInAwkbXpI0p+kpgFFuv3caPYxkia4Gs2IarKA==
X-Received: by 2002:a17:90a:23c4:: with SMTP id g62mr14626631pje.121.1574375064089;
        Thu, 21 Nov 2019 14:24:24 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:e8cb:8497:2a8d:1ec8? ([2601:646:c200:1ef2:e8cb:8497:2a8d:1ec8])
        by smtp.gmail.com with ESMTPSA id 83sm3506601pfv.157.2019.11.21.14.24.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:24:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 14:24:21 -0800
Message-Id: <159DB397-87E2-435D-9F33-067FF9296ADC@amacapital.net>
References: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191121215126.GA9075@agluck-desk2.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 1:51 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 02:15:22PM +0100, Peter Zijlstra wrote:
>> Also, just to remind everyone why we really want this. Split lock is a
>> potent, unprivileged, DoS vector.
>=20
> So how much do we "really want this"?
>=20
> It's been 543 days since the first version of this patch was
> posted. We've made exactly zero progress.
>=20
> Current cut down patch series is the foundation to move one
> small step towards getting this done.
>=20
> Almost all of what's in this set will be required in whatever
> final solution we want to end up with. Out of this:

Why don=E2=80=99t we beat it into shape and apply it, hidden behind BROKEN. T=
hen we can work on the rest of the patches and have a way to test them.

It would be really, really nice if we could pass this feature through to a V=
M. Can we?=
