Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DD6C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA212082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 20:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzyyDt8/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDCUbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 16:31:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42277 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfDCUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 16:31:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id v22so39132lje.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2019 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pABrYDISlrhXz6Arfm5w8XYTATVi1a4LMh0QM9Kxq98=;
        b=DzyyDt8/Y9BoFn/WPDFfW+mqWzl+pyFSXt2enHQUr5EZAL7xROhldNF32ZxbGgVy7b
         +jVA0jXo3KbNL9Jcb2g1AakszpF5zircP1i+PxatHUcIce0teGAo0N4V1sbwJ69SvzxM
         mxwHjJi9K/fpCtKClrdIwJ1yzm4KnEY+jpZlGB7nrFLjLPmNKGw1ESVVLz3KKS8S4WcI
         X/x1RZ6Wh1pJVd31j2KGJbtX04/fn+e7D9kiUUr0uAf3QE7IdXNGoDRTHC1cNzpqLysZ
         1UN+SWBChdcRSyL6DosltQhKsqwb7P62i3taAv7uYpYxQxJY0+/KwQyLZPfgjVJxZNZ7
         df/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pABrYDISlrhXz6Arfm5w8XYTATVi1a4LMh0QM9Kxq98=;
        b=EvWecj7JYCNy/ch+ubhYYuA+7L1FnAWU2Bg9+L+hT16xu7i5X0dRqplqZpG6Lt/S38
         nkqHxexwRmK0+BWrBTgod0kvGx1OqT6hSjhWenBoEiwPT3Gj693rhJBR8YBwutwG07r9
         UrqlA9WJG8YoDDMxlKuQZAB4cFrMb7cm0FpjmtfVX1mXm0aITygT5Dpf0vtJ+GNWoGyI
         zzSA5bvYDj1YeJ0Bs3bFWQUkSDwAEZCj/XFT2QBhsJ+mhRcPpGM1Rb7NVGJs/m7+G5JR
         vv7NkEkMz0niFd/gb/yzs5AjB4sbWjIKNd94cSrEBDOE4PbFutURFEOO0Gd7maITbTI/
         Sn1A==
X-Gm-Message-State: APjAAAUnz1LK/BMyp206G23EVcZ4d+uQudpkQleCyhDusedmeE6+sDpY
        Ng4uYSBrYCD9HlKWt8FpEEY=
X-Google-Smtp-Source: APXvYqw+dXMKtHLQHQskcCojuX8Jr5Y2zN0tRaGTfSGFJIbGVnb9eqRgFr4wsNwq2rNmptr+qci9Ag==
X-Received: by 2002:a2e:8787:: with SMTP id n7mr1008341lji.31.1554323506748;
        Wed, 03 Apr 2019 13:31:46 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id t29sm3463001ljd.82.2019.04.03.13.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Apr 2019 13:31:45 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id C6F0846041D; Wed,  3 Apr 2019 23:31:44 +0300 (MSK)
Date:   Wed, 3 Apr 2019 23:31:44 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Vince Weaver <vincent.weaver@maine.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: perf: perf_fuzzer crashes on Pentium 4 systems
Message-ID: <20190403203144.GI1421@uranus.lan>
References: <alpine.DEB.2.21.1904031043170.29188@macbook-air>
 <20190403191944.GH1421@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403191944.GH1421@uranus.lan>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 10:19:44PM +0300, Cyrill Gorcunov wrote:
> 
> You know, seems I got what happened -- p4_general_events do
> not cover all general events, they stop at PERF_COUNT_HW_BUS_CYCLES,
> while more 3 general event left. This is 'cause I've not been following
> pmu evolution in code. I will try to cover this events hopefully more
> less soon and send you a patch to test (if you don't mind).

Still this should not cause nil deref, continue investigating. Vince
could oyu please apply the patch below, I doubt if it help with nil
issue but worth having anyway
---
From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [PATCH] perf/x86/intel/p4: Limit p4_general_events down to real ones

p4_general_events are allocated up to PERF_COUNT_HW_MAX while this constant
is bigger than the number of general events we do support by now. Thus the
all other entries are equal to zero and maps to P4_EVENT_TC_DELIVER_MODE
which is wrong of course. Instead drop off PERF_COUNT_HW_MAX constant
from declaration, we use ARRAY_SIZE for max_events.

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 arch/x86/events/intel/p4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-tip.git/arch/x86/events/intel/p4.c
===================================================================
--- linux-tip.git.orig/arch/x86/events/intel/p4.c
+++ linux-tip.git/arch/x86/events/intel/p4.c
@@ -648,7 +648,7 @@ static u64 p4_get_alias_event(u64 config
 	return config_match | (config & P4_CONFIG_EVENT_ALIAS_IMMUTABLE_BITS);
 }
 
-static u64 p4_general_events[PERF_COUNT_HW_MAX] = {
+static u64 p4_general_events[] = {
   /* non-halted CPU clocks */
   [PERF_COUNT_HW_CPU_CYCLES] =
 	p4_config_pack_escr(P4_ESCR_EVENT(P4_EVENT_GLOBAL_POWER_EVENTS)		|
