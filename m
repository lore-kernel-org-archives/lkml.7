Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E042DC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4EA52081E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 19:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VchTfkRH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgAFTC3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:02:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 14:02:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so16460132wmf.2;
        Mon, 06 Jan 2020 11:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=FSOZYLdeJYzx9HNM/eHVZQqHNGetz8F34rLJogrEMmw=;
        b=VchTfkRHWQ15fzvFurpwbHnQJzO4ovSRNlVvcBm7mlyYHD4J5jQMMP8zwzys7HmgBS
         FtDIhNzXVJ+U6rTOTnTv8Zdc5vP7a+myYVzERvb0l6+5dOx2r3J4SPaaIcKh0mcT/A9x
         QmlIe/Y5jlGBSFYYf4xVP4fWAJDAfnlhMRpcfsVnnxQb9DKVfLb5yn532WO4J36Nfb4j
         oWsCoVSDmdhT/w20U6HZb9v56w0Az6ny2n6RgnZrV6TFdp/K1ip0fq5l4U0Jp2xYxJVq
         VTmjMt/PcPSqvLlGtMkXyDM36G0xhe+t13ueF9k9hxmMKGNl74JOVLIzLolx9TAEWEay
         WnqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=FSOZYLdeJYzx9HNM/eHVZQqHNGetz8F34rLJogrEMmw=;
        b=ZpSA181m4f71lWjt7ExhftMR3mIwIca5PDzp9KqP84nnn87jdHtX6yblqU2a859IBI
         bxa1nBmeu87ZboI1W7zPJ7tr4MvCfOGCD35LV5wT0KrLGkbf7kmzYZLOgVSLCXWkqtFn
         BNc0Q2LaGPXUAA9mSAViE21l440vJJZFWOgSfnNyPULvAyoz7C2WP6Xu9Wf6pvsmrWcc
         ClF1Eu9gRUTcRd57FRingd957ya9USbavmGFVGNJ2QLjx7z91ID+GbwdwxbokDbLGKpr
         /JTGpBtQmBcROkVokU4UQCx2rBByFLDPJbXdPuv7749rABgk3aUnpRuU3AXHy7DUFjmT
         DZqQ==
X-Gm-Message-State: APjAAAVUl6kK5qK6cpAOkT6hJq1yhL25Fe4vpr2ru/ITfKweHkHVpNkZ
        toqtt5J/HpdHlgX2kjHZK5M=
X-Google-Smtp-Source: APXvYqzbzGbTexFibdeXL8cwzeV1stJTTJXd0fQh4ROjZbmZL+vfTazuUNacYc+Cnk//gudO8csTDw==
X-Received: by 2002:a7b:c946:: with SMTP id i6mr35278830wml.28.1578337347235;
        Mon, 06 Jan 2020 11:02:27 -0800 (PST)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:74f9:b588:decc:794d])
        by smtp.gmail.com with ESMTPSA id n16sm73565486wro.88.2020.01.06.11.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 11:02:26 -0800 (PST)
From:   SeongJae Park <sj38.park@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     madhuparnabhowmik04@gmail.com, sj38.park@gmail.com,
        joel@joelfernandes.or, frextrite@gmail.com, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Subject: Re: Re: [PATCH 6/7] doc/RCU/rcu: Use https instead of http if possible
Date:   Mon,  6 Jan 2020 20:02:12 +0100
Message-Id: <20200106190212.20255-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200106183543.GN13449@paulmck-ThinkPad-P72> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jan 2020 10:35:43 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Mon, Jan 06, 2020 at 06:59:51PM +0530, madhuparnabhowmik04@gmail.com wrote:
> > From: sj38.park@gmail.com
> > 
> > From: SeongJae Park <sjpark@amazon.de>
> > 
> > Signed-off-by: SeongJae Park <sjpark@amazon.de>
> > 
> > Hi SeongJae,
> > 
> > The patch looks fine, but I am not sure if this change is required.
> > What do you think Paul?
> 
> Thank you, Madhuparna!  This change might not be absolutely required,
> but it is a good change.

Sorry for late reply, Madhuparna.  I made this patch because I seen a commit
converting http urls to https url for a document.  However, I couldn't find the
commit again.  Maybe my confusion.  So, please drop this if you have any doubt,
Paul.

> 
> SeongJae, could you please include Madhuparna's pair of Reviewed-by
> tags and also make your email address consistent in your next posting?
> You currently have both sj38.park@gmail.com and sjpark@amazon.de.
> Either is fine.  ;-)

Yes, of course, and sorry for the mistake.  I will use sjpark@amazon.de for
this patchset.  Will send the second version soon.


Thanks,
SeongJae Park

> 
> 							Thanx, Paul
> 
> > Thanks,
> > Madhuparna
> > 
> > ---
> >  Documentation/RCU/rcu.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/RCU/rcu.rst b/Documentation/RCU/rcu.rst
> > index 2a830c51477e..0e03c6ef3147 100644
> > --- a/Documentation/RCU/rcu.rst
> > +++ b/Documentation/RCU/rcu.rst
> > @@ -79,7 +79,7 @@ Frequently Asked Questions
> >    Of these, one was allowed to lapse by the assignee, and the
> >    others have been contributed to the Linux kernel under GPL.
> >    There are now also LGPL implementations of user-level RCU
> > -  available (http://liburcu.org/).
> > +  available (https://liburcu.org/).
> >  
> >  - I hear that RCU needs work in order to support realtime kernels?
> >  
> > -- 
> > 2.17.1
> > 
> > 
