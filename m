Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C05C7618F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 466F9218B8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 20:46:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maine.edu header.i=@maine.edu header.b="d41BIaTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfGZUq6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 16:46:58 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33666 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbfGZUq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 16:46:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id r6so49723658qtt.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2019 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google;
        h=from:date:to:cc:subject:message-id:user-agent:mime-version;
        bh=EkkYyzbKFCkkMpgaoYMPHhbpzI2gyifZuS1BV3t9ELc=;
        b=d41BIaTHJGxt3X6jmm1ZiRmCWH3HgmROD5JE/8Y/Dlhw0fXAlsi+y4Paiin55JriCt
         aDf6CbiXAyC4ABcTDSiiAYf38ABXWtJ/MyNFWnewdNN0VcFzfLv/WPtAzjQpbQ31/xJP
         nXESVzSPK71H1Fi9VXpcwEEjxfmsrF55Fp9AE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=EkkYyzbKFCkkMpgaoYMPHhbpzI2gyifZuS1BV3t9ELc=;
        b=A3V5uyUuBXrKooGjox3HE6KfuYnVyB84uOGFHuMIYGhSjIhwi9lA07cfUAm5D/EQO1
         jgWQI0OGUz0PVV/Ti8aV1MfINnvx+hjDkt/DlAHnzLlID/Qa4qFNz0/j2wQ8COYav3pe
         7eLyTwSqSY37mThwRhhpiYeGhHDcRbqpZ50UPlmyUq5+cyaBbh6zRVyhhqfUJTOM7W4w
         AU6+drmAsgwuvRxI/WYMx2RgsduSkw/Gegjrun7vRexqLhoqXFfnmXv0Kx4cMo+5OlfQ
         8NGjfqBjzn/8QXRhP7Esw8qnnh2aRaeDCc/5N55ZGDajRNe2g8phnlr/vyNDWzUPohWw
         JkOw==
X-Gm-Message-State: APjAAAUFhIzBO5ciLjJ+00AUycZSNG2gVwimJGVbA9GdnpZLxykCzRHr
        mswLIAtsUfdzQhC6rnMiBawRyA==
X-Google-Smtp-Source: APXvYqxl7ywmGwEFcDCqiOH+BMZ8HfahC2V2j0Z79GYZvbYMRgHy7PZ75ZCehW1ufCcDBaNlQDBIsA==
X-Received: by 2002:aed:34a6:: with SMTP id x35mr67957114qtd.187.1564174016913;
        Fri, 26 Jul 2019 13:46:56 -0700 (PDT)
Received: from macbook-air (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id b13sm33271374qtk.55.2019.07.26.13.46.55
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 13:46:55 -0700 (PDT)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Fri, 26 Jul 2019 16:46:51 -0400 (EDT)
X-X-Sender: vince@macbook-air
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: perf: perf report stuck in an infinite loop
Message-ID: <alpine.DEB.2.21.1907261640590.27043@macbook-air>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Currently the perf_data_fuzzer causes perf report to get stuck in an 
infinite loop.

From what I can tell, the issue happens in reader__process_events()
when an event is mapped using mmap(), but when it goes to process the
event finds out the internal event header has the size (invalidly) set to 
something much larger than the mmap buffer size.  This means 
fetch_mmaped_event() fails, which gotos remap: which tries again with
the exact same mmap size, and this will loop forever.

I haven't been able to puzzle out how to fix this, but maybe you have a 
better feel for what's going on here.

Vince
