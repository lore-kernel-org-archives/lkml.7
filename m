Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C9C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC44520B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 15:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbfJJPV3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 11:21:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57792 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfJJPV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 11:21:29 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1iIaFq-00019S-WF
        for linux-kernel@vger.kernel.org; Thu, 10 Oct 2019 15:21:27 +0000
Received: by mail-wm1-f72.google.com with SMTP id o8so2775015wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 08:21:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3boDxdHK1ODl76QlQ3HRBysQraf94+BhUdrM7yrD2xU=;
        b=e1kIsoRqxBCvN76Bq6TosHSVh5tYWvhp7jPyCymrvbpAoQc1dHTiXsnG8vkXGzYYXB
         Sl18dLUwfO4KXV6awmImnUhwd2FyH28+htjpgnCbUd9A2oXxff6zWNxtNiMh/mPFrrNV
         rCvECJE105LYjKxvNLl5bRKutOyplVVGWEhagchH/T48u8ZvoLdrZHe7b9AS5mNVlCiS
         TJUF1MjAgVzeSOWY0w/6NWXE2OLxfu7KkBlzfl1Ga4vFoZBmpsExOb538Ut/RoAHGZRf
         V3ChgqF6sfcmrRfV8Q7s9TAaz5tr14Nf4s5wlZUMaFdpptDtCQAbbisR547M1iUExMET
         TJQA==
X-Gm-Message-State: APjAAAU9Zi9NRhO//iOD8yF14pEpUOCyOC1YCJ4dHqAkPD8tyL2N7+WI
        qnNfDyfY/zmxFXfs7yDCG3ikKqIG+Nit4m2h2Ffay8SD+HbsE3rHsS0FLoHHol01CZUHvXDoxWl
        QcWRbBY7x1jLvnKhq4o3rrmlK2uF2wh4BRGB0JGwElA==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr9577878wrw.194.1570720886671;
        Thu, 10 Oct 2019 08:21:26 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhzmT97wWx/NJwcClk+dDjNHcdVAAMcgNYL94qHj86ABDJWHjsxwm/tzCQuM8nHstPXy2wcA==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr9577857wrw.194.1570720886325;
        Thu, 10 Oct 2019 08:21:26 -0700 (PDT)
Received: from localhost (host138-128-dynamic.32-79-r.retail.telecomitalia.it. [79.32.128.138])
        by smtp.gmail.com with ESMTPSA id l7sm6813484wrv.77.2019.10.10.08.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 08:21:25 -0700 (PDT)
Date:   Thu, 10 Oct 2019 17:21:24 +0200
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Coly Li <colyli@suse.de>
Cc:     Kent Overstreet <kent.overstreet@gmail.com>,
        linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] bcache: fix deadlock in bcache_allocator
Message-ID: <20191010152124.GA25334@xps-13>
References: <20190807103806.GA15450@xps-13>
 <1360a7e6-9135-6f3e-fc30-0834779bcf69@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1360a7e6-9135-6f3e-fc30-0834779bcf69@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2019 at 09:53:46PM +0800, Coly Li wrote:
> On 2019/8/7 6:38 下午, Andrea Righi wrote:
> > bcache_allocator can call the following:
> > 
> >  bch_allocator_thread()
> >   -> bch_prio_write()
> >      -> bch_bucket_alloc()
> >         -> wait on &ca->set->bucket_wait
> > 
> > But the wake up event on bucket_wait is supposed to come from
> > bch_allocator_thread() itself => deadlock:
> > 
> > [ 1158.490744] INFO: task bcache_allocato:15861 blocked for more than 10 seconds.
> > [ 1158.495929]       Not tainted 5.3.0-050300rc3-generic #201908042232
> > [ 1158.500653] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [ 1158.504413] bcache_allocato D    0 15861      2 0x80004000
> > [ 1158.504419] Call Trace:
> > [ 1158.504429]  __schedule+0x2a8/0x670
> > [ 1158.504432]  schedule+0x2d/0x90
> > [ 1158.504448]  bch_bucket_alloc+0xe5/0x370 [bcache]
> > [ 1158.504453]  ? wait_woken+0x80/0x80
> > [ 1158.504466]  bch_prio_write+0x1dc/0x390 [bcache]
> > [ 1158.504476]  bch_allocator_thread+0x233/0x490 [bcache]
> > [ 1158.504491]  kthread+0x121/0x140
> > [ 1158.504503]  ? invalidate_buckets+0x890/0x890 [bcache]
> > [ 1158.504506]  ? kthread_park+0xb0/0xb0
> > [ 1158.504510]  ret_from_fork+0x35/0x40
> > 
> > Fix by making the call to bch_prio_write() non-blocking, so that
> > bch_allocator_thread() never waits on itself.
> > 
> > Moreover, make sure to wake up the garbage collector thread when
> > bch_prio_write() is failing to allocate buckets.
> > 
> > BugLink: https://bugs.launchpad.net/bugs/1784665
> > BugLink: https://bugs.launchpad.net/bugs/1796292
> > Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> 
> OK, I add this version into my for-test directory. Once you have a new
> version, I will update it. Thanks.
> 
> Coly Li

Hi Coly,

any news about this patch? We're still using it in Ubuntu and no errors
have been reported so far. Do you think we can add this to linux-next?

Thanks,
-Andrea
