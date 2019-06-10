Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C3CC43218
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DCC20820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20150623.gappssmtp.com header.i=@landley-net.20150623.gappssmtp.com header.b="KkWwJFeh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389926AbfFJVQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 17:16:59 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:45550 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfFJVQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 17:16:59 -0400
Received: by mail-oi1-f196.google.com with SMTP id m206so7318531oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2019 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZIUfIIMLN3e/0Y4suKqQ9G4anQzSpQbmomczdVDiSH0=;
        b=KkWwJFehPDBhr4NdUmIaYVpcbBtcY+sekuoJua+arEHgspzccbX9hGECT92v0fLHyH
         ZYmpD21H+NYveVnwr6RO/nTlzy8f3FuBTKhJnILGYDXW5cztpw6pG0t90GBA6nFI5SAk
         dAIPcmF6URlzecpoiE/Kvy5nbaa1/QnR1RT0ORTmnbT+jN7CerR2BOQH8j2j4z8Kx+kw
         /odvr+b9/RX9x8kPTajNIuMboPxdvwZpetK0TxmopBw+ZTFvme6ySe4mr44XBdgq1609
         wewfjMfmlIO5tfEHmWioYCOm1x1R0YE9V/8iqa0iXDmjIzpgU85UXKd0JmwByRm5iEuv
         vijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIUfIIMLN3e/0Y4suKqQ9G4anQzSpQbmomczdVDiSH0=;
        b=mNp7y/Kc8YbAW8OFeGCt+3VQDb3fOxtmBTv+D//Ne0Lipo8FCn43Z8B4rahULXwsiC
         JZS+5xmPwc6a5LyIyo4TPXy+XU8A1+3nroxT7qHIM0vTflrufMN7Lg0xpgLKM19QmBq1
         4/hOHucsqcvX/4CL40mx2ElLDUrHXyxggHNvAJz3m1/SXO/bIqmxWgokK2K9IlRG/BWJ
         t/SLiNzTGdITuij3w5lcrIyiDQA0xwDfddP0ZqV850IvriZLvAANlUypIlLh1buBXDsR
         /Nd0fj+CvrvI90AVXFDzPHKwAhpcggcDIKCSBNkaFLM6eGafgjaYNHYxzvYvVEV5EHeb
         0o8A==
X-Gm-Message-State: APjAAAVYXl9OCcWsSU8Gvh2uVK64eM4ZCk3j4WG4eRpJ+1klNISZzNrl
        fZ8gheCr+HcQN4ejMuULG63k6ZA4WJs=
X-Google-Smtp-Source: APXvYqzrQymgucgnl+z86o+ugZd1hdDPnQB2gmMuuW1BS1J+N2O8IQAMrfJxzBp9VL2vM3TkiEdeNA==
X-Received: by 2002:aca:de04:: with SMTP id v4mr12968015oig.162.1560201418724;
        Mon, 10 Jun 2019 14:16:58 -0700 (PDT)
Received: from [192.168.1.5] (072-182-052-210.res.spectrum.com. [72.182.52.210])
        by smtp.googlemail.com with ESMTPSA id h59sm1885798oth.30.2019.06.10.14.16.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2019 14:16:58 -0700 (PDT)
Subject: Re: [PATCH 0/7] TTY Keyboard Status Request
To:     Arseny Maslennikov <ar@cs.msu.ru>, Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        "Vladimir D . Seleznev" <vseleznv@altlinux.org>
References: <20190605081906.28938-1-ar@cs.msu.ru>
 <20190609174139.GA11944@xo-6d-61-c0.localdomain>
 <20190609194013.GA3736@cello> <20190609195132.GA1430@amd>
 <20190609205610.GB3736@cello>
From:   Rob Landley <rob@landley.net>
Message-ID: <97e43820-6143-2a84-7d0d-6f40c6c937a7@landley.net>
Date:   Mon, 10 Jun 2019 16:18:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190609205610.GB3736@cello>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/19 3:56 PM, Arseny Maslennikov wrote:
> This is similar to SIGWINCH, which is default-ignored as well: if the
> terminal width/height changes (like when a terminal emulator window is
> resized), its foreground pgrp gets a surprise signal as well, and the
> processes that don't care about WINCH (and thus have default
> disposition) do not get confused.
> E.g. 'strace cat' demonstrates this quite clearly.

Once upon a time suspending pipelines with ctrl-z broke stuff all the time due
to zero length reads being interpreted as EOF. These days I don't see that so
much anymore, I think SA_RESTART is the default now?

Rob
