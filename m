Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EEC73C66
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E078205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 17:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="Ilf6P6dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728569AbfGNR6D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jul 2019 13:58:03 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36849 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfGNR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jul 2019 13:58:02 -0400
Received: by mail-pl1-f195.google.com with SMTP id k8so7160356plt.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2019 10:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5BHxOsI+XAwqjxerTJpZK4En7/uiTaKx3Y4NftepOk0=;
        b=Ilf6P6dxjQ1J6S6sE9Q1uOjUWR8fKClnhT3TK84V+Ick2+JWIwjbn8C0fNjllseJTE
         8BcxSAf3IujZ9OVAN8OAU+r+LuyeTu2wOffg6aHP4YN3G4y6/xnZ01ZQINJ0NwXNS3CF
         vicLMLDyHbVEVllNUrtRYLGOk0zk53lnHLceY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5BHxOsI+XAwqjxerTJpZK4En7/uiTaKx3Y4NftepOk0=;
        b=eNOD2LTw+m+zOxfao0ccfZsFM4mCUA0cA015bVEi6KHgb0cTL9W7vKv16tiZ+BBtAQ
         7qcIOlWscHrm1M0u7Ufin3fNk9XwyktNwvhwy09c830xEXjIRZ5sCyi022WJYzQonpBJ
         o/gnUrV7JgZE2C7C6ZOsJVnuln9x5QlbpeH3rhwsbHbss547zONHuyd6/jBYAHKuIlqT
         cujkHdolCUe3IVEkvMssYr/ZqT3QAi3WQkTrMcHaEH4r58rvaBo22se3nLUwPOQMA15N
         LLIYclpbnrtRw+A7iuqCetufk52QFdi3CA3GDaKOUU9s9nEFOxzTMsG/3lLc2n822noi
         S3BA==
X-Gm-Message-State: APjAAAWjff5yvnHap2bOhzHlUKNW13cUaU5qvmF8lHoMqpvVgZoBMN6Y
        UW7aVNCJS1KBepU8jiPgLfQ=
X-Google-Smtp-Source: APXvYqyLBG3mpFwvHO0ZoApKQQHwDKLnOEhOJA/OYvOPo2VIxF808hAgnu+SQnxqmkf2JUyUzOOjTQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12mr23164109plk.113.1563127081617;
        Sun, 14 Jul 2019 10:58:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v63sm15528340pfv.174.2019.07.14.10.58.00
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 14 Jul 2019 10:58:00 -0700 (PDT)
Date:   Sun, 14 Jul 2019 13:57:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, acme@kernel.org,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [RFC] Fix python feature detection
Message-ID: <20190714175759.GA34501@google.com>
References: <20190707144417.237913-1-joel@joelfernandes.org>
 <20190714154006.GB16802@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190714154006.GB16802@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 14, 2019 at 05:40:06PM +0200, Jiri Olsa wrote:
> On Sun, Jul 07, 2019 at 10:44:17AM -0400, Joel Fernandes (Google) wrote:
> > I am having a hard time building BPF samples by doing a make in
> > samples/bpf. While I am debugging that, I ran into the Python issue.
> > Even though the system has libpython2.7-dev:
> > 
> > If I just do a 'make' inside tools/build/feature/ I get:
> > Python.h: No such file or directory
> 
> because you don't have FLAGS_PYTHON_EMBED set?
> 
> > 
> > This led me to this patch which fixes Python feature detection for me.
> > I am not sure if it is the right fix for Python since it is hardcoded
> > for Python version 2, but I thought it could be useful.
> 
> we detect python in tools/perf/Makefile.config and
> set FLAGS_PYTHON_EMBED properly
> 
> it's supposed to be set by a project using tools/build
> for feature detection.. what are you building? AFAICS
> samples/bpf do not use tools/build

Yes, you are right. Never mind then. I was debugging feature detection and
ended doing a make in this directory like:

make <something>.bin which works always except for python. But as you said it
is likely a non-issue.

thanks!

 - Joel

