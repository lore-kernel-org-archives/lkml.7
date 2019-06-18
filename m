Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42106C31E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EFE720873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 16:39:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gwSjnibm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbfFRQjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 12:39:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:47053 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbfFRQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 12:39:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so7965276pgr.13
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2019 09:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XrrW0E+Aq0ZK5ZEW02c85rKGyeAIqMgJzZ8XI50g1cw=;
        b=gwSjnibm9Blbi+bN6jrixv5dthYVRSRqHZk61Qze0Vo7hNCpvdHYRI6M2c4OZyZ5+8
         fHdlBbj+BuL+tQTYoYjtJmRSUtzeYwF5f9ISF3Upb+gGbPWS+MWV8zZP8IeH6qhpQ9s5
         2RQYMhRUkfwoGoK8RRr7EvQomQNaWzd6zx0Gbghhw+crVZPNaSjxqFdkeXgok1m1ibMZ
         g/TxSmcFb7TvSYaAm411mVFCipQzcGYOMsCqqbfelS46Kb+Zelh7o8YvhvyY68NcrtN0
         C4O6Qr/5jk1dPGXdY+DKXGYVH+xq4QgRqfV3JiT7CXQAs3rhk66WnEs+8ICl8byim+hK
         4AJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XrrW0E+Aq0ZK5ZEW02c85rKGyeAIqMgJzZ8XI50g1cw=;
        b=s2Wa3lBIEZhZbOlWUWjURt9SIeTGCTTcNdUXt+j+SO8cMxJheopP8iiLMaOgfyeqO4
         F9XacfX/mH1Jqa9dJ/TzMGFN1Qpi1mjTcIrzzyqQwTKAgtMkXRFoU8FEuHC177U+qrtM
         I+BJ/8pBdDJx58tUQ9CpqUM/KbSKWN3G3GyGLlUtJ45Q9xrmtzJp+T+N+riRt5OneLRU
         7I7ToFks2cOfH0Qy+kO6P8w4sh9gTWijNRapvNpuaCNbkMEHqIOURLFxhU3KIGj1j75F
         XhCieRkbAUnk9PwXNhkDkxJhJd+/dV7sGi2Si0PMNH2JwZxKx/2vjRY48lK3v6etTcNy
         O5Zg==
X-Gm-Message-State: APjAAAWFY9fkMk1GCqHMihzmeKABwSoPQ0G+PBS/h3kKrHTiXdN6+JFX
        p2zzYNndD2YL3+OBF34SHojhREIumhgKGA==
X-Google-Smtp-Source: APXvYqwc0c95/fcpzG4//NN/qwaK+yEAGX9GpR/HxZM6zgrRYhhB50BmH1cGBlGtS7u9BrO6skGcaA==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr6079766pjp.76.1560875956573;
        Tue, 18 Jun 2019 09:39:16 -0700 (PDT)
Received: from arch ([112.196.181.128])
        by smtp.gmail.com with ESMTPSA id d4sm2587754pju.19.2019.06.18.09.39.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 18 Jun 2019 09:39:16 -0700 (PDT)
Date:   Tue, 18 Jun 2019 22:08:37 +0530
From:   Puranjay Mohan <puranjay12@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     hch@infradead.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [Linux-kernel-mentees] [PATCH v2] fs: cramfs_fs.h: Fix shifting
 signed 32-bit value by 31 bits problem
Message-ID: <20190618163835.GA4766@arch>
References: <20190618114947.10563-1-puranjay12@gmail.com>
 <20190618160847.GC27611@kroah.com>
 <777ee79c-9371-956a-07df-be866796047b@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777ee79c-9371-956a-07df-be866796047b@linuxfoundation.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 10:15:11AM -0600, Shuah Khan wrote:
> On 6/18/19 10:08 AM, Greg KH wrote:
> > On Tue, Jun 18, 2019 at 05:19:47PM +0530, Puranjay Mohan wrote:
> > > Fix CRAMFS_BLK_FLAG_UNCOMPRESSED to use "U" cast to avoid shifting signed
> > > 32-bit value by 31 bits problem. This isn't a problem for kernel builds
> > > with gcc.
> > > 
> > > This could be problem since this header is part of public API which
> > > could be included for builds using compilers that don't handle this
> > > condition safely resulting in undefined behavior.
> > > 
> > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > 
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > You should resend this and cc: Nicolas Pitre <nico@fluxnic.net> as he is
> > the cramfs maintainer.
> > 
> 
> Puranjay! You can add all the Reviewed-by tags when you resend the patch
> with Nicolas Pitre <nico@fluxnic.net> on the thread.
> 
> 
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> 
> thanks,
> -- Shuah

Thanks, I have sent the mail with Nicolas Pitre in CC.

--Puranjay
