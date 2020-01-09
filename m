Return-Path: <SRS0=a4+J=26=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90EDC33CA2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3D320842
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jan 2020 19:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dV4vHbO3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgAITc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 14:32:58 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43701 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbgAITc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 14:32:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id p8so8393885oth.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=15Z89BEz3MyoZ6v5HIMpK8EJU4eXUmvvtENLzMT47po=;
        b=dV4vHbO3yJC1YETzxVL8c6ZqJvPK9/XcK4jmRax+j7rcA7nRe6Tg5p7OfTgAMVhZxj
         e5Z5Wz8HFFnS/PXc5hVscrwiMThqKeZZ1RlE97vx/ne+T3jFL6xiKrKa7+wn04fW3D8P
         4HxzwPNHX2cV8MwihYbe3NTfU6UU+isJM2TQyQx0nsSf8MLY4U00rc5+n0z0LxSifQ49
         lpG9eFHrMCgEfgnF+hQ9i4kDziMqVe8WLeI9l/ve93HrMOh1zJ737sTQeqUZ/ZA0uVYI
         iD/QwSOGX7LLSmYE2fJ9xkCp4ULxjKOvURfi9psbijceK5Bpevv4hGaK622MC6wVDylv
         X3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=15Z89BEz3MyoZ6v5HIMpK8EJU4eXUmvvtENLzMT47po=;
        b=hEJWIumiYiHDQVwkaA71YKWXh/1WIfDn5maMWOEUJozzfNhKoeiD14NaDLpUwgC5MA
         6DlxAx/XqfsKw1Jcb5qkXDed/e6Z7f6JLYlnnBjfQWyI9HzVKxZNIic2he+EyAn3Ueo9
         MmTlCDnRAtlMsdLYJ6X7IgqyQi4/wi5mu4tlJud41i7ar0vXRUxiX2sMjQm0wfudj3i5
         HMux50u/39wCSh5v0zFPzPCweksWkqGhQxYKTB7RyMDPaGexWqrf1lMh2X6gHXaIC6jv
         eCfXnHPFvDQCbu/bia7ghtI/RKkoUaJ9cO0kjZqq0L187soqkWZztR2WBcw6B9yz5576
         k3WQ==
X-Gm-Message-State: APjAAAVAnFfIw8gp7gp/bXBjyPRDKC4E2DfgycSj1v1iIZwRISSGoYDq
        00MkBXvFHIRaW/v4HFtPa5otwiUN9w3Jv4oIH540oA==
X-Google-Smtp-Source: APXvYqwP3eFYrodvtdZcfAfAqu8xqamJQA9sIs1h0qRh427F+yfPvleK68+NS8Lx2t66bO7knqd07EAla5mtgaQWbio=
X-Received: by 2002:a9d:4e99:: with SMTP id v25mr10115311otk.363.1578598377813;
 Thu, 09 Jan 2020 11:32:57 -0800 (PST)
MIME-Version: 1.0
References: <157835762222.1456824.290100196815539830.stgit@dwillia2-desk3.amr.corp.intel.com>
 <157835764298.1456824.224151767362114611.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200107040415.GA19309@dhcp-128-65.nay.redhat.com> <CAPcyv4g_W4PoH6Wfj_SDGzGLpNLwxtoeGP7uwpzVMS4JWbXSTg@mail.gmail.com>
 <20200107051919.GC19080@dhcp-128-65.nay.redhat.com> <CAKv+Gu-djB=3zTxjEbyjJXXpw=8NE6YA82hMW-JYyAQ2TSywtQ@mail.gmail.com>
 <CAPcyv4ixPchDOet=ztRQxLMgnJf9DauSFgBs3+TEoaua7R1s_Q@mail.gmail.com> <CAKv+Gu8W_EyMNAtDG6zK+dKRcaUEzeJ3fmPAiASdqatD3ewQJQ@mail.gmail.com>
In-Reply-To: <CAKv+Gu8W_EyMNAtDG6zK+dKRcaUEzeJ3fmPAiASdqatD3ewQJQ@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 9 Jan 2020 11:32:46 -0800
Message-ID: <CAPcyv4gjLaDgV0rVttrWHivkzPJ+-OesT3srNomENmT8_FhmFQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] efi: Fix handling of multiple efi_fake_mem= entries
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Dave Young <dyoung@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Taku Izumi <izumi.taku@jp.fujitsu.com>,
        Michael Weiser <michael@weiser.dinsnail.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 1:36 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
[..]
> If it's just for the comment, I can just slap that on, as I already
> queued the patches with the fixes tags dropped.

That would be great. Thanks Ard!
