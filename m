Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A51C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6105D2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 22:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hnLnV0Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbfDYWpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 18:45:08 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35658 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbfDYWpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 18:45:08 -0400
Received: by mail-pf1-f193.google.com with SMTP id t21so655524pfh.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 15:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q3t7m72xnriC1AtIWYUp+t+avKLKvsO18nYRudIdLpE=;
        b=hnLnV0Fm4GpZPPZZifuFJOv5LDjcCq0mbhuM/jcZ/0vyr6Yc60Lqblv/WuFTi+U7mu
         QAfMAtl5b19inEcIlK3vb+mjrMpxvKRr8Xc+52e7+236bXx8ykIsH4UX1ejGqbTvH+4z
         C9SbfbF5GFGVkacgvSNsO6QstuqtMcgkcTAlhZVm7W1ZFkra3qvPO5Ci3tmD6e6uiJ3u
         dUBoNHaJTlQ+6SaP4UKLJJVyjJoA48IhxuH/7pTTjJST8G8GnQJV9m3AAajQi00xsT5C
         i8nb/7PgcRiifOv8Q47j7uBGvFK0wLPnnUVOjRL7LxYFAnO3TwFYXWPGYVw3HSjtvjcT
         4qgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q3t7m72xnriC1AtIWYUp+t+avKLKvsO18nYRudIdLpE=;
        b=oLKzN5JmhgPijbZM0FWc8c5g8c4r2bNJdQJqlSsNrs7OXOI887M9tY6tz2LjCLgzYS
         vDN70dvl5vCUpgWUojvg6T/d27fnWK8cduVs5et0rGi+ufn4MesrhtU42+uXIJZ/etjQ
         TE14f/RNlzxjKIRSAXSVAXdJLQtt645ITs6YM+Iz5AzBL7DJrwDs7rVn4DOmptM67KAx
         BrG031vtg8PXCQ1uVf3HUR/UTPl9I/AB6F1M4hc9Lliw2L9wAKyrWV+VZck/LfH/5CsG
         1XipzLmzatKORM/2FYvoKMmcyt+tchoUvxUhFn6cTT3AIfGLjYmWTeUO7BEFWTzxTu+U
         SdOg==
X-Gm-Message-State: APjAAAUZ609fDK1e3nqNNCsF/KgRcujWG6ucMdFquQQVMMHg4/MADo4l
        tmi6YtDSYMRYn2yTinB3IFU4BQ==
X-Google-Smtp-Source: APXvYqy8MdezYsryP8VZmDPZmI5UuvvqQdblYNTP6/HPBb+61+E4ysVJSOb8TErbDzut4iNDM14Teg==
X-Received: by 2002:a65:654c:: with SMTP id a12mr8537744pgw.101.1556232307137;
        Thu, 25 Apr 2019 15:45:07 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h4sm31517875pfo.119.2019.04.25.15.45.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Apr 2019 15:45:06 -0700 (PDT)
Date:   Thu, 25 Apr 2019 15:45:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Joel Savitz <jsavitz@redhat.com>
cc:     linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH] mm/oom_killer: Add task UID to info message on an oom
 kill
In-Reply-To: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
Message-ID: <alpine.DEB.2.21.1904251544070.34263@chino.kir.corp.google.com>
References: <1556130013-19021-1-git-send-email-jsavitz@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Apr 2019, Joel Savitz wrote:

> In the event of an oom kill, useful information about the killed
> process is printed to dmesg. Users, especially system administrators,
> will find it useful to immediately see the UID of the process.
> 
> In the following example, abuse_the_ram is the name of a program
> that attempts to iteratively allocate all available memory until it is
> stopped by force.
> 
> Current message:
> 
> Out of memory: Killed process 35389 (abuse_the_ram)
> total-vm:133718232kB, anon-rss:129624980kB, file-rss:0kB,
> shmem-rss:0kB
> 
> Patched message:
> 
> Out of memory: Killed process 2739 (abuse_the_ram), UID 0,
> total-vm:133880028kB, anon-rss:129754836kB, file-rss:0kB,
> shmem-rss:0kB
> 
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>

Makes sense, could you add it to the end of the message in case anybody is 
parsing the current string and we would now break their regex?

This would also need from_kuid(&init_user_ns, task_uid(task)) instead.
