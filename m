Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DF6CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7E22089C
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 12:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571401797;
	bh=lJ5kUtRn5NruRHhyO8BWJiTgqPoQRpIgTHfTH+S2qdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Cba3s0tu08vh6DFACtirlPTd8d8Nj+tvvlNSqHoDpoeXYNIqoBfm34jTKVB+OJi3
	 tslDEAV0mfsLHPOmk54OHeOKxicZqVxrPBSk+ie2v9BjHy5cPJGMNGd1ddfhwRQLHx
	 hNHhRRUn0lv9TNdjuJfLqUmM5+1nhyUNLen/0ouQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408116AbfJRM34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 08:29:56 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40921 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389585AbfJRM3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 08:29:55 -0400
Received: by mail-pg1-f193.google.com with SMTP id e13so3302010pga.7;
        Fri, 18 Oct 2019 05:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=288Pc59lRoS3fTQSgHjqYaeNRECTkwE7sqDzfLhbInk=;
        b=tgTBt4GJ/POV5hcHCQCb0YtrRxdKN2/JJgZcfOgJ1dh/QM8ZRHcSCJ13o7k4DkwfUB
         DpPgxmiGCRW97wFtG0rk8gDJqrJ1BNj6e/A26zh9lBrww2PLlK1tOyJ+09Tcnf+mpqq/
         wenvCfaHz+9hdkzgfMlRgF9j2nPC6yDWeHqb7KgOm8y2n3NLaUyHZ/T4Uu8Apz6mUg0Z
         UyNwYmc705OCG43Jjia7ZDD2FD6Hs/X5WLpvKkvDfb17Bp/9sz/n7m9jxwr70AbaYTBo
         fY/heRXdZvteZPy96Qf6IfqCz/UXKFX/7YfYfC17FoB5KkCpOpDOhKQi2EmeS8jUg9KI
         VQwg==
X-Gm-Message-State: APjAAAXAWti8fL1fKQKWrDsjOyu+mdlGSOUIaOf0umuxDjmk1K9PeHMe
        tLTPsPR8IlqWfgsRStoeZNk=
X-Google-Smtp-Source: APXvYqyU19z0Xj8JJM7pjylF4zyrZhqpa+ZWU/DJy10UMIdreem6ukIh9uAUDKQz52Pnc+nuZA4exQ==
X-Received: by 2002:a17:90a:6283:: with SMTP id d3mr11196594pjj.27.1571401794127;
        Fri, 18 Oct 2019 05:29:54 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v68sm6390357pfv.47.2019.10.18.05.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 05:29:50 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B9F394042C; Fri, 18 Oct 2019 12:29:49 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:29:49 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Matthias Maennich <maennich@google.com>
Cc:     shuah@kernel.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, keescook@chromium.org, alan.maguire@oracle.com,
        yzaikin@google.com, davidgow@google.com, tytso@mit.edu,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org,
        Mike Salvatore <mike.salvatore@canonical.com>
Subject: Re: [PATCH linux-kselftest/test v1] apparmor: add AppArmor KUnit
 tests for policy unpack
Message-ID: <20191018122949.GD11244@42.do-not-panic.com>
References: <20191018001816.94460-1-brendanhiggins@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018001816.94460-1-brendanhiggins@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 05:18:16PM -0700, Brendan Higgins wrote:
> From: Mike Salvatore <mike.salvatore@canonical.com>
> 
> In order to write the tests against the policy unpacking code, some
> static functions needed to be exposed for testing purposes. One of the
> goals of this patch is to establish a pattern for which testing these
> kinds of functions should be done in the future.

And you'd run into the same situation expressed elsewhere with kunit of
an issue of the kunit test as built-in working but if built as a module
then it would not work, given the lack of exports. Symbols namespaces
should resolve this [0], and we'd be careful where a driver imports this
namespace.

[0] https://lwn.net/Articles/798254/

  Luis
