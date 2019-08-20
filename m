Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F7AC3A589
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F02CE214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 14:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566311498;
	bh=q6ApkqrORc0Qj1HNl3Ml+CcXr6NCqdWtGJ0QH0Ets6Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O0FMcEOkpBuCt/4+2PV6EcDFeaOkMtWo8feKrblpCZozhvG3u+Ch41yx1131QZrKs
	 3oD89uS6EU/ZgE6gyj9xPjlmwnqv0ZBlN1yj5m7pT1EwywCaxw8PHHfBqy8eMxzgUw
	 21mssHfb9/nvxXMvBJTHfkndq+xKR2W1uM7Na3QA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730174AbfHTObg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Aug 2019 10:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:37262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728993AbfHTObg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Aug 2019 10:31:36 -0400
Received: from localhost (unknown [12.166.174.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B751A20673;
        Tue, 20 Aug 2019 14:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566311495;
        bh=q6ApkqrORc0Qj1HNl3Ml+CcXr6NCqdWtGJ0QH0Ets6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IZsPdsj64+vKrGtB/bwng7b12mo+kcvukl54znKMByUPPLfmRpo8QNT5SMfSkHGhd
         a2bdNs6sxIxh7o5IqlLZSXMFy9ZZySGL9LxndASOLJDNk1Qk24VUv3n24DusXsKkqS
         s3pnTIN4ip4yzvRHXR6vi2UtVEQ29QgRNfpReAjM=
Date:   Tue, 20 Aug 2019 07:31:35 -0700
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     zhangfei <zhangfei.gao@linaro.org>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-accelerators@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Kenneth Lee <liguozhu@hisilicon.com>,
        Zaibo Xu <xuzaibo@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 2/2] uacce: add uacce module
Message-ID: <20190820143135.GA1536@kroah.com>
References: <1565775265-21212-1-git-send-email-zhangfei.gao@linaro.org>
 <1565775265-21212-3-git-send-email-zhangfei.gao@linaro.org>
 <20190815141225.GC23267@kroah.com>
 <5d5a6757.1c69fb81.e0678.2ab2SMTPIN_ADDED_BROKEN@mx.google.com>
 <20190819102250.GA2030@kroah.com>
 <350c937f-faee-f74a-ad76-03532c8648bd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <350c937f-faee-f74a-ad76-03532c8648bd@linaro.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 08:38:46PM +0800, zhangfei wrote:
> 
> 
> On 2019/8/19 下午6:22, Greg Kroah-Hartman wrote:
> > On Mon, Aug 19, 2019 at 05:09:23PM +0800, zhangfei.gao@foxmail.com wrote:
> > > Hi, Greg
> > > 
> > > Thanks for your kind suggestion.
> > > 
> > > On 2019/8/15 下午10:12, Greg Kroah-Hartman wrote:
> > > > On Wed, Aug 14, 2019 at 05:34:25PM +0800, Zhangfei Gao wrote:
> > > > > diff --git a/include/uapi/misc/uacce.h b/include/uapi/misc/uacce.h
> > > > > new file mode 100644
> > > > > index 0000000..44a0a5d
> > > > > --- /dev/null
> > > > > +++ b/include/uapi/misc/uacce.h
> > > > > @@ -0,0 +1,44 @@
> > > > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > > > +#ifndef _UAPIUUACCE_H
> > > > > +#define _UAPIUUACCE_H
> > > > > +
> > > > > +#include <linux/types.h>
> > > > > +#include <linux/ioctl.h>
> > > > > +
> > > > > +#define UACCE_CLASS_NAME	"uacce"
> > > > Why is this in a uapi file?
> > > User app need get attribute from /sys/class,
> > > For example: /sys/class/uacce/hisi_zip-0/xxx
> > > UACCE_CLASS_NAME here tells app which subsystem to open,
> > > /sys/class/subsystem/
> > But that never comes from a uapi file.  No other subsystem does this.
> OK, got it
> Maybe the entry info can come from Documentation/ABI/entries

Yes it can, we now have a tool in the tree that automatically parses
those entries and outputs it in a variety of different formats.

thanks,

greg k-h
