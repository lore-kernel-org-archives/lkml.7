Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE17C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CA5120748
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 18:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574705524;
	bh=v09hIQ8Mwo0Sm0Ii+RFpTQg1FUsLWl49owNkeDplj0E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IY4fq9nnS+9r9/33ZWv1YtVx1KGA2lNlC5JqjTWBgQVfdJilxW2UdudOnzgcUVk9b
	 33GrCfP77iaaa7gduAIG63pzU6X4qJj0eXVlUFTFtcJfy80a8akSO+r+qgKRhhYQGB
	 spgZ5VMAsR3WVcOs1fFfhgPj4sKDcvwjCk439u+w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfKYSMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:12:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727741AbfKYSMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 13:12:03 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F6F420748
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 18:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574705522;
        bh=v09hIQ8Mwo0Sm0Ii+RFpTQg1FUsLWl49owNkeDplj0E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=scxJIQDYIF+vyeQtFSW67Izna47GzzVJiSDFszDpologwEElsVjs0ItF4azamXXh/
         spuMBRZI9eB+dBhgJ9C8fTI8IjvTTbwu0EUIP5DDszF+/pSSGgWns9yxtt8bMLjqhd
         suo6iJzAKE9UD5aq1U78So8uZQOUiRSo4dhGdSus=
Received: by mail-wr1-f43.google.com with SMTP id 4so16040269wro.7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 10:12:02 -0800 (PST)
X-Gm-Message-State: APjAAAWoAuwHhowAr8JDdmd0Y55dqPXB3Lqt7HmqmYgH76RFoGCCpxpW
        1wVSIWLtcvWlyT8/Tliljxz1kd873dBc3KdqnHDd5w==
X-Google-Smtp-Source: APXvYqwueINxoIyTuzNtBSCFyjL4fwklu+qWZ6GHnZSb+cfRMoXOvfwhbvCJNq2/ITDbWMqP1VPi8ioJMSB0us5zT0M=
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr12258266wrs.106.1574705520966;
 Mon, 25 Nov 2019 10:12:00 -0800 (PST)
MIME-Version: 1.0
References: <20191125144946.GA6628@duo.ucw.cz>
In-Reply-To: <20191125144946.GA6628@duo.ucw.cz>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 Nov 2019 10:11:49 -0800
X-Gmail-Original-Message-ID: <CALCETrW85=toRrxe5w6a+AFmpTygR24K7rbDyvbmMLSsMO80XQ@mail.gmail.com>
Message-ID: <CALCETrW85=toRrxe5w6a+AFmpTygR24K7rbDyvbmMLSsMO80XQ@mail.gmail.com>
Subject: Re: next-20191119 on x86-32: fails to boot -- NX protecting kernel
 data, then oops
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 25, 2019 at 6:49 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> Machine is thinkpad x60, that's x86-32. It fails to boot:
>
> EIP: ptdump_pte_entry+0x9
>
> call trace
> ? ptdump_pmd_entry
> walk_pgd_range
> ...
> mark_rodata_ro
> ? rest_init
> kernel_init
>

Can you send a .config?
