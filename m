Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6CBC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F45A20828
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 11:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="wA9y8xWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfL0LhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 06:37:01 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38528 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfL0LhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 06:37:00 -0500
Received: by mail-wm1-f67.google.com with SMTP id u2so8046524wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 03:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vYLFB/uLWChvEa1SjgamsZ5n2OMiY1NO7RNKVGxv64I=;
        b=wA9y8xWm9ulX0jcjr/Q4fMa+CIjLe1WNOnrKOG6FQ86CpFV+mqxMkBOftKML0d6v/J
         rCxUMWOO2JA/WJCAQuwBzCkWnauR8fPiOuXQXFeuR40G4SNS0oPJPgZ1GxcPUloGPyoc
         rTAqTUplNF/TJVhhOC3Qn9Zo61xTe4hukSBt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vYLFB/uLWChvEa1SjgamsZ5n2OMiY1NO7RNKVGxv64I=;
        b=QgOlz2GeibYonCVHnf0I0gfmS0oMx8yP4Off5KQm3FBf28uod8HMprwxxyzGC1Db/7
         WenUkaLj7Qo1ZLIILPWykmhih9m6yPqNHGki4iYDnO+WhHjO6KFfnvp12NtzvrkcpMqR
         bLQ6GPtFcax8KSsmPrp/ajiKAzaHksmynsPF0YTOfeKCMChwIVpwgZVULnnuufZitkBS
         B4JZc04uQpaRVJpf4VvGhEwlcK6EHKbdVudocJEhoLbVd8lRYrHlo/vVtX0WkRIKcLD1
         yv4CRRTYzW3Mra9aQCHp+qs7oztcq80Si4sX2o0dhPjqdypKWfLB2s0+pZdrp42nrIau
         vcQA==
X-Gm-Message-State: APjAAAVE6oZYo5tg2Nh5OT+kKg1v+fn9YZpUuWxr2GWLf+URHZdas7L4
        18QLQomYfyTBxDSl4kjRFi8YEQ==
X-Google-Smtp-Source: APXvYqxdWbM0VFPfavkOQ7Syvg3XtT7I6sj7u2hO46ItzR9trEv+MnBpW96YfNZeXSYp+QJnuqLO4A==
X-Received: by 2002:a1c:8095:: with SMTP id b143mr18803322wmd.7.1577446618889;
        Fri, 27 Dec 2019 03:36:58 -0800 (PST)
Received: from localhost (host-92-23-123-10.as13285.net. [92.23.123.10])
        by smtp.gmail.com with ESMTPSA id v83sm11119135wmg.16.2019.12.27.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 03:36:58 -0800 (PST)
Date:   Fri, 27 Dec 2019 11:36:56 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, kernel-team@fb.com,
        "zhengbin (A)" <zhengbin13@huawei.com>
Subject: Re: [PATCH] fs: inode: Recycle inodenum from volatile inode slabs
Message-ID: <20191227113656.GA442424@chrisdown.name>
References: <20191226154808.GA418948@chrisdown.name>
 <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj8NVwrCTswut+icF2t1-7gtW_cmyuGO7WUWdNZLHOBYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amir Goldstein writes:
>> - bpffs
>> - configfs
>> - debugfs
>> - efivarfs
>> - hugetlbfs
>> - ramfs
>> - tmpfs
>>
>
>I'm confused about this list.
>I suggested to convert tmpfs and hugetlbfs because they use a private
>inode cache pool, therefore, you can know for sure that a recycled i_ino
>was allocated by get_next_ino().

Oh, right. I mistakenly thought alloc_inode was somehow sb-specific and missed 
that these don't have any super_operations->alloc_inode :-)

I'll reduce it just to those with this explicitly set.

>I'd go even further to say that introducing a generic helper for this sort
>of thing is asking for trouble. It is best to keep the recycle logic well within
>the bounds of the specific filesystem driver, which is the owner of the
>private inode cache and the responsible for allocating ino numbers in
>this pool.

Thanks, considering that alloc_inode isn't sb-dependent like I thought, that 
definitely sounds reasonable. I'll do that and send v3 then.

Thanks,

Chris 
