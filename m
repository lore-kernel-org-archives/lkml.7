Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CD5C33C8C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6590920715
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 17:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="P/XrLA3s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgAGRoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 12:44:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39518 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgAGRoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 12:44:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id y11so381760wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 09:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8eqMnrGTPiMzUvhdb0Z8uXo41jdrtgsf6hpzBK0nlMQ=;
        b=P/XrLA3sWbGycnyupfzOxWdJivC6ceAXPPCxrnLUPh+TduZx5ndkDZmQXFSHrof9j/
         tQD9SaAE/CdOr3P0R5dH+i1X2R95TWzLK/Jp8GKp77O7/YBGVPPkFEYnAgDIzrogEDyu
         S+xg3zJZWVZX3XvTEenCiAzsGCh+QTqRMY1+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eqMnrGTPiMzUvhdb0Z8uXo41jdrtgsf6hpzBK0nlMQ=;
        b=kL5NTPpbAfjb/SfgQ4yxKS+HgVNlVoasnx0J+jJfY9Htscho3rNrSB4QZmU8xOTtIJ
         zxJEDQO42ydRalKeZinqvKzqilxMKHRbV2y/fN2EheFRHtXGJ9DuEkz9h/Y6viYP6Fu4
         QimoyYpKizbT2Z3KYjxWjw9Aat562Eux65qufLWYs3HDeWQ05W8R1sYtZxj0i/jrFVS+
         nSQmvQIQ8o2ypMv8gj971jmZlmJUo/a3ybcBeSc2wDYaQpcvYiYBJJA6eLY0xJUXFTED
         TX2uSUVWH9Vhhj2eu9AH8CVs625rHbT6GIiB+GebPBq4Jieg3PHTg3O9rThN2S64gbHn
         qg6Q==
X-Gm-Message-State: APjAAAXAzhQgHR0s7dgK18wv/fdhfGDmJPy8KMN8Nm9eMyfgrJlgmYrM
        YDdI6V9jsV5CCU+Jb1Y82D0ZVA==
X-Google-Smtp-Source: APXvYqynyqHQyph7mlkfkGczhahKEDtFTIiSOiCq7anm6rJZZrYX1taZ671LNRgmt2SgYo6hlDdfDg==
X-Received: by 2002:adf:82f3:: with SMTP id 106mr225820wrc.69.1578419048428;
        Tue, 07 Jan 2020 09:44:08 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:2344])
        by smtp.gmail.com with ESMTPSA id u1sm413118wmc.5.2020.01.07.09.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 09:44:08 -0800 (PST)
Date:   Tue, 7 Jan 2020 17:44:07 +0000
From:   Chris Down <chris@chrisdown.name>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] fs: inode: Reduce volatile inode wraparound risk when
 ino_t is 64 bit
Message-ID: <20200107174407.GA666424@chrisdown.name>
References: <20191220024936.GA380394@chrisdown.name>
 <20191220213052.GB7476@magnolia>
 <20191221101652.GA494948@chrisdown.name>
 <20200107173530.GC944@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200107173530.GC944@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

J. Bruce Fields writes:
>I thought that (dev, inum) was supposed to be unique from creation to
>last unlink (and last close), and (dev, inum, generation) was supposed
>to be unique for all time.

Sure, but I mean, we don't really protect against even the first case.

>> I didn't mention generation because, even though it's set on tmpfs
>> (to prandom_u32()), it's not possible to evaluate it from userspace
>> since `ioctl` returns ENOTTY. We can't ask userspace applications to
>> introspect on an inode attribute that they can't even access :-)
>
>Is there any reason not to add IOC_GETVERSION support to tmpfs?
>
>I wonder if statx should return it too?

We can, but that seems like a tangential discussion/patch series. For the 
second case especially, that's something we should do separately from this 
patchset, since this demonstrably fixes issues encountered in production, and 
extending a user-facing APIs is likely to be a much more extensive discussion.

(Also, this one in particular has advanced quite a lot since this v1 patch :-))
