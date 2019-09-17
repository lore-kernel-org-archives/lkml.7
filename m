Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A0D0C4CEC9
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1FA2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 21:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVOe/Ydd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727106AbfIQVXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 17:23:14 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37248 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfIQVXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 17:23:14 -0400
Received: by mail-pg1-f195.google.com with SMTP id c17so2675290pgg.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 14:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=dkVBs4zSzdoiTgFubYHQRj4hsdd1sH32Fqwe9PFIl1E=;
        b=wVOe/YddR4PEOW3182urUd3iwixirM6pkgMLHtyn7FokoYN8LS8B6SMKt5l9whP5Xd
         a41neH7o7zLWQxvGN5M5g0frQiA2ej+vQjgGay7TLUFHp+TANnV9USPjLDhR6zvRgL7W
         k8H+9BQ5dmOU7ShP367cEpHTrfWC+bsBvSQ0KXrS7qKbQQFNSHXzd5b+g3oqHZQONOd/
         zUSuxUdQK59oR8cxKz87iKCuw6w4V76d1rG8SwlQ7fMK96l8ElmiECWhn7959fLCsXKO
         LiIohUJ/XepjXUw/fl3S3CZmdbvsoDifuqOV7B8/s8Lc9uy8/GvDdOdZifDF6MWOoJBx
         eCrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=dkVBs4zSzdoiTgFubYHQRj4hsdd1sH32Fqwe9PFIl1E=;
        b=pGwxwqljPWb/kf/l0BdKMZeZkjjpnjfqm38JqJWPfVIGCmvmVSFPEUQJvExAUuwQGT
         BIF2MWWFYgcSGrqZEmZbxyCyRAIf2c8pgq3x7t0Cpko8wcxnW54AsuEVKOhIufeP69bT
         C0J5mKdZ0W/qHlMSXfpzxepgedlAzM/bYF7lck3SvHrbRtc2171Ny3G9oCs5qTsgCRuj
         V8h/aVcPPgeWWms/7tpi581bKXAXktVFnQa0HijexnOkpHiP1jPWD5Q9WlWM8fS6eiax
         837FAbKKVd5dySRg5Dx+7YGOUU6xSe0CT6iHv9Af+YXlETYrL36q6A4PB+YtDHyt7Tfe
         vvPw==
X-Gm-Message-State: APjAAAXRA/Il0KiMMn1pgBTjnmkSVaEPSZilWbDpT2YFxyEdMIDZv2HD
        adoXnCyLDq6cdbyfDn2b2P6URg==
X-Google-Smtp-Source: APXvYqwg9LNi+p1+U++EQh5F7CE9dUr0dz4AtnURwATfkLVnhYCkiEcmfusC9N1DvFAukd0L3bSzFA==
X-Received: by 2002:a65:6903:: with SMTP id s3mr818977pgq.269.1568755391787;
        Tue, 17 Sep 2019 14:23:11 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id m24sm2801001pgj.71.2019.09.17.14.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 14:23:11 -0700 (PDT)
Date:   Tue, 17 Sep 2019 14:23:10 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qian Cai <cai@lca.pw>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: fix -Wunused-function compiler warnings
In-Reply-To: <1568752232-5094-1-git-send-email-cai@lca.pw>
Message-ID: <alpine.DEB.2.21.1909171423000.168624@chino.kir.corp.google.com>
References: <1568752232-5094-1-git-send-email-cai@lca.pw>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Sep 2019, Qian Cai wrote:

> tid_to_cpu() and tid_to_event() are only used in note_cmpxchg_failure()
> when SLUB_DEBUG_CMPXCHG=y, so when SLUB_DEBUG_CMPXCHG=n by default,
> Clang will complain that those unused functions.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: David Rientjes <rientjes@google.com>
