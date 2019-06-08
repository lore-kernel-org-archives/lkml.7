Return-Path: <SRS0=LGpO=UH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C2BC28CC5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B253208E3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Jun 2019 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560034338;
	bh=Pb4a399ucftTpDo6qRynJAFaW8nxXbV16dTjIDsmmFM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pl3btISr5uhpvr/d8/YQGyJduqDMINZPjzqfjsgQe9nEv5ijOvUABpNco3tEakVZ4
	 H1T8HWtGRYWvA+oIXkAFS+kzExq/w+YWCNiKe+oADeveN4hA+EBYQSt+/4tLEQvqLw
	 f/8pTCWErtlUXNNU+W5LpoMcPEMIWWvDxwvP1nGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfFHWwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Jun 2019 18:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:33154 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727486AbfFHWwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jun 2019 18:52:17 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 189352168B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2019 22:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560034336;
        bh=Pb4a399ucftTpDo6qRynJAFaW8nxXbV16dTjIDsmmFM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pdgoeXaLjiEfOp2G++DJMZFPdLAZyPL8dmqY+dDlziJHcN8t9F+Gjg64QOqUpmwfy
         z3tFad1TjwkL32RkiazMsQhoeKnjq7GS0E3oBmlE7KqbfeUjr7+/M06hTWh7LDiPt5
         OHk0LwrdvIvhZ7PQbAinxIC9Q8wE1MX4kyQbPIGQ=
Received: by mail-wm1-f47.google.com with SMTP id h19so6491083wme.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jun 2019 15:52:16 -0700 (PDT)
X-Gm-Message-State: APjAAAW7metLclkoepgNou24SMcv1IDWYryMJylvJMruoHxe7jKZR9yN
        xorIf4cyjY0O6uNnJSkJk3Hex/qhOFu4L2x8K/5Ipg==
X-Google-Smtp-Source: APXvYqwBLHa5WaBkibsvSjXohyHyo4HTGYYdPkBujphL3J9T7+raX+H+/d1CP2rwL2hADFXUjNHUAFpxUyCscYezmoE=
X-Received: by 2002:a1c:a942:: with SMTP id s63mr8242341wme.76.1560034334733;
 Sat, 08 Jun 2019 15:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <1559944837-149589-1-git-send-email-fenghua.yu@intel.com> <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1559944837-149589-4-git-send-email-fenghua.yu@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 8 Jun 2019 15:52:03 -0700
X-Gmail-Original-Message-ID: <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
Message-ID: <CALCETrWi+uM5Rch6vaXOwHsHas928CDY5VJoBYaudD+3VFTrNw@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] x86/umwait: Add sysfs interface to control umwait
 C0.2 state
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 3:10 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> C0.2 state in umwait and tpause instructions can be enabled or disabled
> on a processor through IA32_UMWAIT_CONTROL MSR register.
>

> +static u32 get_umwait_control_c02(void)
> +{
> +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_C02;
> +}
> +
> +static u32 get_umwait_control_max_time(void)
> +{
> +       return umwait_control_cached & MSR_IA32_UMWAIT_CONTROL_MAX_TIME;
> +}
> +

I'm not convinced that these helpers make the code any more readable.
