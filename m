Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7540DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC2F20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="R8WaPvHY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbfCSK4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:56:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35460 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727225AbfCSK4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:56:43 -0400
Received: by mail-lf1-f65.google.com with SMTP id u21so4073971lfu.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TrTp/SXGuiH4p0VEUNoj9eUCKnAnXN9z+Kw92eHSV+0=;
        b=R8WaPvHYw7YwXTCJDOClMRlmFxid40JZKCcmeJVEz2Q8873xGqoCWc7eEcAKjzritR
         Apn8zV0lBtV0GZFJz/vsd/2QflraaY2Zk0YAvnprTP4bLnXh42Q19h3XUHnDur2z6iAz
         82C4I/tLPy6GdPZh4Cgt5r9IIIhyDRqZW/0UQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TrTp/SXGuiH4p0VEUNoj9eUCKnAnXN9z+Kw92eHSV+0=;
        b=i+PWkX/TuWY89Ut/YcI2MzIgpFaqlFDvLCKZazidD4MpTeGDS5ZoJgmYavbZkYQuRK
         hvfbEcr3K4EoBxSZMD7yoLlXZIJ5nVR10PM9v91rUXEI/MEu2gFZlUDQdlS4PvjrLsTr
         mxoTQ8ihr97G3S3g6mYMoi37JN2et60GTbcmzgmB0uBY8wnTMpPKoUVVpoKxFT7YgAbE
         1TrgUM1hABCA6r95o+Exev/rSftzu7JIzS2FJrV3PdeEttCLfXdJWfTxjtRij9sOt3jn
         +Y0nvmsVs14fM0r/gBd7+b1zlMplKDtvmhShxD+8NrdVicfXg8B4hH33K0FUJJRFQhRN
         fAaQ==
X-Gm-Message-State: APjAAAW+/Hpo4Y4Z1PYCzD+IbSnPJl1xhs7wKvirxSYPy3Qvbv20kP+A
        VPDrDTO2eg0oTDdl94IzkI7vvg==
X-Google-Smtp-Source: APXvYqy/CsRFvfY87iaaI2SNyDSLsMQN2/bVfXwFtOe8nPJ0LuZZG8ApZmy8sJtbKv9MDdzXVx1tiA==
X-Received: by 2002:a19:8c1e:: with SMTP id o30mr12049192lfd.137.1552993001168;
        Tue, 19 Mar 2019 03:56:41 -0700 (PDT)
Received: from [172.16.11.26] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id z7sm2750032ljk.34.2019.03.19.03.56.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:56:40 -0700 (PDT)
Subject: Re: [RESEND PATCH v2 0/5] lib/sort & lib/list_sort: faster and
 smaller
To:     George Spelvin <lkml@sdf.org>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Abramov <st5pub@yandex.ru>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Don Mullis <don.mullis@gmail.com>,
        Dave Chinner <dchinner@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <cover.1552704199.git.lkml@sdf.org>
 <cover.1552704200.git.lkml@sdf.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <fb5ef3c2-2346-bbe8-351c-67f6b8735f19@rasmusvillemoes.dk>
Date:   Tue, 19 Mar 2019 11:56:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <cover.1552704200.git.lkml@sdf.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2019 09.15, George Spelvin wrote:
> 
> Because CONFIG_RETPOLINE has made indirect calls much more expensive,
> I thought I'd try to reduce the number made by the library sort
> functions.

For the series,

Acked-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

and let's have more commits with such detailed changelogs and references
to academic work combined with "but in the real world we have to do this
and that tradeoff..." :)
