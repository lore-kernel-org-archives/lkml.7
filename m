Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9385C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F982070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XE11i5xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfEPRob (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:44:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44481 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfEPRob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:44:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so1958897pll.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:subject:from:cc:to:user-agent:date;
        bh=DX/0b6pgfq4vy5hUE2kIwYaDF+AtWlTKg8LM9zPMAa8=;
        b=XE11i5xyueyydoGi38YztQ9gONd0wLmDe/yVLxiFnODw2wvOE8lJprhZUutH/Gdcpv
         eYIv8FhThxToxGi5KSJixb92A62/lV/+0IeFK2kOVV/KUchrY3Z7Ey+5vgkZ2CDhK5Ye
         T4EYyt69uuYjqPSvA0xLVWIDZ+Ijr0X5Xfb7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:subject:from:cc:to
         :user-agent:date;
        bh=DX/0b6pgfq4vy5hUE2kIwYaDF+AtWlTKg8LM9zPMAa8=;
        b=k5qWfPsm+uI8CcdnbkXfl+BH8oOMwsJWbvf+hgReUP5T4l/n2gyjEaPp3CZwVJPY5L
         RuIfrWRdRVnQXJ8u4UDt4gpUrOHGVP3L5GQYsMBRDlHSSSOz8nnnePw7OBa/kdWIsS8P
         L7p95VfpcN9gpC2on7T5GM637UWY5pVFUjNJAjNeYcjdMiwOF9sLlNntvnnahDToDGpJ
         55zrAU2wHAYm3UEwWFP+haylq9YWIKjI5Gue95WnRGwd/7gLWMGM6a00CtAHqQCOqRYx
         9LAbrAjoTnT+mkViHnT93488JNB8KwXXQ13FgEag0x/RwKphayASGSZVwsp1HTTwdavk
         KcBg==
X-Gm-Message-State: APjAAAUDOOJ0lPxi90vyCP0Y/1om7RVloFpJMEsah1QbzxhjZ6bqf6qN
        86dlc4xkTXL5uXJWT931/+Vugg==
X-Google-Smtp-Source: APXvYqwy/23C7m757nVm0coVXHptiwFhOoy5KhnjKfhpmcwZpI4khzL/xlya3yYqee+7/YvydKFFsQ==
X-Received: by 2002:a17:902:b489:: with SMTP id y9mr49928224plr.70.1558028670695;
        Thu, 16 May 2019 10:44:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c16sm3017447pfd.99.2019.05.16.10.44.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 May 2019 10:44:29 -0700 (PDT)
Message-ID: <5cdda17d.1c69fb81.8e244.683a@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <5f598806-1c36-7c2a-0f47-da79ec7d28c6@arm.com>
References: <20190516102817.188519-1-hsinyi@chromium.org> <20190516102817.188519-2-hsinyi@chromium.org> <CAL_JsqLx1UdjCnZ69aQm0GU_uOdd7tTdD_oM=D7yhDANoQ0fEA@mail.gmail.com> <CAJMQK-jrJQri3gM=X6JRD6Rk+B5S4939HJTptrQMY64xEWr1qA@mail.gmail.com> <CAL_Jsq+dVg9E_EzpoC4Bz1ytUckDGXUcEJyU5pV2HS6rZuKmHA@mail.gmail.com> <CAJMQK-hzjSBf2-QFMn52Sa8fwvm5-gaddzBOudfEc1neR2rwnA@mail.gmail.com> <5f598806-1c36-7c2a-0f47-da79ec7d28c6@arm.com>
Subject: Re: [PATCH v3 2/3] arm64: implement update_fdt_pgprot()
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>, Yu Zhao <yuzhao@google.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        James Morse <james.morse@arm.com>
User-Agent: alot/0.8.1
Date:   Thu, 16 May 2019 10:44:28 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting James Morse (2019-05-16 10:34:16)
> Hi!
>=20
> On 16/05/2019 17:48, Hsin-Yi Wang wrote:
> > On Thu, May 16, 2019 at 11:32 PM Rob Herring <robh+dt@kernel.org> wrote:
> >> Doesn't kexec operate on a copy because it already does modifications.
>=20
> It does!
>=20
> > This patch is to assist "[PATCH v3 3/3] fdt: add support for rng-seed"
> > (https://lkml.org/lkml/2019/5/16/257). I thought that by default
> > second kernel would use original fdt, so I write new seed back to
> > original fdt. Might be wrong.
> >=20
> > ** "[PATCH v3 3/3] fdt: add support for rng-seed" is supposed to
> > handle for adding new seed in kexec case, discussed in v2
> > (https://lkml.org/lkml/2019/5/13/425)
> >=20
> > By default (not considering user defines their own fdt), if second
> > kernel uses copied fdt, when is it copied and can we modify that?
>=20
> Regular kexec's user-space already updates the dtb for the cmdline and ma=
ybe the initrd.
> For KASLR, it generates its own seed with getrandom():
>=20
> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git/tree/ke=
xec/arch/arm64/kexec-arm64.c#n483
>=20
> If user-space can do it, user-space should do it!
>=20

Doesn't it need to be done in two places? Userspace and also in the
kernel when kexec_file_load() is used? At least, I see a bit of code
that does kaslr seed updates to the copied dtb in setup_dtb() of
arch/arm64/kernel/machine_kexec_file.c that probably needs to get an
update for this new property too.

