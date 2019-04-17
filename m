Return-Path: <SRS0=uTOJ=ST=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18E15C282DA
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DADBB20835
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Apr 2019 17:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfDvDce0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfDQRhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Apr 2019 13:37:11 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33376 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbfDQRhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Apr 2019 13:37:10 -0400
Received: by mail-qk1-f194.google.com with SMTP id k189so14867630qkc.0;
        Wed, 17 Apr 2019 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rhG0aoYPjp9s4pL++SAagqfbVWzZ75og0HO64YD37Dc=;
        b=TfDvDce0C6MB5Edb9RgZAar6yyY2nZ9R8BAhqA7jHaLz+yipha6KQwY1JIKmgV4tcs
         awS3aMLLKDp9fi/DZPsz/sdb1HvoV6wiVhrDQvNrWrjxMbYsDal0/1aG56n1/goLjQNW
         zSVN5DsqwBONtzAR0XueHGkPypPzzWrzaJa9tfWurzeQEJF0rKvwVPjBAzjgO/+4jQ5p
         eMatxIgPznhUBpgcXZPlt0CGyqjeIHCePfw1NcXIp1ztD/bU1XrlXTitwpubE1qO+tyV
         Pll15KRmmJBvj1hc55cb/YHBeXyEPRFbH24xONz8aRSm46tBnOn5kY9DKmz3hzR49pGF
         cFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rhG0aoYPjp9s4pL++SAagqfbVWzZ75og0HO64YD37Dc=;
        b=e0LyOMoT3R85FM5N4hGFQl/ucUWGw24EEl+GWvT1smTd1MRNWPFglCuckV2CSxXpHK
         qCIcSBHgf2/Xh2DfWvoZZA6DT0kj+JoYtf/LQiYpdvvLeAIWjIen7FzqYErZ4EpypN9D
         yXOBy6YSElFo6oaKayTkfjyaPoQIpZDOUv2KOxy9wO3zn0AkPIioJJH2VhC9MANt/PjB
         Kx46MYTYlmH5Ecm64aiJKJZJyw8e4ic0hyDbz5+OLNd2qMsqA48V8zIJiGAm0mUhSJap
         xjeXBG2boCBRRtHFV1f/y43urWAaJZolX01cnib9K4z8FOAWOz8Aw+lYsjlzhp+LyjWe
         J7ng==
X-Gm-Message-State: APjAAAU/xlOq5yxZ/8iGgJd1mToK2aTrtCwZ3n1NF0sMF4nnQwo6IBWv
        ZEoD6B0jXscCfAF57lbQKv4=
X-Google-Smtp-Source: APXvYqwyQ7HbhafqlyJO+Hkz18SilbigvDC0+FXIArCe5+KBgWyFIVwkRXuMQno7CiKslnUHrm6dkA==
X-Received: by 2002:a37:7383:: with SMTP id o125mr70125265qkc.56.1555522629139;
        Wed, 17 Apr 2019 10:37:09 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id q16sm33535565qtb.27.2019.04.17.10.37.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 10:37:08 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1AAD940521; Wed, 17 Apr 2019 14:37:05 -0300 (-03)
Date:   Wed, 17 Apr 2019 14:37:04 -0300
To:     Mukesh Ojha <mojha@codeaurora.org>
Cc:     Colin King <colin.king@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test: fix spelling mistake "leadking" -> "leaking"
Message-ID: <20190417173704.GB5246@kernel.org>
References: <20190417105539.5902-1-colin.king@canonical.com>
 <c9808cb2-7025-2b7a-f311-c69469fc1341@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9808cb2-7025-2b7a-f311-c69469fc1341@codeaurora.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 17, 2019 at 04:37:24PM +0530, Mukesh Ojha escreveu:
> 
> On 4/17/2019 4:25 PM, Colin King wrote:
> > From: Colin Ian King <colin.king@canonical.com>
> > 
> > There are a couple of spelling mistakes in test assert messages. Fix them.
> > 
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> Well, how are you shooting these mistakes one after the other?
> 
> Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>

Thanks, applied.

- Arnaldo
