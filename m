Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9556AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6357D2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 05:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EEr8ce3g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbfCTF5H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 01:57:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36580 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbfCTF5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 01:57:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id y13so1307185wrd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 22:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8J3l6nsfeLLgeNeOpczYaeOF9eruxsq7XesxtlUHTjY=;
        b=EEr8ce3g/wzfEf0tFl9aXrkFHkFvjJ4Z5HCeGGKaB3B+TyZV4HDRu0sjg0NApeVNHj
         6zrRoJEZN/KIlUt2BhNcrd5Kgt42fH4P6yDRB7w/F9Hw/gpDFLeuYJ1QelfO4ANGCsyw
         TvkJ3IBoEgZuu6ZkHxebVZKTqmnaYZ2l+1J9LhU9NjCLebP8B9WsfgVgoKXguzZbC3ET
         jLo1HFijzGjdxlnNu706VFj1YmxKYBzT8IzlEaEH0G0hEZBWWd8A7U91qOKqNkTBNnl/
         4vQ90F2WyOfKcKpPlJSspL0/7l3MFVgeQhFv7Q8Q01dc9ADi0X0bHxA49PPfVAtfZqeS
         fMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8J3l6nsfeLLgeNeOpczYaeOF9eruxsq7XesxtlUHTjY=;
        b=uGBcSsJJYQPEKBlV8BiyXOliI+HA/qmFmCyF/X9WK3s82Ku7abHCy70YkJdN5yBi/I
         sNv/dWiTYoZQV2iCFg/Rgq/U0paeIbkInzKuR1vjPMCeH95AQIK679FkQcQ72JgjIULy
         xdvC16zZ4FGy44L/xdLHWvLmcr8aiCSqouUrkZ8B24OGgf/Szhb4UjCPOy8TftzpP9N9
         QTToWD8pVWwTa3R1mEhWOi+4ut9ctaHRtcefVuQkQgRylvqdRt46CJbu4TS4CbdQpaF6
         543ccYeS+NYhhKVWUm666EaSCUO+GwROod/FeGYCg4z7yIuIu/FKWHbQM8JQEEoSW9uV
         YNGQ==
X-Gm-Message-State: APjAAAW7x4QoCtkdE3OTCtFR8w4OLBLHt/O11s+oqUzGWiHsCN+zFG1G
        xnXntZZXxRpVAlgCF97MWnzywZOLiqXqKTl0wRoppg==
X-Google-Smtp-Source: APXvYqx75A3V98r1dCppI6OTIc/uatEi2Aq16v/qsuXJp+w2oDe+SCjkC+CV/fsky08jf7v4/eZSCjs7pbirgNAxJ2s=
X-Received: by 2002:a5d:6883:: with SMTP id h3mr19798959wru.215.1553061425708;
 Tue, 19 Mar 2019 22:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
In-Reply-To: <1553059940-127038-1-git-send-email-fei.yang@intel.com>
From:   Josh Gao <jmgao@google.com>
Date:   Tue, 19 Mar 2019 22:56:54 -0700
Message-ID: <CAAHfpN_2rUu+kCCgOV+RdqCU5+XRe_c3KkJk6FNv50FG+5_qwg@mail.gmail.com>
Subject: Re: [PATCH V2] usb: gadget: f_fs: don't free buffer prematurely
To:     fei.yang@intel.com
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        Jerry Zhang <zhangjerry@google.com>, andrzej.p@collabora.com,
        plr.vincent@gmail.com, jingx.shen@intel.com,
        John Stultz <john.stultz@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 10:32 PM <fei.yang@intel.com> wrote:
>
> From: Fei Yang <fei.yang@intel.com>
>
> The following kernel panic happens due to the io_data buffer gets deallocated
> before the async io is completed. Add a check for the case where io_data buffer
> should be deallocated by ffs_user_copy_worker.

It looks like this happened because data got renamed to io_data, which made the
`data = NULL` marked with "Do not kfree the buffer in this function" not do
what it was hoping. This should probably either delete the assignment above or
fix the assignment to refer to io_data? (EIOCBQUEUED presumably can't come from
elsewhere?)
