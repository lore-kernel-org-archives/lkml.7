Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEDFC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3FFE20673
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 12:44:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myBhg/eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbfI0Mox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:44:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38246 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0Mow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:44:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id w12so2577261wro.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 05:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iQL/mBFoyT5w4+hqPmctLZTeB55w7NLl/wO5PdSiL2U=;
        b=myBhg/eGuipuj/7sSVjnjujigvoCGLp1eCc3gH/+ShzrqZTEiNeAsQO5iFxgOrXhZ0
         iT/cp4R/uktq28HYdiQjaevn/BI4XxDSO0LJIdd+4SXdZROwKVUpsWkaC/CAIuYIeZF6
         KNB44AZ7EwARPpc+ksUoIxDOHnh2+f72TqOuTNeHwGj5rYDUarg7X3eE1+XPC8dRm6r6
         GQEf9qpoVYT/3ImSdHxdS9OUtJ0RreW1yo56qA+XwY3h4jtozieTx7s66FL6GcI5SpcA
         zXKE40T/1sW+8byUh+KODrKra+jt+AHhdsG9IIHNstzAwmfblkzrVf6oqbQfiYY2QUJC
         ExNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQL/mBFoyT5w4+hqPmctLZTeB55w7NLl/wO5PdSiL2U=;
        b=ixcSbvPzLzKXnWT6xT/mkmlkXVqgn6xmtnEeT2xRwKFi9sgtNrXL9WQqf9KPGDb/UY
         4Xo5enH22Xs/tWvc3Bc9+isAHvUjZcuSgZKslG78PPWehyU8HJi3kc8qjJX3YQVusWwv
         csQXo8fW+myqJ0z9GDyJyyuiFsx27PbAaoO/G1h49RmVYxWCKPXVY7N9YN+VHQxlVhsM
         BZ9huYd6KdTpeO+OfNR7McLZm0z1CEY5jswF5Nn5jP8umETOsQ3EwGoEhaY/bbYJ5pdJ
         p/hmjlaqohstEm4IK9baCOcTj4S+f6+JW2Z5CVaH9o+kqOWk3ZLMFN3W/FOCfEQdvNS3
         ui4A==
X-Gm-Message-State: APjAAAWWa/NF5dTewBqr8OYHqnAETTswzDfLbUBkPIwi8Rxe8bpmq3bv
        WyDGQob9ZCkOYDEV77qdPW8sgA==
X-Google-Smtp-Source: APXvYqzSC7+dVijO0hQycnadf7tT0XIPdovlOCjVDrWfHckpArc6CW+OsTBS1TZwnP1NrZaSUrm1qw==
X-Received: by 2002:adf:fc0e:: with SMTP id i14mr2867784wrr.302.1569588289230;
        Fri, 27 Sep 2019 05:44:49 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id v4sm4201457wrg.56.2019.09.27.05.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2019 05:44:48 -0700 (PDT)
Date:   Fri, 27 Sep 2019 13:44:46 +0100
From:   Matthias Maennich <maennich@google.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Will Deacon <will.deacon@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/7] kbuild: fix build error of 'make nsdeps' in clean
 tree
Message-ID: <20190927124446.GE259443@google.com>
References: <20190927093603.9140-1-yamada.masahiro@socionext.com>
 <20190927093603.9140-6-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190927093603.9140-6-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 27, 2019 at 06:36:01PM +0900, Masahiro Yamada wrote:
>Running 'make nsdeps' in a clean source tree fails as follows:
>
>$ make -s clean; make -s defconfig; make nsdeps
>   [ snip ]
>awk: fatal: cannot open file `init/modules.order' for reading (No such file or directory)
>make: *** [Makefile;1307: modules.order] Error 2
>make: *** Deleting file 'modules.order'
>make: *** Waiting for unfinished jobs....
>
>The cause of the error is 'make nsdeps' does not build modules at all.
>Set KBUILD_MODULES to fix it.

You reported that issue earlier, but having nsdeps depend on modules
(see Makefile:1708) resolved that for me. I wonder what I missed. But I
won't disagree with you on kbuild advise. :-)

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>---
>
> Makefile | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/Makefile b/Makefile
>index d456746da347..80ba8efd56bb 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -616,7 +616,7 @@ endif
> # in addition to whatever we do anyway.
> # Just "make" or "make all" shall build modules as well
>
>-ifneq ($(filter all _all modules,$(MAKECMDGOALS)),)
>+ifneq ($(filter all _all modules nsdeps,$(MAKECMDGOALS)),)
>   KBUILD_MODULES := 1
> endif
>
>-- 
>2.17.1
>
