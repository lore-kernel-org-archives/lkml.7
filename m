Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71501C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 472CE206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 16:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732068AbfDJQbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 12:31:32 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57674 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730167AbfDJQbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 12:31:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3DE0B374;
        Wed, 10 Apr 2019 09:31:31 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B3D93F59C;
        Wed, 10 Apr 2019 09:31:29 -0700 (PDT)
Date:   Wed, 10 Apr 2019 17:31:27 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Steven Price <steven.price@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: check return value of idr_find
Message-ID: <20190410163127.GG3952@e107155-lin>
References: <225abd6e-4551-213d-367b-93d938789188@arm.com>
 <20190325204823.5428-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190325204823.5428-1-kjlu@umn.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2019 at 03:48:22PM -0500, Kangjie Lu wrote:

You should mark this v2 id you changed any code or commit message or
added any tags. Just FYI for future.

> Thanks for Steven Price's review of this patch. In the current code,
> idr_find won't return NULL because the SCMI_PROTOCOL_BASE id must 
> exist. However, it might return NULL in the future code if the check
> is on another node while processing the children in subsequent calls 
> to scmi_mbox_chan_setup().

I don't understand the reference here to future code here. If you have
out of tree code that results in such a scenario, please share or
provide the details on that.

As I mentioned in previous mail, I would bail out much earlier if
SCMI_PROTOCOL_BASE is not allocated IDR and not reach to this point.
We continue even if scmi_create_protocol_device fails for few child
devices.

--
Regards,
Sudeep
