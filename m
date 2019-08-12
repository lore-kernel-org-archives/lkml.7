Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF635C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A62DA20874
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 00:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IKqPzlkB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbfHLAji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 20:39:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43524 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLAjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 20:39:37 -0400
Received: by mail-ua1-f65.google.com with SMTP id o2so39694913uae.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2019 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6K0DvhL9RJkMUKWGy9bBRNsMSDRRIMczdHWxj2ZlOLY=;
        b=IKqPzlkBpTxY+A47jneyPgFuefY8XtvBtZMXnqH7VkTU2q0nJcG3iIRUuKxPVzsVSJ
         qaquyNCY/6XJ7D82HonO4EBmwolNEFZ0EKXfqOGLmnfrGtGIpfHMNqIlMKefsCRAFSqZ
         JoExbp3p4N4WfyaHmR6RVo8ExwftKr4w/E5HNtfOeBbT3xa+aoWI8ruwrdtCuWimPd7I
         V3y+2iKeKtWpb4vFKx67OmWGvsA4thlgxbOSxsJnlK/b/PEdRHBI7Ylo+rUgOPHJMOjh
         BmhzmtoZeu51qfUhDBUGVzA8g+COBbey3b1/Z7KDSww6AYJInUYcnDhyf5zz4TAnOhqH
         Un5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6K0DvhL9RJkMUKWGy9bBRNsMSDRRIMczdHWxj2ZlOLY=;
        b=HtBCKmbjdLWNkW2jLt8Osea39p+fu4nUe481PY3jBByms6SB5G4jMgoe8eyOBt9EHB
         M8oE0HPgieCy2QPZLZZD5BMW333UG6JVD9VJ3zWNplTwEq0VEeuCo05Syu/EMsI/sO6T
         8yK8SbvbfY8npIq3tkUTlTyKTnuRLtqxj9yAIcUwxtRTn8Thnb1IVOo2ykQRCZJPqi3b
         uCqAiUK6+KX2hcm5yGCL/e4gdyyJ2XKqkowW0suVfepAfEt3FeacO1HZRKIfV/15AFu3
         dE1K2IsVJ8eq2J1dWE85xbQiUqXWOtFQ9AEklIWvB9hbvHYwjXElVsOM7T75yTZX/qdI
         K43Q==
X-Gm-Message-State: APjAAAW2FoTMWNegay2LctcNGBFQ6buGUTldqFAsiT372QzZbgEBH0Ss
        Gf204vCYr0IXZo/s+uApPrepviKLWacUOa3cwVQEsg==
X-Google-Smtp-Source: APXvYqxvKmRyM1n6aAxPB7BHyG0ztTWG0OjK+dcEQcs9gVLd7ek1DWS6G6ppS8xScBCLvhhXvUQFgbNQHh9Vv1eg9D0=
X-Received: by 2002:ab0:7618:: with SMTP id o24mr18290583uap.39.1565570376227;
 Sun, 11 Aug 2019 17:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190811184613.20463-1-urezki@gmail.com> <20190811184613.20463-3-urezki@gmail.com>
In-Reply-To: <20190811184613.20463-3-urezki@gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Sun, 11 Aug 2019 17:39:23 -0700
Message-ID: <CANN689Hh-Pr-3r9HD7w=FcNGfj_E7-9HVsHu3J9gZts_DYug8A@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/vmalloc: use generated callback to populate subtree_max_size
To:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Roman Gushchin <guro@fb.com>, Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 11, 2019 at 11:46 AM Uladzislau Rezki (Sony)
<urezki@gmail.com> wrote:
> RB_DECLARE_CALLBACKS_MAX defines its own callback to update the
> augmented subtree information after a node is modified. It makes
> sense to use it instead of our own propagate implementation.
>
> Apart of that, in case of using generated callback we can eliminate
> compute_subtree_max_size() function and get rid of duplication.
>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

Reviewed-by: Michel Lespinasse <walken@google.com>

Love it. Thanks a lot for the cleanup!
