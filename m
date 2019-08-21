Return-Path: <SRS0=xaRW=WR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F23C3A59E
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E837233FE
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Aug 2019 18:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nmacleod-com.20150623.gappssmtp.com header.i=@nmacleod-com.20150623.gappssmtp.com header.b="Ys5TK5ui"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbfHUSck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Aug 2019 14:32:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:36927 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729741AbfHUSch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Aug 2019 14:32:37 -0400
Received: by mail-io1-f65.google.com with SMTP id q22so6620848iog.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2019 11:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nmacleod-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2UY5r0jo00pKwmDrn23Pxk0XvyypLr116idfhOKEng=;
        b=Ys5TK5uiAMztlr9bjkWWjOfMZfoCBPuV3BMWfX6g7m/GPNSH5gP0jIzNTC+VTvtV6/
         aj1CZwvS2ym87TvicRENYLDtZuNXtK1EoCDSlwuqpL9jIb9LwltwO3bFgXuOM+Dtfw7c
         9SUrs7bTcMtekjrtyELXsFxHb5geD1jCRH5IVXhs8hm3CqzDBOZom9T/CSUlwXiOiekz
         JX9lzXGhSlXIn+sWqTxD9p0WrCII+X53/c7hrMZtDJaB/1arP8A7nzARa3onpQzhtDlD
         m+isag/CIXAkEJYEq7IzBLkPughn2bTEhZuBlybL67pWoGmsUWhfs30g/2jTMjEUY+or
         VoLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A2UY5r0jo00pKwmDrn23Pxk0XvyypLr116idfhOKEng=;
        b=UFm+rJX6e8w2PdVcRidwM9/7yEdvd93nQLmidIF2hd+Le8t4cOh35UNomursAvQI/i
         elFT4zrfsgzn5pZgncETd6OmPDXizxygHdcIMzyq3WHDpjJr8f+iuIF4mt4wf68pLkiB
         xK1Z4AMOG1At/ifQ8GuxPyICRrrS3oSH8fkEimx6E8KfTHwOVU7fjgrUV8A20d7tiRDp
         w3vpGbyKvkf46YtLmOGm95LvtiFBZCTfTHkOZmMYvJn3ho2YmLldPc/lWhF/yJk2o/ec
         qwQEbw0mgXP+j+gRpx7CJbiYQQz1ir2XbWZgh5wqV9+0pfhfQiWSTB7pAAEisDftvuEo
         vNWg==
X-Gm-Message-State: APjAAAWzslv6FuH8Pgq+KGsWoNqwQS9FnaqPDgbUx+Nh/kd0Ct+Q7Ebi
        H/hhJmgxDsRh5CjqBlDvU3IuC2clyK9nHP/wH8q/9g==
X-Google-Smtp-Source: APXvYqxNLmTHXjheH2TAJGyirEN/em6eohBgU9JKYer3WCQckXJO4ofIOpZ/US/UH/H2v5eAcTshfm+9xyP8MR1sG0s=
X-Received: by 2002:a02:a11e:: with SMTP id f30mr11427174jag.0.1566412356068;
 Wed, 21 Aug 2019 11:32:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAFbqK8m=F_90531wTiwKT4J0R+EC-3ZmqHtKCwA_2th_nVYrpg@mail.gmail.com>
 <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
In-Reply-To: <900a48bf-c9fc-09bd-52a3-9e16ff8baa19@nvidia.com>
From:   Neil MacLeod <neil@nmacleod.com>
Date:   Wed, 21 Aug 2019 19:32:17 +0100
Message-ID: <CAFbqK8kWUdoEStTRe+a4mk9dMf4W4vk7aZhT_uTqS6jgAqYJ0A@mail.gmail.com>
Subject: Re: Boot failure due to: x86/boot: Save fields explicitly, zero out
 everything else
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John

I can test any patches given a link to the diff, and am happy to do so.

If I've understood your suggestion correctly, I will try commenting
out all of the entries, then add them back one-by-one until I get a
non-booting situation. I'll let you know how I get on.

The OS I'm testing is LibreELEC, which is a custom x86_64 build, and
this hasn't shown any problems on this Skylake i5 NUC in all the years
I've been using it as a test system (since at least 4.15.y). So far
5.3-rc has been trouble-free until 5.3-rc5. As I mentioned in the bug,
I've been able to boot 5.3-rc5 from a USB memory stick, but can't boot
5.3-rc5 from the internal M2 drive unless I revert this commit.

Regards
Neil

On Wed, 21 Aug 2019 at 19:20, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/21/19 10:05 AM, Neil MacLeod wrote:
> > Hi John
> >
> > The following bug might be of interest:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=204645
> >
> > Let me know if I can be of any help.
> >
>
> Hi Neil,
>
> First of all, I'm pasting in the bug information so that it's directly available
> here:
>
> ===================================================================
> Description: Neil MacLeod 2019-08-21 16:29:19 UTC
> System: Intel i5 Skylake NUC (NUC6i5SYH)
>
> This system boots fine from internal M2 (128GB) drive with 5.3-rc4.
>
> With 5.3-rc5, it does not boot from M2 and is stuck on the Intel splash screen (no other text is displayed, no panic etc.). It will boot 5.3-rc5 from a USB flash memory stick (via the F10 boot menu), but not from the internal M2.
>
> Bisecting between 5.3-rc4 and 5.3-rc5, the bad commit is:
>
> neil@nm-linux:~/projects/pullrequest_repos/torvalds-linux$ git bisect bad
> a90118c445cc7f07781de26a9684d4ec58bfcfd1 is the first bad commit
> commit a90118c445cc7f07781de26a9684d4ec58bfcfd1
> Author: John Hubbard <jhubbard@nvidia.com>
> Date:   Tue Jul 30 22:46:27 2019 -0700
>
>      x86/boot: Save fields explicitly, zero out everything else
>
>      Recent gcc compilers (gcc 9.1) generate warnings about an out of bounds
>      memset, if the memset goes accross several fields of a struct. This
>      generated a couple of warnings on x86_64 builds in sanitize_boot_params().
>
>      Fix this by explicitly saving the fields in struct boot_params
>      that are intended to be preserved, and zeroing all the rest.
>
>      [ tglx: Tagged for stable as it breaks the warning free build there as well ]
>
>      Suggested-by: Thomas Gleixner <tglx@linutronix.de>
>      Suggested-by: H. Peter Anvin <hpa@zytor.com>
>      Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>      Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>      Cc: stable@vger.kernel.org
>      Link: https://lkml.kernel.org/r/20190731054627.5627-2-jhubbard@nvidia.com
>
> :040000 040000 e0963edca990540dd759765a3d765af4698df892 d07e645eb3a500c31bd65526205e286ff6941187 M      arch
>
> Comment 1 Neil MacLeod 2019-08-21 16:31:35 UTC
> The kernel is built with gcc-9.2.0.
>
> Comment 2 Neil MacLeod 2019-08-21 16:55:48 UTC
>
> 5.3-rc5 with "x86/boot: Save fields explicitly, zero out everything else" reverted will build with gcc-9.2.0, and boot from M2.
> ===================================================================
>
> I'm also CC'ing the lists, so they know that the patch has caused a regression, and
> also out of hope that they can help me choose the shortest path forward to debugging
> this. My first reaction is that the list of BOOT_PARAM_PRESERVE() fields is
> flawed--by which I include cases of  "the system improperly relied on a field that the spec said
> should be zeroed". (After all, the boot_params->sentinel is set, which already means
> the system is not really doing it right.)
>
> So I'm going to cheat and ask right now if anyone notices either ommissions
> or wrong entries here:
>
> static void sanitize_boot_params(struct boot_params *boot_params)
> {
> ...
>                 const struct boot_params_to_save to_save[] = {
>                         BOOT_PARAM_PRESERVE(screen_info),
>                         BOOT_PARAM_PRESERVE(apm_bios_info),
>                         BOOT_PARAM_PRESERVE(tboot_addr),
>                         BOOT_PARAM_PRESERVE(ist_info),
>                         BOOT_PARAM_PRESERVE(acpi_rsdp_addr),
>                         BOOT_PARAM_PRESERVE(hd0_info),
>                         BOOT_PARAM_PRESERVE(hd1_info),
>                         BOOT_PARAM_PRESERVE(sys_desc_table),
>                         BOOT_PARAM_PRESERVE(olpc_ofw_header),
>                         BOOT_PARAM_PRESERVE(efi_info),
>                         BOOT_PARAM_PRESERVE(alt_mem_k),
>                         BOOT_PARAM_PRESERVE(scratch),
>                         BOOT_PARAM_PRESERVE(e820_entries),
>                         BOOT_PARAM_PRESERVE(eddbuf_entries),
>                         BOOT_PARAM_PRESERVE(edd_mbr_sig_buf_entries),
>                         BOOT_PARAM_PRESERVE(edd_mbr_sig_buffer),
>                         BOOT_PARAM_PRESERVE(e820_table),
>                         BOOT_PARAM_PRESERVE(eddbuf),
>                 };
>
> If not, then I think we need to bisect by...well, let's start with the
> theory that we zeroed out too much, so we could start adding more fields
> to preserve.  If that doesn't find the problem, then it's more complicated,
> and might be better to go the other direction: starting without my commit,
> and zeroing out fields until we see the failure.
>
> Are you able to test patches? It would take some time, since there are quite a
> few fields. Alternately, if you provide some more system information details
> (especially if we have any other notes about other failures and passes), then
> I might be able to borrow a Skylake system and attempt a repro.
>
>
> thanks,
> --
> John Hubbard
> NVIDIA
