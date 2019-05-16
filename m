Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FAKE_REPLY_C,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC687C04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A352082E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 18:58:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0u9IeHa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbfEPS6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 14:58:02 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42309 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfEPS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 14:57:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id l2so4526513wrb.9;
        Thu, 16 May 2019 11:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4Mod0w+FblAyMcQEjnQi2LEp2GvI/rgCxO2rN911/JQ=;
        b=p0u9IeHaeL0IXuaE2OqW0lMXODaKkgs4K4WIJeoZq5PwlAkEW8iYzmS+IGQJJdCLrB
         Ogtl4LZYRKZifbaedBOZG+NoPgPuyndNkxOgNVWrCkQQQ3NdttqAW3CQlS4z1krFyKPU
         HQRSShHBtvYrmd7aGBDq1Phw3vEk4jBEWwTsBUfpH4KrZX0LGTOH4GiMT37p3smtiCZC
         EBSLYXOL35i0Nqv1veRvkze3B9z9HM5OWXFQnlaEvFS2fBpqYeES26jiW85PfIIVLftj
         /fumhtoC016Ox4D5ynOnogCLC3BWdCRR+Bj5XKrmcFmVKKacUjgEuo5BjUuRrLsXhYFV
         5XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4Mod0w+FblAyMcQEjnQi2LEp2GvI/rgCxO2rN911/JQ=;
        b=JoiPjXkb9KiODCsrez15uio3T4MPtIw9+ewDIV1RUSi1KIj8938LMyC+Nd9KjLLX1N
         1D//sh+HvQHext2WXQgnicgGp450XW4RCMeF7N1KgJNZzQxWaAc3r9QcfajYR+dmEvq2
         G2Pda2gy5czBdlv/Jc98ibyKAnOqX2HrunKWBpEsC/9KFRYoDPw8EWbxxGPqywlO18f/
         2SYySnOrlUKfBgbTmqkXBCmwL64Ioq5ASUHoA+bUZdhSpA+gqEezNwC1Dt45uqIbDrn/
         1CaoKk/jPu08fpeTmk057ZwVRiFNfHzPSZMBieENxmV+DEYhnjaQcjLP5efdHOTZxkqU
         isMA==
X-Gm-Message-State: APjAAAUrlOJuDYp4g9nOtPaYl08EPf00ZxwSKbTb4AesSbOe1a4scEFv
        +Endmwj+ULm4ruSHpHKH8g==
X-Google-Smtp-Source: APXvYqxuNzzHHmXNKHk5zRo9ksI0vdF5MVWpEvA/CeD1EWGNHKQxPIroglRzqbwei99YOQVgE7edPQ==
X-Received: by 2002:adf:b6a5:: with SMTP id j37mr27592391wre.4.1558033078012;
        Thu, 16 May 2019 11:57:58 -0700 (PDT)
Received: from avx2 ([46.53.251.158])
        by smtp.gmail.com with ESMTPSA id a5sm5334361wrt.10.2019.05.16.11.57.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 11:57:57 -0700 (PDT)
Date:   Thu, 16 May 2019 21:57:54 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linux-abi@vger.kernel.org,
        christian@brauner.io, dhowells@redhat.com
Subject: Re: [PATCH 0/4] uapi, vfs: Change the mount API UAPI [ver #2]
Message-ID: <20190516185754.GA23402@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>	unshare(CLONE_FILES);
> 	/* we don't want anything past stderr here */
> 	close_range(3, ~0U);
> 	execve(....);

Yes please.

nextfd(2)
https://lkml.org/lkml/2012/4/1/71

fdmap(2)
https://marc.info/?t=150628366900006&r=1&w=4

I like fdmap more.
