Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED0CC7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8F4206BA
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 10:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTQbVJUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbfG2KDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 06:03:11 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39490 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbfG2KDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 06:03:11 -0400
Received: by mail-lf1-f66.google.com with SMTP id v85so41595601lfa.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 03:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GCNBtqG+V+PhaXRLeq18oVL16L2/pzeyYQKg2znql7M=;
        b=TTQbVJULgW8GTZL+FoD7p2lrrNCSaURe3ru+D16c4KRDtywb+Ln+BCSRmPUg5XiWcV
         A+ftfr/1kpnUJL3lX/S4t3Dhkumv1q4WH192cLVRmZFNL8y9pOca7Ehth4LJLB2HT6UB
         3RMNinP3W74o4pz+XprrfdTbaOtqaIppBxD0BhVpijBUsOhMZj2tO853eWGGWWpFB4tf
         YTFn3wnMWR9acke+qPics1zPIRc9bs/s+MisuDVp6HPcwCajIeL1+ML1eVt52jRjpVW2
         smyQslo7o/N105VCRZJNG0cDaFf3O8zJiRaByaBC0DCPsHTcfEEyB2t0P+yWZng3n3V+
         SYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GCNBtqG+V+PhaXRLeq18oVL16L2/pzeyYQKg2znql7M=;
        b=Woh/kxDjtkfqWmtd54IiwRkjeyqI91EYbKlsM9p2qGCJIaXGCvloxhj+JvHBGGQGmE
         FwHBBZ/RjgZXgDl3SuJrCDtcA6khmTCeWE70sNdiTROVfnCIfvIZ6cak1lyez6V2fbFH
         3A6aGDToTEqppiQR8v9CNOojlUmoJGSGLNMEMDCNtvB+zwLvu3tbzWkpu2IwNInNmrfl
         fbP2c4wAXESdi+Q4BWmmeqoU2tVI0VQk+9W4rcJW0IGi0vx1SM1LuT8HWmZC12JT3C3O
         2lBxG3HXdYnydETrOW0d02k8glyCLmueDFNwA0S2cOdYSLPfAGM4IgklUPF46CGL/kds
         s3iw==
X-Gm-Message-State: APjAAAW0GatCIIqjOYgeStH8QOA0eE8LpapTcHhjGD8YfoGAns3IFIjw
        l7wU4ms8YACquUD6aqfyUHw=
X-Google-Smtp-Source: APXvYqxGSlDLsbl73FbT8TM8FM/dREiw1wpaXgoHrEjbBghGNZy+ASXsYnW7OV7qiCeJcS67Pt8CVQ==
X-Received: by 2002:ac2:528e:: with SMTP id q14mr6320025lfm.17.1564394589311;
        Mon, 29 Jul 2019 03:03:09 -0700 (PDT)
Received: from pc636 ([37.212.210.176])
        by smtp.gmail.com with ESMTPSA id h23sm12765821ljg.17.2019.07.29.03.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 03:03:08 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 29 Jul 2019 12:02:54 +0200
To:     Michel Lespinasse <walken@google.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        David Howells <dhowells@redhat.com>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] augmented rbtree: add new
 RB_DECLARE_CALLBACKS_MAX macro
Message-ID: <20190729100254.j4ez5cbalwbyphqb@pc636>
References: <20190703040156.56953-1-walken@google.com>
 <20190703040156.56953-3-walken@google.com>
 <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FXgK13wDYNh1zKxdipeTuALG4eKvKpsdZqKFJ-rvtGiQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Note for Uladzislau Rezki, I noticed that the new augmented rbtree
> code defines its own augment_tree_propagate_from function to update
> the augmented subtree information after a node is modified; it would
> probably be feasible to rely on the generated
> free_vmap_area_rb_augment_cb_propagate function instead. mm/mmap.c
> does something similar in vma_gap_update(), for a very similar use
> case.
> 
Just noticed this email due to vacation period, therefore it is a late
replay.

Yes i have my own "populate" function and i knew about generated one
because it is used during rotate operations. I a agree it makes sense
to go with generated one to reduce the code size and get rid of
duplication. I think we can rely on generated one otherwise it would
not work at all. But i will double check.


--
Vlad Rezki

