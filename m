Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D0AC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF29F206BB
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 03:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbfH0DQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 23:16:37 -0400
Received: from mail.scoopta.ninja ([198.58.106.30]:58198 "EHLO
        mail.scoopta.ninja" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728406AbfH0DQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 23:16:37 -0400
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2600:1700:4810:f9ef:0:0:0:256 (EHLO [IPv6:2600:1700:4810:f9ef::256]) ([2600:1700:4810:f9ef:0:0:0:256])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -1014213224;
          Mon, 26 Aug 2019 20:16:36 -0700 (PDT)
Subject: Re: NVME timeout causing system hangs
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <3a3b2436-b6e0-1504-fe69-756380f373cc@scoopta.email>
 <20190822172856.GA15785@localhost.localdomain>
From:   Ashton Holmes <root@scoopta.email>
Message-ID: <88a455fe-6c7f-6269-363d-ea7362280ea0@scoopta.email>
Date:   Mon, 26 Aug 2019 20:16:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
In-Reply-To: <20190822172856.GA15785@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tried looking around for the firmware online but couldn't find it, 
contacting adata ended up dead ending me, they said I can't find it 
because there hasn't ever been an firmware updates for this drive and am 
recommending I RMA it. Is there anything I can do to further 
troubleshoot this and make sure it is/isn't a hardware issue before I 
RMA it?

On 8/22/19 10:28 AM, Keith Busch wrote:
> On Mon, Aug 19, 2019 at 04:33:45PM -0700, Ashton Holmes wrote:
>> When playing certain games on my PC dmesg will start spitting out NVME
>> timeout messages, this eventually results in BTRFS throwing errors and
>> remounting itself as read only. The drive passes smart's health check and
>> works fine when not playing games. The really weird part is this will happen
>> even if the game I'm playing isn't installed on that drive. I wanted to
>> bisect this but it happens on every kernel version I've tried. I've attached
>> my dmesg log. This was originally reported here
>> https://bugzilla.kernel.org/show_bug.cgi?id=202633 but no response was ever
>> given. In that report I state that 4.19.24 for whatever reason doesn't
>> trigger this however that doesn't seem to be the case anymore. I've updated
>> my UEFI since then, I wouldn't expect that to make a difference but I'm not
>> sure what else would have changed that.
> This really looks like your nvme controller has gotten itself in an
> unresponsive state: it is not responding to IO, admin, or reset
> requests.
>
> The only recommendation I have at the moment is to verify you have the
> most current firmware from your vendor installed on this controller,
> and update if not.
>
>   
>
>> [  170.678837] nvme nvme0: I/O 128 QID 2 timeout, aborting
>> [  170.678845] nvme nvme0: I/O 129 QID 2 timeout, aborting
>> [  170.678850] nvme nvme0: I/O 167 QID 2 timeout, aborting
>> [  170.678853] nvme nvme0: I/O 168 QID 2 timeout, aborting
>> [  170.678856] nvme nvme0: I/O 169 QID 2 timeout, aborting
>> [  201.657527] nvme nvme0: I/O 128 QID 2 timeout, reset controller
>> [  232.372876] nvme nvme0: I/O 8 QID 0 timeout, reset controller
>> [  323.643688] nvme nvme0: Device not ready; aborting reset
>> [  323.675893] print_req_error: I/O error, dev nvme0n1, sector 1088653384 flags 80700
>> [  323.675902] print_req_error: I/O error, dev nvme0n1, sector 1001346664 flags 80700
>> [  323.675915] print_req_error: I/O error, dev nvme0n1, sector 1088646984 flags 84700
>> [  323.675920] print_req_error: I/O error, dev nvme0n1, sector 1088647240 flags 84700
>> [  323.675923] print_req_error: I/O error, dev nvme0n1, sector 1088647496 flags 84700
>> [  323.675927] print_req_error: I/O error, dev nvme0n1, sector 1088647752 flags 84700
>> [  323.675931] print_req_error: I/O error, dev nvme0n1, sector 1088648008 flags 84700
>> [  323.675935] print_req_error: I/O error, dev nvme0n1, sector 1088648264 flags 84700
>> [  323.675938] print_req_error: I/O error, dev nvme0n1, sector 1088648520 flags 84700
>> [  323.675942] print_req_error: I/O error, dev nvme0n1, sector 1088648776 flags 84700
>> [  323.675993] nvme nvme0: Abort status: 0x7
>> [  323.675995] nvme nvme0: Abort status: 0x7
>> [  323.675996] nvme nvme0: Abort status: 0x7
>> [  323.675998] nvme nvme0: Abort status: 0x7
>> [  323.675999] nvme nvme0: Abort status: 0x7
