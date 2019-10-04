Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BD3C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8102077B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 14:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xiJSchKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbfJDOEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:04:30 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:43456 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388270AbfJDOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 10:04:30 -0400
Received: by mail-io1-f42.google.com with SMTP id v2so13709441iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tJ+enjiw0qTMNSwdUMz2YW7UWK/wRJo2/Axq1O5DXYk=;
        b=xiJSchKdeSoi94+f/1x5VooggmYSkgd+2JeynPOaNao1uuFPY3STxV/NIyLQdAGXLL
         7s0SjqBiNn2MkWL4Y4SsnGjvLlTibEZQb9VIFPDdKX9M/qtzMZ1G2yt/WWtKXpm2gvP1
         52jEsBKRune2it9b64BpiPD5vhmwwXhjY0fvfOmoSTzjnLBMXow8aaC4WsbNOUGCGsaX
         C8JM/8Wi3kT2JwmFOUGD7Pi0OhnI/CsjBDETi7sT77RbbgxtOgM8r6fNlpiP1y/YRxFc
         lWlfBwJizFEmCNm3U76Czx1MmAZ5WxoDzNzdikTgvdUa/FmDXeV9YRPm6nOY9qegB6Az
         KTpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tJ+enjiw0qTMNSwdUMz2YW7UWK/wRJo2/Axq1O5DXYk=;
        b=oALopg0lg8/Kv7AGYtqOJrA8jyKtLgjYLuLqGtbPbjQ9LDavsxmoBf+fj7xgx21O49
         Z51gOCnFLUl8Tv+zZkjKICxTae8ypdHLtvAuT088MQmEYgzcTw35rlfG+ddKdwygA+KJ
         RyxKd0E535J3ZLt/f7IXjtZE3Iw/G2orSiUQvIHFuIn5G49cKVLQ63eAkZJzZc015XUu
         VA0yxZddhPGT4xoq1Bdx+tUdA/FW0Ysm0Bhvj36WvS0rW/nMN9lBHdgOLcdm0JAsbRaO
         bk+ZSPVjFBBlUqtAPzJkejZVeSKeWDwBYN3sDq/Na+FsctL8+x9cO2jeBIDVCOmnw8q/
         BTmA==
X-Gm-Message-State: APjAAAUCNuO4HXUgi59etFzirjHtcnGBeiGXv91o6qwkJ2WpuW7hD0Nx
        DZTKAau8YDmz+s8uGCshHdwTiw==
X-Google-Smtp-Source: APXvYqxOx976iqiZp/CwDZh3dbMMahnxL+pKPqa0bJXnsa7TmE1KnsPXFNDLdxtpU8/0Hg6EisqK3Q==
X-Received: by 2002:a92:d78c:: with SMTP id d12mr14803126iln.96.1570197869100;
        Fri, 04 Oct 2019 07:04:29 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o8sm3101385ild.55.2019.10.04.07.04.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 07:04:28 -0700 (PDT)
Subject: Re: [PATCH v3] io_uring: Fix reversed nonblock flag
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild test robot <lkp@intel.com>
References: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
 <9752f33f509287c77801d5e807213cff9195197a.1570197234.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <063ca0ba-96ad-3552-50d3-7eb9f48499b6@kernel.dk>
Date:   Fri, 4 Oct 2019 08:04:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <9752f33f509287c77801d5e807213cff9195197a.1570197234.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/4/19 8:01 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
> passes something opposite.
> 
> v2: build error from test robot: Rebase to block-tree
> v3: simplify with Jens suggestion

Thanks, looks good to me. Two minor notes that I fixed up:

1) The revision history should go below the --- line
2) I've added a Fixes tag

-- 
Jens Axboe

