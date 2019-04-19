Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B8C282E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732D12183F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 21:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="AmPgExiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfDSVcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 17:32:02 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34578 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbfDSVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 17:32:01 -0400
Received: by mail-pg1-f196.google.com with SMTP id v12so3168229pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2019 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bmO/3Maw7aHDxRDaoZRK9eF6ggF4wRbd5WJejIe/fMI=;
        b=AmPgExiN511iVaIgkj7nImZY53VNLKYx7Trjy8jvbdRoOjhNt/JlQvTs+0Da8Ik6ky
         kLjSlvXT6uYKxki9oT8aKp7CXFcAJXC9Ete5rzskV2tsysBNqV3rS+uTVf7c32ZeWwtN
         HSOhZfkBV9RnRg/vSalH8Te2qkIJVN5OIaQIhDpoIdF4oEwYP8xH7ozQHH3J9I+nlKwb
         w/90YCSx5Qqq1gXlbxoEGNeCJkuNiNVYdCqNwL3VyG/0sTJ1uyLdkXCO6JiEPDbl7QRg
         2TlHogx2JRXzifYYWVOhXpDuXj3hDiUQmmSqT5tk7j93AGujFaTfxeb1aDX/JPkCes1u
         mbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bmO/3Maw7aHDxRDaoZRK9eF6ggF4wRbd5WJejIe/fMI=;
        b=dGrYGe3ti1TXBzcfdPclRr3nl5uaPuyN1/19/GoePoczHhSJiG68kCkMPCm4jZ5QvZ
         x7u8ZCQkUVXQVcGEPILZQX12Q4P2/fg6XPvxquCEI7sjj63zoKJMvcX9Qm1q9dXe4Wvx
         xq3AcK+m/IRYUQZHLe/RwvIjlEGWvTfnoWhjLNw9wEJZp03ReJQ8ZlCnc9LMfFkqKFyO
         cka5BiOvnUAFYYhvN4KdtjyIr7vFvMUHywFJ2m7CT4D8WdmaS1lUFqN2AYDMK2ReYNG5
         M9fpNw/IrLDYphxUkq/9/READZLd+OFT9haXBy7RL5eYvHI9HNGMYMFRyB3BWKceRQ1s
         rM2A==
X-Gm-Message-State: APjAAAUInivjxHQthEGJdKd6YNoTflVqJ8yEzg5KWGu8hT3CSrQewkRf
        bm4ammnugdVuROUWX2uSnDEV2Q==
X-Google-Smtp-Source: APXvYqzW0dV9ei/EYZaITt+OPJAt+fdGtDKlydzieXO7V5ZvIque9w9c4WwWnRU0xth0vJjSP5taag==
X-Received: by 2002:a62:b61a:: with SMTP id j26mr6091794pff.203.1555709521007;
        Fri, 19 Apr 2019 14:32:01 -0700 (PDT)
Received: from [10.249.171.50] (163.sub-97-33-128.myvzw.com. [97.33.128.163])
        by smtp.gmail.com with ESMTPSA id 71sm16191755pfs.36.2019.04.19.14.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 14:31:59 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v20 00/28] Intel SGX1 support
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16E227)
In-Reply-To: <49b28ca1-6e66-87d9-2202-84c58f13fb99@fortanix.com>
Date:   Fri, 19 Apr 2019 14:31:57 -0700
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Dr. Greg" <greg@enjellic.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "npmccallum@redhat.com" <npmccallum@redhat.com>,
        "Ayoun, Serge" <serge.ayoun@intel.com>,
        "Katz-zamir, Shay" <shay.katz-zamir@intel.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Svahn, Kai" <kai.svahn@intel.com>, Borislav Petkov <bp@alien8.de>,
        Josh Triplett <josh@joshtriplett.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        David Rientjes <rientjes@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <444537E3-4156-41FB-83CA-57C5B660523F@amacapital.net>
References: <20190417103938.7762-1-jarkko.sakkinen@linux.intel.com> <20190418171059.GA20819@wind.enjellic.com> <09ebfa1d-c03d-c1fe-ff0f-d99287b6ec3c@intel.com> <20190419141732.GA2269@wind.enjellic.com> <CALCETrV=wAsyWxtxQJ7y0xNrzkE863hTfU6Ysej48Gk9yPFJZw@mail.gmail.com> <43aa8fdd-e777-74cb-e3f0-d36805ffa18b@fortanix.com> <alpine.DEB.2.21.1904192233390.3174@nanos.tec.linutronix.de> <8c5133bc-1301-24ca-418d-7151a6eac0e2@fortanix.com> <alpine.DEB.2.21.1904192248550.3174@nanos.tec.linutronix.de> <e1478f70-7e44-6e3e-2aaf-1b12a96328ed@fortanix.com> <2AE80EA3-799E-4808-BBE4-3872F425BCF8@amacapital.net> <49b28ca1-6e66-87d9-2202-84c58f13fb99@fortanix.com>
To:     Jethro Beekman <jethro@fortanix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 19, 2019, at 2:19 PM, Jethro Beekman <jethro@fortanix.com> wrote:
>=20
>> .
>>=20
>> If we start enforcing equivalent rules on SGX, then the current API will s=
imply not allow enclaves to be loaded =E2=80=94 no matter how you slice it, l=
oading an enclave with the current API is indistinguishable from making arbi=
trary data executable.
>=20
> Yes this is exactly what I intended here: a very simple change that
> stops SGX from confusing LSM. Just by enforcing that everything that
> looks like a memory write (EADD, EAUG, EDBGWR, etc.) actually requires
> write permissions, reality and LSM should be on the same page.
>=20
> If you want to go further and actually allow this behavior when your LSM
> would otherwise prohibit it, presumably the same workarounds that exist
> for JITs can be used for SGX.
>=20
>=20

I do think we need to follow LSM rules.  But my bigger point is that there a=
re policies that don=E2=80=99t allow JIT at all. I think we should arrange t=
he SGX API so it=E2=80=99s still usable when such a policy is in effect.=
