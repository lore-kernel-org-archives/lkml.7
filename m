Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDEDC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB637206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g40C38oV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbfCKRGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:06:38 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:36366 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726625AbfCKRGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:06:38 -0400
Received: by mail-qt1-f177.google.com with SMTP id b3so5895024qtj.3;
        Mon, 11 Mar 2019 10:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=riQxMYDRUtRyzbl0IugJdFYUK928VjLGXSfJ+euBnc8=;
        b=g40C38oVyqUvYm5SGqDp4/L9rZ3Yl75I6+vgAqLD+kx7i4tqtIXZFiyiU0vlAqEcjJ
         WHN/Ltg7CbD1bGxYvsh3WjuBK4LvmsioXeR5+rENf53lAy0CTciVuuYEjZsizs4GaW9d
         ql8wrW7HGV/zmX/Bm66xvJ5cnqmuA1z3/TIbv/ccTMTNGtNsmaiwgPwsVaSzBFfAKmI/
         Eoxpj2Ky2wFdb2HysLM3WHQXhnB3zOkF7H/aTP+BF9qGg8HOm8m61jNE0AyUxmCbRw0F
         mysDXKTkN0iLXkz/tNNn7PY5gTeforlvvwhkihBjVLjj4duRPmmEAYH7lNzqHacQlTHg
         kXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=riQxMYDRUtRyzbl0IugJdFYUK928VjLGXSfJ+euBnc8=;
        b=bNT/bKTN6unQ3pl4fayibXYsC5p6KMVb1HcFdHXlmIYw7xQZye/3S8OYWXLA2Sd7nR
         0CLv3ChDkncEEF8GU7edvgH4kvpinlNg+7d48bxt2aqysjpVaLKmSXYzaX2ToELSp6pU
         ioTbNoZIYWqOJ0wEmEVxkv3cdjmACdSCxWR2h0R1lBzJQJeLhp6gr1KUVi8GeHn4QCuc
         bDTWMN9yqyPNwSmGaoD8LoM7dArDtha2VaTGn4Fcf4b/AWT62aDitgTb4i4Ml36UXxOY
         oogSDIxEGPZ4Q+tRSSNU5p0EH2udafh4gjh8gVq8unzJdeDqZ3YU2NZ8svT3YNLnzRa8
         AQ+g==
X-Gm-Message-State: APjAAAVLc8uuy2NvguiMfLVt+ngaNKvestQduHZmHy/x3xWgkWVK6r0p
        cVrI100nD5AzupJairnzSLemPLcrSpY=
X-Google-Smtp-Source: APXvYqzFZ0BGc77gp9W1ZltkXfIZB4AwqQ9Iv/rSl/A1wolMXLZK8MmHiHCfXsf9fJfcUvaveku00A==
X-Received: by 2002:a0c:d849:: with SMTP id i9mr2327919qvj.207.1552323996945;
        Mon, 11 Mar 2019 10:06:36 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.162.132.204])
        by smtp.gmail.com with ESMTPSA id e22sm937810qte.42.2019.03.11.10.06.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 10:06:36 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F11A84039C; Mon, 11 Mar 2019 14:06:28 -0300 (-03)
Date:   Mon, 11 Mar 2019 14:06:28 -0300
To:     Andi Kleen <andi@firstfloor.org>
Cc:     jolsa@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 05/11] perf tools report: Support running scripts for
 current time range
Message-ID: <20190311170628.GR10690@kernel.org>
References: <20190311144502.15423-1-andi@firstfloor.org>
 <20190311144502.15423-6-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144502.15423-6-andi@firstfloor.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 11, 2019 at 07:44:56AM -0700, Andi Kleen escreveu:
> From: Andi Kleen <ak@linux.intel.com>
> 
> When using the time sort key, add new context menus to run
> scripts for only the currently selected time range. Compute
> the correct range for the selection add pass it as the --time option to
> perf script.
> 
> Signed-off-by: Andi Kleen <ak@linux.intel.com>

Thanks, applied.


- Arnaldo
