Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6EC17447
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B686021D7F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 00:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="WoSwtQid"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbfKLAyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:54:43 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:40876 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726910AbfKLAyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 19:54:43 -0500
Received: by mail-qv1-f66.google.com with SMTP id i3so5511835qvv.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2019 16:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wDIf+AsFEXv3NCdOQayJNG94WJKxDDU6WBSBA7KBd1Y=;
        b=WoSwtQidVmlZ8XkxO+Zq/D0sdD/dXfHOSL1CPyaLogJejmZ52HNTiqN4BYzRE0gZM2
         922kuxJpcSKYDY1hFa5mHk8K3Ay7tox4S0c/J/F2QFkkSaf8gKtWWBQCQLqlfayQNdXk
         MZtBauhqbNAXeI7O8rmHDCWj6F6YtymPJVzKDWdHV+qpDRUyxw5njcozWtoHfNIYoLzo
         Zv9ISX3jjbbRzWaR+/XagZkbjR7RChgMQG4DYUCJ4CbzD/vSilVk2JAHp2xTAYOrVlUx
         jbSdbmfYUjBP7oq0S+TglOC6H9Cc2JAnlKq5U0/CeZeuSUvqmnmHDeGdaIwiu1s2fFli
         328w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=wDIf+AsFEXv3NCdOQayJNG94WJKxDDU6WBSBA7KBd1Y=;
        b=FEOWLQO3By7gaaWh89B45KQ2JbFfChq0lfOaZBtz09xz+oNaYsC3BZuCiwstUnl30v
         P1NBDjnViSPaMwUIBrVwACYcVyPyS1KUsHbiBYkOf6bN20V5qHyNOlEZRBkni9uiY7Gc
         2a8Q+DUgj+HVVxmvdVT4dASxVFeqNKcC5ymAlCtRZ+Wi8TloMQMeleXrAgdhG/19q4Tb
         1VE4ytCfaQ1Qg+SWxgb0sIbBO11ZHcgO8MUfhSlpeZJgCgkiqvmIfoYxCCno+pL/MXov
         ptjgvZzTnH+RLyeLUpmL+hqlznY28r3gL80CJVZ8P5ruIICqTgl/PPS+zBWMb5htSrIe
         OUGA==
X-Gm-Message-State: APjAAAUCn6Wv+adgVAuHV5TLqdZvXNY2cJ8NbbI7TzETXCeXzo3QwjhH
        oqCbfb9oz1S44tCF6qSZHkHfjg==
X-Google-Smtp-Source: APXvYqw0hxG4YxMvZ8p+kGWJOZquKlxFpN40XW/i3KDi/bDwap1SrSIcd5cG0onCa0pm9ENXXu3pRg==
X-Received: by 2002:a0c:95c8:: with SMTP id t8mr25861272qvt.227.1573520082377;
        Mon, 11 Nov 2019 16:54:42 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a18sm8900449qkc.2.2019.11.11.16.54.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 16:54:41 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: [PATCH] sched: Avoid spurious lock dependencies
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191029124453.GM4114@hirez.programming.kicks-ass.net>
Date:   Mon, 11 Nov 2019 19:54:40 -0500
Cc:     Andrew Morton <akpm@linux-foundation.org>, bigeasy@linutronix.de,
        Thomas Gleixner <tglx@linutronix.de>, thgarnie@google.com,
        tytso@mit.edu, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, mingo@redhat.com, will@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org
Content-Transfer-Encoding: 7bit
Message-Id: <17A8506A-D7E1-4EF8-82F0-3AC897B85A5F@lca.pw>
References: <20191001091837.GK4536@hirez.programming.kicks-ass.net>
 <EE57FDCF-E3CD-4A0D-B0CC-C3CBAA7EBCBD@lca.pw>
 <20191029124453.GM4114@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 29, 2019, at 8:44 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Tue, Oct 29, 2019 at 07:10:34AM -0400, Qian Cai wrote:
>> 
>> It looks like this patch has been forgotten forever. Do you need to
>> repost, so Ingo might have a better chance to pick it up?
> 
> I've queued it now, sorry!

Hmm, this is still not even in the linux-next after another 2 weeks. Not sure
what to do except carrying the patch on my own. 

