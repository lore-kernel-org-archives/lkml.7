Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B0CC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCED21721
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 19:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="STJ5MbvR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbfGATwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 15:52:15 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:32803 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbfGATwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 15:52:15 -0400
Received: by mail-qt1-f195.google.com with SMTP id h24so12964719qto.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 12:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+dbnRspzNIxjgzsL7DM7toTaRYtZRP01fs20r9H+zxM=;
        b=STJ5MbvRVMUSWKDxkuYn2DY4/Ew0Xfy6cQDKIEyo6CdeNP3Cr0ElbZ7qaQfF6sQY98
         4PXnpQfDVvhN2U6W/sl9/W9f+7dcdGyY5bzuJ5eE39y/Ees0e4erSj6v3Xsnp0lk3J5T
         PUQ662VRt1U4q68a3FspKNkKTtkgKbK9ps1KdJVoGkJsOjOlfcPYTDiOIaU5Vd647Wpc
         INAvnBdkZLw99NHACX3HWr3ZFCp3EI5d1VBf5eFXyt/9+WQePNhX+EnsOxsRUCQNHIRt
         JZ7prLEcFmP9a6AuTMi6iFSBo83blDe7/KbtAINQ7gZuTzYFQQKP4pUkhHwGBEAfX70R
         jG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+dbnRspzNIxjgzsL7DM7toTaRYtZRP01fs20r9H+zxM=;
        b=p3yyPk7/sfjiy2YaksuzHgI9+jauan4sINGuqDTirEEmB3LuP7ASOzSSpOyBZWvSct
         hXdS96/Ud2O7nVkb+JV7S/uPc4WmDGlafdf1RRzRQxEG1UDI169VKXB8oHRfJAMRRmr9
         G0gQvSY5Hit8axyihJAhsKxRD0jbMDiDVs3HXH3LwejxPkRgvzA1u1LP0gqBfSE7D2y/
         UIc+ZaIZc/fkfFJSNQS+dk6DsxWsK31dprQvibS0X9BPnSxQKyl6wTiWod+Ve3/+0hnZ
         Dpp6qMiGs87BeAQ8CdkD++s3QkRpBRBikCto8cAJ5KWnj+cI0H8R/KWjDFS/7nQo9rWf
         jWyw==
X-Gm-Message-State: APjAAAU7uBwTcLFRD9fVSmhS96Wj+hPWfPezy7X9VbTgDct1bnCyMxf/
        oUVx3a0VtLcSgjUpIeewNS4udg==
X-Google-Smtp-Source: APXvYqy4ourwUdSYfmebAZTb7PaHdpEO6rwSNcWbCSFYJv/CUMVWD7T776XZV2wqP0E32zJE0joPZA==
X-Received: by 2002:ac8:2a99:: with SMTP id b25mr22354194qta.223.1562010734470;
        Mon, 01 Jul 2019 12:52:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::2ce6])
        by smtp.gmail.com with ESMTPSA id a15sm5991387qtb.43.2019.07.01.12.52.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 12:52:13 -0700 (PDT)
Date:   Mon, 1 Jul 2019 15:52:12 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        dietmar.eggemann@arm.com, peterz@infradead.org, mingo@redhat.com,
        morten.rasmussen@arm.com, tglx@linutronix.de,
        mgorman@techsingularity.net, vincent.guittot@linaro.org
Subject: Re: [PATCH 02/10] sched: change /proc/sched_debug fields
Message-ID: <20190701195211.ct5fsildh4x4i2ki@macbook-pro-91.dhcp.thefacebook.com>
References: <20190628204913.10287-1-riel@surriel.com>
 <20190628204913.10287-3-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628204913.10287-3-riel@surriel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 28, 2019 at 04:49:05PM -0400, Rik van Riel wrote:
> Remove some fields from /proc/sched_debug that are removed from
> sched_entity in a subsequent patch, and add h_load, which comes in
> very handy to debug CPU controller weight distribution.
> 
> Signed-off-by: Rik van Riel <riel@surriel.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
