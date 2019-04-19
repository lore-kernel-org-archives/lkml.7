Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396AEC282DA
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D9D20449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698594;
	bh=Fk08lzuxx9YIPTpIqZr6xlb8uL4OOSgE9HYPFfQIFj8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I+5CJjDW4gIDtsjn/1pi4dlz0nT3vH2A4cOwBIhul+9zdK6eWDZ+5wLbdUXT5dfOO
	 NhuWnpZ71Ut++4LjB0otyhx2q2V76Vk3/tZQ5chwouV3rOcqc6hnCMqtp5RuSEjjYv
	 T7c//z6uia0O9NNVUGto7i0DB8Xd9DRef6XuT/X4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfDSS3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:29:52 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:37716 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbfDSS3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:50 -0400
Received: by mail-yw1-f65.google.com with SMTP id w66so2166132ywd.4;
        Fri, 19 Apr 2019 11:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EGfjoyWDUmP1Izi9Q+pi/Uu5LN32TT8JKGIaCUuqYyg=;
        b=rQjb7ofOHQ/DGV9bGEujyiPdbToUujv3TKhbcFidNAeU8X1gNU+R2aFUsoDd6Ay72b
         fzN4RAxkQAo0kMYnP79v4fkq3ic7zjcwQbJGwYVJVc+ExBUGXcjK4pQTA5FRgWxLlJX+
         QnqSuqQKewniKKCg1+yi9Ufrx31MrjEl80ftj9ZzaZcCfOHIHXhVKz/MxWGMn0FUxTq6
         DSbNBbxdCRmanQLAw1eeCs77LMa/Y0yvmCI71NMvcLiaqeSwFKAL0BMiuj/TQArO0UDo
         xPdKtyrmfR5V3GuFJ1w4j1QUNRIuUJTAwbhilYkBKol3U77H1p0Yv9euO2UuGpAceV3Q
         vmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EGfjoyWDUmP1Izi9Q+pi/Uu5LN32TT8JKGIaCUuqYyg=;
        b=GSLaXWBxA0Tlk6RgDKoeOiW3qC72BW4W7+IhNLXaXs1wrntz6ErGoDyAD3ooqDmA2j
         AESJNYRt73zZa1Ht4nXA+539Z9TeLp+PF20SO7bE6doIGIQuoWVk7kg++ZkjqCB7/h1N
         5OkRu4YZWeTY3rPpVu6R8SnHJ7HniGR4kKZeAfJ4ASgi5hSKihKhPzAiX+p4kzqfqM2i
         z0QvvqDoa9dtkC/tfeB2XAyLam99q0LVxGwEf4Pemzy+/SuTHCaw6FUrewNnPB4Xytz+
         bBlkS6L6Bm5p3HJbSTQWmPbtZkfcArldj/esllIdEW7XbNjUWaI09EMF5DopHx2MIvw6
         EPlg==
X-Gm-Message-State: APjAAAVe6WWkZLR+vGzIHktsVmcFSHMILFIcErZjvQEhxsVKmvHtRf1C
        I97ayjFjnmeTaB4GjZJGid8=
X-Google-Smtp-Source: APXvYqwVhFUQG6FASXhai73ASh9SONTGMcAts3gxD7EIHsU3q/Ux/g0pcvEs3kmXElJLUcz3ExiOXg==
X-Received: by 2002:a81:4f12:: with SMTP id d18mr413370ywb.475.1555698588974;
        Fri, 19 Apr 2019 11:29:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::2162])
        by smtp.gmail.com with ESMTPSA id s127sm2600647yws.66.2019.04.19.11.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Apr 2019 11:29:48 -0700 (PDT)
Date:   Fri, 19 Apr 2019 11:29:45 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH v10 0/9] freezer for cgroup v2
Message-ID: <20190419182945.GH374014@devbig004.ftw2.facebook.com>
References: <20190405174708.1010-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190405174708.1010-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2019 at 10:46:59AM -0700, Roman Gushchin wrote:
> This patchset implements freezer for cgroup v2.
> 
> It provides similar functionality as v1 freezer, but the interface
> conforms to the cgroup v2 interface design principles, and it
> provides a better user experience: tasks can be killed, ptrace works,
> there is no separate controller, which has to be enabled, etc.
> 
> Patches (1), (2) and (3) are some preparational work, patch (4) contains
> the implementation, patch (5) is a small cgroup kselftest fix,
> patch (6) covers freezer adds 6 new kselftests to cover the freezer
> functionality. Patchse (7) and (8) adding tracing points to simplify
> the debugging process. Patch (9) adds corresponding docs.

All patches applied to cgroup/for-5.2 w/ Oleg's
No-objection-from-me-by added to (4).

Thanks.

-- 
tejun
