Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D564FC282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5CFF20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 12:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6eJPv/C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbfDQMiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 08:38:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:43724 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbfDQMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 08:38:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id f18so22275160lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=rrlGYJVOHOmd+w94iAKkb9bPiDdoO923FRXZHboLrtQ=;
        b=S6eJPv/CaIwbVKl8QkKfm0yv46I2+7FhSr+DoBBCsVCAgpCx+ZS4Wn6Bmu/8QTdpmQ
         1UowURww6+i6MonLSLw4YkwsNL6AjkaX0/LyIY+G4KRIa8IParSvEd5Hxa0XVrgkovX1
         noKeArPAGX1/TCDaukhhxJg/R1M/KcC9pA06Df/3mDVYmslfAyFVBWoRjjQlnbj/tvZx
         FrcfkTgoNf36Vh0edB4AaPLi2RyXHcL2SZOolE8I7E07GFgOp4pMH+xerLJQofp+i4oV
         z7MKNG1e7AjQDXhwG74JbqFm1LuC2OhKHvmj/vnp/3lm8Depud38iCrTseugEG9eoZAU
         n5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=rrlGYJVOHOmd+w94iAKkb9bPiDdoO923FRXZHboLrtQ=;
        b=BN/2rU4FbM0FHf5m6VTu08TC30aobiDaA6FB2I1U1ZnFZ9zln4O1aR3VvK1zYJobDh
         AUbJmlwnrWggl7a+DOKEX1wYICUziTfO2GVF76vLfBjeekYwNHBHcFpcODWWmByaavqv
         M7uOUXLP9La3Slr0MNKCG5BwUNFvuW3hR9LTNMxifHrkWY+Ubuhkab+CmRjQsmgKFllr
         aeSmGmu2IZV8EzThvzAxWARLJChDGXs0HbdTAUXNHTf1p2eKLvKonx90vbgNEQhpBOnz
         xl9dV0TKg5mUZhgVpv1Io1IoVadRG9AhQd6OVyk7gerV2IsTowDo6je7+WDgJvWFJrTE
         KOZQ==
X-Gm-Message-State: APjAAAX4zHCvcxW9IdO+nOFbQUqCVGmp7jX7un6PnoNIu7wDTPrFtu+a
        YQoc7oiIXrACSZdEPCQdIas=
X-Google-Smtp-Source: APXvYqyagoLotxWjDdBgqAMBYpcHB3u7KLEQFYV5VlxsMIH0FkAzGgm22KXH0fBq6xT4dlnQhECS8A==
X-Received: by 2002:a2e:8e96:: with SMTP id z22mr46915406ljk.123.1555504723735;
        Wed, 17 Apr 2019 05:38:43 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id l15sm10869208ljh.62.2019.04.17.05.38.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 05:38:42 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id D62474600FF; Wed, 17 Apr 2019 15:38:41 +0300 (MSK)
Date:   Wed, 17 Apr 2019 15:38:41 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        kbuild-all@01.org, LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH] prctl: Don't compile some of prctl functions when CRUI
Message-ID: <20190417123841.GA3040@uranus.lan>
References: <20180420140044.478b4c88d3cf238bd440f2a7@linux-foundation.org>
 <20190417122349.GA15498@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190417122349.GA15498@blackbody.suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2019 at 02:23:50PM +0200, Michal Koutný wrote:
> Hi.
> 
> I see this discussion somewhat faded away since the previous year.
> 
> There was rework [1] that reduced (ab)use of mmap_sem in prctl
> functions.
> 
> Actually, there still remains the down_write() in prctl_set_mm.
> I considered at least replacing it with the mm_struct.arg_lock +
> down_read() but then I learnt about this thread intending to remove that
> part completely. I wouldn't oppose if CRIU is the sole (aware) user.
> 
> Ad the bot build issue, I could build the kernel both with
> CONFIG_CHECKPOINT_RESTORE and without CONFIG_CHECKPOINT_RESTORE just
> fine after applying the two proposed patches.
> 
> What is the current state? Perhaps, this change should be CCed to
> linux-api@vger.kernel.org(?).
> 
> [1] https://lore.kernel.org/lkml/1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com/T/

Hi! I've a bit vague memory what we've ended up with, but iirc there was
a problem with brk() syscall or similar. Then I think we left everything
as is. I think there is no much activity in this prctl area now as far
as i know (replying to what is current state).
