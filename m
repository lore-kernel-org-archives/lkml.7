Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE19C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:00:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05D0243C6
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 01:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559178020;
	bh=mOlHFE1+Ppn/kWSymrCHn/kbXSRXZTsTvRQJ4IKBq/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DcWWb1avcgUhed+EtxnABdaiJhF+yk3z8eR3hKMkSvIAfA/n51eQcPKevWnZgmjij
	 9ZHfVNE3D/qaObe/GWKyp3QEumDZ3aQhaEYTW0U8Yv1yUENsGKrUP/cKGgZas8Xuop
	 LpUMynb5psFG3KPXCWfxyCoUFCLeTaZIZBsSzs94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbfE3BAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 21:00:19 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33294 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 21:00:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id h17so939080pgv.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 18:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XRlSYLoD4E5PFdWf0blCPVXMfB6705TGt4fGp1hTonw=;
        b=LMp1JMUR5OF0ObdvCOQBIrzuxvqpSThxpnR/XI/qwMNyLrdIzK0AsjNtsEWIUHq2gE
         YJYh23NUT9JFSyvMPc5TR+gMOBMYuLEPP32mv0l1RMCyL8Ubew+asrpi1kEoKCQSbWXE
         xd0+41OXxJf46aEkpDBM2BkuOn3utI1/R6IgRCytdJrrsmawfrCax1e1BOw8oA74mBcj
         urRewhtBiCo7GiX8N4XCYal6Q1L+Tl84H9N1hEnTj3dvlf5ao5DClL/rVPWjxJ9Hwdnl
         r7iIbqeYyRgP1FRjYO1Cd6P1FW3PGVDBUy/ddXF9uR4sbMjaQUW2gdgOm7OeNX0q07bd
         ubkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XRlSYLoD4E5PFdWf0blCPVXMfB6705TGt4fGp1hTonw=;
        b=PVPPsh3ab1ypQOpVoQlCbxlSO6yliAF3uPA7QBmyM2gov9Yn4rE4xfy0tJ9CX3elbH
         gkaWKuXeUY0QQqtSt1BfEdVNfqdyEz2Iih7ToA2oDPG96LIZzt7N5FD9wJGEv4hIyK5D
         knJzdsZqAb9EBqGmvAz2mum8LtNP73JIcNwpWpBicInmPNTMYf0NS4yKp8Ykr6pCtY2T
         m8l7hXwGP9Q1/wGBYh/6yRRlpjU4GeS93IdeG1OksXInKZ4oH+YuQcbRtxAoLGJ5oeJh
         9Kd8j8TtlWEx6ZdLn87s29GFpTTuSGAbcxzz15Ds6FP8bE4gt0/g1XbZcTHGr41xX9+l
         jM4g==
X-Gm-Message-State: APjAAAWPZ9gpHT+Ur/tv/9NJXf7u/B7uS0j2O5mPjyb4ROAfEn7NK29P
        trG6suukMIGmlP1cyYNDDZo=
X-Google-Smtp-Source: APXvYqxqwbIwYQ/1yzfwdYwflNKWsqdcWd22sixyaOeEbpdtllSoeSpuTwEbWi4MsjTxY/QSWz5GpQ==
X-Received: by 2002:a17:90a:db4d:: with SMTP id u13mr628664pjx.43.1559178018805;
        Wed, 29 May 2019 18:00:18 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id x7sm856271pfm.82.2019.05.29.18.00.14
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 18:00:17 -0700 (PDT)
Date:   Thu, 30 May 2019 10:00:11 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: [RFC 7/7] mm: madvise support MADV_ANONYMOUS_FILTER and
 MADV_FILE_FILTER
Message-ID: <20190530010011.GD229459@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-8-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-8-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:36:04PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 May 2019 12:52:54 +0900 Minchan Kim wrote:
> > 
> > With that, user could call a process_madvise syscall simply with a entire
> > range(0x0 - 0xFFFFFFFFFFFFFFFF) but either of MADV_ANONYMOUS_FILTER and
> > MADV_FILE_FILTER so there is no need to call the syscall range by range.
> > 
> Cool.
> 
> Look forward to seeing the non-RFC delivery.

I will drop this filter patch if userspace can parse address range fast.
Daniel suggested a new interface which could get necessary information
from the process with binary format so will it will remove endoce/decode
overhead as well as overhead we don't need to get like directory look
up.

Yes, with this filter option, it's best performance for a specific
usecase but sometime we need to give up *best* thing for *general*
stuff. I belive it's one of the category. ;-)
