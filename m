Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99497C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C82220863
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553017652;
	bh=glXpESmb8KvD8pi524J9aPEOAw15KniUMe1SWTzOc08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R+fGK7sQfjab0LLtGNwwTh6oRGWBj1insm/2eEVYmq/3gx2PEBY7F2mPfYRwQRp+z
	 vfZoJ48JVq94lvAkWWpSZfTOtlDnsUhOybw0VaRY+22VI6SN3uxlLRUDooM7XJZepT
	 /+YuFxvjBdGSxBdd+0cfehIwXIiyUSi9DXJ/Q3Zc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfCSRrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 13:47:31 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46726 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbfCSRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 13:47:31 -0400
Received: by mail-yw1-f67.google.com with SMTP id v127so16309711ywe.13;
        Tue, 19 Mar 2019 10:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3TV5JSMWzDFmGtM2a9PqyZpbM8Cae0apS79wiWWNBuA=;
        b=Of9nZV6g8OozSHtv9gaoyJHGTNVH7aXpFqRf7RG2ulzzh7pwgQj53Ja9kX4SRoysBf
         WTKUwYdhh2cfDrebplPomarUMEhL9wABj/zt2or1kA+U9nPmOmvu8bTqYnxuZcgNZUmU
         tkP6/jg11wyPjsJxwqSNiWbSz57afpm12rthIEQM5jtGDCutSoQDnwIcSgNiW/mDuErG
         CublhaTz5si8j5tJnDxiB8H4gboyWwZw9o34/V5gWFi4+u58GPYemOmMoJ9Iekhxniya
         i5AQNeWP/Whmt+HztHFXJQdO2K12aJk/BkdI/7D0PdklhRP84DYlAqncJICe247p4L5Y
         yU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3TV5JSMWzDFmGtM2a9PqyZpbM8Cae0apS79wiWWNBuA=;
        b=LpzB2GYUUg4vvVjEqGZxVxdzny8+ixFOlg0pYC3O5tGlFMC41o+40V0P2MP0l7J9oI
         eSdNdgMi88W4VpmZCs1jIu4mIMoNQaveKSl+bUJ2efN2koS+hoCXdo/HxH6TQl3Ss5Px
         hNnYNeiYVnJ7pfe+CW3cXf6s6gxDALKPan7jfAhEOS+VKyimLpDverfBS2zcvpEvA68+
         o5c6eWWkIjFiWEenLqE7UDWOLH03YDJyUSfSX+TBSBS3p/Hb392Gcewl6wPRLXJFuABA
         ZbiG+m0sALPRKgt0ydHukBXg4YNJx7FbooJ6thw87nCtWD5fnDYiAYlr6tORUfj2+8tL
         obvQ==
X-Gm-Message-State: APjAAAVZ/58O6FftuZHbAwUU06RBGvDLTDhcSPMlOpK1JINGHf8ekaMZ
        nOVeXwnvr/WwB2mWsZfA46o=
X-Google-Smtp-Source: APXvYqwHDJ7YG7jNKx+tHayfCaH93EKIvt1NPX/iUHmKCXdnAs6bD1EZDII0MdWTJsBN7A+pOzcaDQ==
X-Received: by 2002:a25:c9c7:: with SMTP id z190mr2210886ybf.234.1553017649632;
        Tue, 19 Mar 2019 10:47:29 -0700 (PDT)
Received: from localhost ([2620:10d:c091:200::2:5a18])
        by smtp.gmail.com with ESMTPSA id o64sm8805ywb.25.2019.03.19.10.47.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 10:47:28 -0700 (PDT)
Date:   Tue, 19 Mar 2019 10:47:25 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aristeu Rozanski <aris@redhat.com>,
        "Serge E . Hallyn" <serge.hallyn@ubuntu.com>,
        Michal Hocko <mhocko@suse.cz>, cgroups@vger.kernel.org
Subject: Re: [PATCH] device_cgroup: fix RCU imbalance in error case
Message-ID: <20190319174725.GA69236@devbig004.ftw2.facebook.com>
References: <20190319013659.86199-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190319013659.86199-1-jannh@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2019 at 02:36:59AM +0100, Jann Horn wrote:
> When dev_exception_add() returns an error (due to a failed memory
> allocation), make sure that we move the RCU preemption count back to where
> it was before we were called. We dropped the RCU read lock inside the loop
> body, so we can't just "break".
> 
> sparse complains about this, too:
> 
> $ make -s C=2 security/device_cgroup.o
> ./include/linux/rcupdate.h:647:9: warning: context imbalance in
> 'propagate_exception' - unexpected unlock
> 
> Fixes: d591fb56618f ("device_cgroup: simplify cgroup tree walk in propagate_exception()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Applied to cgroup/for-5.1-fixes.

Thanks.

-- 
tejun
