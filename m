Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D24EC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:41:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 022FE2177E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554410473;
	bh=MvbrbDSUOOY7F683YADSN6pxLJcCxA1jc0YMMoZ4FCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U6YyKwfsuWZzCYoSgqR1bjz3cMwGdLRJ816BUs9hl68DJ+XR1/v65JCvwCyO+iDR6
	 fGcalIpSkgpUGuGSwEqxZwWdsMbJ14or46xbO0pRjJ01MIDaZ1KXARQQwXSLiSAVYu
	 +tIjRlu8nqHFp0++dPlwNgdDQAmkD5mfVlwA7r7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731131AbfDDUlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:41:11 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45505 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbfDDUlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:41:11 -0400
Received: by mail-yw1-f65.google.com with SMTP id j128so1487839ywg.12;
        Thu, 04 Apr 2019 13:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YWVT86VODnemhQ8halJBxHEXUVOGSbGYGR97dsLgYLM=;
        b=CNxkjEf34OBeZL5d5pIjETWoXWcwekGu131qlrgHMN4kX3n0rJMk0BOAo84qWK2ApY
         3eeSqP/dPD8jk+Mn02zR/pNNhHFD+NF5DEnSRWVFH8UfeacLbkxEyGzkyXcPVv4pRrNv
         uCOjkbmuVXbBTTQLbc/bZS/69uiXq4wTwEML9ka/JlCEV6Pl06CwurEw6iu4Qg3aWU/e
         pHxjLW46mr01JR2nv8IOY0H2ZuFlhuP42umT3XCQsEMJRxyFRCfOYTHUQ9peYKNG66RG
         gF2k+6feJr18+76DcJsEd7XGOYw1WJG364YxMww1i6HmJfsOjrRHoTBW+Vz9z8PvEyCp
         0GFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YWVT86VODnemhQ8halJBxHEXUVOGSbGYGR97dsLgYLM=;
        b=BZuwPRWuR8HdqK4a9s/YrAcpZTEQyyBJtgI3hYw4ReHLsPei8o/XWmTPhSzDhETlw1
         V0yCYyQdRfy11N2mDy8TyHavEi986Q29WB4Mg+DSM8kpsKJ9TXUY2NAKgp/vgKCg9VNh
         hlAZF/4RfyFA2l0B7BQEhiCSxiYs7eXSB+kCmNdQbkvRXnmmJ2gHuNboj8hPGs6zh4o6
         cjtJ5+6M23waa/gaU9Db8a+nnlEb/jbr7VSiwkBFRgZ5Ti71FJ87epMn2vWdTvzL/RIU
         M7j2iq3KduAfimTNdb9GdizXmp4XUeoGsrzblP9erVJGbL8LXZPj9za3DiUQALRWi9WC
         JAnw==
X-Gm-Message-State: APjAAAXBA/+S9SIcCTDi3Wskry1WwrJQHx25ZYWDn4RSQ3qzmyY+0Yq0
        IEFR1r4p9Ot5mam+qvSqNPc=
X-Google-Smtp-Source: APXvYqx/F5+C9EjdIfkgG5eJ//8nSZ9WN6aFx+lzqgCqPl8IthXoDKjjjyP9UGZsyRaNwlmbhNp5tA==
X-Received: by 2002:a81:2883:: with SMTP id o125mr6890310ywo.17.1554410470593;
        Thu, 04 Apr 2019 13:41:10 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::3:a162])
        by smtp.gmail.com with ESMTPSA id j187sm11702652ywf.8.2019.04.04.13.41.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Apr 2019 13:41:09 -0700 (PDT)
Date:   Thu, 4 Apr 2019 13:41:06 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup: remove extra cgroup_migrate_finish() call
Message-ID: <20190404204106.GC1975820@devbig004.ftw2.facebook.com>
References: <20190403230354.117915-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403230354.117915-1-shakeelb@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2019 at 04:03:54PM -0700, Shakeel Butt wrote:
> The callers of cgroup_migrate_prepare_dst() correctly call
> cgroup_migrate_finish() for success and failure cases both. No need to
> call it in cgroup_migrate_prepare_dst() in failure case.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Applied to cgroup/for-5.2.

Thanks, Shakeel.

-- 
tejun
