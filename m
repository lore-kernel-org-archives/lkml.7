Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21941C282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB25E20868
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:11:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oON3JTdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729860AbfEVQLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:11:49 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:51558 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbfEVQLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:11:48 -0400
Received: by mail-wm1-f50.google.com with SMTP id c77so2832554wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2019 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FT0F6Pffz/vTvGV/espArxBdiGR9UmPiCRUu0pGnRXM=;
        b=oON3JTdBwI2g3t4alGnJ7RfojjCsvTtUwCqsm4x+AtfxFOzF3Y/hs8KlydjbLClQOt
         2Cbw91NYgaQHcUK/8y2bdzCgVdWHfzNLDsOlL04IwqxTaYurjjcuWAKQj22reSl4Ijed
         /c2G0JBxZcnLtxPooe61NaW/6SOIZpQ7d5Be78TuUajkhkOJhHOMcCUCWlaMadDKairv
         MEwlezeJcRRNS10hZX+9nZ2/nZHBEaTdOfPyNeT6RLDM70lOimDLPbWWBZ7BqakZF6RM
         PuEw4K9v4DSFw7XJKnwrayL7chtXd55bH8rSebeqVc7+TpompzEG5TnUtvqF/GA8JXiZ
         IqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FT0F6Pffz/vTvGV/espArxBdiGR9UmPiCRUu0pGnRXM=;
        b=XTYXz7kNzZ3i8BZhRaBSYxAd4/41T5ZB5gPA0FLm0ucfGQK7RGauifA7ahQvz3iV4j
         aOQFoqT87YMAwgQAxZG9GjipWqytpJCo0Vhwxoj2CTrlxAX+5oDnZAcMnRDz8zlZ5oGn
         IuUNddvWpFqZz7tfteF31qVy5FKUUvXeHkIiefaDn9NfQ5pCfW9e+m7zuOXMAlBbak/P
         zzhwqt9rjInaPMuZJCst4dVdibez5ihOAlKQzREJgBIeO+zx1FoQOaLnU5HYKrL7gRbW
         IZkFmW5k2r3cMyfzVgb+HWFgJ/CGbGDHcOpy54f1CoBnxD2A5QqTNkK1hh7jRfAwj475
         LJww==
X-Gm-Message-State: APjAAAWUZG3YAiqDSwYFE6ahE17hDV4NvdEhRCjWGgTbawuyvi9nYQWo
        R8OQ1rAyaLbOrxi5lOPgRH7n4S2o96OlPMRnwBU=
X-Google-Smtp-Source: APXvYqwF/SOWtLPINQQydtAWkZSJNKSSpKWM0hI2xQ4FwE0p6pVh20jZ75QH3MIXJSAozheypWv3nc/75bbUfzGPTFg=
X-Received: by 2002:a1c:3c2:: with SMTP id 185mr8380580wmd.91.1558541506548;
 Wed, 22 May 2019 09:11:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
In-Reply-To: <CAPhKKr_uVTFAzne0QkZFUGfb8RxQdVFx41G9kXRY7sFN-=pZ6w@mail.gmail.com>
From:   Dhaval Giani <dhaval.giani@gmail.com>
Date:   Wed, 22 May 2019 18:11:34 +0200
Message-ID: <CAPhKKr9nm+JoLUu5g4ruop0589R0Mwbd+gqgG3T+WccjtUjw+g@mail.gmail.com>
Subject: Re: Linux Testing Microconference at LPC
To:     Sasha Levin <alexander.levin@microsoft.com>,
        shuah <shuah@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
        Tim Bird <tbird20d@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, douglas.raillard@arm.com,
        ionela.voinescu@arm.com
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Carpenter,Dan" <dan.carpenter@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        gustavo padovan <gustavo.padovan@collabora.co.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        knut omang <knut.omang@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Please let us know what topics you believe should be a part of the
> micro conference this year.

At OSPM right now, Douglas and Ionela were talking about their
scheduler behavioral testing framework using LISA and rt-app. This is
an interesting topic, and I think has a lot of scope for making
scheduler testing/behaviour more predictable as well as
analyze/validate scheduler behavior. I am hoping they are able to make
it to LPC this year.

Dhaval
