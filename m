Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592D6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:15:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A1322CED
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 00:15:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="e45AO9Np"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbfH2APa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 20:15:30 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44335 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfH2APa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 20:15:30 -0400
Received: by mail-ed1-f68.google.com with SMTP id a21so1930888edt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=HXiTUrgTpySDqJ2z0IlxRdwN/AdZPM9PRJWDyYhpIx4=;
        b=e45AO9NpuZXfOGepMifc4AUPa3t0G9HNLJF47YLc7KvpKfDYlLUXsWbDH+Ox2bJk6K
         VYy4b4AsZ1P8MUQAX9P+ezN47AUeq4yQEIO8yWmcoZ5roCARG2MvUVt3rD5qpLpuo4PI
         Rb7wyAGeBjWQaPMW9syxyBJdgbrXVULFUPptgKkOwB7lcJ21Mf1mBowRdOBTTtNivoLA
         nvjyehZPuY3TxuXV0xG+lYuwG3uMhwkGteIC1vedzAobSccRI73X3BexTK1oY22C4Hm5
         CYDDVXMYV99y0ImBhz0mhyOktBWHEl8PPOep3vvSJZliHZfT0ZJkCJ4T5+r7kcW4L9Gy
         o10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=HXiTUrgTpySDqJ2z0IlxRdwN/AdZPM9PRJWDyYhpIx4=;
        b=ntRZfYI4eaZHHkoKv4NVfsLfCYw3RG8Iog60VoDOZJud1298JDNeMPouiJ+dKwi+pC
         Typ8yR0tesiRCajK/3FIAtrcDIHxtnP2hUuaEwTXr/oNjQm06kHPvGLtPTTQrzb4NBMW
         b5rYgTaqgcAt4A+6zbARMxJFrHwP7ONsgys5xFYi+fW29PpqP/uM9lCJrDnNyD66pVlT
         feqIF7A5o/b9qHzN2CibA7BVRZ3Kju0I9qWj47M/eOAHngXHxYbyYkyGve+RyykYIHAz
         7r18hIY7W9OR3bMn9Z4qybc/gkTsoG1zyrJch4RhvJcZ1AT8O7Vck+423ZBJs60IpeD4
         q4Ng==
X-Gm-Message-State: APjAAAX2IYiTqqVTaIeb8pDkceX/mN/BLcVZUiKdYK9C3IrIbTr/Gwc8
        /2rRbVkM4as9byNx3PD1eS2FTA==
X-Google-Smtp-Source: APXvYqz4W1FQHE5dUOt5X8/Pj/tl8Yb2m0qydnOk+JGjbcp4O6ydKYlpMp4kKWu4l3Teq2GOsVaL/g==
X-Received: by 2002:aa7:da4a:: with SMTP id w10mr6942046eds.74.1567037728472;
        Wed, 28 Aug 2019 17:15:28 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id sa25sm124124ejb.37.2019.08.28.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 17:15:27 -0700 (PDT)
Date:   Wed, 28 Aug 2019 17:15:05 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Masanari Iida <standby24x7@gmail.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kafai@fb.com
Subject: Re: [PATCH] selftests/bpf: Fix a typo in test_offload.py
Message-ID: <20190828171505.105c2cf7@cakuba.netronome.com>
In-Reply-To: <20190829000130.7845-1-standby24x7@gmail.com>
References: <20190829000130.7845-1-standby24x7@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Aug 2019 09:01:30 +0900, Masanari Iida wrote:
> This patch fix a spelling typo in test_offload.py
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>
