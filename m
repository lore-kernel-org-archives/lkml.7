Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EDEC28CC5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257672075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 18:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PlkGjGUX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbfFES0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 14:26:16 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51813 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfFES0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 14:26:16 -0400
Received: by mail-it1-f195.google.com with SMTP id m3so5049269itl.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 11:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuKsTBPsIQTq7kaBkBZ4doP5Ts93RaiB5cwtxxnYeKo=;
        b=PlkGjGUXwzj17TBdlmfkM3QAvf/E4BNtOY6z86bVQd4magMo+EcHQNSjIFIMHSv9ep
         Hvn0TJUbPu1jT6y+TjRG17nCAMo2zeTFBjnwLXvyDDHdIs/phhSJ5FGcELiuZ3qi4qb4
         8r2u0QNafuNOyyE9n3i5EJIFPbKUN09gquhoJ1Jq5l847nWhl3wXZXG+e0tX2A09B2Ea
         t4L1U4es8Xu93CiBgt7golQhzRx1HiABCzolmi+9lkEYx/cOhkMz8PX2Q17JQViNF8KR
         kPmbzLqAvRGc8MlXh9si9eN7nJ94ifGV8+0AQezoJE43EQfRV4SMR1Ea1rT4lxoRcBoK
         um3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuKsTBPsIQTq7kaBkBZ4doP5Ts93RaiB5cwtxxnYeKo=;
        b=cmSHuyF4EdzVGjTjkjnhtW+V9wgFsrnqq9ISPF6bOW2jsqfly5f8Sd7oEBWfEDxEwZ
         yM9rVofrtfDjGLfAYcLEP9H+fFhqSP03szHQAiSgd0ecHljKw4eEacGDDaD6brzF9Cig
         Ebt5KQvzjtBDsuIDxn+Zen6avyWf+iY3QaaE4YjjS3NslIaN6nrgo9fYXj6D8+J9P9rG
         8Awsa//kjxzZH3mBvbYojdPJ3zrXqbY4aeyYbbPX/wGZKHvUU5JiWq5/nL7RXQ85eOdx
         cbwPJGfAXzYlvk4r/yU9SuccdV+PXmNCwI0T5IRj3iJTmeDbIJ+YAgQIefcnIH9+MJqL
         Z6YQ==
X-Gm-Message-State: APjAAAWNHq85yao4evI5clNxbc72EeMo1TaIkSv2oRQuchzp8gQIrmET
        Z77iqbG7XiBEy3BLU1mlzSQNRC0tpZmujz3jVcJD4YmGo54=
X-Google-Smtp-Source: APXvYqzg2Q8FD5mu9akBujndKp639v+Wwjk+fWqAAHLrXjNUx9Ab4kGUMVzGf0NiOxZjZs7NT3ykGTBqnEr/028Fy/w=
X-Received: by 2002:a24:bd4:: with SMTP id 203mr26657993itd.119.1559759174805;
 Wed, 05 Jun 2019 11:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <CACdnJuup-y1xAO93wr+nr6ARacxJ9YXgaceQK9TLktE7shab1w@mail.gmail.com>
 <20190429193631.119828-1-matthewgarrett@google.com>
In-Reply-To: <20190429193631.119828-1-matthewgarrett@google.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Wed, 5 Jun 2019 11:26:03 -0700
Message-ID: <CACdnJuvJcJ4Rkp7gBTwZ_r_9wKtu34Yko+E3yo07cwc53QrGGA@mail.gmail.com>
Subject: Re: [PATCH V4] mm: Allow userland to request that the kernel clear
 memory on release
To:     Linux-MM <linux-mm@kvack.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 12:36 PM Matthew Garrett
<matthewgarrett@google.com> wrote:

(snip)

Any further feedback on this? Does it seem conceptually useful?
