Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85960C43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49CC32077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfDZP0g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:26:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:39854 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726266AbfDZP0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:26:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 726E6AB7D;
        Fri, 26 Apr 2019 15:26:34 +0000 (UTC)
Date:   Fri, 26 Apr 2019 17:26:32 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
Message-ID: <20190426152632.GC3173@suse.de>
References: <1556290348.6132.6.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1556290348.6132.6.camel@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 10:52:28AM -0400, Qian Cai wrote:
> Applying some memory pressure would causes smartpqi offline even in today's
> linux-next. This can always be reproduced by a LTP test cases [1] or sometimes
> just compiling kernels.
> 
> Reverting the commit "iommu/amd: Set exclusion range correctly" fixed the issue.
> 
> [  213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0000 address=0x1000 flags=0x0000]
> [  213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> domain=0x0000 address=0x1800 flags=0x0000]
> [  233.362013] smartpqi 0000:23:00.0: controller is offline: status code 0x14803
> [  233.369359] smartpqi 0000:23:00.0: controller offline
> [  233.388915] print_req_error: I/O error, dev sdb, sector 3317352 flags 2000001
> [  233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result: hostbyte=0x01
> driverbyte=0x00
> [  233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=0x2a 2a 00 00 55 89 00 00 01
> 08 00
> [  233.389003] Write-error on swap-device (254:1:4474640)
> [  233.389015] Write-error on swap-device (254:1:2190776)
> [  233.389023] Write-error on swap-device (254:1:8351936)
> 
> [1] /opt/ltp/testcases/bin/mtest01 -p80 -w

I can't explain that, can you please boot with 'amd_iommu_dump' on the
kernel command line and send me dmesg after boot?

Thanks,

	Joerg
