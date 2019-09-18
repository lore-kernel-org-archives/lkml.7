Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3762CC4CEC9
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1141521920
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 17:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CToDozDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbfIRRcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 13:32:42 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:36392 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387871AbfIRRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 13:32:40 -0400
Received: by mail-io1-f67.google.com with SMTP id b136so1159657iof.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2019 10:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQupU8qDMpWTvbsNNXhBq+S54ArsioiWDu9t9lJjviM=;
        b=CToDozDYgHwAtzZXC18Vjxrqvj4jq9AzsicJuP6QeX1POgsDqyC5VvF1p1I6sUX88h
         vuejj3ffZDJ5j2zWnKto7245TwhLkessME3JRjH74JBokmEvZmZ+0nx5f3j0xRsGz4G9
         XHn0dsqvSdIE8rbBR7nhnP1M3VSbmQZwdVL5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQupU8qDMpWTvbsNNXhBq+S54ArsioiWDu9t9lJjviM=;
        b=HVWKAJcccPdH18XacPIOZzEiOIYJQrVldSjBtDMEOjfYpUC0S3PQqEX6eDUw4SNt+L
         3f9SW5AhIC+iy/AiZP9hCkA45kLI1hMpFHAkS/rxn0s6sqoZfwaxZZ4gzXx/qNAiCUD4
         HkCGQ4epJvfNKKgqVkJUMdkeHTDj3bWk5+4hpkxXM98fxHVMdLLHcjqIg4fYrgYaXCDg
         YcJt6j0wzZdA9WhIWkABxPJ+KwWjOM4MX3P6eThzcIRZTdjqqvzH7JWA9uRDPhHuhHfH
         MtPeG3sL7aSR3an5i5selKBnUCVxnhG54AMpoxH2qgyuRh2xz4GJXlnfntGxd78313Zk
         UdcQ==
X-Gm-Message-State: APjAAAWDg3sBXJWF2UQaitIIw3uV82MHvyOnXL2joo4lspK/OOqGWt9Z
        RfuWFbn3B26IjUOeuqg7Z260B3d1BOQ=
X-Google-Smtp-Source: APXvYqxm7H0vlfK9UJQQlAd0mzPNmGzLYJu8h3TwA5Bj5QAuHum8D403w8vj5S4G7j9YpMmRiL4VPg==
X-Received: by 2002:a6b:7615:: with SMTP id g21mr6140478iom.67.1568827959398;
        Wed, 18 Sep 2019 10:32:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:183:200:798c:e494:921c:d544])
        by smtp.gmail.com with ESMTPSA id u124sm9385513ioe.63.2019.09.18.10.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2019 10:32:38 -0700 (PDT)
Date:   Wed, 18 Sep 2019 11:32:36 -0600
From:   Daniel Campello <campello@chromium.org>
To:     Nick Crews <ncrews@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Duncan Laurie <dlaurie@google.com>,
        Trent Begin <tbegin@google.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Add debugfs test_event file
Message-ID: <20190918173236.GB24119@chromium.org>
References: <20190906204205.50799-1-campello@chromium.org>
 <CAHX4x84w1xf9RL_rK4PiMrW2uhVkNFeU5GrW_BYfs8B5NKG9jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHX4x84w1xf9RL_rK4PiMrW2uhVkNFeU5GrW_BYfs8B5NKG9jg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2019 at 06:20:51PM -0400, Nick Crews wrote:
> Thanks for the patch Daniel! A few thoughts that I didn't
> have on the review on Gerrit, sorry :) After those changes,
>
No problem, I will take care of them.

> Reviewed-by: Nick Crews <ncrews@chromium.org>
>
> >         u8 sub_cmd;     /* Always SUB_CMD_H1_GPIO */
>
> This comment should be removed.
>
I overlooked this. Done.

> This comment should be moved to h1_gpio_get().
>
Agree

> > -static int h1_gpio_get(void *arg, u64 *val)
> > +static int write_to_mailbox(struct wilco_ec_device *ec, u8 sub_cmd, u64 *val)
>
> What about send_ec_cmd() or similar? Something that communicates that
> we are sometimes telling the EC to do something, and sometimes reading something
> back. Also, since we are adding in another layer in here, we can fix
> the signature from
> the one required by a debugfs attribute. Use "ret" instead of "val"
> and make it a u8*.
>
send_ec_cmd() sounds good to me but ret is already used. Will change
to out_val as discussed offline.

> A one line comment as to what test_event does?
>
> > +static int test_event_set(void *arg, u64 val)
> > +{
> > +       u64 ret;
> > +
> > +       return write_to_mailbox(arg, SUB_CMD_TEST_EVENT, &ret);
> > +}
> > +

Will do. Thanks again.
