Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9EA9C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81042208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 18:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfIAcnKR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbfGaSXZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 14:23:25 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:34314 "EHLO
        mail-pf1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfGaSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 14:23:24 -0400
Received: by mail-pf1-f173.google.com with SMTP id b13so32335453pfo.1;
        Wed, 31 Jul 2019 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BWZwOQmIlvQQZPTLSVK9bZ5Ei0Nf8UiNBXPd+xlQOoY=;
        b=FfIAcnKRdIi6rtG53El20ZCUws7qaP9vZPrPBGlRLXjeITOt003OaZ3s18rBPL8qSt
         MdNYS4F2uSdmABmVNlUgMNrVeE+5YH2d/2AXTifL10DXJUYGo2gxs0oGJMHOHXPpMYSD
         VKQzmbzeSm0TH6NRukgGnajCTlVkt2rIZbnHZzMdBTuBgVv/4873YxayOP4xh94iqi9t
         SOmJEJV7z4LmDiwJt1I/dmjUgr3ZJpA+nZxsncwMHkSgs7qb2SmYQc6wrDXbgtCtf9Aw
         /s949qQJfQLGIJ3x46aT5ErBQakEZCyTLQ/G9Yngw3bml2C0kfXmeZXecaHh8pcRTr18
         uaBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BWZwOQmIlvQQZPTLSVK9bZ5Ei0Nf8UiNBXPd+xlQOoY=;
        b=uRL6BkYDZmmIf7E1AwbT6bGl1w8x/zhM6WggUX7Gt0RzjZ5HwGFV9DCQmm5t/iQW9J
         6+RywIRRwCW6B8DwgUUvfc9oGOpXyo+OHwEEfjSbJuOi4UtU+aldSJIRIFoDzAu8nsqM
         f/ew4lpjwFlQVarrSBItE/pnwLFyElvC/YCVnHubyms2oUEydt1Fjo78Hfos5QQOI5w+
         GLMOmkpqb7P32FzXm1g1CROEikMZBuenGy9/TEXHUPdh8rtVFuZhZrUGBt8dxBqBTXKB
         kYdVwNNU+aV/gYf5viFHP4EhLokJnhctI18Xg/PUgS+7QTs1H/j7nOS6u7iT52YyPWTW
         mAUQ==
X-Gm-Message-State: APjAAAVN0xeJKTa7wSDaq/+UnzYf9n2wc+eDSAjIl4w2ov4YB9DCrVRu
        YeGJs/40bMFsEbUb72pRtzs=
X-Google-Smtp-Source: APXvYqxEcSgRuzNYju1Q8vsuYy3bCwSHmCfSrAbkUTfuKfYKaKdnBs2AGvvaR5Cy7pw6AIEs/lVNAw==
X-Received: by 2002:a62:16:: with SMTP id 22mr50519637pfa.151.1564597403910;
        Wed, 31 Jul 2019 11:23:23 -0700 (PDT)
Received: from mbalantz-desktop (d206-116-172-62.bchsia.telus.net. [206.116.172.62])
        by smtp.gmail.com with ESMTPSA id 65sm68854515pff.148.2019.07.31.11.23.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 31 Jul 2019 11:23:23 -0700 (PDT)
From:   Mark Balantzyan <mbalant3@gmail.com>
X-Google-Original-From: Mark Balantzyan <mbalantz@mbalantz-desktop>
Date:   Wed, 31 Jul 2019 11:23:19 -0700 (PDT)
To:     Guenter Roeck <linux@roeck-us.net>
cc:     Mark Balantzyan <mbalant3@gmail.com>, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pavel Andrianov <andrianov@ispras.ru>
Subject: Re: [PATCH] watchdog:alim1535_wdt: Fix data race in ali_settimer()
 concerning ali_timeout_bits variable.
In-Reply-To: <20190731164337.GA13646@roeck-us.net>
Message-ID: <alpine.DEB.2.21.1907311118190.81695@mbalantz-desktop>
References: <20190718155238.3066-1-mbalant3@gmail.com> <20190718163458.GA18125@roeck-us.net> <alpine.DEB.2.21.1907310911120.29703@mbalantz-desktop> <20190731164337.GA13646@roeck-us.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter, all,

It's alright if you still don't wish to review my patch on alim1535_wdt, 
but my employer and I, using our race condition analysis tool, detected it 
to contain a race condition warning. I believe any possible issues could 
be resolved if it were rewritten to use the watchdog subsystem as you've 
previously stated.

Now, I don't wish to bother you too much, but it seems I forgot to work 
mainly with my assigned mentor prior to submitting patches..sorry. So, 
after I have worked on rewriting the alim1535 driver into common watchdog 
subsystem with my mentor, may I submit it to you then?

Thank you,
Mark

