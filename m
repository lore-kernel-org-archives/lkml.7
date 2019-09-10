Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C355C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C502067B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mj/kwfMF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391990AbfIJKGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:06:31 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41219 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388027AbfIJKGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:06:31 -0400
Received: by mail-io1-f68.google.com with SMTP id r26so36038895ioh.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YrD7opUTCKF/Dc+PRvwx3vIbiJXUFvJEMZmsR+GeGLI=;
        b=mj/kwfMFsOlg1W0Tg86x5PW0kMxOd/8jOfYxBbRuhq/VBKoYHYgwmHMlAch25hIwCX
         hsumRlADSP8BuzHfk9kQkZonqsY7Tar7qr+8fyW7GHaAQR7wXo2cJ8rOcr++w82KypHE
         pqYszKBozCCxdsQd4QzZHsxITHg9KRV8G5miLdN8jGQ5jY1XN9kERdLvBSDW4vnVs22F
         56ecEc349oYv4wzwfbNezEKgN7yvZtTW1/gNhDJGAp0t4aG51+yyvxDOPHsUvI8tjQSV
         D1RgLvAZZ3VMnvYGXc1w4LxkIOm7ODnR7PYHHXSDRlpjTSoyvuRXrJx53VQ1ZH+2CwUn
         hegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YrD7opUTCKF/Dc+PRvwx3vIbiJXUFvJEMZmsR+GeGLI=;
        b=ufcvp8nCoJEdlUtmSIAXTUXELmx0xeW3EIcUd5m7UNcgVVfqGLY3KIz8CUVyXt+mxh
         qEPdGMFbQjoCgxP6bIu4lD6qVVLh4CsDo3gRcRdA6FCqT44qb2sLhE9J0ta9Sb9vri+b
         FTgUdY6L98PITz54bu4oC9TpzdqljMHOZoELBND+2DFDh/Gb0k+CN3tl8jJM+v9JxNuy
         g9xxy6UcEfG769y9HT0CmF9fVzn/MmyKL2ZLcpUxzZ5CscepuMYDNmO7XlN4e9VEn8Nl
         wd3GsAfi0uk6ul8943jt4UZHknsraKFKGNfxwk5pi+SxL+SV4rr73w5FzDhHOWV/ihSI
         3vWw==
X-Gm-Message-State: APjAAAW1fQ1rYJs90wmuNxWlHSwJE1akz+TO7XH5LCB6K7lCmoZbw25u
        yhLID79PVGJDbqePaTRDN8v071QD8xq6cLvXPrCmUQ==
X-Google-Smtp-Source: APXvYqxpy/qz8tcSd+bcaxYn/LqS/1teJzJ/Y1EorcnP9rEyNbA6nUM+glGsXWTF0JBljuiJUTLCzR1beKcFFxzpSA4=
X-Received: by 2002:a6b:5f11:: with SMTP id t17mr1107180iob.169.1568109989802;
 Tue, 10 Sep 2019 03:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190820001805.241928-1-matthewgarrett@google.com>
 <20190820001805.241928-4-matthewgarrett@google.com> <3440.1567182506@warthog.procyon.org.uk>
 <CACdnJuvR7mqhpzEQZdgw9EE_PsM-QWQ_JmwFLcoeLbAuKCHnOA@mail.gmail.com>
In-Reply-To: <CACdnJuvR7mqhpzEQZdgw9EE_PsM-QWQ_JmwFLcoeLbAuKCHnOA@mail.gmail.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Tue, 10 Sep 2019 06:06:17 -0400
Message-ID: <CACdnJuvfJ-L-3a5PVL+fWi6XwKb7EBONG8jEwbR=uHkA3wcxOQ@mail.gmail.com>
Subject: Re: [PATCH V40 03/29] security: Add a static lockdown policy LSM
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris <jmorris@namei.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 4, 2019 at 12:51 PM Matthew Garrett <mjg59@google.com> wrote:
> On Fri, Aug 30, 2019 at 9:28 AM David Howells <dhowells@redhat.com> wrote:
> > > +static int lock_kernel_down(const char *where, enum lockdown_reason level)
> >
> > Is the last parameter the reason or the level?  You're mixing the terms.
>
> Fair.

Actually, on re-reading, I think this correct - this is setting the
lockdown level, it's just that the lockdown level is an enum
lockdown_reason for the sake of convenience.
