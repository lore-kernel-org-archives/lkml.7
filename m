Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CEE4CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A9920820
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 09:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SFV9uWz5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407720AbfJRJk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 05:40:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33800 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389165AbfJRJky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 05:40:54 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19so5548495lja.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bOJNlT4L8Idf/nqVi29AwDYXYOoGHJN4nbyrREFiJ6U=;
        b=SFV9uWz5WebpMzn33pswNWj6JSRk6BEr1PEK0IlJcC7ygoWmlQSQYhnxzAB3IctjHL
         XcaWKdYSPSPoOoq5IyfoV4mBHCQQxnhdF35/DnjEudWa0yzVIFMIR4GMFDIVob/8Qzdo
         zlISixM7a4MMJEySdeso6HOSNQSIGHSsM+qr3gwnF1TRh15SygSrDW1brP3wUXRnWur7
         7zKxfN6tAoZ6NhLZ1TndNsvtDr6NEarQ3bwnNTjpiGr5fafJB63CrqByyHpuBvJ3L/4m
         RRrVFMKH/sSM3/I/jt2z9SKwLSiRhXDP+m+30BTnI18jC1QLya8YmYPVm6fD1fX7Aazg
         nRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bOJNlT4L8Idf/nqVi29AwDYXYOoGHJN4nbyrREFiJ6U=;
        b=EA2IRrLd69ZfyvT4eTXIcqaz1mPH5FjlYFMSPBLV/gaOjvbk91RvxN3ABKzuiLkxoU
         We3J6TCqeED/ysN9MFz5xDtCWoeviYrqK0i8kksqXKD2GOUc/M20snjwV27rrS3SWV5G
         yKvW/Y14gL69msTjRq2CX04D7JiKzweZ/cW3/IZ4wCYznNhXMtSeNpWJfzzkfC580FCh
         1HD2F4jli1PLbpAtW+cNTTA5k6OBjh+wnuk5dVKdpcte8bppYQvpnhPZ14BYmc5lBxHe
         WSxxawNeY23k0/FFbsp9ORwBx6FbjvIBT8kToUISHFgdlWoQYbbc9p//xBQoi/m788MF
         GPNQ==
X-Gm-Message-State: APjAAAW1fQ44jG0ilL289P4V4xlX5U+yUVPVGw3JjdZpiQnfHRtHD1S4
        s4vIPB0Fh8SvwRosnMmVSLs=
X-Google-Smtp-Source: APXvYqywCB2VCpIQP/0RrUdWYoZ85jhgAxhGeaxxBV3j7fl5o3jrM7p6x5FjRDAVLLSPreDBiJCH/A==
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr4840327ljk.85.1571391652638;
        Fri, 18 Oct 2019 02:40:52 -0700 (PDT)
Received: from pc636 ([37.139.158.167])
        by smtp.gmail.com with ESMTPSA id p18sm2699719lfh.24.2019.10.18.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 02:40:51 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 18 Oct 2019 11:40:49 +0200
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Wagner <dwagner@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hillf Danton <hdanton@sina.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3 2/3] mm/vmalloc: respect passed gfp_mask when do
 preloading
Message-ID: <20191018094049.GB8744@pc636>
References: <20191016095438.12391-1-urezki@gmail.com>
 <20191016095438.12391-2-urezki@gmail.com>
 <20191016110604.GT317@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016110604.GT317@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > alloc_vmap_area() is given a gfp_mask for the page allocator.
> > Let's respect that mask and consider it even in the case when
> > doing regular CPU preloading, i.e. where a context can sleep.
> 
> This is explaining what but it doesn't say why. I would go with
> "
> Allocation functions should comply with the given gfp_mask as much as
> possible. The preallocation code in alloc_vmap_area doesn't follow that
> pattern and it is using a hardcoded GFP_KERNEL. Although this doesn't
> really make much difference because vmalloc is not GFP_NOWAIT compliant
> in general (e.g. page table allocations are GFP_KERNEL) there is no
> reason to spread that bad habit and it is good to fix the antipattern.
> "
I can go with that, agree. I am not sure if i need to update the patch
and send v4. Or maybe Andrew can directly update it in his tree.

Andrew, should i send or can update?

Thank you in advance!

--
Vlad Rezki
