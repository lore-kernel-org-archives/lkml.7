Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0155FC433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF9852089E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vcsfox7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404424AbfHHV4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 17:56:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42941 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733140AbfHHV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 17:56:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so44745490pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=G0ZFIdTmFS3mi9/id10ztks8QYGXi0cdUMK8KphwuIs=;
        b=Vcsfox7Qf4kxhjopDy8uXiVHIPVFjKjN155ZJIg7B0yZ6WMwMZN76Puje2QDjdk5ze
         1856uJlMZRVrVYl7mzNAlyEdF2pc6w+8eC0mVuXa6T1XWGo4sN80o6d91Ikr2pSEfMVO
         UE1DAv8wKLQI0m5/Bek456yUquEnueNcf/pxykXwK58taMTMx2UiuZXICTRnd3D1Uccf
         usSzGt47c/Qkbqz5HwXm5AD5ynHx52pyRqm4pBo5DH/hozwwRZ7+LS3rik2CyuTgo4mB
         3NYfPHevz6YS2T3b3wIwE6PITr+g66NU1CVIQSpuyIH95gwNrurdTKr4beyWyMIeUkSz
         KIxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=G0ZFIdTmFS3mi9/id10ztks8QYGXi0cdUMK8KphwuIs=;
        b=VmdbjyL/biMbl49fFlKaG/2829ox5TqoODzVt5TbaicL5AMwO8r1S7VRu6bQmzpUo9
         i1xuyW8VaJh9V0ZJWB25+DXd3ynvA7CTnTj9jeLSuqIeDykbrTTR0n5bqcBnIu+lTrF/
         JFQ8tiSIqmjHsGN1htJtmfi7NHQoFlOf5CSb3z0T2oc28eKnhiOlmlBhmH6CbFtk5+09
         idfFnf5ZTNntCpEAZ16CcahWQ+169ekHjX7uBjarRX54OfPQFlfeCN74kEtur9HRRWWC
         4+F3FA2K8GA2x1aIiOZxDaufMqSYwdP/qXSAn69XtLzmGXjocjD+HkBWGMlKklHdoblY
         +KhQ==
X-Gm-Message-State: APjAAAUECMBa3LEGWpqA9AVzDI2wFJrv4KSCnAhZyCmbsf4+xHX8vudE
        BoQJbc48K1DZEqPKXXQq97LT7g==
X-Google-Smtp-Source: APXvYqyIgWknW1PK10iRT7TxNhYG58XNbWKUWsac+7TN1a/G4yk08VvkyIfmDevHzObM0jWKnDfUBQ==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr17261793pfa.58.1565301407116;
        Thu, 08 Aug 2019 14:56:47 -0700 (PDT)
Received: from [100.112.81.118] ([104.133.9.102])
        by smtp.gmail.com with ESMTPSA id v7sm56709980pff.87.2019.08.08.14.56.46
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 14:56:46 -0700 (PDT)
Date:   Thu, 8 Aug 2019 14:56:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Chris Wilson <chris@chris-wilson.co.uk>
cc:     intel-gfx@lists.freedesktop.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Auld <matthew.auld@intel.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] drm/i915: Stop reconfiguring our shmemfs mountpoint
In-Reply-To: <20190808172226.18306-1-chris@chris-wilson.co.uk>
Message-ID: <alpine.LSU.2.11.1908081447080.10003@eggly.anvils>
References: <20190808172226.18306-1-chris@chris-wilson.co.uk>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Chris Wilson wrote:
> +	 * By creating our own shmemfs mountpoint, we can pass in
> +	 * mount flags that better match our usecase.
> +	 *
> +	 * One example, although it is probably better with a per-file
> +	 * control, is selecting huge page allocations ("huge=within").

s/within/within_size/

Not that either of us is recommending that direction,
but since it's mentioned, better to give the correct name.

> +	 * Currently unused due to bandwidth issues (slow reads) on Broadwell+.

Thanks,
Hugh
