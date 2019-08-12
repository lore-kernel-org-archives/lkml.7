Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B095C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E927F2070C
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 07:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf2WF8S9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfHLHLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 03:11:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37091 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfHLHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 03:11:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id z28so43148123ljn.4;
        Mon, 12 Aug 2019 00:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NZ1OizWcpbP6noxx8/xg2mgm7Hx581BOepTaovkOMgw=;
        b=Yf2WF8S9ApkFHjD4UxCouGHKiT3fooxvqPfGFdBww+sjt9fCTswOp/+dBgV7Rc+aV2
         NJAzLQW8hpgJgmCfrUuCv+BQ/VQtPSg7SCm3C+tld/fSjxcjGOFx1Kpp1erKFQJgq4P4
         KylSf+K35x0U+fBVxRtmGXi6a6Qj+Gly+k/CtTuoGQrnQpK++KU15mz7lTnMlxVhF2ic
         gKNFO1qMpZbeTX1woqJzdQ4yc63UB50yQRpfteFCY1OTWMQxPOf2sYYvXm8UOvvdgPff
         u6dUPEvsUHa0KUjVxbgKcEaSPvastu3RBhhbqkXfifVQbmwy49SAaTYT8GAcQ478vwOk
         fc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NZ1OizWcpbP6noxx8/xg2mgm7Hx581BOepTaovkOMgw=;
        b=qCVe8Rk7v0+XF7Z0Gv3dmmgMpBMH/2El9iJXW22AJ6VuzivsnIqHGTfKaIXH1gQyaY
         yl61qeyRnl17hqG9rnMP9YixVZ25B6Gs6OTxNRowv4Thu92XZ/1Nrpa1bMz2TC8J2rjX
         IyJHIGStUas9/vQNSwIDYglgG0DII5FoxP25Azikg7xfqJje5+5+eub7RNmAwPakweiP
         wsM1xQwf/tE37vq45GTDuHdz8bggWTjR2X0FSQtC49xBM9f9etpQa8n+fM9q6K0FGDfZ
         OZ435A9Vr6owDjD6sZxkjpVXQy6HKR3yhbqFJm6v5yMwKSlY4hclbivBQ/YytVLXJf6Y
         eOgg==
X-Gm-Message-State: APjAAAVLPVBiG4nSXwnHZmxvNKQSp3JNM522aZ5B+PVTlLu+zfCAd1Wb
        KHYnkC5dstO290U0S2uZSR4=
X-Google-Smtp-Source: APXvYqwabjEsn2E3ceEjQ9qSbaZX7inxaXw2629zc8ft8lSOSSxYH6TAfvapsKTSz14ZdoaWJLtPkQ==
X-Received: by 2002:a2e:9045:: with SMTP id n5mr18442876ljg.66.1565593910060;
        Mon, 12 Aug 2019 00:11:50 -0700 (PDT)
Received: from localhost ([178.127.242.45])
        by smtp.gmail.com with ESMTPSA id w4sm5327361lfk.4.2019.08.12.00.11.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 00:11:49 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 12 Aug 2019 16:11:48 +0900
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
Message-ID: <20190812071148.GA696@tigerII.localdomain>
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808172226.18306-1-chris@chris-wilson.co.uk>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (08/08/19 18:22), Chris Wilson wrote:
[..]
> @@ -20,31 +20,18 @@ int i915_gemfs_init(struct drm_i915_private *i915)
>  	if (!type)
>  		return -ENODEV;
[..]
> +	gemfs = kern_mount(type);
> +	if (IS_ERR(gemfs))
> +		return PTR_ERR(gemfs);
>  
>  	i915->mm.gemfs = gemfs;

We still have to put_filesystem(). Right?

	-ss
