Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22236C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 020C320650
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 15:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390429AbfIFPRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 11:17:44 -0400
Received: from foss.arm.com ([217.140.110.172]:57948 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbfIFPRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 11:17:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211D71576;
        Fri,  6 Sep 2019 08:17:43 -0700 (PDT)
Received: from [10.1.196.105] (unknown [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C75063F59C;
        Fri,  6 Sep 2019 08:17:40 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
Subject: Re: [PATCH v3 04/17] arm64, hibernate: rename dst to page in
 create_safe_exec_page
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     jmorris@namei.org, sashal@kernel.org, ebiederm@xmission.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, marc.zyngier@arm.com,
        vladimir.murzin@arm.com, matthias.bgg@gmail.com,
        bhsharma@redhat.com, linux-mm@kvack.org, mark.rutland@arm.com
References: <20190821183204.23576-1-pasha.tatashin@soleen.com>
 <20190821183204.23576-5-pasha.tatashin@soleen.com>
Message-ID: <2e826560-4005-fa16-8bbb-fc0e25763dcc@arm.com>
Date:   Fri, 6 Sep 2019 16:17:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190821183204.23576-5-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 21/08/2019 19:31, Pavel Tatashin wrote:
> create_safe_exec_page() allocates a safe page and maps it at a
> specific location, also this function returns the physical address
> of newly allocated page.
> 
> The destination VA, and PA are specified in arguments: dst_addr,
> phys_dst_addr
> 
> However, within the function it uses "dst" which has unsigned long
> type, but is actually a pointers in the current virtual space. This
> is confusing to read.

The type? There are plenty of places in the kernel that an unsigned-long is actually a
pointer. This isn't unusual.


> Rename dst to more appropriate page (page that is created), and also
> change its time to "void *"

If you think its clearer,
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
