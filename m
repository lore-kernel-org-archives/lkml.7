Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FCCC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF35D20842
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 10:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbfHLKc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 06:32:57 -0400
Received: from foss.arm.com ([217.140.110.172]:47872 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfHLKc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 06:32:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 53F7315AB;
        Mon, 12 Aug 2019 03:32:54 -0700 (PDT)
Received: from e107155-lin (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A1D193F706;
        Mon, 12 Aug 2019 03:32:53 -0700 (PDT)
Date:   Mon, 12 Aug 2019 11:32:48 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] firmware: arm_scmi: Eliminate local db variable in
 SCMI_PERF_FC_RING_DB
Message-ID: <20190812103246.GA28585@e107155-lin>
References: <20190810044910.114015-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190810044910.114015-1-natechancellor@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2019 at 09:49:10PM -0700, Nathan Chancellor wrote:
> clang warns four times:
>
> drivers/firmware/arm_scmi/perf.c:320:24: warning: variable 'db' is
> uninitialized when used within its own initialization [-Wuninitialized]
>                 SCMI_PERF_FC_RING_DB(db, 64);
>                 ~~~~~~~~~~~~~~~~~~~~~^~~~~~~
> drivers/firmware/arm_scmi/perf.c:300:31: note: expanded from macro
> 'SCMI_PERF_FC_RING_DB'
>         struct scmi_fc_db_info *db = doorbell;          \
>                                 ~~   ^~~~~~~~
>
> This happens because the doorbell identifier becomes db after
> preprocessing:
>
>         if (db->width == 1)
>                 do {
>                         u8 val = 0;
>                         struct scmi_fc_db_info *db = db;
>                         if (db->mask)
>                                 val = ioread8(db->addr) & db->mask;
>                         iowrite8((u8)db->set | val, db->addr);
>                 } while (0);
>
> We could swap the doorbell and db identifiers within the macro and that
> would resolve the issue; however, there doesn't appear to be a good
> reason for having two copies of the same variable. Eliminate the one in
> the do while loop to prevent this warning and make the code clearer.
>

I originally had exactly what we will after this patch applied. I think
one of the tool complained about argument 'db' reused in the macro
might have possible side-effects. That's the reason I moved it. I will
dig it up and fold this in the original patch as before.

--
Regards,
Sudeep
