Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF80C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE28620717
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 13:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfQG1YAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfLPNhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 08:37:19 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36270 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbfLPNhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 08:37:17 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so7292330wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 05:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=1zfuGQ1qe2hDELfu6AsH16OXoBlMUxIDB6zTtky9aok=;
        b=mfQG1YAO5lpvU1Vr+JWzkRLUL4+MLvwVQCju5dR95vK39ickxPreTV8cjyqfC1RZ7A
         P/jZgKsY1nfx1sZCQXpAlfcDLWO4sdXcv47WSQxchMkgLOvv0pF9ml9So0Ce+DsQ4sld
         A4SwecqkQjpflZQPlp7jveQTwfWmlTRehY9QtN2J50MX4HDNMjiNsfbc9tayDT6HhFSM
         0d4bTBihpuGzJ0/x3asu+wlk1maQDvp0wIordAZMWPsHIj/FTEEhQyfuDnzaXHOhoJk4
         k0u0PtWl2gBjV2DhALyBegf6uEGro5SPOUvGfmjknYS2KdMTmoglU64YAQciXYUwOv7y
         fz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=1zfuGQ1qe2hDELfu6AsH16OXoBlMUxIDB6zTtky9aok=;
        b=bVijFWdWrk0kGpYjzThD9CmTmcT6v6hu1LPCKijcFLwV1MS9IX5Xn95vW4SLs9qyCZ
         EkAFTjd54uPixzhpB9PnJsIm+p/z6xdQt+WPcbmb20guwJNhKBv1ygUBzuG1gUza9AKX
         pg8ZuKNu3NHhvOutmVgF37q3dUKY4kIWjz2U6iuavBGTQv1ed+BcRPcNbLVzgp/tw1OF
         RJROwK26RTamLGiHbdKU0Wa8HqwmP8CpRion17EDBpDRk4zH5wB+xkfhY21a9++VeS7X
         LhjmzJ1uU8Q2XATYec9ToB0LmRFOYxq13GzhDPJKe3r+jHkFWshORa7v9wI9mH/jkeEx
         Mzow==
X-Gm-Message-State: APjAAAUbibpGTUNj7NGxzHJjqFZMrzTi3RX5Ne0RU1nwOsANb3yoaufJ
        HS8K2ZV0HIMJ5MMQFL4Ryw==
X-Google-Smtp-Source: APXvYqwpwv6Xs2Lty1Kg3w+du/QWBucDPrAljXRXjF0XXtRvy9m0xrq3s68FKBgDgKLHkBnGQXZYPw==
X-Received: by 2002:adf:dfd2:: with SMTP id q18mr30194212wrn.152.1576503436233;
        Mon, 16 Dec 2019 05:37:16 -0800 (PST)
Received: from ninjahub.lan (host-92-15-174-53.as43234.net. [92.15.174.53])
        by smtp.gmail.com with ESMTPSA id e8sm21495101wrt.7.2019.12.16.05.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2019 05:37:15 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Mon, 16 Dec 2019 13:37:08 +0000 (GMT)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, bokun.feng@gmail.com,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel: events: add releases() notation
In-Reply-To: <20191216083128.GI2844@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.21.1912161335320.23578@ninjahub.org>
References: <20191216002400.89985-1-jbi.octave@gmail.com> <20191216083128.GI2844@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 16 Dec 2019, Peter Zijlstra wrote:

> On Mon, Dec 16, 2019 at 12:24:00AM +0000, Jules Irenge wrote:
> > Add releases() notation to remove issue detected by sparse
> > context imbalance in perf_output_end() - unexpected unlock
> 
> None of the perf code uses the __acquire / __release annotations crud.
> Also, your annotation is broken, I think it should be __releases(RCU) or
> something like that.
> 
> 

Thanks for the response. I already updated. 
