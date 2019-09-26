Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC6FC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4533222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 19:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569525576;
	bh=HtE9YZm2xqRLii2SPx9bVlH25BMCMsFegMBTW5xe8IA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ESzBG6uhmZskKnvqP0ieBp7TjA6VVaLUqayKH/O6sTPWcW29tOBeX4S8k3kBGB9g8
	 CLAIXg2z8Q2EwZE074O3wxhKBgppLbEFNPwdzRnd9V2HmWkINpJ38KMmmciDyVKxni
	 7qiRZUga4kgKB0mxHxBAB3YyJ+Gn3mpcG4Bwx8uE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfIZTTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 15:19:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:37199 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfIZTTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 15:19:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id l21so73605lje.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GiZ5XkiSe0GQ+VPxuAaFzoJ9mvYMh1MShnjH8fQ9hAI=;
        b=c9mTnqktidPTMYUOmMWXZMF1goG76CXiNifuKVesxB5dObJ0alKuAuZtRHPM7MTsE3
         PfSbj8B+f1Tckr50tkYnebK6E1998jFhRJ+aDRYwluwmX3Z6mrcbu3NYDRsUsD6t5cuy
         HEUQ+3kqxJ3QeSCrC5XOLkh1HS3nztUHhL2AQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GiZ5XkiSe0GQ+VPxuAaFzoJ9mvYMh1MShnjH8fQ9hAI=;
        b=DClAFoYht0Bdb1kuP09gAvpgvFbO5wmTMJiKzrq5hiNTxL5EhksYPlW+5XIM0v+UcY
         mCr6YpqTw5499LLo+C+KdeZ7PCj9ZC4OsueTOG2IbfUHMw7MqsRSH6jtnVokYt8kJCfA
         RUzSDeUPs8jx98A/Iov6WWOaqM3dHehcQPb/qsIcbNTj2FHzsXSfkCRrXj50Rh0iE+fy
         EbkleVay8KJfhD1ZkEE+phI7yNR46KFV8NIpa5MeXQayFRafq89WF/v+QxGNS3Oum2B5
         toNuBdIXWyFhMI6XDZTEtK4i+ICbWuXoh7KogAwuDry7vN6tHOYocD4WuzxUTzKOv3G+
         lKcw==
X-Gm-Message-State: APjAAAWMUY/MG9jD81MBa2M0i3e/NklsWiLrXAfEDm9EQkuiAzMZR7qi
        2M2EdJXZy/Ox1R8v9k4HjRlMMkWcRvY=
X-Google-Smtp-Source: APXvYqwaKRirHyzmjzz2ehooLDQ5TaJdB8gcyq8Fq0VVv1MQAwBVC+J+5y/5CVVr6CpDnSvoD4GUkQ==
X-Received: by 2002:a2e:8558:: with SMTP id u24mr151779ljj.191.1569525572386;
        Thu, 26 Sep 2019 12:19:32 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id k28sm26452lfj.33.2019.09.26.12.19.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2019 12:19:31 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id w67so53686lff.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2019 12:19:31 -0700 (PDT)
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr90953lfp.61.1569525570797;
 Thu, 26 Sep 2019 12:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190926115548.44000-1-thomas_os@shipmail.org>
 <20190926115548.44000-2-thomas_os@shipmail.org> <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
In-Reply-To: <85e31bcf-d3c8-2fcf-e659-2c9f82ebedc7@shipmail.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 26 Sep 2019 12:19:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
Message-ID: <CAHk-=wifjLeeMEtMPytiMAKiWkqPorjf1P4PbB3dj17Y3Jcqag@mail.gmail.com>
Subject: Re: Ack to merge through DRM? WAS Re: [PATCH v2 1/5] mm: Add
 write-protect and clean utilities for address space ranges
To:     =?UTF-8?Q?Thomas_Hellstr=C3=B6m_=28VMware=29?= 
        <thomas_os@shipmail.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 5:03 AM Thomas Hellstr=C3=B6m (VMware)
<thomas_os@shipmail.org> wrote:
>
> I wonder if I can get an ack from an mm maintainer to merge this through
> DRM along with the vmwgfx patches? Andrew? Matthew?

It would have helped to actually point to the patch itself, instead of
just quoting the commit message.

Looks like this:

     https://lore.kernel.org/lkml/20190926115548.44000-2-thomas_os@shipmail=
.org/

but why is the code in question not just using the regular page
walkers. The commit log shows no explanation of what's so special
about this?

Is the only reason the locking magic? Because if that's the reason,
then afaik we already have a function for that: it's
__walk_page_range().

Yes, it's static right now, but that's imho not a reason to duplicate
all the walking (badly).

Is there some other magic reason that isn't documented?

              Linus
