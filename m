Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F9CC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF8AC20684
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 22:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="szjpaQv9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbfDVWEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 18:04:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44763 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfDVWEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 18:04:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id c5so8562564wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2019 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mk/aeqDyjVubC22vG+Tnj0+IUdzO2mmBQHViP+VJ06s=;
        b=szjpaQv92lzbMiKOj0TAIoB9rr7VMgOQoKv4yzw6lMIIm/aFTsHcgCP+VIi2vdv11s
         ZH9mYh7+FXHPjjftyvGhs2pdVhD+PvKYCLObmtaCMVyo8HW7ZFREGtvVfpbd9SwY/R37
         tJTaDD4jb5deb6mVNjPXoJHAZK161PwpFUvMMsca/XYlBVcB37phcoiL3wysP1X5p/w3
         6S6B1BrPQZXuW7Vcl3uDH8gcVEGBOEuBR0Jd2JD3B0J79tQyQ+LIWEojK+/8iCf1rJkw
         8IUf0U0s9gKy7eUnDZpzhvtOsVAWokEPYfU/nSBgCHenS1uChKKXEnIKYInaGdrwQFiB
         0yOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mk/aeqDyjVubC22vG+Tnj0+IUdzO2mmBQHViP+VJ06s=;
        b=Q7QqB3GQB1tpEYhd+BXIfNEkMDgdVKmLub/KbJldAxRMbN67jWtEWwKdPoIan8qUu/
         XhGu8mMmwUwLnoK4k7cX64m83/nQuDxsNmWHfdrFRmxfjRiCIYx2y5hd2mnx8J+xUWBf
         YPyg5TQWTCkid9gTh6tT8MdQ2th+nhdxRKV+44jjKsjbqIBLpBsRSFdAeSgyQOe7RTPb
         H69mBHYxPtouH3f3+TIuO8D5rAcbUUoKS6N7A524oI3N8ZAj1XFfEr+HCg/WCdye5MSa
         Jz/mVsZTKe5HEizSwJ9LI95pxyWhVE0RXnl22nXySaTktt67SPgj3qnjISmaD+wbamhM
         2ePA==
X-Gm-Message-State: APjAAAX4HzDVgFjakJ+XYBvnNh7lyLbru5IacK/ikUuPPGwwePck/bov
        AEpbGHFLpl6Sb5fpERaNWQ==
X-Google-Smtp-Source: APXvYqy630KUEPGKRP/IBGTaFuoUXtyW+9jQ66apq0UaG/On3dO+kw6NvhLguM6jJ8LcLxOFetMXyA==
X-Received: by 2002:a5d:5346:: with SMTP id t6mr15598952wrv.59.1555970672564;
        Mon, 22 Apr 2019 15:04:32 -0700 (PDT)
Received: from avx2 ([46.53.240.81])
        by smtp.gmail.com with ESMTPSA id 62sm12287029wrm.18.2019.04.22.15.04.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 15:04:31 -0700 (PDT)
Date:   Tue, 23 Apr 2019 01:04:29 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] x86_64: uninline TASK_SIZE
Message-ID: <20190422220429.GA26031@avx2>
References: <20190421160600.GA31092@avx2>
 <20190421182842.GD35603@gmail.com>
 <8B42CD57-9343-4234-A96D-80337BFFDF0E@zytor.com>
 <20190421211007.GA30444@avx2>
 <20190422103449.GA75723@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190422103449.GA75723@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 12:34:49PM +0200, Ingo Molnar wrote:

> When set_personality_ia32() is called then TIF_ADDR32 is set 
> unconditionally, without any Kconfig variations.

Indeed.

	personality(PER_LINUX32) = 0 (PER_LINUX)

I only wasted about half an evening ifdefing TIF_ flags.
Thanks for saving a lot of time!
