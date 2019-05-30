Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC260C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 739E3243AA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559176529;
	bh=oO5qw6KcCYUQXW/Btf/T5AVuZKeA6eFYF4kxfBv2rHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bs5x1NnodY/USIwYQ/pX320q0mUogpBSwV7UTLHt0fC4G+OitJfcdHuFuu5bpk24T
	 utAbMxjxVEgvW2ykCk+39Ku1bLJQQPsuHv8QbLjBHqKhTaUMIc+Tp68kBJmnkpwxUe
	 B0hxm6dejbez8yZXW/M6VuSaCSUZx5HyUxIxBFQg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbfE3Af2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:35:28 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38279 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE3Af2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:35:28 -0400
Received: by mail-pl1-f193.google.com with SMTP id f97so1781403plb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2019 17:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WCSz9/I6gTeqg/ESOjee5MQIcRdo/bNNoxObWxNXK4E=;
        b=opqCw3aqBIiknEKeQodAFFu3OCxtwvP+W4j9BVCjB36idpHMrPJrPuD5ph2s9xacgY
         fafk59YaCZmoDVNf64N7EctZ0V370beTquv0AGmOqimjyZ5UBcTuiUG6Z927N967cMRd
         CR3J73QQiSo7PFksi/g2h10sGE+qf+UlSrsXgb0c1vE0F24uoabRtcUWmov3uOZMJETH
         XF0B0gxdMK1u6tihyh92ckmO5B4OJbRTm8i1dDuBzZ14eITrt+6tvm1PaD82ziYXfkfT
         YgsEDfXqnArQu3czX0Vt6HJALiMWMcI7uP1mPTqs2V91tk6hCvtV8fUoDsIYlt4rm/3g
         2A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WCSz9/I6gTeqg/ESOjee5MQIcRdo/bNNoxObWxNXK4E=;
        b=ozsKRTgoRHR9OuuPwJQCAOloN+L5NSv2pQsrwbuCBQYOC6B3VcuO1Rz4Y9OWzEldnM
         7qRyVfdyVNH7VHw5dMuUT7UTXg3P2erpAFGDNzudE8ELI45mnO8W9O4Koqfx6jYf7F67
         eFzsgCvWhLySdKRivdegEK2T9dH6a98ZLXRoGN6yLisr3dmteIf5sl7i7mjszqQAXQ+Q
         fDnL3MTaK6kR075rEZAJQPhVxL/07hq0qYSRMXMW73QRlRdyU2tHgeTMUVOuTeju1LDz
         CmROQtSod3TdfFsstMPEzLuOYxf7ZOb0TeJQoO+siXIoHwpJNi/Dkt81Vo1tRu5A4rFb
         mPZw==
X-Gm-Message-State: APjAAAU3wldJywwLkul6alckOg5nuRN3+vNN0Gz4ywSXRZVJB/63yt6q
        wh82GW91M1JreReVZPC1IWItGFw2
X-Google-Smtp-Source: APXvYqwqxTqPzeJe0bYTfxudVeVQk2PJ/n+gl8eR6vQJis3N9o3oE/pOOo35+eiB0i/2B3itKVDFXA==
X-Received: by 2002:a17:902:b495:: with SMTP id y21mr839620plr.243.1559176527378;
        Wed, 29 May 2019 17:35:27 -0700 (PDT)
Received: from google.com ([2401:fa00:d:0:98f1:8b3d:1f37:3e8])
        by smtp.gmail.com with ESMTPSA id r7sm751659pjb.8.2019.05.29.17.35.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 17:35:26 -0700 (PDT)
Date:   Thu, 30 May 2019 09:35:20 +0900
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
Subject: Re: [RFC 6/7] mm: extend process_madvise syscall to support vector
 arrary
Message-ID: <20190530003520.GA229459@google.com>
References: <20190520035254.57579-1-minchan@kernel.org>
 <20190520035254.57579-7-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520035254.57579-7-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 29, 2019 at 12:14:47PM +0800, Hillf Danton wrote:
> 
> On Mon, 20 May 2019 12:52:53 +0900 Minchan Kim wrote:
> > Example)
> > 
> Better if the following stuff is stored somewhere under the
> tools/testing directory.

Sure, I will do once we figure out RFC stage.
