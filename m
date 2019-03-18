Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8744C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A28A22085A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 14:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cRAwBlTZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbfCROex (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 10:34:53 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:44888 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfCROex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 10:34:53 -0400
Received: by mail-pg1-f194.google.com with SMTP id h34so11499530pgh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2019 07:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oNe+B0p7D+d5WR49jlZ/vcloKG63Et3my9JV/mFWf0Y=;
        b=cRAwBlTZnjjGHQI4lF59YPu7bOM8YYp5HOXA/bDkQwSAlXRxN4aIJtEebiUbErE+q3
         J8jQkAhNtCVpzMvMDFkrA40GajYtGRjnL14+9nsb/MXiKgFzV0ShHTiAFOTCFtHMep9s
         QA76YdYwFjgx5SIcOYo/JXsBxzPSwDE8+SRnmjv53LD+XzcRB+B5CqhN4E2MewjvsBJG
         yt2h97+yWlUjA7CYgEPvL/iHtaFpmqBJtg+2Y14OnMJE8ZlCq6wuDBcWPtlHZy2CjPWc
         IU0UgJG1QQIe4L71N4IhJoIu8SZNt6YtQz9UWW/JIN8HiAUw9kUFW90J1PpOwVA9zsdh
         Attw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oNe+B0p7D+d5WR49jlZ/vcloKG63Et3my9JV/mFWf0Y=;
        b=oqlIjnOsha/s532wfCNS5Pw0R0T/ZhehoEqOCfJcU48wxCeFguyix5klGkZUa537+h
         bLz50XpwN0MMzzMwe38zre1R8Jw0Lpm+cTOUm4IoM493jBRjUOeZaZGZT2nAlQzfAkp3
         wW1XSFU0g2+/OHq3FkutOTXL4PdcW92WC/85Xv231mUDHFip6R+en0k39wZz76PsvOxA
         v6uOT99Koi45Hr6PNVAl5RuU6YZh2ay9LU5YOBoEdlanbPDWn0Oj5DKmyJpNQxxflAQn
         uhh73WXV6ly7QhtncDm52ZCPgUp3VORUQwpHwX84Ymhda+mQeZ/80pKORWVwlhIGzUzT
         5NAQ==
X-Gm-Message-State: APjAAAW9E5hewTBhwDCFbmImvvLoihHrrO5wMLOSAtvZtY3tEs8kg5ab
        qa6WHa6Ex9HjHOqqOhdgdpI=
X-Google-Smtp-Source: APXvYqzskAJv79kQDMUTMC79yL6/+6tgjEe6BamCbss0CBUNNZeWil64AUz9ZIICuJpulPf3VrXe5A==
X-Received: by 2002:a17:902:a704:: with SMTP id w4mr19638834plq.251.1552919692274;
        Mon, 18 Mar 2019 07:34:52 -0700 (PDT)
Received: from localhost ([121.137.63.184])
        by smtp.gmail.com with ESMTPSA id y8sm20123068pge.35.2019.03.18.07.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 07:34:51 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 18 Mar 2019 23:34:21 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] printk: Remove no longer used console_silent().
Message-ID: <20190318143421.GB29374@tigerII.localdomain>
References: <1552917923-16601-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552917923-16601-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (03/18/19 23:05), Tetsuo Handa wrote:
> console_silent() is no longer used after the removal of
> arch/mn10300/kernel/mn10300-watchdog.c in Linux 4.17-rc1.

[..]

> -static inline void console_silent(void)
> -{
> -	console_loglevel = CONSOLE_LOGLEVEL_SILENT;
> -}

I would keep it, I guess, and would instead covert

kernel/debug/kdb/kdb_io.c:              console_loglevel = CONSOLE_LOGLEVEL_SILENT

to use proper API (console_silent()).

	-ss
