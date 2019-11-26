Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBD7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B66982071E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="GOi0Pvb5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfKZWaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 17:30:16 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34027 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfKZWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 17:30:16 -0500
Received: by mail-pj1-f68.google.com with SMTP id bo14so8964467pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2019 14:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=SvRgiXbuOoqNEm3OxNPvyr3hgCCZTVydK0BpMfWn0as=;
        b=GOi0Pvb5BaNFOVx+WFLVcqM4IorZsaBZXe384eIVtRGd31vcXMH3bWNLdPt/IW4Ucp
         yGnEwC8DFatLSDA5cSWvTio8PtbEstwYj8/C7Ms94Qw3xfp2tlD05DP52DX24lNximIZ
         TK+pVJqhtC+eBINCQcNwdBMtaitraiWIdvaj7r4jxF6I3XGbtAwEuIQ4uKqezuwW4D78
         3M83G7U8O+JxPezcjk7ennNKb+pRPf40/JWk1U9MZ2Y3IPcUUaww3Aron5e291NZMhT4
         L6EH12vvm4L04PkHGSQUvblelp2S8HkMkElPEy4NmonmTOfF80UXo5w2IMSzyisDC8k/
         bVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SvRgiXbuOoqNEm3OxNPvyr3hgCCZTVydK0BpMfWn0as=;
        b=HKLj8N2BQr83NJkWhf1sJOPRSd2N8sM255Opr5ASv/zricROqaYfUgxc3kQxjpCQ6l
         MD5jm2A2hoN3pyXhsdg78iJ87CZv0/BRORvz+UE2ZNR3UkdEWekdYJFKx5cnolY2tsu3
         d53Et8/+4Gwul15pAHi/AuZQBq0fn7PohlMp8fBOTxRWMZzW9maAuj7q5V8QOTY7QgOq
         rJjg8vE+4MdBLvPsBRGDqaxsVTClD6O8dUVO5Iw0npX8XUyKJRc9zqYcnABRIrsEG1in
         mIVfM4un/hCqihkJHHFqHLC08v+EtdXSEjusCtaddahbcpVVAOaq5ac43fNkPGXBKoja
         Ewiw==
X-Gm-Message-State: APjAAAX6NtaNvjLYlFxw4+oRFOIbI5npzoCTFyYTzv+2s7HuPJy+tk52
        +WspJEIvDtqGe4I8mHCr9wl2pb3WLiQ=
X-Google-Smtp-Source: APXvYqzfb+D5I8yFjdv+SlfXjxO4sSzarp4V8xU6aUsVuFUHb3tq8fZv5mYPopn1jv5GXVgoJvP7+g==
X-Received: by 2002:a17:902:760b:: with SMTP id k11mr670928pll.272.1574807415400;
        Tue, 26 Nov 2019 14:30:15 -0800 (PST)
Received: from ?IPv6:2600:1010:b02c:ebf1:d072:2f46:c89c:d06f? ([2600:1010:b02c:ebf1:d072:2f46:c89c:d06f])
        by smtp.gmail.com with ESMTPSA id u7sm13287076pfh.84.2019.11.26.14.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2019 14:30:14 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: AVX register corruption from signal delivery
Date:   Tue, 26 Nov 2019 14:30:10 -0800
Message-Id: <EFBC6B60-D0EC-4518-A38E-076D3933AA0E@amacapital.net>
References: <20191126221328.GH31379@zn.tnic>
Cc:     Barret Rhoden <brho@google.com>, austin@google.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Rik van Riel <riel@surriel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
In-Reply-To: <20191126221328.GH31379@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 26, 2019, at 2:14 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> =EF=BB=BFOn Tue, Nov 26, 2019 at 04:23:40PM -0500, Barret Rhoden wrote:
>> Thanks; config attached.  I've been able to recreate it in QEMU with at
>> least 2 cores.
>=20
> Yap, I can too, in my VM.
>=20
> Btw, would you guys like to submit that reproducer test program
>=20
> https://bugzilla.kernel.org/attachment.cgi?id=3D286073
>=20
> into the kernel selftests pile here:
>=20
> tools/testing/selftests/x86/
>=20
> ?
>=20
> It needs proper cleanup to fit kernel coding style but it could be a
> good start for collecting interesting FPU test cases.

If we do this, we should have selftests/x86/slow or otherwise have a fast vs=
 slow mode. I really like that the entire suite takes under 2s.=
