Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBAFC76195
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D3972082F
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563473990;
	bh=Z8FZTi0eFir5dseK/B8TV6Q+fA2J5hnef0bclzUSEYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rOOYW0AiAugoFqQ6bbQHgvS10T+tkfjyCZmFZfn+m4ipTikyBjHVEfkfxaPu5jQU9
	 wN2IIrbUSDwz+QgLGbUowEb5P6fGFlause72OP+bHNBV5VM7j/SWlaqBGERl3bGE6j
	 AuMtVw4dlZ6dzwjirb9FiVAw6XImY9reYqYEA9eU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390978AbfGRSTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 14:19:49 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46289 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390295AbfGRSTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:19:48 -0400
Received: by mail-lj1-f195.google.com with SMTP id v24so28343129ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gepmqZ8N/IE1dD9ivKS4WqYoEjZkViTT4tcrJbEnbOk=;
        b=hz94MbDILZQNajQa2trZ7qSP+dksrJ1mAn7+S56JhO9w6m2RoO+0OT5YlB/RoWVZsm
         b6VzRDPrYK6DWpUJo2nniO3XvejJMPKKxgv6OvnMr/AqDX/Q+A97QqUJ3nnZY+EcO0B5
         fNB3N40k3vyszAKIDXrJNNSSZ9MG6v37aATJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gepmqZ8N/IE1dD9ivKS4WqYoEjZkViTT4tcrJbEnbOk=;
        b=IgDX/mTDfKORwQuA2yVTnlFmFmz/bsUIB+8cQu8JMcYRuFufKH2hMacL2H2wzFW08b
         yOjlEz4HbYPh44t4NV3tBmguNxNXLf0j0/aiPm7Yf4XvOCjCQDSDrXr0iSgstaXLSA/V
         JdEh3L3tm4OuVpMFCduw6mIT0s9KiZh7UdJS0dOE8B5wBCXFv4gMR7qesfy9Qu4cOGOT
         qrFIdq5XelFm8sC8RL6r0KPBwW3F8l18piO1idbOuVGqFgb3I/TpXOjV6+QuMuW7EdrT
         LSudBcAOwvhOx9C8ZviyZSUn61RIfdSQc/nJ19kjfb+ifaSgVt4T31stmyRLThMg6lVD
         tCxg==
X-Gm-Message-State: APjAAAVHcR09PFmk7vG0wbjU6yiXYAc5Q0DvJto3GYsIbHeIGPJfFnPw
        Hnrqi/Y9XhI/cFiFu+PjGMtFE9vs1O0=
X-Google-Smtp-Source: APXvYqz8XwLn/usTuQ2heHE2G7A7OPAnmC1jycw218ri23iPhnCqEl5cKHUHwBLZScyoYlXd2Ej4Tw==
X-Received: by 2002:a2e:9e81:: with SMTP id f1mr25326206ljk.29.1563473986144;
        Thu, 18 Jul 2019 11:19:46 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j90sm5229695ljb.29.2019.07.18.11.19.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 11:19:45 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id q26so19914962lfc.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2019 11:19:44 -0700 (PDT)
X-Received: by 2002:ac2:4839:: with SMTP id 25mr21790208lft.79.1563473984522;
 Thu, 18 Jul 2019 11:19:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190718161824.GE7093@magnolia>
In-Reply-To: <20190718161824.GE7093@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jul 2019 11:19:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whewBiKzpsO73Y38SAPSktxD6gUuEr2ANC8Z_3JPiqk3w@mail.gmail.com>
Message-ID: <CAHk-=whewBiKzpsO73Y38SAPSktxD6gUuEr2ANC8Z_3JPiqk3w@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: cleanups for 5.3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2019 at 9:18 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> Please let me know if you run into anything weird, I promise I drank two
> cups of coffee this time around. :)

Apparently two cups is just the right amount.

                 Linus
