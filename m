Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2F1AC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A632063A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 23:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="qcNpQSUh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfKUXSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 18:18:49 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44938 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfKUXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 18:18:49 -0500
Received: by mail-pl1-f195.google.com with SMTP id az9so2271375plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2019 15:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=T/k6WfAKiK5ZAt7UUpRJgMNaBWYlBAGfNObz/8ZE1Ok=;
        b=qcNpQSUhVvcK/duPw0+fJJ0+qrQWmWj9LDXW1JdbDJ3IAdjrPEObFE4O5fWB4foMBy
         tWtcDdjeZ8ipVggAmvFqrTvk+8PnXTUKB9fW/GUz7SVzOEeIYZrg7ySPO7l8OWwAjf7x
         Rv5RTufvt5rE74Hs+rjxZV4xYO4vbBkpXeNj8S1sTHKhrudwgmRF9yfQDG9JwenwrNIL
         OyoBpCNjZMnnuC/COGy+CUkR7vND9gAudYqYfpBhweE5o7dFMGbe9MS/oEXDrprN3IPJ
         b6m0GGErJOBBKa1Ln3UvcQo32xHlUaLf04unp7Pz8CLTiaZ6LF5sZJfT3eOCWSqmmOIR
         EhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=T/k6WfAKiK5ZAt7UUpRJgMNaBWYlBAGfNObz/8ZE1Ok=;
        b=S7Ir0givgHTquEW0vluoP4+Xhd2LWA5yhw/+Iy8lmWrkvf2qmdhhsLHWLshPoJGVhx
         o6lPyb/eO1yJDsCWTU121AbUdxzTK4M0hoC3yGMXyTFc77a3+txrsy2kesZQ7vcRQFDu
         D0xg1NYmSHqDeLhnX4rHHv34S65S6539BUSGvPdUAn1iFB/9KfaWcGbyMe9TKHoCksuf
         beZEDQmzxj9VMwQMOxe5aTJBXRq2E5pjTRCPfJOMFlgdpcbW4khe455dSLE5cSAkLfHL
         APg+ElYLDD6un5bsAAmWVEtpeC2mYU35/hljdvp4b6+L/ubOWbGUI2oeTPkD3NbP0xhe
         ptBg==
X-Gm-Message-State: APjAAAVferQQnxRVRd62C+wmNwmDAnn7pwINIO1pcPkbr85ATyDpxPPy
        zWg9XUTNksy/tZtH+CCkYh7Vcg==
X-Google-Smtp-Source: APXvYqwQdE15+fpub3lzdCpJVDgkoYf7Nba5bI6C1TwUfcUiH7TmuX8lVAmihM82XQPJc+zmmO2h5A==
X-Received: by 2002:a17:902:fe85:: with SMTP id x5mr11186143plm.292.1574378328671;
        Thu, 21 Nov 2019 15:18:48 -0800 (PST)
Received: from ?IPv6:2600:1010:b062:827f:f4a7:a1e:b790:5671? ([2600:1010:b062:827f:f4a7:a1e:b790:5671])
        by smtp.gmail.com with ESMTPSA id g30sm4084642pgm.23.2019.11.21.15.18.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2019 15:18:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v10 6/6] x86/split_lock: Enable split lock detection by kernel parameter
Date:   Thu, 21 Nov 2019 15:18:46 -0800
Message-Id: <B2612A75-BEC8-4FF7-9FDA-A7B55C2E0B4A@amacapital.net>
References: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F4DC167@ORSMSX115.amr.corp.intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 21, 2019, at 2:29 PM, Luck, Tony <tony.luck@intel.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> It would be really, really nice if we could pass this feature through to a=
 VM. Can we?
>=20
> It's hard because the MSR is core scoped rather than thread scoped.  So on=
 an HT
> enabled system a pair of logical processors gets enabled/disabled together=
.
>=20
>=20

Well that sucks.

Could we pass it through if the host has no HT?  Debugging is *so* much easi=
er in a VM.  And HT is a bit dubious these days anyway.=
