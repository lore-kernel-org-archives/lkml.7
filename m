Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8740C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8549E2083E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 13:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0BgunIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732247AbfDJNAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 09:00:16 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43521 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbfDJNAP (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 09:00:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id c20so1102832qkc.10
        for <Linux-kernel@vger.kernel.org>; Wed, 10 Apr 2019 06:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yyWtWSdzcecoHSR1H/BynJZDNT7b01jBXghr8QWC9Fc=;
        b=Q0BgunIqyqlHxh+Y9Ju5WYUXKC+vH4Sfqken447P723NAam//yzs/8KTa9ahqaEQ5m
         ZtUpObG4wbJCoMt1eEDJJS1gQq69wtnfMDeGxYzEEwKg+X39e//Ag37RTVeU7ow2mDQe
         i2fVJqn1Xop6EoHe6CrdOGi8PDLlFHg4jvyC4CtkikBlkIvHk/2PNMQneX0IPo31l9ul
         OcLpIae8KIejMmJIgvfnI2lpYhDzZJqzqzIzTW1mnwk+TRloL4PoB1oLxAfyrxu9dha3
         aZeZLjgKi0xF87ux3XUZC1wy7OGuJ924m9LMOx0tAb06QIdJspXcdtp/D7z4QvMfYPTL
         uTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yyWtWSdzcecoHSR1H/BynJZDNT7b01jBXghr8QWC9Fc=;
        b=bNnvF1yCrCPjTdiUc6y//fYV3lWUnTI77oLh/KBSIFLB0sNQEvsxFCTzCZHoJ42KiJ
         VcTpjlIeGM0n8vtRekzSKfU+pwaOFrXqucIjZ39VlTmZag0HLEraV+VY0zxAPbFuobWD
         ECciTfTqFTjDjT0BKP/3AWvxBX3+I8FAl7wMaqUuBW/1NXJcZ7P9PzGeaee+l7gyg4KT
         uV4dG+Mw5U+Sg41r23974FVSaUzuG8m5IfkstOHXofxT4c7efeCK7qfgs+w6gFrBoSnT
         tDoiQORU12LgInVrcA7FpzV8HW4K53BQbze5GsowD4RhXg2WT/9vYrlCrp1L3uN+tvvS
         XkLA==
X-Gm-Message-State: APjAAAVLCf0JHby4W4aN4UulcLrmHnFIpwSauMRTzgcWtNFcUoKUYoZt
        yZZJS7p3UASKN1DeCyi9mbk=
X-Google-Smtp-Source: APXvYqy70Ul0rWHzCRCdlKeV/bKT4X8BETB3w+cgPQfYMhF5/XhnEGvsMsMS/u4FWbz0bLn9DiAOXA==
X-Received: by 2002:a37:a1d5:: with SMTP id k204mr34069149qke.167.1554901214227;
        Wed, 10 Apr 2019 06:00:14 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id h22sm28336326qth.68.2019.04.10.06.00.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Apr 2019 06:00:13 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id ADDFD4039C; Wed, 10 Apr 2019 10:00:10 -0300 (-03)
Date:   Wed, 10 Apr 2019 10:00:10 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3] perf annotate/report: Remove hist__account_cycles
 from callback
Message-ID: <20190410130010.GD13888@kernel.org>
References: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552684577-29041-1-git-send-email-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Mar 16, 2019 at 05:16:17AM +0800, Jin Yao escreveu:
> The hist__account_cycles is executed when the hist_iter__branch_callback
> is called. But it looks it's not necessary. In hist__account_cycles, it
> already walks on all branch entries.
> 
> This patch moves the hist__account_cycles out of callback, now the data
> processing is much faster than before.
> 
> Previous code has an issue that the ch[offset].num++
> (in __symbol__account_cycles) is executed repeatedly since
> hist__account_cycles is called in each hist_iter__branch_callback,
> so the counting of ch[offset].num is not correct (too big).
> With this patch, the issue is fixed. And we don't need the code of
> "ch->reset >= ch->num / 2" to check if there are too many overlaps
> (in annotation__count_and_fill), otherwise some data would be
> hidden.
> 
> Now, we can try, for example:

Tested with:

  perf annotate --stdio
  perf annotate --stdio2
  perf annotate --tui
  perf report --tui -> press annotation hotkey 'a'

Applied,

- Arnaldo
