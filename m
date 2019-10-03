Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A9EC32792
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB74215EA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfJCLzP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:55:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729671AbfJCLzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:55:15 -0400
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1iFzhQ-0002NX-I0
        for linux-kernel@vger.kernel.org; Thu, 03 Oct 2019 11:55:12 +0000
Received: by mail-pf1-f197.google.com with SMTP id z4so1965009pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zkgjaNihidQzev45YtvaiCCwUzaOEPHNobyPBYPD3js=;
        b=expl3NZ2m+Yz7TpPAI7Y2jq3GRW+0vi37snWasOt1ZBhrnxaXRL7jLd0qMvK3FDBHc
         3jJe5iG/M3oxsypClxkPyAncHCQc2fIOBfPzNgLDUkDpHWAY3192QqyAJORU2LJ+wByt
         mhFtEpZyN9YVGqyX6McQm0soy0bB3aGAJcqNmHYwCNBd0gVr419o8RfiyUC3sxzPPVmX
         LJ0FpAvpwXXBI/n/42YSqtofsT4MzE3C+riepGiy8UofbAHxFtSs31g5yKm6uquxL51d
         5zMUqx52K8TdsjBJn4rFYPiD90rex94kTRDtcguqyeYLUnefA+YbTao1JIU4TnwhtVFk
         wSDw==
X-Gm-Message-State: APjAAAVBJqjAsRrlk97VaxwIDDRoWjQVLC/x+XoRG1EVMI0yTIvBFVlo
        vd44wLockbvc1Bq24TQRjN5FHBjKz1kvbkxI3eEYAg1+b9abD19vcmCpUaKHGnNytbwbbLQf0xW
        HxhRW1xXFNV920P0c94QIMkvrLnoInx3MohcsCX9CXQ==
X-Received: by 2002:a63:ff14:: with SMTP id k20mr6054153pgi.302.1570103711114;
        Thu, 03 Oct 2019 04:55:11 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy8bF/GDPJnP/8mvPp9hx1ElP0npS/Ztseid8l2upqoO+fPdPwoPU9GSCA+STVkngzsQhIypQ==
X-Received: by 2002:a63:ff14:: with SMTP id k20mr6054122pgi.302.1570103710722;
        Thu, 03 Oct 2019 04:55:10 -0700 (PDT)
Received: from 2001-b011-380f-3c42-0c4b-be14-8894-cacf.dynamic-ip6.hinet.net (2001-b011-380f-3c42-0c4b-be14-8894-cacf.dynamic-ip6.hinet.net. [2001:b011:380f:3c42:c4b:be14:8894:cacf])
        by smtp.gmail.com with ESMTPSA id j128sm3618554pfg.51.2019.10.03.04.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Oct 2019 04:55:10 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.18\))
Subject: Re: [PATCH] Revert "usb: Avoid unnecessary LPM enabling and disabling
 during suspend and resume"
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <Pine.LNX.4.44L0.1910021146260.1552-100000@iolanthe.rowland.org>
Date:   Thu, 3 Oct 2019 19:55:06 +0800
Cc:     mathias.nyman@intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <123BCB7F-5ABA-4DDD-9599-46D3240903F6@canonical.com>
References: <Pine.LNX.4.44L0.1910021146260.1552-100000@iolanthe.rowland.org>
To:     Alan Stern <stern@rowland.harvard.edu>
X-Mailer: Apple Mail (2.3594.4.18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 2, 2019, at 23:47, Alan Stern <stern@rowland.harvard.edu> wrote:
> 
> On Wed, 2 Oct 2019, Kai-Heng Feng wrote:
> 
>> This reverts commit d590c23111505635e1beb01006612971e5ede8aa.
>> 
>> Dell WD15 dock has a topology like this:
>> /:  Bus 04.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/2p, 10000M
>>    |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/7p, 5000M
>>            |__ Port 2: Dev 3, If 0, Class=Vendor Specific Class, Driver=r8152, 5000M
>> 
>> Their IDs:
>> Bus 004 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
>> Bus 004 Device 002: ID 0424:5537 Standard Microsystems Corp.
>> Bus 004 Device 004: ID 0bda:8153 Realtek Semiconductor Corp.
>> 
>> Ethernet cannot be detected after plugging ethernet cable to the dock,
>> the hub and roothub get runtime resumed and runtime suspended
>> immediately:
>> ...
> 
>> After some trial and errors, the issue goes away if LPM on the SMSC hub
>> is disabled. Digging further, enabling and disabling LPM during runtime
>> resume and runtime suspend respectively can solve the issue.
>> 
>> So bring back the old LPM behavior, which the SMSC hub inside Dell WD15
>> depends on.
>> 
>> Fixes: d590c2311150 ("usb: Avoid unnecessary LPM enabling and disabling during suspend and resume")
>> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> 
> Maybe it would be better to have a VID/PID-specific quirk for this?

Re-reading the spec, I think we need some clarification:
"If the value is 3, then host software wants to selectively suspend the
device connected to this port. The hub shall transition the link to U3
from any of the other U states using allowed link state transitions.
If the port is not already in the U0 state, then it shall transition the
port to the U0 state and then initiate the transition to U3."

The phrase "then it shall transition the port to the U0 state" what does "it" here refer to?
Is it the hub or the software?
If it's the former then it's indeed a buggy hub, but if it's the latter I think reverting the commit is the right thing to do.

Kai-Heng

> 
> Alan Stern
> 

