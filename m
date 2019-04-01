Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798EC10F05
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F60620830
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 08:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GlM2Khll";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="aPZd9qK5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732142AbfDAITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 04:19:02 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54474 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731919AbfDAITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 04:19:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 83E9C611BE; Mon,  1 Apr 2019 08:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106740;
        bh=IFqV9cJsn6EXiiv4KICZogj/+1WSre0bJ66q0Fl80Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GlM2KhllDReIarOwkvdSUgBaFUso/FUHzqElsE37m64gIoozNZUk/lsDkooRuqSIa
         58lVv6aKaoxMyW4jpzo+042F2RwzE+AoWvRzFYLlDIFCroiJSOU2J2gFYvB+rXF//v
         gsBsvw9DgM8c78bBx6IbjJOvxGpybPMmPezOwTpY=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 44B26608FF;
        Mon,  1 Apr 2019 08:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1554106726;
        bh=IFqV9cJsn6EXiiv4KICZogj/+1WSre0bJ66q0Fl80Kc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aPZd9qK5JmeDIuzBScsSYDW901d6/r7Sg6SehK5whojtxd1Kfep5ioxXucy8YcXYB
         UE1qoFFEAZgf2NVsFCLcyxuBQ2++5E5fwWPHpA7cNEuezCDm++nFGxNgr80XXZqkAV
         A4AlW5o9XQ+hVNoYWeKTs5Xt3KG772KqDqinbFso=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Apr 2019 13:48:23 +0530
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hemantg <hemantg@codeaurora.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_qca: wcn3990: Drop baudrate change
 vendor event
In-Reply-To: <c985a6712f91930d7c710ca4abb42e80@codeaurora.org>
References: <20190307004041.38059-1-mka@chromium.org>
 <20190307004041.38059-3-mka@chromium.org>
 <ff905fac1e57bcca78c74f1bc3349645@codeaurora.org>
 <20190307182009.GB138592@google.com> <20190307233039.GA69116@google.com>
 <c985a6712f91930d7c710ca4abb42e80@codeaurora.org>
Message-ID: <a03acbdc6bfad172fdd65f428ffbe4cf@codeaurora.org>
X-Sender: bgodavar@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2019-04-01 13:29, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> Sorry for the late reply i was on vacation.
> 
> On 2019-03-08 05:00, Matthias Kaehlcke wrote:
>> On Thu, Mar 07, 2019 at 10:20:09AM -0800, Matthias Kaehlcke wrote:
>>> Hi Balakrishna,
>>> 
>>> On Thu, Mar 07, 2019 at 10:35:08AM +0530, Balakrishna Godavarthi 
>>> wrote:
>>> > hi Matthias,
>>> >
>>> > On 2019-03-07 06:10, Matthias Kaehlcke wrote:
>>> > > Firmware download to the WCN3990 often fails with a 'TLV response size
>>> > > mismatch' error:
>>> > >
>>> > > [  133.064659] Bluetooth: hci0: setting up wcn3990
>>> > > [  133.489150] Bluetooth: hci0: QCA controller version 0x02140201
>>> > > [  133.495245] Bluetooth: hci0: QCA Downloading qca/crbtfw21.tlv
>>> > > [  133.507214] Bluetooth: hci0: QCA TLV response size mismatch
>>> > > [  133.513265] Bluetooth: hci0: QCA Failed to download patch (-84)
>>> > >
>>> > > This is caused by a vendor event that corresponds to an earlier command
>>> > > to change the baudrate. The event is not processed in the context of the
>>> > > baudrate change and later interpreted as response to the firmware
>>> > > download command (which is also a vendor command), but the driver
>>> > > detects
>>> > > that the event doesn't have the expected amount of associated data.
>>> > >
>>> > > More details:
>>> > >
>>> > > For the WCN3990 the vendor command for a baudrate change isn't sent as
>>> > > synchronous HCI command, because the controller sends the corresponding
>>> > > vendor event with the new baudrate. The event is received and decoded
>>> > > after the baudrate change of the host port.
>>> > >
>>> > > Identify the 'unused' event when it is received and don't add it to
>>> > > the queue of RX frames.
>>> > >
>>> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
>>> > > ---
>>> >
>>> > ...
>>> >
>>> > Can you test by reverting this change "94d6671473924".
>>> 
>>> The issue is still reproducible.
>>> 
>>> > We need at least 15ms minimum delay for the soc to change its baud rate and
>>> > respond to the with command complete event.
>>> 
>>> The baudrate change has clearly been successful when the problem is
>>> observed, since the host receives the vendor event with the new
>>> baudrate.
>> 
>> I forgot to mention this earlier: the controller doesn't send a
>> command complete event for the command, or at least not a correct
>> one.
>> 
>> That's the data that is received:
>> 
>> 04 0e 04 01 00 00 00
>>             ~~ ~~
>> 
> [Bala]: can you share me the command sent and event recevied.
>  I see that we receive a command complete event for the baud rate
> change command.
> 
> command sent: 01 48 fc 01 11
> vendor specific event: 04 ff 02 92 01
> command complete event: 04 0e 04 01 00 00 00.
> 
> 
> 
>> This is *a* command complete event, but the opcode is 0x0000 instead
>> of the earlier command. The same happens for the firmware
>> download/read version command, which is the reason why the command
>> complete injection mess
>> (https://lore.kernel.org/patchwork/patch/1027955/) is needed in one
>> way or another.
>> 
> [Bala]: fw download approach is different where we use
> __hci_cmd_sync() where as here we use hci_uart_tx_wakeup()
>         which directly calls the hci_uart_write_work(). so even we
> send an valid opcode or not for baudrate change will bot matter.
> 
[Bala]: i miss understood the comment. Yes your true. in the all vendor 
commands SoC responds with an 0x0000 opcode.

>> I wished Qualcomm FW developers would get their act together and:
>> 
>> - send actual command complete events :
>> - acknowledge a baudrate change request using the current baudrate
>>   like Broadcom and Intel chips apparently do
>> 
>> this would have saved countless hours of debugging and implementing
>> quirky workarounds ...
>> 
>> Maybe there is hope for future chips (hint, hint)?
> 
> [Bala]: will take this forward to the SoC teams.

-- 
Regards
Balakrishna.
