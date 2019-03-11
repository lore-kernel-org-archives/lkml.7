Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 462D0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D03220657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCZyiTpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfCKSSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:18:22 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34167 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKSSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:18:22 -0400
Received: by mail-qk1-f193.google.com with SMTP id n6so3311313qkf.1;
        Mon, 11 Mar 2019 11:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O7jO7rs8Ohfe9b7GEKGMkhUK02B6cyZTegWwSqUx2+c=;
        b=mCZyiTpBSJ/QkO9hYtAPar0ZDuPtKY6f1mTcrePc3d+WtwZXWcN3ACAQ1C3vzgyRS3
         sxi36g/nLk14AaO7G7BJpl8TuaFA29C8HfixTZR7gvoo1sahMK6MnW16G+FGgH2YCH9k
         0ckZRIrgaURviesfLxk2tNQFJgv37cZjqZhm6DH543b78geAY10DrN0jW5cMlEcaoB+o
         QNKp2b7bZ1UfXGl4Ya4FQmobWb5vkZnx6zCXFElphnvqnpzT9IscElSlDuAnv+Cwo3b4
         DgQhugyRiWXn0FB5SNluK83bq9H41Xk/i4R9U9VbjDXG82sWHF7ptdkYkH0d2p3EUi5j
         h9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O7jO7rs8Ohfe9b7GEKGMkhUK02B6cyZTegWwSqUx2+c=;
        b=UykW+QPt6A/o7ZDDC/Tn9RatgpB9gqzX69QDPnSVqiaGiV7AVw39IQTC3169LO9GfN
         QDkCo4swtPxmBzn9d5Z1Vte8UwSjWEQkLl7GUObR2eK960V6vCFvpv8iePLbYHk9f7bT
         hmxI0E8koehcgRVZ9zgHFVLtf8UkjydshxocRtvdOG2kuxuaJx/5FsDYLuVzAI0kjf6D
         e8KA/FwESB6HPeNBZz7os/AZf/FTePWQgQwl5qPaH3dkcG3PIpHs079Skrw1yH6nCcYK
         WupQAPynfeWiisWnjASvxTCMLLlsRBLg3INr3jeJaaTLjE6vVQe7hMXyQERgieQLRUTy
         IAvg==
X-Gm-Message-State: APjAAAVU+fjnACYwYph29L3NtUAjWdnj8Q+H6qFzZKZQxIDeQsmXCxmZ
        fh9rMIvFLT/U7QrhTKMSSgU=
X-Google-Smtp-Source: APXvYqyhPXZVTL+83v64bCwrdbsx6r9Vc9kRr6NGcbuMGYxFBrVD0CAxPG8BMsq2z1uQ2V9Bx2oPkw==
X-Received: by 2002:a37:4c88:: with SMTP id z130mr24994155qka.206.1552328301260;
        Mon, 11 Mar 2019 11:18:21 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id k27sm3351103qki.19.2019.03.11.11.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 11:18:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BAD6F4039C; Mon, 11 Mar 2019 15:18:17 -0300 (-03)
Date:   Mon, 11 Mar 2019 15:18:17 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 10/11] perf tools script: Add array bound checking to
 list_scripts
Message-ID: <20190311181817.GV10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-11-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-11-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:45:01AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> Don't overflow array when the scripts directory is too large,
> or the script file name is too long.

Applied.
