Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5566C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A232A218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 01:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="feVNe5FF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfCVB7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 21:59:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:35152 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbfCVB7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 21:59:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id d132so699426ywa.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2019 18:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rdnmn7yxssUzb3bXdY19gbuGdUiJlVYAXBvHN95zUAg=;
        b=feVNe5FF/ey/npbt5mQ8ivp5sqxJqeTu1XUhpyuF+ft3GC0CE/8sMqaGvueZ6natFU
         k9yII/xjHDiY/gmEJP72SRnmAoeoLkvs+VdJzG59kd9XG+tEl1E9pLTsP46XXg2IrJZx
         H1GSAo08NFMnjcJOxQfu4IOnD6XInOIn6XhhYJ3gJX5EZlgQpN3EBYrQZOQ8bDVMtc60
         Oz0Q+TLfk7X4+xZP2QvYUInkqkqiG50PLsFxSklzsmZoK44B/wNIS4Ty0a0hUU79wyyb
         pOhIcZa5AVwWbxoSIoA0JRbVKwBU428M75Uj3oTIKSVYNY1+EE/nHJ6ZL7Il+TCpzRD6
         Af1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rdnmn7yxssUzb3bXdY19gbuGdUiJlVYAXBvHN95zUAg=;
        b=rz0vt57FCAVnE1No+2f62hJeMoAXU0sebOUrQCVQ3+0I6Yb8EEasQN0123uq5P5UUC
         haEWF614gDp582Y3FqQSbYZ4qxq2DwUSls2QZIrskHJHYVwmn1ke/HYCKKIfuqzxt5T8
         WQC7rqZB1mBjnlG3on9/Kdiqw0G0SDmJiaEaPCrsz71V4Ktfn8FI5N2h3DG3fF1brXcD
         djowR4MHyURJRaPmXLfSuuBTRH4aJU2YjzMCr58gGa4E8lIdPI/ZBfjIxzIC/zWqdabL
         ycOBI27uJgcN9OByxSlB1vsKWPJBGZ403KzkUqaO1EqNVa3dx2tIM8tSnKpyVZRF191d
         bTWg==
X-Gm-Message-State: APjAAAVI/E96hR2JOT025J6JY5MVQJHjTIwFVoVS2jFHTVOsXHCiInGb
        pgmkrTB2qh+cCeKRaBt0EHupog==
X-Google-Smtp-Source: APXvYqzgH+Bht1Mq9/fKEqrohpUs1HQAYVe5RcRxGMMdlMmE/zZ+NEgWy3Y/51s8ddW7YCFyIswqfg==
X-Received: by 2002:a81:8354:: with SMTP id t81mr6231095ywf.488.1553219990045;
        Thu, 21 Mar 2019 18:59:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (li931-65.members.linode.com. [45.56.113.65])
        by smtp.gmail.com with ESMTPSA id g82sm3018959ywg.60.2019.03.21.18.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 18:59:48 -0700 (PDT)
Date:   Fri, 22 Mar 2019 09:59:41 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Solomon Tan <solomonbstoner@protonmail.ch>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "robert.walker@arm.com" <robert.walker@arm.com>,
        "acme@redhat.com" <acme@redhat.com>
Subject: Re: [PATCH v4] perf tools: Add missing case value
Message-ID: <20190322015935.GA29608@leoy-ThinkPad-X240s>
References: <iXDQnAbT-yValKlLnwDyoyBCwymrdxjykuMsgI4Cxau_e2ib9QYVroNDbJgZz3kuxTTaPJnyzRWmEY0TpEZDVQBSdElz9K9R0tAz79Qkp2s=@protonmail.ch>
 <20190321162702.GA24451@xps15>
 <vZ4GE7nXgr7nfrMHj_pp8qu6onE8B7YfoczBpbm9RA8spzbqAoEmAIT_YJXkGFXgK8tJqLdVBW_1D9D4jQ2Um51V7SWi1ZgIjrMaYxEYzqg=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vZ4GE7nXgr7nfrMHj_pp8qu6onE8B7YfoczBpbm9RA8spzbqAoEmAIT_YJXkGFXgK8tJqLdVBW_1D9D4jQ2Um51V7SWi1ZgIjrMaYxEYzqg=@protonmail.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Solomon,

On Fri, Mar 22, 2019 at 12:47:11AM +0000, Solomon Tan wrote:

[...]

> > On my side this patch is no different from V3, i.e it doesn't pass checkpatch
> > and it doesn't apply on my next tree.
> >
> > Mathieu
> >
> > >
> >
> > pub RSA 2048/C88289A6 2018-05-09solomonbstoner@protonmail.ch solomonbstoner@protonmail.ch
> >
> > > sub RSA 2048/7C5E8D6D 2018-05-09
> 
> I created a new branch from `next` for the patch mentioned above. Should I
> have made the patch directly on the `next` branch instead?
> 
> I ran the following 2 commands to test the files I edited:
> ```
> perl scripts/checkpatch.pl -f tools/build/feature/test-libopencsd.c
> perl scripts/checkpatch.pl -f tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> ```
> The commands reported that the files "has no obvious style problems and is ready
> for submission." For your kind advice please. Thank you.

Suggest you to use below flow for sending patch:

- git format HEAD~1: generate patch
- ./scripts/checkpatch.pl xxxx.patch: check patch format
- git send-email xxxx.patch: use git to send patch so avoid any
  unexpected characters in the mail

P.s. Marc has a good presentation [1] for upstreaming patches, you
could check page 16 for how to use the git tool.

[1] https://elinux.org/images/2/26/Getting-Your-Patches-in-Mainline-Linux-What-Not-To-Do-and-a-Few-Things-You-Could-Try-Instead-Marc-Zyngier-ARM.pdf

Thanks,
Leo Yan
