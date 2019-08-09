Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40889C32756
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11ED52089E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 21:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PZAf+XDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbfHIVRj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 17:17:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42036 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbfHIVRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 17:17:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id s19so7804310lfb.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6qcKD1aVaygupbagJQvs2szHppirdYUK1GjYON7+Wc=;
        b=PZAf+XDThboVQRyYZztPO0KbXTs1zesXPlhPtOdK0cxWUGJAax/ZcgrlVtr+Flu12b
         LM63vttNkoeT5Zskzk7N+8pLvqMd4TuogzXoQ2gjJk1vVQfgsxf3f9vx0Q2iLXCcEOj0
         jvveAaMqqpP2Aa/Eyw+wy7Ba4XmwDB4MEXCmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6qcKD1aVaygupbagJQvs2szHppirdYUK1GjYON7+Wc=;
        b=kA2FsTAKFcxfEL6y2c9cmhdZ7DZLu9gpsh7AwOh68Jn5+pQAD4MmgKjmqOz/9jEDVy
         AzHqCRIqK61bNmw3kq+1SLZyXhHS7uoa90Fh0xThA3c0TvqKxr25/f05O1BCs2/r2V7m
         9u/o4JX9nWswGOBMdwSlrGfyeSlVW3eVQ4hUrinq336fE79otVO6hwZq4UeQ2GhfF2on
         xj/MWNkEf+6mVbhPrlvPEZ22F8vhVGlB+5h1bwSK1XRcSKn8/jpsKhYQfldi+QxNGLMS
         1WmSSD7ozK67lYTy+V+PMS/Cfsv/NkUgqng5UlFnnBWCjl31fpyRgWYhrwAabjgqahq4
         D0+Q==
X-Gm-Message-State: APjAAAWpjDF+kYeRlDIEaY4xiB8QTP2Brks6M+hQwDtiQ2fhGQ0qORQ2
        Pm7RCSjZ9tk8B5acSQ2n8hQ5T6Y2YC0=
X-Google-Smtp-Source: APXvYqwEDo3BHzU4IhO45oOezpyE56O6VwahmK0Q7tfgTlb4+LLRCFcr135FbE/Awo3IYf0DdTi/Mg==
X-Received: by 2002:a19:8c56:: with SMTP id i22mr13619520lfj.105.1565385456469;
        Fri, 09 Aug 2019 14:17:36 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a15sm3405853lfo.2.2019.08.09.14.17.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 14:17:35 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id x3so16706136lfn.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 14:17:35 -0700 (PDT)
X-Received: by 2002:a19:110:: with SMTP id 16mr14160555lfb.63.1565385454814;
 Fri, 09 Aug 2019 14:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190809121325.8138-1-georgi.djakov@linaro.org> <20190809121325.8138-2-georgi.djakov@linaro.org>
In-Reply-To: <20190809121325.8138-2-georgi.djakov@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Fri, 9 Aug 2019 14:16:58 -0700
X-Gmail-Original-Message-ID: <CAE=gft4mkz=rhmC7p903UuAhzG2obaST+ZTecOfmDFKbpgSTpg@mail.gmail.com>
Message-ID: <CAE=gft4mkz=rhmC7p903UuAhzG2obaST+ZTecOfmDFKbpgSTpg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] interconnect: Add support for path tags
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, David Dai <daidavid1@codeaurora.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        amit.kucheria@linaro.org, Doug Anderson <dianders@chromium.org>,
        Sean Sweeney <seansw@qti.qualcomm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 9, 2019 at 5:13 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> Consumers may have use cases with different bandwidth requirements based
> on the system or driver state. The consumer driver can append a specific
> tag to the path and pass this information to the interconnect platform
> driver to do the aggregation based on this state.
>
> Introduce icc_set_tag() function that will allow the consumers to append
> an optional tag to each path. The aggregation of these tagged paths is
> platform specific.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Reviewed-by: Evan Green <evgreen@chromium.org>
