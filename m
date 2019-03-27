Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07ABC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0394206DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 13:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="bkH0m9SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfC0NEd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 09:04:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39118 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfC0NEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 09:04:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id j9so18473938wrn.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2019 06:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=crf1Iecu3EOEPIAilP0B17w6/ntCR3m+XRl1tzv0Lek=;
        b=bkH0m9SDwm9Uw2UujNsQbl7tcQUwj2HqYbF1eHksp8PReaG/yRIvJojVadxen3wxEW
         1jq44Ud9sZvKizEvcRg5EIIFSWNFRAoQ99TIidDZ/1l4SiJj+NOGb6WM4EV/OwKPxDtf
         F9Zbz522SaeBqPPammzpkeTLUbhEKp/Em/KcZAkA4TBZ8OsaxOoq+MTW0oaKjqiNzCIf
         wt3mPJkOwfaFsjoosoaKNj2G8VNRRJlBkurI+fMh7ANGixWs3TnQBkk+aLcO2rJ2/NXR
         iJu1mBxHRhsvLVnfzcB204pSEWqmlB/eNkWjj2N+50erchBZDZTzrvC48MltXEYnSvK2
         KhLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=crf1Iecu3EOEPIAilP0B17w6/ntCR3m+XRl1tzv0Lek=;
        b=KmxSbAFCi9bLYc+xtGSL6LIIPdDwP4FzTEZLLyPEsjBaRZbAfXrSM0E5PqLJJHnUp7
         1zXW5vap5tCjEyueoj8o48btvFc6iS4c4cuBMJU6CsQyzVLlVC9uPwBDPyMQAxDTeYMX
         KSRoFN6EWjzHuzsNCEDNvCECQv52enymMeAHfDJOLIGIykt8LrDZr29kbm4QmAp2pLJu
         TRYADKcerVWc2yFQwedvisfAsKmZ/HjQzqCi/BdBQlOD2YcgtHWyrYI5TPrpyIMgkEGz
         Z2GdyNF555knTkTdX+jPFjiNjeDz9QOEMNkaH6nFb7FeY3QBzust1g/UfZSg4h/kVm42
         cemQ==
X-Gm-Message-State: APjAAAXHBr0mUOSFVodugmUaDZrb8zZiJTyPHFEvHRuOoh2AUlMFK2+w
        rLaSSGZgXzjfX1YAx9VvVvbXGQ==
X-Google-Smtp-Source: APXvYqz0bzT9UX6YiZMsMIdPGjpQ4ivmAYhOjG1oa0D3n7BbzWhCGLvfuw4t2oeQi+/gHzdSfXGUKg==
X-Received: by 2002:a5d:6b4a:: with SMTP id x10mr22874279wrw.63.1553691869937;
        Wed, 27 Mar 2019 06:04:29 -0700 (PDT)
Received: from localhost (ip-94-113-223-73.net.upcbroadband.cz. [94.113.223.73])
        by smtp.gmail.com with ESMTPSA id a22sm1752102wmj.44.2019.03.27.06.04.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 06:04:29 -0700 (PDT)
Date:   Wed, 27 Mar 2019 14:04:28 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/22] ethtool: implement EVENT notifications
Message-ID: <20190327130428.GB14297@nanopsycho>
References: <cover.1553532199.git.mkubecek@suse.cz>
 <971a93b567c81103716902cd1ad00946201f9710.1553532199.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <971a93b567c81103716902cd1ad00946201f9710.1553532199.git.mkubecek@suse.cz>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 25, 2019 at 06:08:21PM CET, mkubecek@suse.cz wrote:
>Three types of netlink notifications are introduced:
>
>  - ETHA_EVENT_NEWDEV to notify about newly registered network devices
>  - ETHA_EVENT_DELDEV to notify about unregistered network devices
>  - ETHA_EVENT_RENAMEDEV to notify about renamed network device
>
>The notifications are triggered by NETDEV_REGISTER, NETDEV_UNREGISTER and
>NETDEV_CHANGENAME notifiers.
>
>These notifications are intended for applications and daemons monitoring
>ethtool events to allow updating the list of existing devices without
>having to open another socket for rtnetlink.

Wait. You duplicate events that are already going out through RTNETLINK.
App should open RTNETLINK in order to get those. Other apps are doing
that too. I don't think that duplications like this are desirable :/
