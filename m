Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F774C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4359520700
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 12:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abs2/kSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbfC1MA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 08:00:59 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:56047 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfC1MA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 08:00:58 -0400
Received: by mail-it1-f193.google.com with SMTP id z126so5509159itd.5;
        Thu, 28 Mar 2019 05:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVDBjPr9OBXs3KNt4gc5phUNmqDjJOjI10/upymc2XU=;
        b=abs2/kSwOeR1FNNROATaRlKzqZpjU3/L7KsmdhhapFx1i9QZKgIhZB43op9EoAjPYD
         /I9/B0rvRZiPVe5YsD5Z6E9yWwyDSS+e/+CTlSTqf001IIgp7ySOOZIknSfeSYXtL9uS
         GWZgGICVpurEc9gFnA7T32npbArKv81izmCicZvuceH10f4TmoKJt3tVLMzjieRs/REs
         5w3iqUsdZIIOWkjkULnhFdQwWKWERney4/a0qTjrQPs5u7obVvkLTaXak/zHlX2Qlw5s
         mqZFZFSQHqplfhUuSYIkRyF5P5G/8I4Vzbjp6Xv4tC8Sn30YGMf8F6o+twaf7U8UKpeM
         6GoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVDBjPr9OBXs3KNt4gc5phUNmqDjJOjI10/upymc2XU=;
        b=aX730QTeCfq2gLmBDlw6xXlUznJOwcVLtS3QUjZ8wOwkNCA2Fid0VmcTaofWjnc1YW
         PFooyst+SL84Jl3c2pW7wOSWv4d3lRHPAdj5cMfwJ/cJiIlNhgjDHAPnU9dDNz/qtg4d
         KtfAc5tLI3Vu4HsuGTenYzV6CXd3z1Q2hAfP3YIu7k7ZhLcNGgrHjCLySPn8kXPp9wYt
         DgCyqsvsbdO4mLf1EEHy/a1dulGp0fNHUPXPRRWMp7wX5RKuQxyYhu88dO5jFOtcA2yu
         HGfXPtww0mhXQUB5HOipLex7i8rhXTNHgqqpR8U5YiqWt5aynuHJDygpcbP7HoQdV6TL
         Mxkg==
X-Gm-Message-State: APjAAAX3HtgKEihpR4xcxzYhqurKyXlI/VUqc57dhN3Kj9L7n0KlgY0B
        7v5THPHEe0Uhyh4STXha6gRl7t7rehHCH6zHHoTYsQ==
X-Google-Smtp-Source: APXvYqxUe7ZvISPjGkn8NjfU6J1+lpR6NynA/s/mdsS5RbPT5qw7XDww2of8lE1JuUrONCx+uG/Kb421y0AZ0e1dAw8=
X-Received: by 2002:a05:660c:94a:: with SMTP id h10mr7957359itl.54.1553774457645;
 Thu, 28 Mar 2019 05:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHG4imOAn7rcQWj--XMV2maBLgp4DynKGxwcbSzrcxk0a8n=8Q@mail.gmail.com>
 <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
In-Reply-To: <742c1607-1e28-3674-65ca-8e5f111e243e@kernel.dk>
From:   raymond pang <raymondpangxd@gmail.com>
Date:   Thu, 28 Mar 2019 12:00:15 +0000
Message-ID: <CAHG4imPE3pNXAd5WvF-7hLyyZfpgAcT7KkVoCa+0iTGbHxxbvA@mail.gmail.com>
Subject: Re: [PATCH] libata: fix using DMA buffers on stack
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Jens,

Thanks for review. I'll fix them up.

Best regards,
Raymond

On Tue, Mar 26, 2019 at 2:09 PM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/25/19 9:07 PM, raymond pang wrote:
> > When CONFIG_VMAP_STACK=y, __pa() returns incorrect physical address for
> > a stack virtual address. Stack DMA buffers must be avoided.
>
> The patch looks fine, but it's white space mangled so it won't apply.
> Additionally, you don't need to use kzfree, just use kfree.
>
> --
> Jens Axboe
>
