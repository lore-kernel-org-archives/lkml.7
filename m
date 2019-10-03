Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B28C10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF4521783
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 14:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730158AbfJCO5k convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 10:57:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50271 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbfJCO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 10:57:40 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iG2Xy-00004q-J6
        for linux-kernel@vger.kernel.org; Thu, 03 Oct 2019 14:57:38 +0000
Received: by mail-pg1-f200.google.com with SMTP id z7so2139504pgk.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 07:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=W0SWomT5SY0yDSTtHUSDJc9LHcZaOyfwcQXgQs9p9z4=;
        b=pYkH9fwwoSXBo7fT5FfxZ9Ngk58OkMv54PMua7PqE6inJdbj31q3WooILFQy3wHnsW
         wG9Mj9zcYr069Tiro50jiStNjZcSzUb4Pui93QeoC5DPhmwmNWxD2MdpGXYA7kWDI2IW
         FQ4C/0oGw6HZ5waD3/HtlWn2JtWVJjaUYVCUVAI+qkU85R7fnBO75HzguncHN2vGrNAm
         v3xk9P/0oUUYoOO5SYSTs68nIeqmFVzreNZpkjlJ1ID5ADWeTd/IHJN2LoT9AneF1/A8
         FOuFRY5aARBryI8J2C7ej+s4//fgTJCBC1SvFx/DoRx93ZSNPksg/A9ZLXBjHTu02YFx
         cb5w==
X-Gm-Message-State: APjAAAWqgR2NySx3vG7F8NQeqqyka8aisZt4/9ESMU4ASvSeQFTIzh+P
        1cZM2E0votcc+wVDsrOGf+LL4mqCYUTFz8HOIl8aPLnY+KYqm/3cbmKPbzdXyo1yl9DeuDuk0TS
        YDsvY/RLOUr2ocQxTksVnMga+MU/y9974Gg/72Gfvxg==
X-Received: by 2002:a62:2b4d:: with SMTP id r74mr11513014pfr.30.1570114657200;
        Thu, 03 Oct 2019 07:57:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqygWXjUMR1GW5JvI0IYOkgqCblsfxeBPVrb6mAoWUgub2AC/J9+rFS9punoE4zVZDk2PoplcA==
X-Received: by 2002:a62:2b4d:: with SMTP id r74mr11512986pfr.30.1570114656861;
        Thu, 03 Oct 2019 07:57:36 -0700 (PDT)
Received: from 2001-b011-380f-3c42-0c4b-be14-8894-cacf.dynamic-ip6.hinet.net (2001-b011-380f-3c42-0c4b-be14-8894-cacf.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:c4b:be14:8894:cacf])
        by smtp.gmail.com with ESMTPSA id p66sm3205097pfg.127.2019.10.03.07.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 07:57:36 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH] Revert "usb: Avoid unnecessary LPM enabling and disabling
 during suspend and resume"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1910031024410.1797-100000@iolanthe.rowland.org>
Date:   Thu, 3 Oct 2019 22:57:33 +0800
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <E833DEE2-ADE1-436C-A342-427EA460F276@canonical.com>
References: <Pine.LNX.4.44L0.1910031024410.1797-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 22:26, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Thu, 3 Oct 2019, Kai-Heng Feng wrote:
> 
>>> On Oct 2, 2019, at 23:47, Alan Stern <stern@rowland.harvard.edu> wrote:
>>> 
>>> On Wed, 2 Oct 2019, Kai-Heng Feng wrote:
>>> 
>>>> This reverts commit d590c23111505635e1beb01006612971e5ede8aa.
>>>> 
>>>> Dell WD15 dock has a topology like this:
>>>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
>>>>   |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>>>           |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>>>> 
>>>> Their IDs:
>>>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>>>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp.
>>>> Bus 004 Device 004: ID 0bda:8153 Realtek Semiconductor Corp.
>>>> 
>>>> Ethernet cannot be detected after plugging ethernet cable to the dock,
>>>> the hub and roothub get runtime resumed and runtime suspended
>>>> immediately:
>>>> ...
>>> 
>>>> After some trial and errors, the issue goes away if LPM on the SMSC hub
>>>> is disabled. Digging further, enabling and disabling LPM during runtime
>>>> resume and runtime suspend respectively can solve the issue.
>>>> 
>>>> So bring back the old LPM behavior, which the SMSC hub inside Dell WD15
>>>> depends on.
>>>> 
>>>> Fixes: d590c2311150 ("usb: Avoid unnecessary LPM enabling and disabling during suspend and resume")
>>>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> 
>>> Maybe it would be better to have a VID/PID-specific quirk for this?
>> 
>> Re-reading the spec, I think we need some clarification:
>> "If the value is 3, then host software wants to selectively suspend the
>> device connected to this port. The hub shall transition the link to U3
>> from any of the other U states using allowed link state transitions.
>> If the port is not already in the U0 state, then it shall transition the
>> port to the U0 state and then initiate the transition to U3."
>> 
>> The phrase "then it shall transition the port to the U0 state" what does "it" here refer to?
>> Is it the hub or the software?
>> If it's the former then it's indeed a buggy hub, but if it's the latter I think reverting the commit is the right thing to do.
> 
> In my opinion, "it" here refers to the hub.  This is because of the 
> parallel construction with the preceding sentence ("... shall 
> transition the link/port"), which indicates that the subjects should be 
> the same.

Hmm, okay, this is ambiguous to a non-native speaker like me.
I'll use a quirk instead.

Kai-Heng

> 
> Alan Stern
> 

