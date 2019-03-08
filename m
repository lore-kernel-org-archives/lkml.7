Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE85C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745A720851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 10:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="M4W12fMZ";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="AY7gv84x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfCHK6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 05:58:09 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:40956 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfCHK6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 05:58:09 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EBF6C60452; Fri,  8 Mar 2019 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552042688;
        bh=ESJvtdf/RvFwEABiTSCwhCKX7uWVBIGqnsRaYBJCA0k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=M4W12fMZUCPJzOUkRKb3nd0WMPplF3TbvpmRVUHbYjMGUHNXGb9eQsJcmIMX883DK
         nG8OKVcLdo91dFVx3jJCUNT3buFmE0s9sRwYPVDbP8RUf/s7jJWj7amWPsbSDfHktc
         t3nucAWFkLw48H44dPOrgx6W+kR2SHIXJzGbG7rA=
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F064260312;
        Fri,  8 Mar 2019 10:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552042686;
        bh=ESJvtdf/RvFwEABiTSCwhCKX7uWVBIGqnsRaYBJCA0k=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=AY7gv84xIvnMXYzJ73ntxtc97fl3ieMej0wwjs/u5pOkee0EcMrC5HiiOrUk7ufWl
         EY+qLB4L9GEUHEGKTDYG6U0i1sOsGXOfKNml/Zk1KLjnBZOYioOKJpF+3wiYTTQGKI
         7QBCGf8SfzWf0Idcn2peMjXwUDkMzB+2yhVIvX3w=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F064260312
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Gabriel C <nix.or.die@gmail.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>, ath10k@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
        <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
        <874l8ic0l4.fsf@codeaurora.org>
        <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
Date:   Fri, 08 Mar 2019 12:58:02 +0200
In-Reply-To: <CAEJqkgjYRu1Az6ec1ksQfLZ71fa062Us7XkOzw8BZ2bEoUe8BQ@mail.gmail.com>
        (Gabriel C.'s message of "Mon, 4 Mar 2019 14:00:40 +0100")
Message-ID: <87wol97hvp.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel C <nix.or.die@gmail.com> writes:

> Am Mo., 4. M=C3=A4rz 2019 um 12:59 Uhr schrieb Kalle Valo <kvalo@codeauro=
ra.org>:
>>
>> Gabriel C <nix.or.die@gmail.com> writes:
>>
>> > Am Mo., 4. M=C3=A4rz 2019 um 12:28 Uhr schrieb Paul Menzel <pmenzel@mo=
lgen.mpg.de>:
>> >
>> >> Resuming from ACPI S3 on the Dell XPS 13 9370 with Debian Sid/unstabl=
e,
>> >> Linux 4.19.20 showed the warning below. It=E2=80=99s not reproducible.
>>
>> [...]
>>
>> >> [ 3018.992916] Call Trace:
>> >> [ 3018.992921]  ? ath10k_conf_tx+0x7a/0x4b0 [ath10k_core]
>> >> [ 3018.992937]  ieee80211_bss_info_change_notify+0xab/0x1a0 [mac80211]
>> >> [ 3018.992946]  ieee80211_reconfig+0x661/0x12a0 [mac80211]
>> >> [ 3018.992962]  wiphy_resume+0x7f/0x120 [cfg80211]
>> >> [ 3018.992969]  ? wiphy_suspend+0x270/0x270 [cfg80211]
>> >> [ 3018.992971]  dpm_run_callback+0x59/0x150
>> >> [ 3018.992972]  device_resume+0x97/0x190
>> >> [ 3018.992973]  async_resume+0x19/0x30
>> >> [ 3018.992974]  async_run_entry_fn+0x39/0x160
>> >> [ 3018.992976]  process_one_work+0x1a7/0x3a0
>> >> [ 3018.992978]  worker_thread+0x30/0x390
>> >> [ 3018.992979]  ? pwq_unbound_release_workfn+0xd0/0xd0
>> >> [ 3018.992980]  kthread+0x112/0x130
>> >> [ 3018.992981]  ? kthread_bind+0x30/0x30
>> >> [ 3018.992983]  ret_from_fork+0x35/0x40
>> >> [ 3018.992984] ---[ end trace 3af618ca97bd4a0a ]---
>> >> ```
>> >>
>> >> Please find all Linux messages attached.
>> >
>> > I reported that twice and no one seems to care about.
>> >
>> > http://lists.infradead.org/pipermail/ath10k/2018-November/012398.html
>> > http://lists.infradead.org/pipermail/ath10k/2018-December/012658.html
>>
>> Does this patch help:
>>
>> ath10k: Drop WARN_ON()s that always trigger during system resume
>>
>> https://patchwork.kernel.org/patch/10837139/
>>
>
> Without to test this patch I can confirm it will help , I dropped the
> WARN_ON()'s in 4.19 already.
> If I remember right 4.19 has one WARN_ON() triggers while 4.20 got two.

Ok, thanks. I'll try to get this patch to 5.1.

--=20
Kalle Valo
