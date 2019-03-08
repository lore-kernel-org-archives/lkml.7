Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5C5C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257062064A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 00:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arS/tXHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbfCHAR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:17:28 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41387 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbfCHAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 19:17:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id x7so15001614eds.8;
        Thu, 07 Mar 2019 16:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fU+3ZR6JvYH0Ei/NU+N17IuHfcJ1IFS1wC94CSOQpWw=;
        b=arS/tXHTUxDechPD1KmKbo6BoyRUdfFtXDTQLgUWzQFcK5aN8YtAxfWBz7cfyxsxVX
         RoUEwNr6SoaEQL4ep2Q4OL9oggRKaVDFPg7Esw4fNPvCfGYnt4hmsHnwc0PLATKqgJsj
         O8PDMr51Oj6ywaeOsGaV9UVuDGvs7rQzj/BxtP1Z6vrAwKJxVb84cK86jV0tz2/CCvuM
         mnJtHoIgBXhc0bXhvIlgzEb7cbxqzNEOB5P/95JLRqaWPriCzeWEB843ttxLry0sxh6p
         Aai/UDZ8/484HwZBojUv2AL+YKIMBt5SEf7GwHzwnS61aTgRv/eTKS0GIGk/IbSz+Qdb
         rvRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fU+3ZR6JvYH0Ei/NU+N17IuHfcJ1IFS1wC94CSOQpWw=;
        b=G6W+smURsMJc1vrjNCQS1duq9/F08oIkprQ1eSd6RXn4leRY9phWP6RHVQWEKsXSW/
         2C/lsE68toadMwmsoB7ar9FUEOfreD0rGcN055GtQ1IvRVeeST3qTTr+KkN5I0IpUOS0
         wtggMUYj/nUZxALRlEyx+ul43sUnhZRWmlLSvXxcCYEVR6ss4bhcq3tZV7QZVXBaxKEe
         lf2HfSZqhLqj8RB+85OQ3J19K3ClQW9PKiduU0fHXva3S+/NDAMxu7050CyFggUKimdn
         wD37bk1wVaZ3a+fef3713/9Z+4Ie1gtTM09s+08oJLjbvKHzyS0iohpNZS1qcOuyl/AI
         XpLg==
X-Gm-Message-State: APjAAAXWMWx2q+lXcRPZoXmtvAJMlBaPe6quZPwNL8wnhlna6HPZ7eYR
        7NTVWaA41xOvZe9UQ9ieBj8=
X-Google-Smtp-Source: APXvYqyUfnQfC/CNZBgLAY4NogcA3k+c0pZZH/jnERXFedl5JKYSorxpT4ZUQjrj1XOSCm5bmDoFYA==
X-Received: by 2002:a17:906:f101:: with SMTP id gv1mr9544944ejb.73.1552004246100;
        Thu, 07 Mar 2019 16:17:26 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id h22sm1134534ejj.43.2019.03.07.16.17.25
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 07 Mar 2019 16:17:25 -0800 (PST)
Date:   Thu, 7 Mar 2019 17:17:23 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jon Maloy <jon.maloy@ericsson.com>,
        Ying Xue <ying.xue@windriver.com>,
        "David S. Miller" <davem@davemloft.net>,
        tipc-discussion@lists.sourceforge.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com
Subject: -Wsometimes-uninitialized Clang warning in net/tipc/node.c
Message-ID: <20190308001723.GA11197@archlinux-ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

We are trying to get Clang's -Wsometimes-uninitialized turned on for the
kernel as it can catch some bugs that GCC can't. This warning came up:

net/tipc/node.c:831:6: warning: variable 'maddr' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        if (!tipc_link_is_establishing(l)) {
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:847:46: note: uninitialized use occurs here
        tipc_bearer_xmit(n->net, bearer_id, &xmitq, maddr);
                                                    ^~~~~
net/tipc/node.c:831:2: note: remove the 'if' if its condition is always true
        if (!tipc_link_is_establishing(l)) {
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/tipc/node.c:821:31: note: initialize the variable 'maddr' to silence this warning
        struct tipc_media_addr *maddr;
                                     ^
                                      = NULL
1 warning generated.

This definitely appears to be a legitimate warning but I'm not sure of
the proper solution (should maddr be initialized to NULL or should it be
set to something different in the else branch). Your input would be
greatly appreciated.

Cheers,
Nathan
