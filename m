Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DF8C4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD65D207FC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568829255;
	bh=GAWx1LXo+XiZgr0w9PJANPFiUisD48gTUx/a3JHOGro=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ew/Q0Z64HqCXwszmL3UY47d9E5eFEbyAT8n66wfME/U/4t3FI3BQjWWDX+E/n5ilp
	 ZeY6oOzPl3HTHFWDBrjanMnZZp1g//i6x32WgGMf1MBW9GZOyV0csyLath81KmwDjR
	 umEY3KOGOSYNjWBi4HiNtzmPkMkj09O8FJuW6pV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbfIRRyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:54:15 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36039 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfIRRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:54:14 -0400
Received: by mail-lf1-f67.google.com with SMTP id x80so334228lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKPEblYmiNWRiv20ieEmPxQMSPG3ROjEN5oXXUa4NGI=;
        b=dCH0MbSm99XKssdMsOkoLpiwx4MDo8pFEsngrU0Z/OMvbuihc7aYnWe7t8BBAd+ttJ
         Uu0Ju8g0bM2omm07tKD+EqqWeJSWbzm8neDVGBp7Mr89tT2SS4rfcSbcrdLMYaqDX9Ch
         cLSicD9c3odh1fkwx2ih0er4rVz2IoV58s0/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKPEblYmiNWRiv20ieEmPxQMSPG3ROjEN5oXXUa4NGI=;
        b=atoLxh+bPQO599Kafm/ZT1yJz6s1DIXP9ML8v79WcJ4qI13T332jzjyInuhpApSooN
         x7hKC4f7PyUEOu7XQ9pCSX1XYRzfF15eBVsfyBOKRir/oPc6SJOM6XzbESS/kcGfkwUW
         nPJXwO80DiT1Ml8VMVgUh+C/LG4rqsooRgQjMhglvO9/m8q0qlEanYYoE0FVeC+zx2+2
         87k7A/ZyHDa3e9WtTddXzmOurdGb6j3BUOkKH+g+OgVZIiGhD69/zjNeykSUQ/UU4W/c
         rV10DLnczv9/+xYnELV+d0XAokUFlFE5rztBRDC+fcQXikqGt3xs7sgYeTIfs1RDJXGM
         Eo/Q==
X-Gm-Message-State: APjAAAUErX6kXHGKRD0xfbkffQ8Gb/lOjqfT/tRhl9l5/pdf4kP06MM2
        wssrYNs0pd+837Tw8z2rXDCaSXiPj0o=
X-Google-Smtp-Source: APXvYqwdcmkL8VIGYkyb5uiL6LA6IW+igtJ/f1QajOjF3B5bSdCBTZgP0/sl4hIKYI5VNYkBR06kTw==
X-Received: by 2002:a19:8a0b:: with SMTP id m11mr2771847lfd.4.1568829252541;
        Wed, 18 Sep 2019 10:54:12 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 207sm1271211lfn.0.2019.09.18.10.54.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2019 10:54:11 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id c195so308199lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:54:11 -0700 (PDT)
X-Received: by 2002:ac2:50cb:: with SMTP id h11mr2762148lfm.170.1568829251126;
 Wed, 18 Sep 2019 10:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190918164121.30006-1-Larry.Finger@lwfinger.net>
 <20190918164518.GA19222@lst.de> <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
In-Reply-To: <b4fa6ab6-ab30-fc05-0f9f-93c41e7e8c79@lwfinger.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 18 Sep 2019 10:53:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji2fMDpSwvR4U8FkKBx8=eZtg3CmWtH7hACzeHbBei8A@mail.gmail.com>
Message-ID: <CAHk-=wji2fMDpSwvR4U8FkKBx8=eZtg3CmWtH7hACzeHbBei8A@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Remove set_pages_x() and set_pages_nx()
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 10:50 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>
> Is there approved way for pages to be set to be executable by an external module
> that would not be a security issue?

Point to what external module and why.

Honestly, the likely answer is simply "no". Why would an external
module ever need to make something executable that isn't read-only
code? That's pretty fundamental. Marking data executable is fairly
questionable these days.

Instead, what might work is to have some higher-level concept that we
actually trust, and that isn't about making data executable, but about
doing something reasonable.

See the difference? Making things executable is not ok, but perhaps a
"alternative runtime code sequence" is ok.

                Linus
