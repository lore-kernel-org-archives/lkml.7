Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1FC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB6320851
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 23:30:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Lb/GBvAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfCGXap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 18:30:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36938 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCGXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 18:30:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id s22so12654791pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 15:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tJqT7pM1IomMnnU+5F6jSTpHjIxUCEOsVig1V79DC/A=;
        b=Lb/GBvAJlxHamq+q5GpxueAgxMtpkPrCglTjOS/u7MQ7ofVKaFxucj0km7T8Icxgqv
         a1jTjFy5Y0lijV3UvqXuAslLt0uLrKir/0DFRsuQPMfwjqXmGe7nr9UAEXqFvLyyRo88
         aBqkD7mLiSo6Ga+UzCVyXU0k8lPUi9hTfX5ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tJqT7pM1IomMnnU+5F6jSTpHjIxUCEOsVig1V79DC/A=;
        b=S48ZCZ6ftwwxiOwB957cWJhHlNkY9ptlZkS+jFqmf65kqPkFsgLcMB7LYZOhDfKyN2
         Pb3AMu/rLFLDcnFaDsG5dZSqvKKMXAFwskExomAu91ZxSKGmt2wgZGWPU3zywH0xiyZY
         gmCMlo7k+DcF7MJQiUaYmXpiOuWeGMQnmcn27ra3dNMmsTbU9QKwoLd389C2qdIuIr07
         zJwKBtlDR516aawgAGiv4w0zbt3BmJ6wbMoubpB7cIR9A1wIwsx6ZKdH/rO97bq8WjDz
         JhuWuB1fp2jrJDZvZnG257FVhUkIoWJS3RToKwCz9ra1SVbcbKYp6McMFrvtXE98QtBb
         wHRQ==
X-Gm-Message-State: APjAAAW/1hxPRQ1cHQSbaUuBgHDBww2lh7lmTZsLSnqY6cNe61VJbtMo
        nSz+tlUTcgVh7NxwTITdUs/01g==
X-Google-Smtp-Source: APXvYqxleXeEsD7rVLLcV5YMlWREG7KIPqNWxwr6PvxY/KqhnBJJNNvKhOuRnyAlB83mjt9XzuvVBg==
X-Received: by 2002:a63:f5f:: with SMTP id 31mr13656075pgp.186.1552001440538;
        Thu, 07 Mar 2019 15:30:40 -0800 (PST)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id 8sm9088117pfj.88.2019.03.07.15.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 15:30:40 -0800 (PST)
Date:   Thu, 7 Mar 2019 15:30:39 -0800
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190307233039.GA69116@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
 <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
 <20190307182009.GB138592@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190307182009.GB138592@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2019 at 10:20:09AM -0800, Matthias Kaehlcke wrote:
> Hi Balakrishna,
> 
> On Thu, Mar 07, 2019 at 10:35:08AM +0530, Balakrishna Godavarthi wrote:
> > hi Matthias,
> > 
> > On 2019-03-07 06:10, Matthias Kaehlcke wrote:
> > > Firmware download to the WCN3990 often fails with a 'TLV response size
> > > mismatch' error:
> > > 
> > > [  133.064659] Bluetooth: hci0: setting up wcn3990
> > > [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> > > [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > > [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> > > [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> > > 
> > > This is caused by a vendor event that corresponds to an earlier command
> > > to change the baudrate. The event is not processed in the context of the
> > > baudrate change and later interpreted as response to the firmware
> > > download command (which is also a vendor command), but the driver
> > > detects
> > > that the event doesn't have the expected amount of associated data.
> > > 
> > > More details:
> > > 
> > > For the WCN3990 the vendor command for a baudrate change isn't sent as
> > > synchronous HCI command, because the controller sends the corresponding
> > > vendor event with the new baudrate. The event is received and decoded
> > > after the baudrate change of the host port.
> > > 
> > > Identify the 'unused' event when it is received and don't add it to
> > > the queue of RX frames.
> > > 
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> >
> > ...
> >
> > Can you test by reverting this change "94d6671473924".
> 
> The issue is still reproducible.
> 
> > We need at least 15ms minimum delay for the soc to change its baud rate and
> > respond to the with command complete event.
> 
> The baudrate change has clearly been successful when the problem is
> observed, since the host receives the vendor event with the new
> baudrate.

I forgot to mention this earlier: the controller doesn't send a
command complete event for the command, or at least not a correct
one.

That's the data that is received:

04 0e 04 01 00 00 00
            ~~ ~~

This is *a* command complete event, but the opcode is 0x0000 instead
of the earlier command. The same happens for the firmware
download/read version command, which is the reason why the command
complete injection mess
(https://lore.kernel.org/patchwork/patch/1027955/) is needed in one
way or another.

I wished Qualcomm FW developers would get their act together and:

- send actual command complete events
- acknowledge a baudrate change request using the current baudrate
  like Broadcom and Intel chips apparently do

this would have saved countless hours of debugging and implementing
quirky workarounds ...

Maybe there is hope for future chips (hint, hint)?
