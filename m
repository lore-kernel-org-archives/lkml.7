Return-Path: <SRS0=g5d9=RD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF6AC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F2D2133D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Feb 2019 12:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="QjwzuLxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbfB1Mvq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Feb 2019 07:51:46 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34294 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbfB1Mvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Feb 2019 07:51:45 -0500
Received: by mail-wr1-f68.google.com with SMTP id f14so21847753wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Feb 2019 04:51:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9abm0vdzy1u8k6t9ZPdWfEHMFX/OS1Bdc2ERO6x3ga0=;
        b=QjwzuLxDrl+HPKlwdKfODyAY2mBGwVvTaW9CLwhP32n2Lvx/8GicnuinoOZWPO8NJP
         qsjsDgtvcl/0BePwDn7LlW7Vyc1CI604eY1Jt6o6HWr2VcYo2muKLPsjM/ljuwaBxvbQ
         bOpUhPejtlwVVJHXuL2oF7YeBoiy+i3VrcLRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9abm0vdzy1u8k6t9ZPdWfEHMFX/OS1Bdc2ERO6x3ga0=;
        b=jjnNMsByJU5t1B+ELh+Z/dESnfRgj62a0b5s0dt+XneRlLdRocsltmk/8qtnXtZQEV
         iX//F6QSfkqOzohO3T2S38fy7EoKnGPkjQLplvERrqcwo3VccIlSdoZukPClf6Ey/RiC
         uvdi7rZgp5EOE1OwdNVgIJFWYXuATN7/0T2WHubha4r/UcDBTLjqILILbqPegf1wHe2L
         4Hdtgh7UPYmRYi9MskW8yWPx9NVsQC16Gx28E8+JEuP670J8YVnwS6h/hHeijBAPRMMf
         ftekhM7WmzWW9gZFmn+BitPMulvkZNt0sbchyUA9A11ENkqDfFEixfP0+8gqiRxhy1jZ
         LGaA==
X-Gm-Message-State: APjAAAU4hFM3IkC7/9s0WOinA2HLKh16mST0EUq6KJsP7TjSUfRfjWmK
        0bGoaIjUOZOCW4AvbBQxb9Cld7VeIug=
X-Google-Smtp-Source: APXvYqycnvwkVA52YbGqmvi8Gr4mzZGaRSuKwx2AMis/NyMnS1IjehuHd5ENSFRGBC/ossCj84e1lw==
X-Received: by 2002:adf:9cc3:: with SMTP id h3mr6010367wre.47.1551358303852;
        Thu, 28 Feb 2019 04:51:43 -0800 (PST)
Received: from localhost ([85.255.236.253])
        by smtp.gmail.com with ESMTPSA id m15sm14260352wrx.30.2019.02.28.04.51.42
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 28 Feb 2019 04:51:43 -0800 (PST)
Date:   Thu, 28 Feb 2019 12:51:41 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memcg: Handle cgroup_disable=memory when getting
 memcg protection
Message-ID: <20190228125141.GA7365@chrisdown.name>
References: <20190201045711.GA18302@chrisdown.name>
 <20190201071203.GD11599@dhcp22.suse.cz>
 <20190201074809.GF11599@dhcp22.suse.cz>
 <20190226152958.726b921f0cb03ccc50144539@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190226152958.726b921f0cb03ccc50144539@linux-foundation.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:
>Things settled down.  Here's the rolled-up patch.  Please review?

Looks correct to me as patch author, thanks!
