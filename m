Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C454FC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9097C21773
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558606801;
	bh=GNInhe6VPv5fombvzpUL3THNY7dma3FuzHTYbDtjP6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nbgDO1PEckLzwzpScRcuN7j/ORmiLaajUs1WPeYP9QMjONHf6UGDNCg0EMCn/joax
	 lbTvRAWloGKkk8KUGb+7xqiTo4R9Z8yrCNjnFmJanjIjiofciqydWvt8nzCxtxhKJT
	 JgO4b1xBh34ugejS2EN/DlslrwAQrbm0lI/wa7Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfEWKUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:20:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfEWKUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:20:00 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 559862133D;
        Thu, 23 May 2019 10:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558606799;
        bh=GNInhe6VPv5fombvzpUL3THNY7dma3FuzHTYbDtjP6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e895LSjjeSNnD/eybI4cwM0yOCD5it0EtRNNciV8cg1Z5l8taqfhijMy2MuLrpRru
         I8j2Z3rEW41aX+EfrcsofnLJ3hqnYj3FoeEljrBMQHAFCSpVrtCwMog2qsxXg5Hian
         Bhf9Vp397y//mfiXBkI5yqmpc+7q3MlLqXwIYUxo=
Date:   Thu, 23 May 2019 12:19:57 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     TonyWWang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>,
        "lenb@kernel.org" <lenb@kernel.org>,
        David Wang <DavidWang@zhaoxin.com>,
        "Cooper Yan(BJ-RD)" <CooperYan@zhaoxin.com>,
        "Qiyuan Wang(BJ-RD)" <QiyuanWang@zhaoxin.com>,
        "Herry Yang(BJ-RD)" <HerryYang@zhaoxin.com>
Subject: Re: [PATCH v1 1/3] x86/cpu: Create Zhaoxin processors architecture
 support file
Message-ID: <20190523101957.GB11016@kroah.com>
References: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3b31fab04814140b1feb13887c4aa2a@zhaoxin.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 23, 2019 at 10:10:52AM +0000, TonyWWang-oc wrote:
> --- /dev/null
> +++ b/arch/x86/kernel/cpu/zhaoxin.c
> @@ -0,0 +1,178 @@
> +// SPDX-License-Identifier: GPL-2.0

Nice, but:

> +/*
> + * Zhaoxin Processor Support for Linux
> + *
> + * Copyright (c) 2019 Shanghai Zhaoxin Semiconductor Co., Ltd.
> + *
> + * Author: David Wang <davidwang@zhaoxin.com>
> + *
> + * This file is licensed under the terms of the GNU General
> + * License v2.0 or later. See file COPYING for details.

That contridicts the first line of the file :(

Please sort this out with your lawyers and resend it corrected.

Also, gpl "boilerplate" text like this does not need to be in the file
if you just include the spdx line.

thanks,

greg k-h
