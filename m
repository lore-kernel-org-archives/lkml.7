Return-Path: <SRS0=Ybdz=SI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A6C10F06
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B2F213A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Apr 2019 14:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554560522;
	bh=ktd99R5pataYu6exOZ+qCbYPOulQNmaPD0WBCEV/r7g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uGh9FfQb7lZApN+OlTQZTV/Ox/yyxvVLwJQLxKZCYsKs1bMCPs+8OZcxeBOIFDIbZ
	 njsIa/vOZC4q1ZIfajGC2U0v2gH2uWh7tlnfKjicmj/EAxJB0cWl6SVobubXz+yJ9X
	 RVITjlcfEpgcCNlx1Arf2y0w9o622ux0AdjB0pHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfDFOWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Apr 2019 10:22:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbfDFOWA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Apr 2019 10:22:00 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE32213A2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2019 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554560520;
        bh=ktd99R5pataYu6exOZ+qCbYPOulQNmaPD0WBCEV/r7g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eEheBa6ePhHIg4NCq4DQtez7S00GzXFGl8EHNnhudTfyRopnViF6NM+RZtAJ2pplK
         7vNEDscOsQH+u33NxbEORzwyT6+UVG8ZsxNnmDTta4hdp+j55kaACoCwqfykGQM4kB
         +0vVhNJaB1jUZImMa/UZMTa1/LZEIIAJpmhk2KDE=
Received: by mail-wr1-f53.google.com with SMTP id y7so11164938wrn.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2019 07:21:59 -0700 (PDT)
X-Gm-Message-State: APjAAAVByz0HUoZV3I2m8H6D1SDlAG8pB0ncBjo2dZRd6XzCdAh9Yx6Y
        TI2UdHRFekTXi9L3VxX6Z1yceqVBkwp6UwZOpjmz7A==
X-Google-Smtp-Source: APXvYqzETShKK3k3DD383jUsn9WVu+RUwdNip0qol9S68Y7M2WEn/kX4uGMxlqLtatjHZC9vt65/O0MMal8KPOsRsfY=
X-Received: by 2002:adf:eb84:: with SMTP id t4mr5798505wrn.43.1554560518551;
 Sat, 06 Apr 2019 07:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190405161929.4756-1-tycho@tycho.ws>
In-Reply-To: <20190405161929.4756-1-tycho@tycho.ws>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Apr 2019 07:21:45 -0700
X-Gmail-Original-Message-ID: <CALCETrXj_LZ3n1tJZAKRwNP4VrVibUqEhcMQpHuYMq8bb-OkZQ@mail.gmail.com>
Message-ID: <CALCETrXj_LZ3n1tJZAKRwNP4VrVibUqEhcMQpHuYMq8bb-OkZQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/entry: re-enable interrupts before exiting
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 5, 2019 at 9:19 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> If the kernel oopses in an interrupt, nothing re-enables interrupts:

You probably should also set irq_count back to -1, too, if you really
want this thing to fully survive being called from an IRQ.
