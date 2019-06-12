Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B84C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC420874
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 15:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbbVQq0D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfFLPOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:14:25 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38052 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728203AbfFLPOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 11:14:25 -0400
Received: by mail-yw1-f66.google.com with SMTP id k125so604338ywe.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 08:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S/GB4a5TSispNPGgoL6ZNAOrf6nS5uurvxT3ihYPD/Y=;
        b=GbbVQq0DRbYQmv73EzjW7DwgW/Urn4CFLavsKDLUU3dJtrrq/SV11swrqa2vQgovHb
         sCEuJuHq0m3yfssNENG6l9iL8xMzQL+9LNOd5hdgCWNWe4NFxuUX25G7UXppctTU66ha
         5a2JsaD+G+Fb3bPRcPAxcFMfxQnp5rI2rAALrcmclQA6VHlzTAaEaHzRK3ItaPfW1MLk
         t6J/m3ZicM2QsoNeu9FH6VAkZYCzYV/jriV6ioCiK7JoRHWk65XRG/Zi5UjojjqTyCwX
         ZMwsW7wbCivUt2G5ojspc3XcAz0jICcQDcbHogxXeYqf3pddTWD6GZdFscVvk9VM7Dcu
         DpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S/GB4a5TSispNPGgoL6ZNAOrf6nS5uurvxT3ihYPD/Y=;
        b=TPZR/XOg8xlLWlA2qglL4ghhZ8MUr65L2Ngns5MHNIEUM30Wwg4ugdZTSHRx28I0Tx
         DA5VlmZmdqA+ziHFMyLzN967Cxqz1leLNbN4xdNKcUq7fal0SuMi70tMps06FTU1LpEy
         me1pJoRI9OR36hEkfk7xUCOaZY7jczoHVxrKRAs76Rq3rdXAoaOMgFLIU0pf6MDQt1P2
         A0NXXowmwTL65uD6yM4qu2XLTYlo/X2Mse3IrPID/bMxx+h0Yq2DFvMQqQG4swnx+SPs
         rqxR9dckMh8lnkRcIiGiyTNsVok4r2xyxTkIn/+XAo2iz1PDf4txFYauitWgov8D2VVk
         dZDQ==
X-Gm-Message-State: APjAAAXtK2c28wC/oXG1Wxd19gfJXjKghe7hylsLmZuzuw1RDArwQL4v
        KflVI4kEAihYt5uNdFXMYV79cKIEPREWRwdzbQz3yw==
X-Google-Smtp-Source: APXvYqy4NPrO4WjE4mjyLGgpcDGgvF3A2Bxmonui1RUQPoq/XgwD1e5jtQFHlL+GyogUVHY3TejSiHp2J39NHOAGSqU=
X-Received: by 2002:a81:4c46:: with SMTP id z67mr31835690ywa.267.1560352462950;
 Wed, 12 Jun 2019 08:14:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190612142727.GA1710@ahmlpt0706>
In-Reply-To: <20190612142727.GA1710@ahmlpt0706>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 12 Jun 2019 08:14:11 -0700
Message-ID: <CABXOdTfrbQ-4YgLYTXQiMPpOgRL2Z+Gqsv+uDNcJ+CtuW++2aQ@mail.gmail.com>
Subject: Re: [PATCH] gsmi: Replace printk with relevant pr_<level>
To:     Saiyam Doshi <saiyamdoshi.in@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Aaron Durbin <adurbin@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Duncan Laurie <dlaurie@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running checkpatch on the attachment, I get lots of

ERROR: DOS line endings

plus

WARNING: Possible unnecessary 'out of memory' message

Hmm ... ok, the latter is a different issue, but it kind of
contradicts "This also helps avoid checkpatch warnings".

Guenter


On Wed, Jun 12, 2019 at 7:27 AM Saiyam Doshi <saiyamdoshi.in@gmail.com> wrote:
