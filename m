Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 376FAC3A5A6
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B9B2341B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 13:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S4xlxo1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfH3NnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 09:43:19 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36806 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfH3NnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 09:43:18 -0400
Received: by mail-io1-f68.google.com with SMTP id o9so14069051iom.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zYGH3fN4v8plY5qOryvWCm0ZkkSEcqIXPLFE0LXF1xM=;
        b=S4xlxo1McUe3ODbG6lFGApEUyreIy3lVJLjs+cn9444a0h0+Rw/NY4ZYuiUhvrjZPo
         DmB3w8J5vYckaTr6NsZa5XfN94OcZxbrVgulnZbOWhB6mRLpe4+kLyv43tswN/kHk4GG
         9UHMiIN5cFXivXPg3y9OVT9Tg1EsF/bMJHpgPMOgiv6k4nDTt2wvthKF6hoO3GMwReXK
         fIQpZ2YrA/op7HljEdDrnfM3cap4cNptn4aIL7Tiiue5UgTXJiAZOyYcBEvGwX4MJfyC
         kYCa9ot7vwFWEc/WqwgS2OomWM/Ed1tsIkDvT7jB8a7sXwHTnKsiDO4uIU9ToiEeWM30
         Hlww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zYGH3fN4v8plY5qOryvWCm0ZkkSEcqIXPLFE0LXF1xM=;
        b=UnGrmdalhPoMXGr55PgeudHvB0dqafSWzHnERfdyAZTCx6s0kf/qCdxGtEK/ymzw6p
         YBZdF1/9jmTtQm+QqUXKB7VnyQQq7RkhDELc2SfZXN0L2ACtyWVzO+p0lt6hkxhlGewK
         b0upd7BeYojeroR9rPrNy72hmNR6OYoL+MHSrnZ4t0eUnT4TH9lwAPmX2GFmuWcphEF6
         9m2hUUuNJnDXvdanu0mQJeHq8+ubR9E4G1XNqhxGAEeZxPwwvcB7xKcNQC5KuShScS+n
         IWkCvVRpudSbN7PNDxNThuU+WpBaZVPzy354jOOuRnVqIDcx+F9aeUG0K42RtC3x6831
         z+jQ==
X-Gm-Message-State: APjAAAUujGe0iUVLvacfoNutXSrZIF7TIqurvkxn2NK3LpaSTk4/i3+k
        jAtX80HMQo9hewtTZPrQuDzZEA==
X-Google-Smtp-Source: APXvYqxv98ySoIehWYfQrkiVnKQ7682zkf1UCD2MmgpAND0sCQpnfidFJwrCLdPl9ybmgBa1NkKwWw==
X-Received: by 2002:a6b:3c0a:: with SMTP id k10mr12501340iob.282.1567172597938;
        Fri, 30 Aug 2019 06:43:17 -0700 (PDT)
Received: from [192.168.1.50] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id o2sm5032889iob.64.2019.08.30.06.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Aug 2019 06:43:16 -0700 (PDT)
Subject: Re: [PATCH block/for-next] writeback: add tracepoints for cgroup
 foreign writebacks
To:     Tejun Heo <tj@kernel.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>
References: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a54af97b-b9c2-3e31-d7e5-bacd40e74711@kernel.dk>
Date:   Fri, 30 Aug 2019 07:43:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190829224701.GX2263813@devbig004.ftw2.facebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/19 4:47 PM, Tejun Heo wrote:
> cgroup foreign inode handling has quite a bit of heuristics and
> internal states which sometimes makes it difficult to understand
> what's going on.  Add tracepoints to improve visibility.

LGTM, applied.

-- 
Jens Axboe

