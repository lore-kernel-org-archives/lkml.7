Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9326DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6AB20854
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 22:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552601297;
	bh=dAwEj6hkwJVav2HocTLKe+eCNkrMI6uCPIGIBc6CxtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=chcbIEmHy7ZQKYvLrCNCumdORUMgDRvttntwJVenF+vj7gKAvZFeNJvJUK305zmID
	 I8IJwEsZXxTo7gf/Oy1ACyCeGnQMNVHDkV1IP7sSSFBTyJEK61V0YBYYd1jytugF6L
	 EYfDQT8NKyfU6ZTP1vqWz6m5oxnoUb7A1VJD7QR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727573AbfCNWIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 18:08:16 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39382 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbfCNWIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 18:08:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id e15so6612529otk.6;
        Thu, 14 Mar 2019 15:08:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXCPmTlnAZhHllNvpnoywKNTmWdgGF6QJBXrvsJXaE8=;
        b=h1ikMsNYTsDEoicI+4CKjJplgfrTZUm+y7ZneuLBrjFMf3KlecIgL18/72vYBWD9n5
         Qib5mPNI1xYbkx4DPLbvgJkWScl2eQ9tNiLZxBqI/UqWZofJYnUXYfE2gAk5in2OEVLN
         Vpzy6s7TNa3gfVSYa7AXnGuMKV2djwpL2wFdwHKNHygWQU/NKEFSkoZjUZ4raILPDrsV
         +Ix8+1y1XaKNUMC5wyfCmmPd+Puu607tmnwD/+F9Cyg2m3uLzqoHF6avYLyBg810uB3G
         ityCgJuKXuTIC8hHxUKG7sb5b+BBOugMc/9QANHudx3BFQPexF9EzuT20LmCy+GPkhz4
         BFTQ==
X-Gm-Message-State: APjAAAVD+75rl/0Z4pTdl1WBPCOmDEwaaGXdAJnigjepNRCEJfUZ6cA+
        m5qZOg9diI0zoeY6FowO1afrFx450cp77uDI/NI=
X-Google-Smtp-Source: APXvYqzu/zUvObsbRaHCJL+Q+PS45dNc10MPZf7UO4nob5//59dzQa2seZjuSmT+LLFBKYIm3A5ClqlxeEjnAtjQhqI=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr193749otf.124.1552601294428;
 Thu, 14 Mar 2019 15:08:14 -0700 (PDT)
MIME-Version: 1.0
References: <6369897.qxlu8PgE1t@house>
In-Reply-To: <6369897.qxlu8PgE1t@house>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 14 Mar 2019 23:08:03 +0100
Message-ID: <CAJZ5v0h3zLrqqMXzt_cqGV1rBR0muosZwy1Zu3fV9O1kqGc6gw@mail.gmail.com>
Subject: Re: [PATCH] [RESEND] Do not modify perf bias performance setting by
 default at boot
To:     Thomas Renninger <trenn@suse.de>
Cc:     Len Brown <lenb@kernel.org>, Rafael Wysocki <rafael@kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@suse.de>,
        Simon Schricker <sschricker@suse.de>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2019 at 3:42 PM Thomas Renninger <trenn@suse.de> wrote:
>
> This is a revert of mainline git commits:
> commit b51ef52df71cb28e9d90cd1d48b79bf19f0bab06
> commit 17edf2d79f1ea6dfdb4c444801d928953b9f98d6
> commit abe48b108247e9b90b4c6739662a2e5c765ed114

I'm not quite convinced that reverting these is the right thing to do here.

> It is about this kernel message showing up on quite a lot servers:
> [    0.072652] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
> [    0.076003] ENERGY_PERF_BIAS: View and update with x86_energy_perf_policy(8)

What happens on boot is a matter of convention and the convention by
which the EPB is set to "neutral" at that point has been used for
quite a while.  Changing it now may confuse some users or even worse.

It would be fine to change the log level of these messages in my view, though.

> The background afaik were some BIOS which "forgot to set a default value".
> Certainly some (one?) broken laptop BIOS was meant, because
> the value zero (performance) is quite a reasonable default value on server systems
> and this is how a lot CPUs typically come up there.

That depends on the expected power/perf profile of the system and the
kernel has no information regarding that.  Arguably, user space can
set the EPB to whatever it wants at the init time according to the
information it has.  It is not quite realistic to expect that either
the BIOS or the kernel will do the right thing on all systems in that
respect anyway.

> Another sever bug with above patches:
> If you really set performance BIAS MSR value to 'performance'
> as mentioned in kernel boot log, it is reset on next CPU offline/online cycle
> (see below).

That is a bug.  There is no reason to change the EPB on CPU
offline/online and I agree that this needs to be fixed.  The reverts
would make this problem go away, but that's not the only possible way
to fix it.

Moreover, what is done during system-wide resume appears to be a bug
too.  Whatever EPB value is there during suspend should be saved and
it should be restored during resume. Reverting the commits above will
not fix that particular issue.

Thanks,
Rafael
