Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA732C3A5A3
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91C92189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lHE8Rghi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfH2O26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:28:58 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37670 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbfH2O25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:28:57 -0400
Received: by mail-vs1-f66.google.com with SMTP id q188so2550167vsa.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIpyQ3wOb9bWqvkX0Kpr4MtQFBTIPyZmoRnHAHX/iC4=;
        b=lHE8RghiwfW1Za7MXZfEj+tcRA5+wrEWmVF5Keow8qTDcQOlGf4062XfDSUn6uEXDh
         lZNKY9YudWj2VwmIGrrk0z96f7MCwqTmToJ0qUx7s9qo5fMEKYT63v3iilBq/ykKVI0k
         4uQGf2L0Qu4GxqfenZnbk3+E1Hyft/0qcstmSQbMSOP0hSUEeCdV4ho5986Zq2vC8vFd
         /3xTmD1TXSCXRTRhGGM9PJzXP4mIJTDL8Uz9uL0aFnR4Pv2X7S+q6R+YjGzN16IA04xd
         G/zNaTE1nZDJiQiJwhAZUOdxXwX36xfy+KGbSTMV406iQO+PaEU3HTP2Bd2sUPzNjmH9
         9DGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIpyQ3wOb9bWqvkX0Kpr4MtQFBTIPyZmoRnHAHX/iC4=;
        b=mhUYvow6dVvIbVpnxipHSwewwRUQJk1bApJAuTrK1SENDNkVLeZvulfes48KFAlSud
         K+ZGYj1Zttgu73VYXRFR/6qoIIhR5v4u6QdsxYNajuuDAPtmyhSdoL+vr1JCYKDYTzV3
         IhxQ+kvuyQq367eohEeMxA9qNC3Bh4AkaHZyuYu021ih+GUKc55pYkXa024InIwGkcga
         BBVJoNlUIJ5ivt+RsftiakFuaG3TooMdZHtuFWZGf8n3pNlwigPXPpuRAbtTryoSgNOw
         wJMrjZocF+sdEeU68hTeFUnz7sT4xbMGEkzwGO0yWUSY/8gzuOZ6LjdzHMPDpIzpc9wf
         PuXg==
X-Gm-Message-State: APjAAAV8d9YkZxAqZ6IrNcwzvrOt5zh2/KyWFpecjdUS9WkPz6dWLGwm
        yynsFiRSCGzRQvsamsFaw2O7loH1MC+HX10Y1mofeg==
X-Google-Smtp-Source: APXvYqzYJ6oqRwamIEDLJ3VtjU+XaOg77kkXW1O2XB+w4FxGCSBbCRCZltm1LjnvJjPK+WsK0l7De0RJSAqYnMnKyvI=
X-Received: by 2002:a67:b009:: with SMTP id z9mr5725405vse.27.1567088936391;
 Thu, 29 Aug 2019 07:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566907161.git.amit.kucheria@linaro.org>
 <93fa782bde9c66845993ff883532b3f1f02d99e4.1566907161.git.amit.kucheria@linaro.org>
 <20190829140459.szauzhennltrwvg4@holly.lan>
In-Reply-To: <20190829140459.szauzhennltrwvg4@holly.lan>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 29 Aug 2019 19:58:45 +0530
Message-ID: <CAHLCerNuycWTLmCvdffM0=GdG7UZ7zNoj0Jb0CeLTULzVmfSJw@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] drivers: thermal: tsens: Add __func__ identifier
 to debug statements
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <masneyb@onstation.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 7:35 PM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Tue, Aug 27, 2019 at 05:43:59PM +0530, Amit Kucheria wrote:
> > Printing the function name when enabling debugging makes logs easier to
> > read.
> >
> > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> > Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> This should need to be manually added at each call site; it is already
> built into the logging system (the f flag for dynamic debug)?

I assume you meant "shouldn't".

I haven't yet integrated dynamic debug into my daily workflow.

Last time I looked at it, it was a bit bothersome to use because I
needed to lookup exact line numbers to trigger useful information. And
those line numbers constantly keep changing as I work on the driver,
so it was a bit painful to script. Not to mention the syntax to frob
the correct files in debugfs to enable this functionality.

As opposed to this, adding the following to the makefile is so easy. :-)

CFLAGS_tsens-common.o          := -DDEBUG

Perhaps I am using it all wrong? How would I go about using dynamic
debug instead of this patch?

Regards,
Amit
