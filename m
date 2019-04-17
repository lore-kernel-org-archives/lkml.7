Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15217C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE85920674
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 18:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNT70rAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbfDQSPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 14:15:01 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:56299 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQSPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 14:15:01 -0400
Received: by mail-wm1-f43.google.com with SMTP id o25so4482718wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2019 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=qknltXgQ5IBlpPlWXUPSOmejXwDtBrUW+UOJB+W3m0o=;
        b=dNT70rARPL2YKUYplIvRYV7DBpgUPH9AVykEvfqN+Yd/a+10pU1a0aOcpmGJc6G9Bl
         D4aEPfJUfA77Ny6eM0qhQ/oZvpUaxtGJx5lrkd6KJae2mVQIc1psWNshCZY3lQjoz8Ri
         fbpLKpKtomzh+yxuxCNK8uiOmMk3YpgGDmjUQHn81BBzlJYg6tiej8aMrhbXUPRCaw4i
         xkPlV9rqq7ye8LoZpqscDpVGR1YJMt/BLTc7BMou0GHUOlrd/TEDTlgi2I0nofVegO+Y
         x5qs3TvKcL/QknRXdo9jzXwl9O++AVQT7Tnb8KzjuS/mvXhirsrDXciTp4k7mB8M/9dL
         y/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=qknltXgQ5IBlpPlWXUPSOmejXwDtBrUW+UOJB+W3m0o=;
        b=uC8TDW4rqRtryIF4nQyv8Ief7X3nsL6Ll9UGYV0May5M/GOImLq039C8NibhMxLpJ8
         zNJSf4xQY7k1Z4Q8thM5Ajsqm/tUKWwH923REoWVp/LjyiuMC7gieQw9lt1qUI5yeIIN
         G3K2Qpc0GRkZoNbepWmL1CRFE3uR9uqnfRiBGhdpRD+h+d2k4px80ULpIMw3xiSpzyXX
         bcgBGiLYWN8bzxJe7tlWrPNvhSGXCSSHRLrCRJHSwEbcFjRWZJTItMNktN0f33DD4FRF
         RN1UXKQcxce/fYltNlieC9sBiV4+c0mPY6TN8UKIe3vaYQRkyol7UOW0OsBTHug1BkOF
         5CyA==
X-Gm-Message-State: APjAAAWHdlOTG8BXIi6UDu/uOCTfKq43Yg3M+gspmNyGsX39BEH4UhYF
        jVrPMkBACHkmtT4mGIVPt4JBGoY=
X-Google-Smtp-Source: APXvYqwsTDJMQi3tvMOYxMyoGQiXqG2Tposu/yMqUDpEJ0pONvIb3B49itO1QFWFB5ev5FO8gKh+lw==
X-Received: by 2002:a1c:b088:: with SMTP id z130mr696286wme.5.1555524899432;
        Wed, 17 Apr 2019 11:14:59 -0700 (PDT)
Received: from avx2 ([46.53.244.117])
        by smtp.gmail.com with ESMTPSA id a6sm46166826wrp.49.2019.04.17.11.14.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 11:14:58 -0700 (PDT)
Date:   Wed, 17 Apr 2019 21:14:55 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     shajit@codeaurora.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: fs/proc: Crash observed in next_tgid (fs/proc/base.c)
Message-ID: <20190417181455.GA2965@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Test case: Not some specific test case.

Write 2 programs: one forks, clones, and execs randomly (but not going
out of control), another does open("/proc"), getdents in a loop.
Don't use shell scripts or readdir as they only bring overhead.

Run getdents in a loop and several forkers, see what happens.
