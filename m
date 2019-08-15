Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48E2C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA2D206C2
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 07:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rI9KVoef"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730669AbfHOHwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 03:52:09 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41170 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbfHOHwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 03:52:09 -0400
Received: by mail-lj1-f196.google.com with SMTP id m24so1466912ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 00:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7QKRw6h8ekNuRALJOQsNy9D/QAqlX3b3LLygjMpHmjE=;
        b=rI9KVoefLfkbRc4AJ/1grl9DhsL0e7p2639FeIUUlxzozg/A/uv2UMfLrRnYmxcB8o
         Pv9yrIQKE14CKnhFwhGNG/aF7OEbZEEOx9rTB9+a+b7AoRenbKMGVJUVuNT3fsq7xGpB
         fVSdUveQWL1lhXhAM4Za5LCtQMKMwNxtRs+Au4bMKdKF6JEH75wqSSP9vTDbZqpduIId
         8hkAdFlU3Dy+UOUwbgBJJunmNDGcEaADtY9nGZAcfwoeaNoNe6ZXXwW+5JGHSZAV3uYY
         8AUAbMnrAk8dURaywCpVWx72/4cBHXarssZsQw6o5t41FbOpGY3frpL401XaREdpcJjb
         8o8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7QKRw6h8ekNuRALJOQsNy9D/QAqlX3b3LLygjMpHmjE=;
        b=lVbOn6Da2iuVQBykeJ6uwufdugtwptvmCvABaqCd0uKptVZ/iKKTz9F6ok/UH17Icn
         IMr5XnysheTTNMd+TynyA0/VlJzXJmRdhIPdu7XziTojyOlMrJX6SDBK7RT0/IBpQMQO
         pcGb3oLajmj0tZvAKKpHry0DWqARwMdcGDN/vlSogn+wa5PCuW9mDontI5VG+wVSEPif
         fEasVxhQU3Bc0cFhsnOovpLfVkzJ396yjalPtietQPluohck6mTjdRtS6m4fkZGXZi6M
         7jVliq1am3lwKtzA0nckm6Zs3luqcokSUka1IF9p6+8/F9CEyIagNu0+5R9BZqUQ/4x/
         Tigw==
X-Gm-Message-State: APjAAAXTgfCJQ8oBqGW1LB+JmDFl7Jd+yr8VriFVu20dkxa3H39US8e+
        gRe+zyhRu56edf+GitCkpQI=
X-Google-Smtp-Source: APXvYqzVme39bM+Qo57K3icf2Pi7OoFj+y/oH9eApYTigQWgMYr65t2uiMOh553fKFyZWQoyYnf5Bg==
X-Received: by 2002:a2e:534e:: with SMTP id t14mr1985186ljd.218.1565855527206;
        Thu, 15 Aug 2019 00:52:07 -0700 (PDT)
Received: from localhost ([178.127.188.12])
        by smtp.gmail.com with ESMTPSA id q13sm358303ljg.76.2019.08.15.00.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2019 00:52:06 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Thu, 15 Aug 2019 16:52:06 +0900
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Subject: Re: [PATCH 1/2] vsprintf: Prevent crash when dereferencing invalid
 pointers for %pD
Message-ID: <20190815075206.GB26479@tigerII.localdomain>
References: <20190809012457.56685-1-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809012457.56685-1-justin.he@arm.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/09/19 09:24), Jia He wrote:
> Commit 3e5903eb9cff ("vsprintf: Prevent crash when dereferencing invalid
> pointers") prevents most crash except for %pD.
> There is an additional pointer dereferencing before dentry_name.
> 
> At least, vma->file can be NULL and be passed to printk %pD in 
> print_bad_pte, which can cause crash.
> 
> This patch fixes it with introducing a new file_dentry_name.
> 
> Signed-off-by: Jia He <justin.he@arm.com>

The series looks OK to me.

FWIW,
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
