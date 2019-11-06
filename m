Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E61C5DF63
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9472075C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 19:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWlWq3+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfKFTK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 14:10:59 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46711 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731910AbfKFTK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 14:10:58 -0500
Received: by mail-qt1-f195.google.com with SMTP id u22so34875242qtq.13;
        Wed, 06 Nov 2019 11:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=HiPPtpPqNsZZBm360vADbujssXqudzIu3bWSQPcxm+Y=;
        b=XWlWq3+yYpMXCnX3TkiJGUdoiZPBcAO/fApL0VQnPZqtywQG1OyXIWXnEhw+PCpRQG
         cCQmg5d8G6iFHYnxpgY5l741U8KvPV6UfNDaVvPV4tYSLcbSn1dd8xD/mnISMbnion+E
         76wxE+DIMaU/h/Q2R5Alx5GP5L13SWdUETWtYDKufMQwnsFi9NV/NleSPlfdEaNw63jQ
         3x2VqDsqCcrmlKH4EoRavFkGrxDGGiZZl71MEfaCBmMaVBYrWaYt3P1max96ygAboByb
         z8yNSbi1Gx4GB8ItI+0/7uNpEw2B/iLiLRtDvaNc1dzvZ4IssgW6mdlhKmeeGx7K3yfV
         jPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=HiPPtpPqNsZZBm360vADbujssXqudzIu3bWSQPcxm+Y=;
        b=jEEOSnzVzscAIC3ZC7j8y5G8mqXG7SalvEwd5XO2wQECiuWG1ULJ/s4mcLJHiiKFeQ
         FpvtGZKvtsfjr6HJEovtt8yvKZZTCyWcvtwduPC+vdpW2Q0ZYsjwKd7nMA0naaysc+PS
         mUncXk/8Y5bW6rii6+6GxOk8P2ICnyn8alc9W7l4V8fk4rchkvV1lrJIxf9boPcLM/aE
         YnXaquRaVsMdYOlsgxBjvK9dBnId7W4DC+hvpUWGXSJDCpTKc60kFlrST8xpHOTQ4/mO
         F15kJwn116Ksl+uiuFW2ifpO1W5EpGS7vRirhFZixKiXTpzg02o61GtLAuOONi+LPhIs
         DYgg==
X-Gm-Message-State: APjAAAW9tX2XNUmAp6oarrL/HUtBqVlm0qM6PT+7wqAE2UjhXK9iqVP8
        k15RK+Vt0BVvtNATCkltwoY=
X-Google-Smtp-Source: APXvYqxfvpGXXyPzQMQyxcWTRO+LVQnrrWluYMAt1yXNw2CSCsSf2wl79J3yR2DrhGOsDUMcd5mZBA==
X-Received: by 2002:ac8:5317:: with SMTP id t23mr4144296qtn.228.1573067456562;
        Wed, 06 Nov 2019 11:10:56 -0800 (PST)
Received: from quaco.ghostprotocols.net (187-26-100-98.3g.claro.net.br. [187.26.100.98])
        by smtp.gmail.com with ESMTPSA id a4sm894096qko.57.2019.11.06.11.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 11:10:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id E62E940B1D; Wed,  6 Nov 2019 16:10:51 -0300 (-03)
Date:   Wed, 6 Nov 2019 16:10:51 -0300
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20191106191051.GE3636@kernel.org>
References: <20191017160301.20888-1-acme@kernel.org>
 <20191021062354.GA22042@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021062354.GA22042@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 21, 2019 at 08:23:54AM +0200, Ingo Molnar escreveu:
> Secondly, there also appears to be a TUI weirdness when the annotated 
> kernel functions are small (or weird): the blue cursor is stuck at the 
> top and I cannot move between the annotated instructions with the down/up 
> arrow:
> 
> Samples: 13M of event 'cycles', 4000 Hz, Event count (approx.): 1272420588851
> clear_page_rep  /usr/lib/debug/boot/vmlinux-5.4.0-rc3-custom-00557-gb6c81ae120e0 [Percent: local period]
>   0.01 │     mov  $0x200,%ecx                                                                                                                                                                      ▒
>        │   xorl %eax,%eax                                                                                                                                                                          ▒
>   0.01 │     xor  %eax,%eax                                                                                                                                                                        ▒
>        │   rep stosq                                                                                                                                                                               ▒
>  99.27 │     rep  stos %rax,%es:(%rdi)                                                                                                                                                             ▒
>        │   ret                                                                                                                                                                                     ▒
>   0.71 │   ← retq                         
> 
> I can still exit the screen with 'q', and can move around in larger 
> annotated kernel functions. Not sure whether it's related to function 
> size, or perhaps to the 'hottest' instruction that the cursor is normally 
> placed at.

I couldn't reproduce this one so far, with another small function,
clear_page_erms, what happens is that the cursor seems to be hidden at the
bottom, if you press the "magic" 'D' hotkey it will tell (at the bottom of the
screen) that the idx is at 18, which  for a function with just 8 output lines
doesn't make sense:

Samples: 12K of event 'cycles', 4000 Hz, Event count (approx.): 2219443843
clear_page_erms  /proc/kcore [Percent: local period]
Percent│                                                                 ◆
       │                                                                 ▒
       │                                                                 ▒
       │    Disassembly of section load0:                                ▒
       │                                                                 ▒
       │    ffffffffab9d17c0 <load0>:                                    ▒
       │      mov  $0x1000,%ecx                                          ▒
       │      xor  %eax,%eax                                             ▒
100.00 │      rep  stos %al,%es:(%rdi)                                   ▒
       │    ← retq                                                       ▒
                                                                         ▒
1: nr_ent=20, height=35, idx=18, top_idx=1, nr_asm_entries=8

Doesn't make sense, there aren't 20 entries nor the idx is 18, the
nr_asm_entries is right, I'll try to follow up on this one...

But you can in these cases try to go on pressin the up arrow till the cursor
appears, etc.
 
> Thanks,
> 
> 	Ingo

-- 

- Arnaldo
