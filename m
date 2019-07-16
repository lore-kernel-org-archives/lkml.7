Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC4EC76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94F6F2064B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 18:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaJ+yy0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388563AbfGPSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 14:47:04 -0400
Received: from mail-qk1-f169.google.com ([209.85.222.169]:42739 "EHLO
        mail-qk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728608AbfGPSrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 14:47:03 -0400
Received: by mail-qk1-f169.google.com with SMTP id 201so15423978qkm.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 11:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8eLxe9nuAUyuK3sgh1JtwqJtoQfJeodSg1/HcJI7MtM=;
        b=ZaJ+yy0/mMtkS3qf6FfVSGhgruGcMCae5R0XJLmL5sZRH6j6Bw+NFyi0VPxO1HcAnH
         gyVhNH8yzt6Q7Uj6aQ/nFM1Bj4sYLeTwBZuInyz9CYOvSk1/pBBXVqIIueshjXcWsQGs
         kHUGp0lpCAhG2CIqNwU4x/xSKrjeW+SwkLnY672LUJ1S19/+AQDTqoEtsv4FPuIsTfHP
         LjsR3E5lfNbvCChoEhWncpe6ww3lELIvnrkKWHS4aTVwQh4DV0pPDOWhaTBadGvoS5w1
         Np8/qMLhliKAiAuBOx2NkfMt4wQ2LNFL+VAsczW3UqQT6U+fakiUN13oEguuMt6008Gw
         K7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8eLxe9nuAUyuK3sgh1JtwqJtoQfJeodSg1/HcJI7MtM=;
        b=UIQ3JnLycDoYwYHLe8uJ35AD2Dgj0oIGHK3Rl6wkVFoJkG4XdeDScV4KR2ldG8AcOs
         a8zSnAx3mUEQ6nbwXHXIri+XfQMqvEbjkd7zAa7HaWfd55uZZ1ZgAmW9se7va711APRi
         HSGK78qziUk+sPrnKNMNh54NI5ZhmxwXCqNvECo8vbp39V5JwzwDRUTvbCy7ozesTebq
         va/D4OtPmCMjQFH+i7olktGz5OiZFbuG97r1ier3PP2cgFkQQ1+OgqaQiZCdeTS2hzxs
         OymeYUf5FPIsnLunMW8YsS5fjUEf6KfeNLFJspyVu5rXlKUaBay1Ap1rxWNJnQYGgtMV
         1FUg==
X-Gm-Message-State: APjAAAVBwIOmAPU1LOvmd299LVHdAQ6bA9++RmiVpGreRWfX7Wo7PeoI
        GuQ0Ef785iW2IB18FJNGhJE=
X-Google-Smtp-Source: APXvYqyuEpsGi3FEumZWkzujz4MACbziM0rCA56Q4h4kZPPtatUWEQKsckBUsmHdB58YGMu+ajVayA==
X-Received: by 2002:a37:9d15:: with SMTP id g21mr21356362qke.343.1563302822857;
        Tue, 16 Jul 2019 11:47:02 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id f20sm8622395qkh.15.2019.07.16.11.47.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 11:47:02 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 957FE40340; Tue, 16 Jul 2019 15:46:58 -0300 (-03)
Date:   Tue, 16 Jul 2019 15:46:58 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     David Carrillo-Cisneros <davidcc@google.com>,
        Song Liu <songliubraving@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Fix proper buffer size for feature processing
Message-ID: <20190716184658.GE3624@kernel.org>
References: <20190715140426.32509-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190715140426.32509-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Jul 15, 2019 at 04:04:26PM +0200, Jiri Olsa escreveu:
> After Song Liu's segfault fix for pipe mode, Arnaldo reported
> following error:
> 
>   # perf record -o - | perf script
>   0x514 [0x1ac]: failed to process type: 80

Thanks, tested and applied.

- Arnaldo
