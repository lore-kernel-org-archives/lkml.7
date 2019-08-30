Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E40C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33EF23439
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="WF1KfJ49"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbfH3WjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:39:17 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37356 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728143AbfH3WjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:39:17 -0400
Received: by mail-pf1-f195.google.com with SMTP id y9so5503729pfl.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=lYEdR7OIDmrYXbk4LsKiDmBX9nCzp/LrQYMbm64bufM=;
        b=WF1KfJ49hDOc8AAWwIr2x8c8W1VoJ45wRR/+jocFol+ez9T/GPhK3vHYwWOB6hCPc4
         oCrSjcO6b7imhN76Z92f2auVNFr+qC+uiaVxRz6jZdDq7Yuv4x/CWxbKx5QOl5O/KqLD
         r4EZEEZnGDVEF4gERFq+22WUxFnZDrTwXLYhi01PUVF6R6QeNv6v1R9US56yDI7LcMBc
         COf2IuQf0M3TJwCkBL4MJZ9EzcQzL5e6NiVAQ3MZif20UCy6hPgnmsYZJTKQvJ1plTm+
         aIQsNt/o/XfCazaCkOe/VQiRXB8PM6EHVBAfYXh+h6zy+6RN+2nT+yrn443kZXbvLaaD
         pG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=lYEdR7OIDmrYXbk4LsKiDmBX9nCzp/LrQYMbm64bufM=;
        b=nBqI41WJa///wc2HSqzgz/2mA2R1vwZvRgCDJtHBCjPtPoGiUG9Zvmgn6ADvozsenV
         goWAl0tewaPfNLewEO0Zr5VmWiwrvdX5WWZCH9fXNJCykS2O1Dfyn3h9ZLOKaIC3248j
         rg1eDYbxISJxtkdk7K53xZqiYTem6wp+H/WP92oTb6aSDPjDVP3q0iJX1d+tUjhJN0NL
         UtFdsDYNouNpZ6B7bNGx3z97QbA9E40k3xRpk/DPI4Af+KWeBHq9J4eotsocHQTyuwzO
         Y3Rl3Z7UrtzWOL8ZN76Fp24DkljAw7nOPxeZNSgU+yyd2cA0r/kf16I2+fIWTVCcqhPt
         Gk0w==
X-Gm-Message-State: APjAAAUZZQHAtaGB10XFYUiWoJ1EVSqDlP2OkLl+ZayIexdz159iDXQq
        8mP/rLiIRajY0PyDE4OTs3pXlw==
X-Google-Smtp-Source: APXvYqzbISoGZhwQ49KJKWsevd9L4dZaH5WH0hKG0FbEsF/ss34J7wAO/LJhXWAZ49+xbJGNEvONPg==
X-Received: by 2002:a17:90a:b108:: with SMTP id z8mr870586pjq.108.1567204756814;
        Fri, 30 Aug 2019 15:39:16 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id m9sm10956448pgr.24.2019.08.30.15.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 15:39:16 -0700 (PDT)
Date:   Fri, 30 Aug 2019 15:38:54 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        oss-drivers@netronome.com, Divya Indi <divya.indi@oracle.com>
Subject: Re: [PATCH 0/3] tracing: fix minor build warnings
Message-ID: <20190830153854.7b524cf8@cakuba.netronome.com>
In-Reply-To: <20190830180150.687f3ec8@gandalf.local.home>
References: <20190828052549.2472-1-jakub.kicinski@netronome.com>
        <20190830180150.687f3ec8@gandalf.local.home>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 18:01:50 -0400, Steven Rostedt wrote:
> On Tue, 27 Aug 2019 22:25:46 -0700
> Jakub Kicinski <jakub.kicinski@netronome.com> wrote:
> 
> > Hi!
> > 
> > trace.o gets rebuild on every make run when tracing is enabled,
> > which makes all warnings particularly noisy. This patchset fixes
> > some low-hanging fruit on W=1 C=1 builds.
> > 
> > Jakub Kicinski (3):
> >   tracing: correct kdoc formats  
> 
> I took the first one, but the two below, I wont take. Those changes
> were added in preparation of the kernel access to tracing code.
> 
> See:
> 
>   http://lkml.kernel.org/r/1565805327-579-1-git-send-email-divya.indi@oracle.com

Sounds good, thanks!
