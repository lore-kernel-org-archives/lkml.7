Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B3C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C072341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 15:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="pSVl9bYd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfH3PB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 11:01:28 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39500 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727754AbfH3PB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 11:01:28 -0400
Received: by mail-io1-f67.google.com with SMTP id d25so12070534iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+6AS1wxaosaOlU3Xtuxu0RL5HXDYhQrxbAdoPZ19vYs=;
        b=pSVl9bYd1QooTuZSyeNmhaOBRtjqTSbV2cgcRm38IMnu3KcnhSyrSo+3S3EKYdRY8t
         t/NyMeiG+PxGw2spFgAHwQHqxjbRJReIeH96l5s+Q7LD+Gs8rBCq9R5EdnHugT++kidy
         FLK4veATSyOFDVPTE4PCQXVI89ldXKA56Gdts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+6AS1wxaosaOlU3Xtuxu0RL5HXDYhQrxbAdoPZ19vYs=;
        b=hgDvgiUjtjdvhTmy6zQt0ZWoRja8Pvfrx64Ja9F29AnhzVl81XA0xlHm42mZ0T/Wvu
         ozRzsPpIdCLeCRTL+X/J6hf5XLZkjo2MfMzl/lnMQZZyccMUH/VSGgo0qLScU+gfHJNd
         1/XmAnL83CjOz7TAcNI+TOxfF+Qps/MMJY/MdAy965L5sPjajNEI6Bu0Ko/kAXxBeDCh
         QAwhd9jzSSwNNcbatIjXlEYxwzeP4S2NH3Xv8kmSS/0ntQwWQEGKjZDO+jDfakp2hSkd
         w+NOo04Kxe4A2pMvLZg/TVI/j1OyWKFhyohQf/s05ij7GbGSXKEOOjs34dh5vmu1Pnaf
         u/VQ==
X-Gm-Message-State: APjAAAX6WRtYHvQf5h7Vu6cFiTCqsdKyTvNvDDkYH0lsa4pnxoLDz5PI
        gEOmchiUOwZWDRsbX1BnGTEeNg==
X-Google-Smtp-Source: APXvYqxq+wRB1RyW9v8NRY8Y3CdZkE2gv/yw5RLu0LHoRhnGJPWY7GmO8OWIDwmh5HDMIuzUuwty6g==
X-Received: by 2002:a02:6a68:: with SMTP id m40mr16174861jaf.135.1567177287137;
        Fri, 30 Aug 2019 08:01:27 -0700 (PDT)
Received: from rocky ([2607:fea8:bea0:e11:9410:aa2:6ab7:15b])
        by smtp.gmail.com with ESMTPSA id c18sm4580330iod.19.2019.08.30.08.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2019 08:01:26 -0700 (PDT)
Message-ID: <13610f1bd1c248848611fbf2d46f351bed9ee7f0.camel@kepstin.ca>
Subject: Re: [RFC PATCH] tools/power turbostat: Fix caller parameter of
 get_tdp_amd()
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Pu Wen <puwen@hygon.cn>, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Date:   Fri, 30 Aug 2019 11:01:16 -0400
In-Reply-To: <1567156956-29634-1-git-send-email-puwen@hygon.cn>
References: <1567156956-29634-1-git-send-email-puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-08-30 at 17:22 +0800, Pu Wen wrote:
> Commit 9392bd98bba760be96ee ("tools/power turbostat: Add support for
> AMD
> Fam 17h (Zen) RAPL") add a function get_tdp_amd(), the parameter is
> CPU
> family. But the rapl_probe_amd() function use wrong model parameter.
> Fix the wrong caller parameter of get_tdp_amd() to use family.

Whoops, good catch. Before, this code was only working because the
switch statement in get_tdp_amd() has a default case.

That said, this patch is effectively a no-op, since the get_tdp_amd()
function returns the value "250" no matter what argument is passed. The
only reason the function exists in the first place is that I thought
there might be a way to read the configured TDP from the CPU, but I
couldn't find any documentation on how to do that at the time.

Reviewed-by: Calvin Walton <calvin.walton@kepstin.ca>

-- 
Calvin Walton <calvin.walton@kepstin.ca>

