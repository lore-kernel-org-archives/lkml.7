Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19361C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FD921556
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20150623.gappssmtp.com header.i=@rajagiritech-edu-in.20150623.gappssmtp.com header.b="bZgefzwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbfLKTWn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 14:22:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45699 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbfLKTWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 14:22:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id w7so1786656plz.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 11:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/omuTxLtHKj4Gwws5UIGOHbZDI0wtiUpMOSLjh5SOg=;
        b=bZgefzwEkt66di7eEoIMJi8Eb8O7LjWSQwmfhJVeDwUDKmw0C6bCkAA5kq0eZHIKsy
         fqPf6/5C8AO+W6y+hXe7JScra3Z8OWGSC7gvGbGW51dybvkxb7Y6rBbELKRH7obCZcWq
         /8P/13zoFwrN/6ftLXNcGZDfZbzlCa/8ZbjRDFl6UYrDqClHU7SdjrOQlgBwSZMX7nqm
         riXHtP1QlB9Xgc/Fhh3Di8/z8bEoDlm5gGrpMibEISDrxtczHKbUtlPjcF3oFrCgnyu6
         Tuxtzpb3m1hnxSu7TR1HAHXtTeT75eNtUal3VPwGOxuxvUSQRGKYnqHDVBVljoVyW88k
         a5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/omuTxLtHKj4Gwws5UIGOHbZDI0wtiUpMOSLjh5SOg=;
        b=meHNtFY9N4qAUZlmUqBBiZ30QusgojwixVBL7KXsZifWaT4KdTyHjPKx+qIWzX104x
         TWV2WE/9YSYnFsoP1XtITo39rqSGgVuPX6bJNv2w1h3/z2J+PAFJTbuPWbXPqxCtz9V7
         /8kNPW7RAyOtgIXFTVGn/ZnhCxHDFvg9UA655m7KR2YKuQ3LFDTbDFv9ekO4ZJjqo/0+
         abXhk+nYbyYeSd0V2GFsGOoZ6DzUTEzC6IHzntXcWtyp2QYALLar3phRpDFaQATUDQk/
         uCd64rE+FpNOf4iZHnCMsy/bXn0ROelCrVJVysRqDFVh/EjMTDpGgMMox8WSteNZPkDC
         u/HA==
X-Gm-Message-State: APjAAAWn7DuRQ+3mMPpfyCGShLEa7Cpc2LAXaY9W2I6vID8rBbU2awYj
        xZTdtdwJhrZt3RLlVtrd4w8KdA==
X-Google-Smtp-Source: APXvYqyX3BF+YrPnd9mOB8VeUOnacPqiHgPI5cziuwV5GAgotQQt7bXy8qJSwgEE+a7+bmAWTBFgaw==
X-Received: by 2002:a17:90a:1992:: with SMTP id 18mr5425701pji.46.1576092161690;
        Wed, 11 Dec 2019 11:22:41 -0800 (PST)
Received: from debian ([122.164.82.31])
        by smtp.gmail.com with ESMTPSA id a10sm3948864pgm.81.2019.12.11.11.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 11:22:40 -0800 (PST)
Date:   Thu, 12 Dec 2019 00:52:32 +0530
From:   Jeffrin Jose <jeffrin@rajagiritech.edu.in>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org,
        jeffrin@rajagiritech.edu.in
Subject: Re: [PATCH 5.3 000/105] 5.3.16-stable review
Message-ID: <20191211192232.GA14178@debian>
References: <20191211150221.153659747@linuxfoundation.org>
 <20191211161605.GA4849@debian>
 <20191211182852.GA715826@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211182852.GA715826@kroah.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 07:28:52PM +0100, Greg Kroah-Hartman wrote:
> that's really odd.  How are you building this, from the git tree, or the
> tarball generated?
git tree
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git


> And I still see that file in the 5.3 tree, what do you mean it was
> deleted?

may be during "git checkout linux-5.3.y" or may be i did "git pull" inside that branch

that was a git status which showed "D" at the start of a few lines
and one of that lines showed that file.
i also checked that path locally and found it was not there

--
software engineer
rajagiri school of engineering and technology
