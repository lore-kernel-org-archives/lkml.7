Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6327BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308022175B
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 23:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vf5dcy5Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbfCSXEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 19:04:05 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:32826 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfCSXEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 19:04:05 -0400
Received: by mail-it1-f194.google.com with SMTP id f186so20589309ita.0;
        Tue, 19 Mar 2019 16:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRG31FVxu+ytEbBMyE08gIvbBLVXhFZwEjv+hRH6sr4=;
        b=Vf5dcy5ZCws+kdILZUbA9xqQLm/IphqoT1I2yLPLUrsH9ULIDwumpygxkKA+fT/Iq8
         X8EHVMtGgjbqC8EkG1NV9hYJMoBKQ88gjyzXNYlbQkk6lTon45miFpPD4T7IP4k/zdH8
         T+dprOf87uvX0PjzYuzEDyWW2lSg62BYS+vKev3YzIt1u+cT23mVbT2MVnRyXqfbS735
         mch71AYXhZqv6mhzrtkJxt0sf8QbeqdCxhsqbgUw4lt5Lm7qaBmXP4Icz/mxv38K6WXg
         EPDzP0ICCsCHRwJ4lgbNsa6E3XhnnyTAa9dT3OIotv1J0MGbCqHz6lOxXnO/vpbMgILZ
         DVHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRG31FVxu+ytEbBMyE08gIvbBLVXhFZwEjv+hRH6sr4=;
        b=ouQvuD3roa/YYGRpqZGzPIVLivl5BWOnwdeQsj7QbzrcLZbXgc/DMOtUxaMJL3BA52
         gS5oi4I03CO1rDFZperYjTbQTr5K8XJTOo6C67L0zUlRZ2j/MdOyfmlbEYNqPQcpRe70
         hxcKX/UUECEQre2WOsXLA/dgO9q/mdcn46XUe/e2E4UyiWAFDxba0fk1iZhrEzQGO3VL
         7kdc1MK9JsXbCFISkNjyRuxOGNW3vr/gnhCaZk5Qf/9sRsujFr398I8NN5pdhss/0Geq
         TiP9V7P3UUI9n2QA603HVpCKjUps/jMM/haG2g+tVoGdtgf0U3Q2PrumKXdjwg+N/HOg
         78xQ==
X-Gm-Message-State: APjAAAX8WUYBYdGMdamfKa1+ONyYQLHo2ukbbONiFEp39jl/4ffqWjEQ
        +ADDI2bEj8tLRmnK/y6Ks/9hykyvh3YtJpyes4I=
X-Google-Smtp-Source: APXvYqxlkVSuFABOhBo6l6ShNzF03WMXTYdeCJhLPre7qulx/h98iqzAXaKzEFhPCLs4QphqI/6s2bAsW3My7MRMQAc=
X-Received: by 2002:a05:660c:12d4:: with SMTP id k20mr1066597itd.30.1553036643742;
 Tue, 19 Mar 2019 16:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <CADBGO7_WUoA53gM8EDFy6Q36SDEZPU9V=OUBA0QM20FOko51Rg@mail.gmail.com>
 <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
In-Reply-To: <CADBGO7-UkQMxSPdSX9bGVPxSRROj75FA16FuXeFrVmcKVQ_Qdg@mail.gmail.com>
From:   Paul Zimmerman <pauldzim@gmail.com>
Date:   Tue, 19 Mar 2019 16:03:37 -0700
Message-ID: <CADBGO7_XnbXiWHB=O1B_+b+CUA9g-bYJHN37VJ2SsxXMNHcPOQ@mail.gmail.com>
Subject: Re: Regression in suspend-to-ram (TPM related) with 5.1-rc1 (BISECTED)
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So I bisected this down to:

# first bad commit: [a3fbfae82b4cb3ff9928e29f34c64d0507cad874] tpm:
take TPM chip power gating out of tpm_transmit()

but this doesn't revert cleanly on Linus' HEAD. Anyone have an idea what
could be wrong here?

Thanks,
-- Paul

On Mon, Mar 18, 2019 at 6:08 PM Paul Zimmerman <pauldzim@gmail.com> wrote:
>
> Hmm, looks like my original email didn't make it to the linux-integrity
> list, maybe the two attachments were too big. You can read it on the
> linux-kernel list here:
> https://marc.info/?l=linux-kernel&m=155294522323580
>
> On Mon, Mar 18, 2019 at 2:39 PM Paul Zimmerman <pauldzim@gmail.com> wrote:
> >
> > Hello,
> >
> > I'm seeing suspend-to-ram fail consistently in 5.1-rc1. Dmesg shows a
> > failure in the TPM subsystem. This is on an HP Elitebook 640 G1 running
> > Linux Mint.
> >
> > [   43.110604] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
> > [   53.179672] PM: suspend entry (deep)
> > [   53.179674] PM: Syncing filesystems ... done.
> > [   53.190349] Freezing user space processes ... (elapsed 0.001 seconds) done.
> > [   53.192107] OOM killer disabled.
> > [   53.192107] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
> > [   53.193147] printk: Suspending console(s) (use no_console_suspend to debug)
> > [   53.209184] sd 2:0:0:0: [sdb] Synchronizing SCSI cache
> > [   53.213137] sd 0:0:0:0: [sda] Synchronizing SCSI cache
> > [   53.214632] sd 0:0:0:0: [sda] Stopping disk
> > [   53.241598] tpm tpm0: tpm_try_transmit: send(): error -5
> > [   53.241600] tpm tpm0: Error (-5) sending savestate before suspend
> > [   53.241606] PM: __pnp_bus_suspend(): tpm_pm_suspend+0x0/0x90 returns -5
> > [   53.241609] PM: dpm_run_callback(): pnp_bus_suspend+0x0/0x20 returns -5
> > [   53.241610] PM: Device 00:06 failed to suspend: error -5
> >
> > Full dmesg and config attached. Anything I can do to help debug this?
> > It takes about 45 minutes to do a full kernel rebuild on this machine,
> > so doing a full bisection would be a little painful.
> >
> > -- Paul
