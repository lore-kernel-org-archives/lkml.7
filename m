Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D926C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B8121929
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 17:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QsbdQ7AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbfDARMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 13:12:07 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45816 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbfDARME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 13:12:04 -0400
Received: by mail-pf1-f194.google.com with SMTP id e24so4873148pfi.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2019 10:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HFIbZQ25f4RzvK0/BsFZbfNQa0GXntCHY2z9L/SWgJU=;
        b=QsbdQ7ADJEhzkoGPL3+/ra9c5lYN7tOF/Rhc0XBcCxSFoj++biSNDXYvh54PgXw1NQ
         Nuk0LNQJ0iAo14ZwMyVfsWf4b0OcHfbdPV/Ya4vca67LV85SIK/xRNWEb0FTZukPUxAR
         iepoSsLDVStcIR/vkbGXAwfnEEuPn4mfG9dBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HFIbZQ25f4RzvK0/BsFZbfNQa0GXntCHY2z9L/SWgJU=;
        b=gZkqZpxRT56J59ZkuuHYQVU/ZPB9nHXsk3oQUdIJp8rrN45jsqYbmTrYaKTxevG+zM
         prkiVYNGAgxumhLtBcapv/IZ2VMBBXi6423RcoO/+MNb36WKvd1omTLod+kVLzVOchws
         93apTrZr78ga7YH0umRO8Ms3tfpjCiDpdw/MUjVh9A283Wv0i0KEKAdLPwsUfuQyl/YJ
         YRZbsoSTC/2mM2coxP0lgK0gYC+VzCUfu/+Md+QagkZAfEAZdDZAmYIXeX9rwf3R/wUk
         eR+T6G1iWYsu1Ix6nS1LpljaDOzXpdf4ilhqCny24VKyVwxZ3EMznc8f6yoDKaRdUezR
         wQGQ==
X-Gm-Message-State: APjAAAV2Ngtc20an+9QCKh1ypqWSB1adCwK438JFNc3A48UYuCg3uMLW
        X1mPPBzwwTRkS7m+FrEASlzvXg==
X-Google-Smtp-Source: APXvYqxqySrCSoCUBIC5R3add1vmpekUcOQaNrYLLoDpK1yf1i/QvT6jL7sYKDYwmsDThgj6d82GVg==
X-Received: by 2002:a63:fa46:: with SMTP id g6mr6522937pgk.382.1554138723328;
        Mon, 01 Apr 2019 10:12:03 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id n22sm12979659pfa.51.2019.04.01.10.12.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 10:12:02 -0700 (PDT)
Date:   Mon, 1 Apr 2019 10:12:02 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
Message-ID: <20190401171202.GH112750@google.com>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
 <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
 <20190307182009.GB138592@google.com>
 <20190307233039.GA69116@google.com>
 <c985a6712f91930d7c710ca4abb42e80@codeaurora.org>
 <a03acbdc6bfad172fdd65f428ffbe4cf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a03acbdc6bfad172fdd65f428ffbe4cf@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 01, 2019 at 01:48:23PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-04-01 13:29, Balakrishna Godavarthi wrote:
> > Hi Matthias,
> > 
> > Sorry for the late reply i was on vacation.
> > 
> > On 2019-03-08 05:00, Matthias Kaehlcke wrote:
> > > On Thu, Mar 07, 2019 at 10:20:09AM -0800, Matthias Kaehlcke wrote:
> > > > Hi Balakrishna,
> > > > 
> > > > On Thu, Mar 07, 2019 at 10:35:08AM +0530, Balakrishna Godavarthi
> > > > wrote:
> > > > > hi Matthias,
> > > > >
> > > > > On 2019-03-07 06:10, Matthias Kaehlcke wrote:
> > > > > > Firmware download to the WCN3990 often fails with a 'TLV response size
> > > > > > mismatch' error:
> > > > > >
> > > > > > [  133.064659] Bluetooth: hci0: setting up wcn3990
> > > > > > [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
> > > > > > [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
> > > > > > [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
> > > > > > [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
> > > > > >
> > > > > > This is caused by a vendor event that corresponds to an earlier command
> > > > > > to change the baudrate. The event is not processed in the context of the
> > > > > > baudrate change and later interpreted as response to the firmware
> > > > > > download command (which is also a vendor command), but the driver
> > > > > > detects
> > > > > > that the event doesn't have the expected amount of associated data.
> > > > > >
> > > > > > More details:
> > > > > >
> > > > > > For the WCN3990 the vendor command for a baudrate change isn't sent as
> > > > > > synchronous HCI command, because the controller sends the corresponding
> > > > > > vendor event with the new baudrate. The event is received and decoded
> > > > > > after the baudrate change of the host port.
> > > > > >
> > > > > > Identify the 'unused' event when it is received and don't add it to
> > > > > > the queue of RX frames.
> > > > > >
> > > > > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > > > > ---
> > > > >
> > > > > ...
> > > > >
> > > > > Can you test by reverting this change "94d6671473924".
> > > > 
> > > > The issue is still reproducible.
> > > > 
> > > > > We need at least 15ms minimum delay for the soc to change its baud rate and
> > > > > respond to the with command complete event.
> > > > 
> > > > The baudrate change has clearly been successful when the problem is
> > > > observed, since the host receives the vendor event with the new
> > > > baudrate.
> > > 
> > > I forgot to mention this earlier: the controller doesn't send a
> > > command complete event for the command, or at least not a correct
> > > one.
> > > 
> > > That's the data that is received:
> > > 
> > > 04 0e 04 01 00 00 00
> > >             ~~ ~~
> > > 
> > [Bala]: can you share me the command sent and event recevied.
> >  I see that we receive a command complete event for the baud rate
> > change command.
> > 
> > command sent: 01 48 fc 01 11
> > vendor specific event: 04 ff 02 92 01
> > command complete event: 04 0e 04 01 00 00 00.
> > 
> > 
> > 
> > > This is *a* command complete event, but the opcode is 0x0000 instead
> > > of the earlier command. The same happens for the firmware
> > > download/read version command, which is the reason why the command
> > > complete injection mess
> > > (https://lore.kernel.org/patchwork/patch/1027955/) is needed in one
> > > way or another.
> > > 
> > [Bala]: fw download approach is different where we use
> > __hci_cmd_sync() where as here we use hci_uart_tx_wakeup()
> >         which directly calls the hci_uart_write_work(). so even we
> > send an valid opcode or not for baudrate change will bot matter.
> > 
> [Bala]: i miss understood the comment. Yes your true. in the all vendor
> commands SoC responds with an 0x0000 opcode.

And IIUC this is not compliant with the spec, or at least the BT core
expects the actual opcode to consider the command to be completed.
