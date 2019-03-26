Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C271C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BAD2075C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 19:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553628042;
	bh=bNnFYh38SuqDllljiUAm8cHWf4KPM2Rm7i/Xh3MQULw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=t+jXVaElvLAFHeRgaZwfhKhI0DTzUsWOu1CTHY7TvOm7iAd5dsFbW4/ZMGCmmwj10
	 PF5aiRCvDH/V0dPHAD0L1t5c3rIKNx4ZkarmPhdEoAEP8IhK0YbjLIJsd15Z2udg7e
	 pCSWnNil9f2fBcMLXX7mHDyzm/59cLoJqswe/Bj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732272AbfCZTUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbfCZTUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 15:20:40 -0400
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B8192075C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 19:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553628039;
        bh=bNnFYh38SuqDllljiUAm8cHWf4KPM2Rm7i/Xh3MQULw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SPh9sndLf5L+z8w24xCt620iuwf7m61WMxWzzLyEsuMJFCUexCPDW08eNL2OshchO
         Q+9/8cn/bXjzjfd7CFfsJ8hIF78HADW5ZwWhOeXlRhOyJk/92xWFNC6g947yRhCtjG
         DDuIFt020Kl1zuH/odz2npaBpqy29UP4MXphypEs=
Received: by mail-wr1-f42.google.com with SMTP id w10so15757866wrm.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 12:20:39 -0700 (PDT)
X-Gm-Message-State: APjAAAWhKSzfGmmatsiK5dBqVd8+6/4o/X21l/FSNXdGz08CpCvdPXxL
        RoTlfrzoxqj/NG94ahCOtU7+Jd8w+Nge0MnFht/BYA==
X-Google-Smtp-Source: APXvYqyU5qYOlluf0hTkfca40/GsYO8E1IVNImF4uhchjdYwXlFgPoyvT4WESRnbAIKI7+Sd1/JQaoujOiEosFG2ioo=
X-Received: by 2002:a5d:4710:: with SMTP id y16mr19830662wrq.176.1553628038018;
 Tue, 26 Mar 2019 12:20:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190326182742.16950-1-matthewgarrett@google.com> <20190326182742.16950-26-matthewgarrett@google.com>
In-Reply-To: <20190326182742.16950-26-matthewgarrett@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 26 Mar 2019 12:20:24 -0700
X-Gmail-Original-Message-ID: <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
Message-ID: <CALCETrXDF2c2-gnOyNTnEn-uPAZp0AaSB_PB8e2y8jf7zo=Cyg@mail.gmail.com>
Subject: Re: [PATCH V31 25/25] debugfs: Disable open() when kernel is locked down
To:     Matthew Garrett <matthewgarrett@google.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        Andrew Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 11:28 AM Matthew Garrett
<matthewgarrett@google.com> wrote:
>
> From: Matthew Garrett <mjg59@google.com>
>
> debugfs has not been meaningfully audited in terms of ensuring that
> userland cannot trample over the kernel. At Greg's request, disable
> access to it entirely when the kernel is locked down. This is done at
> open() time rather than init time as the kernel lockdown status may be
> made stricter at runtime.

Ugh.  Some of those files are very useful.  Could this perhaps still
allow O_RDONLY if we're in INTEGRITY mode?
