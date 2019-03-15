Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FAD218E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 13:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="DOm3k7xY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbfCON1o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 09:27:44 -0400
Received: from mail-qt1-f170.google.com ([209.85.160.170]:34898 "EHLO
        mail-qt1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbfCON1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 09:27:44 -0400
Received: by mail-qt1-f170.google.com with SMTP id h39so10039520qte.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=No1HWm0EsCJCKhgJLbb3/U/NHO8sMm1k/TSYX8LGc6Q=;
        b=DOm3k7xYFoHXos1RvdmIdXhpBQAYPDHy9rp4+wXKTEfosJSu0x0usHOezzegKlg5lh
         Ske6dLEJgMQKVQFaW8LHTxi3i5eVwP++jO/HwV/CrcQ33PGMm/GQq7rAsQaSc5o+fO8j
         2G4U77ocq1EW+UXUBlVKzqC++Mo/UEIai9wlgPwumMOAnnYuKt+KYDdvJ4srvty/z94H
         AjBwnrDbO/NhfPKs+Rtpwv9fKSYRadkgrLLyZakDUssdgdUV76+HvwXQTldCAjVTrYR0
         Vjk3qQIq2ezdv7ZO+QwAJhwLJIjLE2SvFyTyTz4iqjzmAzvW+oeRBs/4BF9BsJ0klKTO
         TgUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=No1HWm0EsCJCKhgJLbb3/U/NHO8sMm1k/TSYX8LGc6Q=;
        b=IIVjnWh8ukeubeXaKH+L5GoJ5Sd8rwf9Wa/8L3tkas0jGiDuozxXbdGzFI7FgqMfBi
         2/hIS2+j6cJdeOx3OMVuDnYCGBcUz8M7X6gGNosz3kBTKIMLuK8dZ2Q06y/5W1kPwIaa
         uLqUSTm8Pym1yV4+42MS3pt4m4iDhPwJwX7RmXVaBfJY9XCBtN+dG2IBPx9pf8Dus+ZX
         Ys3oJ/Z653SxgF6LlPWw9LnQzYxRU5w+zSbjm8BW897O3uERfZZV0v1tdNLDsKJAHWAE
         EDyjJpsgyma+K5Wf+BHEt+CKHQVbuzx84Eb1V0Jx7Ut0Zpfxv/RwH2ehByvTJt3gGbyD
         v3fA==
X-Gm-Message-State: APjAAAVtSaLMdX61wmrmjY7p3RMoTmY0cDdGuhqG+/tsZteaHUtdEJcf
        3t5vqNMl6tr/AhjPl82Bztjhmg==
X-Google-Smtp-Source: APXvYqz7HLKof8j3jGEoMoEfytO3lSQQVR/S/SdZ6syIQqabjFNdZDG/SL5NGoFYK8OFMQW7jmvsLQ==
X-Received: by 2002:a0c:b89e:: with SMTP id y30mr2557406qvf.52.1552656463123;
        Fri, 15 Mar 2019 06:27:43 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id w33sm1438382qth.34.2019.03.15.06.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 06:27:42 -0700 (PDT)
Date:   Fri, 15 Mar 2019 09:27:40 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kangjie Lu <kjlu@umn.edu>
Cc:     pakki001@umn.edu, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        nbd@other.debian.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: nbd: fix a missing check for nla_nest_start
Message-ID: <20190315132739.mfnbkp5vdjx2uhko@MacBook-Pro-91.local>
References: <20190315063138.17666-1-kjlu@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190315063138.17666-1-kjlu@umn.edu>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2019 at 01:31:38AM -0500, Kangjie Lu wrote:
> nla_nest_start may fail and thus deserves a check.
> 
> The fix inserts such a check and exits gracefully in case it
> fails.
> 

Except it won't because we pre-reserve enough space for that attr.  Subsequent
calls could fail, and those are checked properly, but this one won't.  Thanks,

Josef
