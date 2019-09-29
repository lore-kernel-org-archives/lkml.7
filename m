Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EBF2C4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A67E20863
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 20:51:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sT1wM/fR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbfI2Uo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 16:44:29 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33498 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbfI2Uo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 16:44:29 -0400
Received: by mail-wr1-f68.google.com with SMTP id b9so8818343wrs.0
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 13:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6g8BFOr4RuJJvpBnYUG0GgT2UdKjcagjVd8h5jd5/M8=;
        b=sT1wM/fRKKWD3kB4Q9J9gqeWWMDzMq0zn4ntcp14NIUbRd7lGCK9kjj5UJ4DWs3wpf
         +hwDeY0km2cJpIJrGpinS66lH9Qo8Uuk6prZQCSwdD43CkOB6A8d4qNZYemRBhZLgioe
         LvleJ/xBZqNq+IjDX4ONYA4Igu4fYaUbLX7H7sqmshqKXm3Egdc1rLKAw7IUhH0HXp3f
         wj0c+0R3TsCLOj5s4N7ODTPhuYvyqZjkPBNNFSiwNO452QXg3jE0Gn7/frOyABdTSgvn
         R5VjXrMiSmMq3k5mCgQiQ3k3Oy26zJf4q0BUpToKlERADsR54yt/FlfanolhUcQXtZ4Q
         KA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6g8BFOr4RuJJvpBnYUG0GgT2UdKjcagjVd8h5jd5/M8=;
        b=pZvwpW2mW6QdetU2MkJj3gx6riFciVyp4IzQSAANI6QGGPfjwiD6i85nGTu5SIZpwq
         qX5jQSk/f9QVGfLNUocvXSFptZXR3mlrK/5EFGzpYBAgSZarJNS0sD65Yhl3atSvvy6m
         biOj/k7whhanwULXnASDvYTyRXYaqSM/ZVn7nAc+5h4RcASrpKGnQn7n9uxHrfvZ/1hq
         wi8BI5kbjCmCDf21L6WYeqpkzmqTJhjeXJ+HDdMsLOXpFQ9sUYbK+/WTiXffdDVpsV/4
         fSqn+oyPsYnNLyrdccnoTqyZRFfLreq1KD3pt3Ajl0NXcsG3GjM1Z2YZwSKAJPB5xirF
         vZ7g==
X-Gm-Message-State: APjAAAXpHTgVCKJ4+0FCLHX+T1Dhnl/6QNnVKbaMofJejtuBwB5M2lQz
        Z5zif8gSBh13U6/18cXzuw==
X-Google-Smtp-Source: APXvYqyRd+2X5uvlwES43XuRYMjiMK3l6KgPqgWkoynAa288MY6y0tQsTSgyWOL5PQ2eUFgitLTnww==
X-Received: by 2002:adf:f092:: with SMTP id n18mr11134779wro.262.1569789867436;
        Sun, 29 Sep 2019 13:44:27 -0700 (PDT)
Received: from avx2 ([46.53.254.141])
        by smtp.gmail.com with ESMTPSA id y14sm21961780wrd.84.2019.09.29.13.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Sep 2019 13:44:26 -0700 (PDT)
Date:   Sun, 29 Sep 2019 23:44:24 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        mingo@redhat.com, linux@rasmusvillemoes.dk
Subject: Re: [PATCH] Make is_signed_type() simpler
Message-ID: <20190929204424.GA14565@avx2>
References: <20190929200619.GA12851@avx2>
 <20190929161531.727da348@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190929161531.727da348@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 29, 2019 at 04:15:31PM -0400, Steven Rostedt wrote:
> On Sun, 29 Sep 2019 23:06:19 +0300
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > * Simply compare -1 with 0,
> > * Drop unnecessary parenthesis sets
> > 
> > New macro leaves pointer as "unsigned type" but gives a warning,
> > which should be fine because asking whether a pointer is signed is
> > strange question.
> > 
> > I'm not sure what's going on in the i915 driver, it is shipping kernel
> > pointers to userspace.
> 
> This tells us what the patch does, not why.

Check the subject line.
