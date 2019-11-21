Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40241C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED854206CB
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="PsIuuJ/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbfKUXME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:12:04 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33429 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:12:04 -0500
Received: by mail-pf1-f196.google.com with SMTP id c184so2536603pfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=NP+haqKPmSQ+6hDWMNAqvC/wCJ+E+aitQAs3F0Y4tsY=;
        b=PsIuuJ/06Kgz6oSBzYf8Xt4v2tbxWe4SCBn9Iggvo34QGCP0y73nNEI/Bygojn7gG5
         tMMBhjMa+YK6ImC75z5nYAOfAcaEzezrWY0MkoKdbyrrFzHzOj9zS9okVwU2O7RZW9Fk
         zVbov70BJHSG+tiV9Wdor8vgDcrpAWLrfJA54QJq/spui7MTp/ASWBBwXB7KHy6cyFgZ
         b8kbqF0Gi0evM3fUG5i69acEzxrXwSFIKC8Wm+09wP0Bhdhj6HeraNfguMnVA9PV8SN8
         /4B1VECl5xhz1bsm5rbNgGbbQnjtFEUmwm63j4Dad5GOwZKmW7HLH5LArmUiRm1A9Nfs
         w0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=NP+haqKPmSQ+6hDWMNAqvC/wCJ+E+aitQAs3F0Y4tsY=;
        b=V3eIQhLfMaqNqn+srG/tTI8zwglD1FomR6IderByM4v1bitw5dk3lSoOHk1CH9o1nn
         sd5QUBGKPKYSSJaZY44mFKVMnHT6Xy5jjXI5ykCIHEM4o9M5vGBpZX6lmpp0hRbT6mcI
         Aw6TRxUqsM+tylTpYYRcJXx1VurrFWNcjrecm/GcX2MqPeEWUcpWyiO5O6A8qGZ9GLyQ
         deasznKqV4VK4o8XiHVgeE/B7+nlcesQo9QikI0wmZXkBeWrEMzjfRA57brDI/xj+mMv
         3qywOH7oYu0gTVN7pa7PXUFiPXz0YuE48rwdssid6ZqDSJSP55veqEYI40zulcMKgByB
         JUjQ==
X-Gm-Message-State: APjAAAWw0KiC1KMJA7GK5GwNNfXEIXAM8yS10X7Obf/SIuLUNThp8aEh
        F2RN5Kf3ke0YauYz6MhI2dcy5g==
X-Google-Smtp-Source: APXvYqz5dojdO7T/reQkQuf6jRFPZecRF3ZU2VLeLeXAq1I3YjVu+Tvcb7E7riv8dyctTcS9cteYnQ==
X-Received: by 2002:a62:5485:: with SMTP id i127mr5978697pfb.186.1574377923797;
        Thu, 21 Nov 2019 15:12:03 -0800 (PST)
Received: from ?IPv6:2600:1010:b062:827f:f4a7:a1e:b790:5671? ([2600:1010:b062:827f:f4a7:a1e:b790:5671])
        by smtp.gmail.com with ESMTPSA id h4sm556971pjs.24.2019.11.21.15.12.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:12:02 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 5/6] x86/split_lock: Handle #AC exception for split lock
Date:   Thu, 21 Nov 2019 15:12:01 -0800
Message-Id: <FB8AAE2A-108E-493A-B5FD-FCBFC1CA1C38@amacapital.net>
References: <20191121231410.GD199273@romley-ivt3.sc.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <20191121231410.GD199273@romley-ivt3.sc.intel.com>
To:     Fenghua Yu <fenghua.yu@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Nov 21, 2019, at 3:02 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>=20
> =EF=BB=BFOn Thu, Nov 21, 2019 at 02:10:38PM -0800, Andy Lutomirski wrote:
>>=20
>>=20
>>>> On Nov 20, 2019, at 5:45 PM, Fenghua Yu <fenghua.yu@intel.com> wrote:
>>>=20
>>> +    if (!user_mode(regs) && split_lock_detect_enabled)
>>> +        panic("Split lock detected\n");
>>=20
>> NAK.
>>=20
>> 1. Don=E2=80=99t say =E2=80=9Csplit lock detected=E2=80=9D if you don=E2=80=
=99t know that you detected a split lock.  Or is this genuinely the only way=
 to get #AC from kernel mode?
>=20
> Intel hardware design team confirmed that the only reason for #AC in ring 0=
 is
> split lock.

Okay.

This should eventually get integrated with Jann=E2=80=99s decoder work to pr=
int the lock address and size.

>=20
>>=20
>> 2. Don=E2=80=99t panic. Use die() just like every other error where nothi=
ng is corrupted.
>=20
> Ok. Will change to die() which provides all the trace information and
> allow multiple split lock in one boot.
>=20
>>=20
>> And maybe instead turn off split lock detection and print a stack trace i=
nstead.  Then the kernel is even more likely to survive to log something use=
ful.
>=20
> How about we just use simple policy die() in this patch set to allow
> detect and debug split lock issues and extend the code base to handle
> split lock with different policies (panic, disable split lock, maybe other=

> options) in the future?
>=20
>=20

I=E2=80=99m okay with this.  Peter?

>=20
