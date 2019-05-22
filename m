Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC42C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366462089E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 19:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Py5imB+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbfEVTu6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 15:50:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46059 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387853AbfEVTu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 15:50:56 -0400
Received: by mail-pg1-f194.google.com with SMTP id i21so1823290pgi.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 12:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=53aAc4kEic3W8LcByj9D1czfciT2GPYNahiN2QB6f+o=;
        b=Py5imB+ccN7o6LXfkutFeYUWW139CLz2E1VxTs2FXquuFqOV908mn8GmCCogVKfVP7
         U0UfBb1Aw7WEW8TgOBS8gBW0TR4pK21SIbiyho+nNveHwAggyHhCVdcsu0l+7ZzjDR01
         +Ht0Ky4pHLeIli3ddDYSb8qoZaqRUJme/YIOGPuSUH+kTIIwzcMjf78hER7RWWdk7mxn
         y75tPCC/S/EvS7tJRukNy2Y+VN4djxJOvFyOeSJShWuDKtkrbVp/6Yu46StX4Is7mG4a
         SgS0mNUs4iFVXLfdL2gN1ULWXzz7AntbrLKMNDjUmoX671+8orBXQTVle2Y/HdNOr/uN
         mqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=53aAc4kEic3W8LcByj9D1czfciT2GPYNahiN2QB6f+o=;
        b=gFZ7XJr9iDBfm5m9wlW2HvQTMGztj7NDO+16GWQMsdpzMepeZ4NTSKq3AzQHX5F7Wa
         NzcWkplNWCqTZNsp155pz0oxV82txmx54hixa9oLYXwSzREK8Ox1qAwpwq/CFZeGZQz4
         u4LEl6/Dykwvl6xiEpS4mnl3p3PX5VDlX9Msh1EwGFB+bk75bwt67YugI/kkH2NDycee
         KnX3pqtaZ/qgnJxOKFFGpARb14dDK/4MA+qivSRbI2uk3S5iZYcFt2lFz74mHeozStx9
         scgqdQNcBB24+5Bm/6r3UHbeP8cexLVAAQzF+yAfSnG5YVqv/niMH95o405u6kJuNFft
         44Hw==
X-Gm-Message-State: APjAAAXHmu0aSll3G3wXZvFlvGPzPv4SejQwRvrHjDka5ha3+BI7qdwH
        cSsJGO28NWxHxpXiqe/rzTI=
X-Google-Smtp-Source: APXvYqywlr35KcLDjQdk9Z84b/a2gL29NPf5ZP47XbE0nAbE4e5pr7hWtnxvnpZSKhoiqJ7q4CZn2w==
X-Received: by 2002:a65:614a:: with SMTP id o10mr75217907pgv.258.1558554656229;
        Wed, 22 May 2019 12:50:56 -0700 (PDT)
Received: from bharath12345-Inspiron-5559 ([103.110.42.31])
        by smtp.gmail.com with ESMTPSA id d9sm32099917pgj.34.2019.05.22.12.50.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:50:55 -0700 (PDT)
Date:   Thu, 23 May 2019 01:20:49 +0530
From:   Bharath Vedartham <linux.bhar@gmail.com>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     ericvh@gmail.com, lucho@ionkov.net, linux-kernel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] 9p/cache.c: Fix memory leak in
 v9fs_cache_session_get_cookie
Message-ID: <20190522195049.GA5363@bharath12345-Inspiron-5559>
References: <20190522194519.GA5313@bharath12345-Inspiron-5559>
 <20190522194733.GA4766@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522194733.GA4766@nautica>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cool! Thanks!

Thank you,
Bharath
