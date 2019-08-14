Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BA3C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 395842084D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 17:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUY4bV8z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbfHNRPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 13:15:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41223 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbfHNRPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 13:15:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id o101so31215705ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 10:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=01Ayf9LgEcMv7V+WI2AsTnek5WUaEhOAgw1TLPT5Lg8=;
        b=cUY4bV8z98fFrOSFWWEdErQVDghtf844gc08EquK79TWPwgrs8cts9QORhUbmj84w6
         f6m4/lvh33jikA+ZGM+tRxQ7toWhgXNf/hwvBLPgnKwiBbxG/hNFcYj9+6y8trNIYobL
         ilhTnpmaW/fEejmEK013Y8FFlYqMK/zF/v1CwFP79IdFl+ufYbogIYsXzDf8W3I4UxKF
         r8v0YXlyRRhd1ggXnCn4S6QZLyTNrwzaOdCaJg1+ES5vnUy0kZjxLEi49f9BB2aexwxP
         eHVzRfwa+CreiMnCsgeyIj4Uq36gE0EIt5XlCqU8y22UxzWojnwOuHQRKsdXe9SxFPNa
         DIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=01Ayf9LgEcMv7V+WI2AsTnek5WUaEhOAgw1TLPT5Lg8=;
        b=r1OkDezx5Mlmz/w03JhAFnv0bS1bEaaP4p25aEDtb52uEAdsK6OVLHTDvVzoO6iM+J
         u6946ByeKLe5Si4YTuNrstKqmnGhSeCnhyaScDUP540ZlJNDJRJLU7QfyR4XuzGsQe5U
         imlOR4aFo+lCgFhj+tChjm7tpbWPOyZJv/6yppk+Dr/UoDVH4AlM/HuK+hH33W0dY5qa
         3E4gmWRX1Xp+DXV4vlmrYnfLAmDjqqwjEV42S8yzzlQvzvu9l3Mw3RG0rkp9MyCpbxgX
         I7d2CiCIGAQUoE/RaqAuDWQ1rBrxeJOR/4C4EvBgtcHUwj6IVXLHEdupYjwfRZ4okDzc
         G0Rw==
X-Gm-Message-State: APjAAAWSRHR5hOyo5VgaSruUnA9w4qSp5ZoxlAPKO74+nBABomN99yGS
        VYv6Fg8bMfjTNi9h14MN6rvZjNbbkDlyKgeVdP1IFA==
X-Google-Smtp-Source: APXvYqx0J+BLly1ZtoTkIyMRX0f+EWksHL1efdejnhvFvA6o4jTrFb7cWvdHrOwDDKU8F7aJNPtUW/N21twPL0yxhHI=
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr1046835iod.204.1565802905873;
 Wed, 14 Aug 2019 10:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190808000721.124691-1-matthewgarrett@google.com>
 <20190808000721.124691-16-matthewgarrett@google.com> <20190814072602.GA27836@zn.tnic>
In-Reply-To: <20190814072602.GA27836@zn.tnic>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 14 Aug 2019 10:14:54 -0700
Message-ID: <CACdnJuuOhuw71GDwQOrPQxUexpvpZNJocr6m0dYzJw+MMaVKWQ@mail.gmail.com>
Subject: Re: [PATCH V38 15/29] acpi: Ignore acpi_rsdp kernel param when the
 kernel has been locked down
To:     Borislav Petkov <bp@alien8.de>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Josh Boyer <jwboyer@redhat.com>,
        David Howells <dhowells@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Dave Young <dyoung@redhat.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 12:25 AM Borislav Petkov <bp@alien8.de> wrote:
> #if defined(CONFIG_RANDOMIZE_BASE) && defined(CONFIG_MEMORY_HOTREMOVE)
>
> false and thus not available to early code anymore.

We explicitly don't want to pay attention to the acpi_rsdp kernel
parameter in early boot except for the case of finding the SRAT table,
and we only need that if CONFIG_RANDOMIZE_BASE and
CONFIG_MEMORY_HOTREMOVE are set. However, we *do* want to tell the
actual kernel where the RSDP is if we found it via some other means,
so we can't just clear the boot parameters value. The kernel proper
will parse the command line again and will then (if lockdown isn't
enabled) override the actual value we passed up in boot params. So I
think this is ok?

(Sorry for not Cc:ing x86, clear oversight on my part)
