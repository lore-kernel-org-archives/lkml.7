Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E486FC76188
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35EB2229B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=etsukata-com.20150623.gappssmtp.com header.i=@etsukata-com.20150623.gappssmtp.com header.b="Y8NnNlV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbfGVIeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 04:34:03 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42213 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfGVIeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 04:34:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id ay6so18896191plb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2019 01:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsukata-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GDrviT7pYkZ/XECogfqjELwBhZ+0VUiIqMlWTI/BqbY=;
        b=Y8NnNlV6vHtKnC0JQOl7kdtd4sJl766kIFaibiDus5Ij7SsZ2W42vmpKsVu1WWvP20
         Xk3HkjDyjND1tb37pNM3O9p+xa796EuzLelGAMgSRlQLjwzIwyx4r7k6yE/KYDaVVeDA
         9DS/kphQOh+zI/3l7oG5TBrAljL49eCmStOTWokIOflmy5VgDOfGy8uEf+DxhODr54KQ
         XWYz2KR0ViTbnJ0vvwFNz/01BPjF4m9rZdFf7rzo2xLFlAVIjHFWXBX/BPRA95+OmAVl
         8j+m+a5rAiMHdmc584/y5ZOgjs6VkuMLJXc3C9s6GJTRpHabTG4RED+EgHc0BvOpJWe4
         i7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GDrviT7pYkZ/XECogfqjELwBhZ+0VUiIqMlWTI/BqbY=;
        b=U+mAabR4IYC07xvK0zRQrB8JX2/hWo5N9JJ3uu/UY59M0dCi55YSAZIi1l63Fy2jtV
         IkwmKHNn0EKukgkJr+Wo1pBsqUxwdyVMeHIaIba0oZB06mNjUralVHFaDZcQkaUIMfyQ
         U/+up1VZDrpn1vF+jQiIW1dZhXtPjy2Zgkp+rGuyMv7p6uO2ii7ilor90TK5wQD97a0r
         vcuix6CoW+3q052FAM5oAZWbpLHN7AzqKI8+iRRny5ak7cPm0ikfkvM8Xmpv3WMgpszk
         Q30Ij2SncAB/3aSodcOm2q3JbpSCAMIJdJUfZg+LWTIYZFqaasBVyoiPChp+NEeOOUc6
         q/lg==
X-Gm-Message-State: APjAAAUZ98++iOb9HmT52/Wozbxm8Vo6L7iyjV4HVO2d3U8NKMp2MJT1
        U6zedazj8RDOc2hAmv3YlmI=
X-Google-Smtp-Source: APXvYqzHGjcDY9Ql2f2fj4dYZs0dj2D/hBUoiF9UZXP6YYJERNsYBsXlj1vB7RPfiJk8Aoo6yQxAcQ==
X-Received: by 2002:a17:902:f082:: with SMTP id go2mr77561475plb.25.1563784442391;
        Mon, 22 Jul 2019 01:34:02 -0700 (PDT)
Received: from localhost.localdomain (p2517222-ipngn21701marunouchi.tokyo.ocn.ne.jp. [118.7.246.222])
        by smtp.gmail.com with ESMTPSA id n89sm51344032pjc.0.2019.07.22.01.33.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 01:34:01 -0700 (PDT)
From:   Eiichi Tsukata <devel@etsukata.com>
To:     mhiramat@kernel.org
Cc:     juri.lelli@gmail.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        williams@redhat.com, Eiichi Tsukata <devel@etsukata.com>
Subject: [PATCH 0/1] x86/stacktrace: Fix userstacktrace access_ok() WARNING in irq events
Date:   Mon, 22 Jul 2019 17:32:15 +0900
Message-Id: <20190722083216.16192-1-devel@etsukata.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621231232.259536faeea4b19cf39a7688@kernel.org>
References: <20190621231232.259536faeea4b19cf39a7688@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I also hit the same WARNING previously repored by Juri.

Hiramatsu san's patch looks good to me but I found that perf and
oprofile code do the similar thing by just directly calling
__range_not_ok().

  perf: perf_callchain_user()@arch/x86/events/core.c
  oprofile: dump_user_backtrace()@arch/x86/oprofile/backtrace.c

So for simplicity, I wrote a patch to fix the warning as other
codes do.

Ideally, we should merge these similar stacktrace codes(perf, ftrace,
oprofile) into one, but this time I made the minimum fix.

Eiichi Tsukata (1):
  x86/stacktrace: Fix userstacktrace access_ok() WARNING in irq events

 arch/x86/kernel/stacktrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0

