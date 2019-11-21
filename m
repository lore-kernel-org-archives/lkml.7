Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A104C43215
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:00:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCC620872
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NaeVEh1d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfKUIAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:00:38 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:46904 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:00:37 -0500
Received: by mail-wr1-f43.google.com with SMTP id b3so3091307wrs.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 00:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YbaoFvGkzMkk3YVTsbTRKPvpsIhBgk9Eo6jCU2rLZjA=;
        b=NaeVEh1dbnpqhOYiYztXDT+bdEM3to/eiqSV8XOd884SPIbUucmLl6iEKS78ultxe0
         zbEv5mM0e0ZOQLZ1GKYg0RtD0JR1c6BB3SjkPXg71g6VKNgJCVdRxJ1aJUT9xgxz3nfQ
         XxpuY8ZgYMBkejS20uu0f23slAfTX5l7OwV8uFdv2nBIOy+X9ZZ4l9GwR3307d964NG/
         wUJBnj1NXvqov1TKuIJJSfEJ995yX5ldFIho1AJaKOSUXT2+VUQvTcz5BF6a3k6ze1zj
         BoLBXuEokEQUZcJfD5JRnR7vv2h+xCVGckBmw1uDOdxG17Qt6jlDzwflekOkw0cQapBL
         xEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YbaoFvGkzMkk3YVTsbTRKPvpsIhBgk9Eo6jCU2rLZjA=;
        b=Tn9MW6W3pVP9OfKXetDVqdu1QPRqaF/lYCca2SEfZ8oyJkiLRfBUZdrMQximFPrMT+
         EDoWOpcqQ8iTYofONX3GxYMTFrx5z8XqmCtYzriw7DIk8YjEhm68nGKOcmQwWWXgGbj0
         R7dngnrXoSHSR5oGJbah5DYvGUWFb1fY6liQZnmgErjL+tGtthi75UFB4cnocScDpzaw
         ++yWF1X0jMJBR5O18QC8u3+b3iYhyhepu3va9FfbFgZABrPX4eIbzCvpKLlGNpoiOq/3
         hdzRxY8+5hyNdUEnpM5m0CDmSucu9s2thjIP5SZFL9tbJxz0IIbaou3pR1Te8Jro5V9q
         /+gw==
X-Gm-Message-State: APjAAAX62pyrVi/w2z1XGxdBmLGb5Em2z6p8fwaHRYCWHQwd8+A5FwZT
        KPMmPu68HnDcfoQFqLI/YvmM3g==
X-Google-Smtp-Source: APXvYqxspqxd+q75fR3XpIYMvoY+sOz3ci4gXy8JTdQ5WhfIOa9aVVuYlVvU4fuv44rw55Rzl/nksQ==
X-Received: by 2002:adf:a551:: with SMTP id j17mr7924785wrb.18.1574323235749;
        Thu, 21 Nov 2019 00:00:35 -0800 (PST)
Received: from [192.168.0.102] (84-33-69-1.dyn.eolo.it. [84.33.69.1])
        by smtp.gmail.com with ESMTPSA id k1sm2351846wrp.29.2019.11.21.00.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 00:00:35 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.8\))
Subject: Re: Injecting delays into block layer
From:   Paolo Valente <paolo.valente@linaro.org>
In-Reply-To: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
Date:   Thu, 21 Nov 2019 09:00:33 +0100
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D695D19-B226-4093-9C27-CE561ED08CB7@linaro.org>
References: <d7ee69fc368db16fa96a05643083674a@natalenko.name>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
X-Mailer: Apple Mail (2.3445.104.8)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Il giorno 21 nov 2019, alle ore 08:13, Oleksandr Natalenko =
<oleksandr@natalenko.name> ha scritto:
>=20
> Hi Paolo et al.
>=20

Hi

> I have a strong suspect that something is going wrong when the =
underlying block device responds with a large delay. What makes me =
thinking so is that I use a VM on some cloud provider, and they have =
substantial block device latency resulting in permanently high (~20%) =
iowait. It spikes occasionally when their cluster is overloaded, and =
when that happens, the I/O in my VM may stop and never recover. This is =
a rare occasion, but it really happens.
>=20
> What's worse, so far I've seen such a behaviour with BFQ only. I'm =
still testing other schedulers though.
>=20
> Important note: I have no strict evidences that this is *the* case, =
thus I'm asking for some suggestions. My idea is to fire up a local VM =
and inject delays to a block device while performing some I/O from =
within the VM.
>=20
> So the question is: how can those delays be injected? Using dm-delay? =
Can those delays be random?
>=20

So far I have used scsi_debug [1] for this kind of tests.  In my S
suite [2], it boils down to setting SCSI_DEBUG=3Dyes in the S config
file, and then launching any of the benchmarks.  Unfortunately, AFAIK
scsi_debug gives you only constant delays; but you can emulate delay
spikes very easily, by changing the delay parameter manually during
the test.

If this option sounds reasonable to you, then I'm willing to help you
for every step.

Thanks,
Paolo

[1] http://sg.danny.cz/sg/sdebug26.html
[2] https://github.com/Algodev-github/S

> Thanks in advance.
>=20
> --=20
>  Oleksandr Natalenko (post-factum)

