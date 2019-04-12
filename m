Return-Path: <SRS0=nVcb=SO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560EC10F0E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3A2820818
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Apr 2019 19:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="Uv4YryJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbfDLToO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Apr 2019 15:44:14 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43756 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726874AbfDLToN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Apr 2019 15:44:13 -0400
Received: by mail-pl1-f193.google.com with SMTP id n8so5590848plp.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2019 12:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QDSyeWKte6gUJHhZ5n8yra+XVisEFH5wdFTnyuNs4rY=;
        b=Uv4YryJmlahAjDgDwAuvUpQoU8nfwH9+Yr4tQ9RmwQemsQHwYhZBam1/EPa3W0epC1
         Zh/28DVpZNPJynU5jnzdpbHZPxBiAkG0hzrzhJx3F+egfeIBNjO4ZtivEd1pplorUJKw
         k5Gk0sUugibKuuejEvc/Ck+0cL/cS883ueTh+RSU2gX1o5ImTFbrJP1MA8y2I0oG98ox
         LIcFWxXMUkADxiENYgYLS8zRaDWcp6O/iqdggRJD/Q+j52I8aQIdOAs02hAa8V3euEMw
         tGtLv3ASAALsMHsaCk1Rg8uCE9X+j22Up1PIm0+hLzbWuMiD19B2RpOYvnIoodb+YVFk
         2HxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QDSyeWKte6gUJHhZ5n8yra+XVisEFH5wdFTnyuNs4rY=;
        b=gz33uWxnIl+J0nQWYLpw0dsymVYob7d98bye1HfJYlrJM/1OS44EMrJGGPYa7ZMuEh
         nRxV5U4pNIgxivOCRyPNCiHBAAnbYWIAgAmlOtM/ankrc7nZDHA3AP59nkAAauicJP8w
         khkKOeO3sqoUBjVLi737oLS41Z8RPgmzxFCkQEXYKKgECkUj9TdEfigtYtWcTppfGEue
         DeZXrmKHKIUrBaV+LZ87k7NCCFrev9RpAu3TDxn18wLrXwRtyhldzAwPCyzot79TkzW6
         5NKC3KBHDfgUychl0DfKji0zasGYy8Hp5m4Jm+rk0qQCT4XnjSCr8tLpEn9aFkU0sHc9
         R7Nw==
X-Gm-Message-State: APjAAAU9iQ6ndq8BQe2R2BYwdok+K/p9Wc4mThOOPkFJYhJBX6XawV86
        cEhSRIRCeoW0NFdALWg5adxWjQ==
X-Google-Smtp-Source: APXvYqxq4h7OpgaqkLS8WLWdn5KmkgnOjZwCYjndr2hv1AYef932p5Jx5qN7FsfRQ2sUwuI4tgSmVQ==
X-Received: by 2002:a17:902:294b:: with SMTP id g69mr10137752plb.57.1555098252408;
        Fri, 12 Apr 2019 12:44:12 -0700 (PDT)
Received: from cisco ([2601:282:901:dd7b:e0a2:3243:c21a:e844])
        by smtp.gmail.com with ESMTPSA id 81sm35768568pfy.89.2019.04.12.12.44.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 12:44:11 -0700 (PDT)
Date:   Fri, 12 Apr 2019 13:44:09 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     shuah <shuah@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/seccomp: Handle namespace failures gracefully
Message-ID: <20190412194409.GD25793@cisco>
References: <20190411235631.GA31624@beast>
 <20190412152543.GB25793@cisco>
 <8fca6205-4983-2ba1-c1eb-c80be2dc8769@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fca6205-4983-2ba1-c1eb-c80be2dc8769@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 12, 2019 at 11:07:11AM -0600, shuah wrote:
> On 4/12/19 9:25 AM, Tycho Andersen wrote:
> > On Thu, Apr 11, 2019 at 04:56:31PM -0700, Kees Cook wrote:
> > > When running without USERNS or PIDNS the seccomp test would hang since
> > > it was waiting forever for the child to trigger the user notification
> > > since it seems the glibc() abort handler makes a call to getpid(),
> > > which would trap again. This changes the getpid filter to getppid, and
> > > makes sure ASSERTs execute to stop from spawning the listener.
> > > 
> > > Reported-by: Shuah Khan <shuah@kernel.org>
> > > Fixes: 6a21cc50f0c7 ("seccomp: add a return code to trap to userspace")
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > 
> > Sorry for the delay, thanks for looking at this!
> > 
> > Reviewed-by: Tycho Andersen <tycho@tycho.ws>
> > 
> 
> Thanks both. Should it go into stables. I will pull this and
> add stable if that is appropriate.

Yes, for 5.0+ that sounds good.

Thanks!

Tycho
