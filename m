Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD25C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE90220659
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 11:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbfGSLDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 07:03:24 -0400
Received: from foss.arm.com ([217.140.110.172]:41940 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfGSLDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:03:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1676337;
        Fri, 19 Jul 2019 04:03:23 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D5BE23F59C;
        Fri, 19 Jul 2019 04:03:22 -0700 (PDT)
Date:   Fri, 19 Jul 2019 12:03:20 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Bo Zhang <bozhang.zhang@broadcom.com>,
        Volodymyr Babchuk <volodymyr_babchuk@epam.com>
Subject: Re: [PATCH 07/11] firmware: arm_scmi: Add support for asynchronous
 commands and delayed response
Message-ID: <20190719110320.GC18022@e107155-lin>
References: <20190708154730.16643-1-sudeep.holla@arm.com>
 <20190708154730.16643-8-sudeep.holla@arm.com>
 <CA+-6iNyFToC8QSf042OcqvAStvaF=voy_ohayvQBVCppgtyD7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+-6iNyFToC8QSf042OcqvAStvaF=voy_ohayvQBVCppgtyD7A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 05:38:06PM -0400, Jim Quinlan wrote:
> Hi Sudeep,
> 
> Just a comment in general.  The asynchronous commands you are
> implementing are not really asynchronous to the caller.

Yes, but as per specification, the idea is to release the channel for
other communication.

> Yes it is is "async" at the low level, but there is no way to use
> scmi_do_xfer() or scmi_do_xfer_with_response() and have the calling
> thread be able to continue on in parallel with the command being
> processed by the platform. This will limit the types of applications
> that can use SCMI (perhaps this is intentional).

Yes indeed, it's intentional and async is applicable for channel usage.

> I was hoping that true async would be possible, and that the caller
> could also register a callback function to be invoked when the command
> was completed.  Is this something that may be added in the future?

This is how notifications are designed and must work. I would suggest
to use notifications instead. Do you see any issues with that approach ?

> It does overlap with notifications, because with those messages you
> will need some kind of callback or handler thread.
>

Ah you do mention about overlap. I am replying as I read, sorry for that.
Anyways, let me know if we can just use notifications. Also the current
sync users(mainly clocks and sensors), may need even change in Linux
infrastructure if we need to make it work in notification style.

It would be good to know the use case you are referring.

> BTW, if scmi_do_xfer_with_response()  returns --ETIMEDOUT the caller
> has no way of knowing whether it was the command ack timeout or the
> command execution timeout.
>
Yes, I did think about this but I left it as is thinking it may not be
important. Do you think that makes a difference ? I am fine to change
if there are users that needs to handle the difference.

--
Regards,
Sudeep
