Return-Path: <SRS0=Dm7n=X7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A4AC4360C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A22D2084B
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Oct 2019 09:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MvSavGHr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfJFJd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Oct 2019 05:33:59 -0400
Received: from mail-vs1-f41.google.com ([209.85.217.41]:45745 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbfJFJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Oct 2019 05:33:59 -0400
Received: by mail-vs1-f41.google.com with SMTP id d204so6942753vsc.12
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2019 02:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=WR9seTF6b/AIYyFA9kvA5VJHKX1PsFFiJpEiUOjg95M=;
        b=MvSavGHro7C5Z2eRKoTaRQKoXTMbfDcOHE3o8QtYYxcjVtcOCPUo3DqyAShmb2RhIT
         VUuEEPNdlnFbHgMr9BOfcnlXRuPLexQV4GaFJE5HFgk87ibYcpVavdloVkwIr/TvUO2E
         MnU/LjBipXKNpVPQ7TVIy8YQ2UX9K0k0db5CTU7IX9IgABoZV8yXeZWISzjkeavjLHpd
         GdHp2y0BCGBmUMq3YZRUILa0uhctZxQAwCkrVxhYJdmtyGx+gDfrJI5IvtufzGYL5m/x
         g/XmTvEXEl6ZD1d73PEZaihQKHtu4grLEaBALlFSJ2FmrtvUkHLVL74A0tn6hZEfqVcf
         mgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=WR9seTF6b/AIYyFA9kvA5VJHKX1PsFFiJpEiUOjg95M=;
        b=mLT2VBPM+IUIL8lu7jLQ1VnySx+00MFImKoDZMgQNG8phW+nrYqKku36IjekOR8Q0A
         14qHJm/5ZZhX6Ly9Ok3x1L0zSv2f88Nl28L5s8P/xS0DdCGLizKZYHJX1lLR1q++eyhw
         WWfCHs0wrXzA5SeBGsQbW2Qk67U0N6cVHqCBmkOrst1THFazeEdTbqzU+6WJRuXO7bmd
         LrVYP8A3KyLaFUb1xrcHrRbR3oYXFX2uOSQeMlyEHc6HF1ZPXTdW4IPzvy18bYhLXZmg
         h6wx0WhYcQ7RI7IR9GqZ83bAGgtHd+tLmwMUQYPAC6zPHDJVVLLfMTjT+bwpz3AuD+8t
         6emg==
X-Gm-Message-State: APjAAAXXpZfGz7Z5Q55mmDQOxqLiEtiEERmIVbm3SwRPavOt8EtZzZfI
        C6cmJNccrnEFyrVwCKMCTWHK+cxCCgF0FwEEf4q5Kk1b
X-Google-Smtp-Source: APXvYqzEU7iccGRPCunyygioydjGIFrWOxrtuMdVGIIzlpGm1sWK3OYNSit8DGr/3TW89ed2dGb3Kag4XbIdCMpZ7WA=
X-Received: by 2002:a67:dc13:: with SMTP id x19mr12309088vsj.172.1570354437780;
 Sun, 06 Oct 2019 02:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAFCwf11-MzroWUmj4qOgwLTibqsdOmPP9cHJjXZmS0Pgr3bEOQ@mail.gmail.com>
In-Reply-To: <CAFCwf11-MzroWUmj4qOgwLTibqsdOmPP9cHJjXZmS0Pgr3bEOQ@mail.gmail.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 6 Oct 2019 12:33:31 +0300
Message-ID: <CAFCwf13AtwkWQ4Gnxi6pfKbcdEK95+X__7cFboN1FdHd1aKNQw@mail.gmail.com>
Subject: Question about using #ifdef CONFIG_PPC64 in driver code
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
a while ago we had an argument about identifying in my driver's code
whether I'm running on x86 or powerpc. I tried to do something
dynamically (based on parent pci bridge ID), and you and other people
objected to it.

I see in other drivers (more then a few) that they are using #ifdef
CONFIG_PPC64 in some places for similar things (e.g. to run code that
is only needed in case of powerpc).

e.g. from ocxl driver in misc:

#ifdef CONFIG_PPC64
static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
...
#endif
and also:

#ifdef CONFIG_PPC64
if (cpu_has_feature(CPU_FTR_P9_TIDR))
arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
#endif

Is this approach acceptable on you ?
Can I do something similar in my driver:

#ifdef CONFIG_PPC64
      foo (64)
#else
      foo (48)
#endif

Thanks,
Oded
