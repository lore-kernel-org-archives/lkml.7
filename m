Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45DD2C10F03
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A67820840
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 18:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YpArZAGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbfCGSUM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 13:20:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36962 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGSUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 13:20:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so12058092pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 10:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=n8wSLJh3GXdY5a0oY98XTXZmgoXX8BLFR1DAUT44FVc=;
        b=YpArZAGF2rkH+wl8ZqI3DxIhYtHR6yMZ7TB03z/egkTW+6e/WGDbHZtXl7oWJ+S4uQ
         +ZpJFwKZxpA/czdyIbbqV8KTN5iJMozcuBteCoRYDnbE+WXT0pwii/Ndb8FwG50Xrenn
         9+/e9i753OmYF45snSFF612oGQ66pDAftMR8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=n8wSLJh3GXdY5a0oY98XTXZmgoXX8BLFR1DAUT44FVc=;
        b=SYuRHsR1znszvjuK9frhe/tMseuq2WQPGVZbkHQIFZJCD9D4D+Tqy3NqqFIGVqSAXJ
         JIpHakeaVw5BBFdJm5FARmvZ7UpTrYEr0BiFwhJo+UWvyOnlk7pIA9tP8Q7aT6Ox9mOY
         5MMrafjwADNjaTcZ6qwes08Jh0x4auP1lo8Dxo4S9Ea/hUJuuE1PGRuB7tUmgtAT0isu
         k9AFTo6PUFX83Mofi7YuPTJPVUEnWZkp/FrSaFqp7xFhHYxg/40WqG6qwQOkhyMUR+MB
         xFLJb5+7EhNdl6r3ovLYPP+3e9mvqRlJO2UGy4RIaUXSwToAAvrKXtK2Ww/+oBKSfZpL
         iJzg==
X-Gm-Message-State: APjAAAU8Etgx5TlXoUaD6btlWeEugJUWJYv3aeAhy/VJ8plh/yUcnR3E
        pqgzEBxDPjPChX6yZuOFFhNyfg==
X-Google-Smtp-Source: APXvYqxIfc416OIg9O8zgIT6yHYstjjw7WgIBUqIaRMElyhlE2ApvirLqBvWcIyfBKXKgc2yqusqJw==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr14431176pll.311.1551982810943;
        Thu, 07 Mar 2019 10:20:10 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id s4sm7810922pfe.16.2019.03.07.10.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 10:20:10 -0800 (PST)
Date:   Thu, 7 Mar 2019 10:20:09 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190307182009.GB138592@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
 <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Balakrishna,

On Thu, Mar 07, 2019 at 10:35:08AM +0530, Balakrishna Godavarthi wrote:
> hi Matthias,
> 
> On 2019-03-07 06:10, Matthias Kaehlcke wrote:
> > Firmware download to the WCN3990 often fails with a 'TLV response size
> > mismatch' error:
> > 
> > [  133.064659] Bluetooth: hci0: setting up wcn3990
> > [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> > [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> > [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> > 
> > This is caused by a vendor event that corresponds to an earlier command
> > to change the baudrate. The event is not processed in the context of the
> > baudrate change and later interpreted as response to the firmware
> > download command (which is also a vendor command), but the driver
> > detects
> > that the event doesn't have the expected amount of associated data.
> > 
> > More details:
> > 
> > For the WCN3990 the vendor command for a baudrate change isn't sent as
> > synchronous HCI command, because the controller sends the corresponding
> > vendor event with the new baudrate. The event is received and decoded
> > after the baudrate change of the host port.
> > 
> > Identify the 'unused' event when it is received and don't add it to
> > the queue of RX frames.
> > 
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
>
> ...
>
> Can you test by reverting this change "94d6671473924".

The issue is still reproducible.

> We need at least 15ms minimum delay for the soc to change its baud rate and
> respond to the with command complete event.

The baudrate change has clearly been successful when the problem is
observed, since the host receives the vendor event with the new
baudrate.

We could increase the delay to 15ms just in case, though in my stress
tests with 1000s of iterations I didn't observe any problem with the
baudrate change itself. However if this patch gets landed the delay
could be removed completely, since we are waiting until the vendor
event is received with the new baudrate.

> In my previous stress test we have not observed any issues.

Which patches did you use for the stress test?

Did your stack include '78e8fa2972e55 Bluetooth: hci_qca: Deassert RTS
while baudrate change command' (or equivalent)? It is mainly this
patch which *exposes* the problem, before it (and with the long delay)
the controller response was received with the old baudrate and could
not be decoded ("frame reassembly errors").

Also make sure to test without 'Bluetooth: btqca: inject command
complete event during fw download'
(https://lore.kernel.org/patchwork/patch/1027955/), since it affects
timing and injects extra events. It might seem that it fixes the
problem, but it just papers over it.

I have my suspicions that the mega-timeout of 300ms for ROME was
introduced to 'fix' a related issue ...

Cheers

Matthias
