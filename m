Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49AC5C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EA9B217D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 11:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzvVVV/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfEVLTM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 07:19:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45085 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbfEVLTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 07:19:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id s11so1149043pfm.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 04:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1zLXiDzWRtuMpSXLOKHv8I1pCMupBHLpB2jOrm6xbno=;
        b=QzvVVV/x4KFUluzAxs2xSKx8TV3hRaBOm3iazVgyKIYJD2MdSw8I+F8KZtW/0GBkpO
         qdvsqvxP4nabnejAnz+UeR+UGW2t5h4WWHZmKUPgUw51d//hHdwzIkOyLEcj4wtDsXwg
         KC/EkrgQhtQBsCh3bckW5spzvFvDfo/Gndb3yv3G+qfaZ13GqNquqEvM1ynSnc24J3mD
         Lco8x9I/UYQBfF5tJkIWxpqXFaLS6YzDltQqaGKZyPK/0DKJmlmsS+dfyZ3NUzelone8
         rdP+rPgkNoAUuW382GZGhowFff6VrXNp3nCfxNID+SyAfJEu4VtZkhAH1X3mWsixSIJZ
         sd/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1zLXiDzWRtuMpSXLOKHv8I1pCMupBHLpB2jOrm6xbno=;
        b=WVE5x+QVXjkZfyAgflFjkU6M1mvC5hH3FLNyUq50Ea71znisnPCpqM26QOV6zPcwQh
         YGh2mD1EF/5bk9d5k8mTfgzeen3VqN+Lmkg2rdQOoQ/wbQC6Y67FXOQCZL9t2oB70lqp
         Bkv27VEKyBz83Lg8Cl2DVITDlQWAeKAWnoj5XPiEMMkciXWn5FeXzATqL9LxJcdDyIH5
         JMJNAd+0z9zkzmOBEe+Ak+Pv5hS9dU30Wen1XkG9bIH7zKHuH7YCRhMeXf98B680YvY9
         JmTQA3kTGcM2KW3S1iKk5ggedPA5HCHlypvFkbkTCEwq4rmAfb1RrMtKaT+cJfBj+5oN
         Ob3w==
X-Gm-Message-State: APjAAAXliDubW2mocHA0o+2xpHi5t1Pgr6BXsjFxNoldGrveYmWt/Rij
        y5flNWExLvPCy3XVfVaqoTlZx+e2EuXnnA==
X-Google-Smtp-Source: APXvYqwZqWgAbNjNNCwKP1RNnA32pCJ7S+fVina+XAqlMaK7Z4TvaztmDs+I0l5CKR02tew4C9ZvAQ==
X-Received: by 2002:a63:1316:: with SMTP id i22mr90209873pgl.274.1558523951133;
        Wed, 22 May 2019 04:19:11 -0700 (PDT)
Received: from zhanggen-UX430UQ ([66.42.35.75])
        by smtp.gmail.com with ESMTPSA id o5sm28631733pgl.48.2019.05.22.04.19.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 04:19:10 -0700 (PDT)
Date:   Wed, 22 May 2019 19:18:28 +0800
From:   Gen Zhang <blackgod016574@gmail.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_io: Fix a missing-check bug in drivers/tty/tty_io.c
Message-ID: <20190522111828.GB5849@zhanggen-UX430UQ>
References: <20190522014006.GB4093@zhanggen-UX430UQ>
 <abc68141-df99-1ae1-ea51-c83bd4480d92@suse.cz>
 <20190522080656.GA5109@zhanggen-UX430UQ>
 <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a3db304-9725-6a90-65ac-dff09ef31aae@suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2019 at 10:15:56AM +0200, Jiri Slaby wrote:
> Look at the top of alloc_tty_struct: there is tty_ldisc_init. If
> tty_get_device fails here, you have to call tty_ldisc_deinit. Better,
> you should add a failure-handling tail to this function and "goto" there.
Thanks for your explaination, Jiri.
I will work on it.
Thanks
Gen
