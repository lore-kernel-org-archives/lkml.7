Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B61C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A283E2082C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbfDBKO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:14:28 -0400
Received: from foss.arm.com ([217.140.101.70]:47894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbfDBKO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:14:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA68E15AD;
        Tue,  2 Apr 2019 03:14:27 -0700 (PDT)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B32AA3F59C;
        Tue,  2 Apr 2019 03:14:26 -0700 (PDT)
Subject: Re: of_reserved_mem()/kexec interaction
To:     Roy Pledge <roy.pledge@nxp.com>
Cc:     Rob Herring <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <DB6PR0402MB2727C7111A5BDBB07F05E29886550@DB6PR0402MB2727.eurprd04.prod.outlook.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <f48b0010-a136-48a4-bfc7-7bbaf91b4da9@arm.com>
Date:   Tue, 2 Apr 2019 11:14:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <DB6PR0402MB2727C7111A5BDBB07F05E29886550@DB6PR0402MB2727.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roy,

On 01/04/2019 20:09, Roy Pledge wrote:
> I'm trying to understand if memory reserved in the device tree via the
> "reserved-memory" facility is preserved during a kexec system call,
> i.e., is the memory at the same location with the contents undisturbed
> when the new kernel starts?

If the reservation is a static-allocation (so the address appears in the DT) then the new
kernel should know this is reserved too, and not touch it.

If its a dynamic-allocation, the address isn't in the DT, so the new kernel can't know. It
will dynamically allocate a new reservation, which may be in a different place. If the
data didn't matter at the first-boot, it probably doesn't matter over subsequent kexec either.

As an outlier: the gic has some funny requirements around this. It needs to dynamically
allocate a page during first-boot that is preserved over kexec. It does this using
efi_mem_reserve_persistent().


Thanks,

James
