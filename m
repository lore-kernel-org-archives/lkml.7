Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4B5C4740A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390D320679
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 08:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfJGIMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 04:12:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:26507 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbfJGIMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 04:12:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Oct 2019 01:11:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,265,1566889200"; 
   d="scan'208";a="196220046"
Received: from mattu-haswell.fi.intel.com (HELO [10.237.72.170]) ([10.237.72.170])
  by orsmga003.jf.intel.com with ESMTP; 07 Oct 2019 01:11:56 -0700
Subject: Re: [BISECTED] Suspend / USB broken on XPS 9370 + TB16
To:     Carlo Caione <carlo.caione@gmail.com>, linux-kernel@vger.kernel.org
Cc:     andrew.smirnov@gmail.com, rrangel@chromium.org,
        gregkh@linuxfoundation.org, kamal@canonical.com,
        khalid.elmously@canonical.com
References: <2f2f62bc-558f-70d1-44bf-a95334453f8a@gmail.com>
From:   Mathias Nyman <mathias.nyman@linux.intel.com>
Message-ID: <294a9515-962a-d64b-c113-b73e9fe85fa8@linux.intel.com>
Date:   Mon, 7 Oct 2019 11:13:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2f2f62bc-558f-70d1-44bf-a95334453f8a@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.10.2019 10.21, Carlo Caione wrote:
> Hi,
> I bisected an issue down to commit f7fac17ca925 "xhci: Convert xhci_handshake() to use readl_poll_timeout_atomic()".
> 
> Setup:
> XPS 9370 + Thunderbolt dock Dell TB16
> 
> Issue:
> The laptop is unable to go to sleep. It never really goes to sleep and after a few seconds the USB dies.
> 
> Log:
> https://termbin.com/icix
> 
> Cheers!
> 

Does the below patch help?  Greg just applied it to his usb-linus branch.

ac343366846a xhci: Increase STS_SAVE timeout in xhci_suspend()
Link: https://lore.kernel.org/r/1570190373-30684-8-git-send-email-mathias.nyman@linux.intel.com

-Mathias
