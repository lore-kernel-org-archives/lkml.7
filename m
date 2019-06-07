Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA5EC28CC3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 019922089E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 08:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBm7FNo0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfFGIIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 04:08:49 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38885 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfFGIIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 04:08:48 -0400
Received: by mail-ua1-f67.google.com with SMTP id j2so331457uaq.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 01:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k72Thv2FjMxl4wYVuFILhsC5Nmx7fltmHQaavC6rg04=;
        b=JBm7FNo0xgNfRLtalYt8rEziqhWDKi6X0uWlO6NZGV/cSrBxUQ6a5zbjgSlkph16pp
         Dbav3A90ZANZuxDh05RYG1P9sw4jM/qqHi49vfBcLFPplYYZJ86/caa+ePWF0WqYslJY
         +fAy7xNlvVrgBiYx7yqDA3hudhHmAeusU0n1nvufQ6WOjt9IWf/5f/mDhiMPu5hI5kBa
         oIRXswkJteCzfV4FSvibO8en7bxxi2LW+w+mjW3gBU0gLp+OuhRgNsYzeeJ+IeeA6Np2
         wLrb3tKA8MFhkbyaZoJnp4iceNd2+PwO5WlXgb3PRJ2DD4xXTFMaS+MqmASfllINX4MK
         WhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k72Thv2FjMxl4wYVuFILhsC5Nmx7fltmHQaavC6rg04=;
        b=SE2NtQK7GlQz020p7JjJq+OD9AwTzKuWLQvyKuB8ktNLTzO0hgWA01pqkX0eP0rpd+
         UoxnwrtBjD9me7Y+185hgAaJmqVBvETMLwfYbzZKGDMniVKBE96XpzFEJ9EXkd+EOgQJ
         mcSY8quISmuQMqb30GgYOWz1p8xU9BpXzKWfPJ6KxhlqMyDiBsutuO4YMCb6DyhdsUFr
         RQHHmUStxogKcORLPMx5JA4FX9qZoJtPQM7B3dqy1CaaazeNYjYd9LEDkZTvC5oUQkzf
         dG7Ja2dNeguWmErUF6bM1TUEqCBCGoTN3V28ShWCvqHk1owdqIsG3U4XlnTWcHFSr6Nv
         +Wtw==
X-Gm-Message-State: APjAAAX5p8j2J7k/IxBr3W8nCY13573qynbf337jzer0O6avVr0PjYHR
        75m9d4v3EGbYMm4cvjEH3rHVr9XYLfS48G31KygoFrqp
X-Google-Smtp-Source: APXvYqyZTo5v0xZue/iPgLth/fyKSMcRw/E9Zir9kQFY3wPg2eSU+T3lg4obOBYoJxkdRsfWR0vXASs133M4sVSgboU=
X-Received: by 2002:ab0:698f:: with SMTP id t15mr16837845uaq.34.1559894927538;
 Fri, 07 Jun 2019 01:08:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190606122009.12471-1-oded.gabbay@gmail.com> <4257c916c5db569c6182880e06ddc1230e80ddf0.camel@perches.com>
In-Reply-To: <4257c916c5db569c6182880e06ddc1230e80ddf0.camel@perches.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 7 Jun 2019 11:08:22 +0300
Message-ID: <CAFCwf13a33KvMQ=beOkKtaBaKtJn_JqZF5av-bSgpPpBnDSO3Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] habanalabs: add rate-limit to an error message
To:     Joe Perches <joe@perches.com>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 6, 2019 at 9:54 PM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2019-06-06 at 15:20 +0300, Oded Gabbay wrote:
> > This patch changes the print of an error message about mis-configuration
> > of the debug infrastructure to be rate-limited, to prevent flooding of
> > kernel log, as these configuration requests can come at a high rate.
> []
> > diff --git a/drivers/misc/habanalabs/habanalabs_ioctl.c b/drivers/misc/habanalabs/habanalabs_ioctl.c
> []
> > @@ -255,7 +255,7 @@ static int hl_debug_ioctl(struct hl_fpriv *hpriv, void *data)
> >       case HL_DEBUG_OP_SPMU:
> >       case HL_DEBUG_OP_TIMESTAMP:
> >               if (!hdev->in_debug) {
> > -                     dev_err(hdev->dev,
> > +                     dev_err_ratelimited(hdev->dev,
> >                               "Rejecting debug configuration request because device not in debug mode\n");
> >                       return -EFAULT;
> >               }
>
> Perhaps this should be dev_dbg
>
>
But this a basic error. I prefer to give visibility to the user in such a case.

Thanks,
Oded
