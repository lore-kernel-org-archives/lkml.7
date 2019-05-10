Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771DCC04AB3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5453520896
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 12:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbfEJMSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 08:18:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:32840 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727071AbfEJMSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 08:18:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5306AF96;
        Fri, 10 May 2019 12:18:34 +0000 (UTC)
Date:   Fri, 10 May 2019 14:18:33 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        <linux-i2c@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 3/3] i2c: i801: avoid panic if ioreamp fails
Message-ID: <20190510141833.2cb3d108@endymion>
In-Reply-To: <164bb498-35dc-b226-4adb-3d743f4790a1@huawei.com>
References: <20190510030320.109154-1-wangkefeng.wang@huawei.com>
        <20190510030320.109154-3-wangkefeng.wang@huawei.com>
        <20190510100955.497a1a57@endymion>
        <164bb498-35dc-b226-4adb-3d743f4790a1@huawei.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 May 2019 17:35:46 +0800, Kefeng Wang wrote:
> On 2019/5/10 16:09, Jean Delvare wrote:
> > We don't need this anyway. The comment says it can't fail, so why
> > bother checking for a condition which will never happen?  
> 
> The ioremap could fails due to no memory, our inner test robot(enable FAULT_INJECTION)
> 
> find this issue.

The code only runs on x86 where this specific memory segment is
standardized for the purpose. That's how we know it "can't fail".

That being said, maybe it could fail for other reasons (internal kernel
bug, or bogus BIOS maybe), and I don't care adding the check
anyway, as this code path is not performance critical.

-- 
Jean Delvare
SUSE L3 Support
