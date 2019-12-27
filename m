Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676E8C2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:37:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32F0C20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Y/fnMhtm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbfL0Lhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:37:38 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35307 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727144AbfL0Lhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:37:36 -0500
Received: by mail-wr1-f68.google.com with SMTP id g17so25841808wro.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 03:37:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bpIiCK5WqIgrEaa234cHRdees/ayR1lDtho4HV6gLnw=;
        b=Y/fnMhtmNh8pgB10eb6arwxjSyLM5+I+paY7YL2IY/MObHLoX8vbJpouoENflytyaM
         WqU+HtXQz4r16r9lvNxZKbTRaCliJrULZE9RAjeLemCG2ImoRtxfc7X+bp7ZCtPIIzbE
         fkXql1aoW++4m07KH7nGnnx+kQqDJSCp1fHag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bpIiCK5WqIgrEaa234cHRdees/ayR1lDtho4HV6gLnw=;
        b=QlsiznDsgl0FdAIi2AIKvllbL5CRSBQHNRgRMZKnIMBM+xaDVYcDe4e5ttSKXYhlTB
         mJ0nGnrT5r5bTPB3BPIXZIk4rb0YSP4WpFkjFIBjYvofs/d1kEoP4GyPdr0fR27iGtdY
         RB32oDfl/s/D6z9ByAkt6qolkn9rPitu9SoMdvp1YjW7NughVcc9K+RXboeCkgalB4mW
         0SrUfJAQ8/cRngIuwqG0kSpnc+X4FQZyjBdNDQMp65SBf74pgG0oC8D1HJwQ315xLNJl
         fy9Zvh3arodqdRn7WWWjgsTJa/+Qgr4evjPt8b+ze/d8jnT/HvUqB5bxk5sn3V5LYXSK
         nq9A==
X-Gm-Message-State: APjAAAXcUj0e4S3qnuLDR2KLMBKPL6wBqUA643RUkbKXxsBJB685pWix
        R9uKI8hUEIABcABR436kZhzFkQ==
X-Google-Smtp-Source: APXvYqz7YRORD3nJ5nHFQjwcVPr4Hrl8QOet2glGy16vOAsGaad37FExuqc9Dqqfmtsyv49zuqK2bQ==
X-Received: by 2002:a05:6000:160d:: with SMTP id u13mr51720244wrb.22.1577446654952;
        Fri, 27 Dec 2019 03:37:34 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id r15sm10972362wmh.21.2019.12.27.03.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:37:34 -0800 (PST)
Date:   Fri, 27 Dec 2019 11:37:32 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "zhengbin (A)" <zhengbin13@huawei.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191227113732.GB442424@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
 <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
 <88698fed-528b-85b2-1d07-e00051d6db60@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <88698fed-528b-85b2-1d07-e00051d6db60@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zhengbin (A) writes:
>How about tmpfs and hugetlbfs use their own get_next_ino? like
>
>static DEFINE_PER_CPU(unsigned int, tmpfs_last_ino),
>
>which can reduce the risk of 32 bit wraparound further.

This won't help by itself, because in the case presented the wraparound almost 
solely comes from shmem alone.
