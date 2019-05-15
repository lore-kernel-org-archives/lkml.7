Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91D8C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE98120843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:14:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrvmA0uP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfEOTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:14:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36243 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfEOTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:14:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id a17so1045840qth.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2019 12:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=53jwncdE+8A+JQgg3NikodLCsu8d8vFjeH3Gfxt1LY8=;
        b=BrvmA0uPoexTDKwjLcD9wDqReetbKsMjWzMquKqP+2hwVqqy77+4YFZig9hGYER0Or
         NsGJkI3bdHo3e6Rw71oj2TDVNUn9iAI8RLwlu7Rkape9uR8KiAxapK1e6N7Q3Htrk/b9
         /LxvfGGVRAhv3XWUjmsidKkqKt347M/3fVSem8g3oVdOgi9+MuOFqJ21kUOnODfUlH4n
         nh9NMOna8kENd6urixKEtldYOGvDN6uHZHcdKpV4DoLxhkc7qS+a78g+qIwmxCXw+S+x
         rxcqyrbYLafc50bJF0qrg0NT8VZTkxDL/Y18x30TL/XDTd3YDPGOUX2OWTeVeUPE8Ql3
         E+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53jwncdE+8A+JQgg3NikodLCsu8d8vFjeH3Gfxt1LY8=;
        b=fAVDxRq4IYvac+Pun3Ojb0Oe8tExeveVxSWknZd/fbZJ4J9AP3bCM3PZPp4AvJjizA
         kBRvKW7Xlgfn3yUEpSUo11STfnpCsDm051VHITZ9DVbqcNI4okbYpZA7+zptuRbsnqcr
         N8TcAfVIxtc1y71UoJJa17jkIcnsBPKasVSDFLwxaJKUWuD9yQLCoYR9vjjqxby6DNr7
         C3ggFuGGOTgKEn+ofdhrjC68GgZV1O0Q6sqRlyfYhWuvvVzZuvcc0nNhlfISe2UAfsa4
         yt/bZWq/8UA3C1aaFuOixjauTnq/sG3KiLr02vg8dCH7o8Iv6zPnK2LLCs1PcTL6Ea2i
         a5UA==
X-Gm-Message-State: APjAAAXJqdMWfNUPWnnojKZ4yGf6XmqAsJMGNwDMknayEmqJpQKX3sQE
        u4q2XXWGU4oVWkovJp8/dR0=
X-Google-Smtp-Source: APXvYqzwzWCyNasN6O19B4yHwkSdAXC7TD7Uy61doDkin6h0P4dOxN5pmN+aXRo/AfGzwdEd6VQqHA==
X-Received: by 2002:ac8:3659:: with SMTP id n25mr35367953qtb.297.1557947647040;
        Wed, 15 May 2019 12:14:07 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id y14sm1813921qth.48.2019.05.15.12.14.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 May 2019 12:14:06 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 916C0404A1; Wed, 15 May 2019 16:13:59 -0300 (-03)
Date:   Wed, 15 May 2019 16:13:59 -0300
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "moderated list:ARM PMU PROFILING AND DEBUGGING" 
        <linux-arm-kernel@lists.infradead.org>,
        John Garry <john.garry@huawei.com>,
        Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>,
        Sean V Kelley <seanvk.dev@oregontracks.org>
Subject: Re: [PATCH v2 0/3] perf vendor events arm64: support for Brahma-B53,
 Cortex-A57/A72
Message-ID: <20190515191359.GD23162@kernel.org>
References: <20190513202522.9050-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190513202522.9050-1-f.fainelli@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, May 13, 2019 at 01:25:19PM -0700, Florian Fainelli escreveu:
> Hi all,
> 
> Based on discussion about the last patch, it turned out that we can
> remove the [[:xdigit:]] wildcard entirely since get_cpuid_str() strips
> the revision bits anyway.

Thanks, applied.

- Arnaldo
