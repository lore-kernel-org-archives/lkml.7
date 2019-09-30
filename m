Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ADC32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C286A2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 16:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0ePlnh0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732315AbfI3Qa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 12:30:57 -0400
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39026 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730780AbfI3Qa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 12:30:56 -0400
Received: by mail-ed1-f46.google.com with SMTP id a15so9225492edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l1JjNjL9Q+ctmsJLByX8pbSl0e96/VvXq5ETaN5KZX4=;
        b=l0ePlnh0nXV0M7vdeJq8lclvP/rG2eoKftDBcNNYLrdwoHnYRTpcXGccFWnWhBOtIt
         BWTyNht33vqNS29P0dyutN9kvX1rRmV2rr4BH64xsAd6KsnIf79BYp4O5UcIbqOs+Zis
         jC/+IAtFC78SPzFQ8P/DoRZ/FvxOIf7zDUMCUcNDTZlp6TxQNh2onS6464WzbeNhN8Eq
         NqKBYTTfpgGyE/swxkEM46kSynmZgX9izjnM1IRTAhNzrRiiI6b6O3YZzf4vJGmpOc+i
         f3XTbHsQWAz7RBe7YUo/1LKvM7uI0cZSS6AuN3aDR8GCJkFuUlCQR886PiISDE+LmP+w
         P1UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l1JjNjL9Q+ctmsJLByX8pbSl0e96/VvXq5ETaN5KZX4=;
        b=k8AcY0prMMPnk/rf7g9CGA5ZtCdoZLDkmg132W3EZCGwezRjjOP5Rcc5xpEN3kf5d+
         ozoZEQ8s7rMhIZpnmubAr7LcNNHmIc4w4Bup8Qt0tGErQzYT5pjqKzb6Ftr5n1itKHFP
         oKRj1Nf2nBux7gnXhjuE6v4/DQjJ7ZGL0Fu6sH6/i9VIs8GwTanQCjkQ+eAuHgP+/iL7
         Soo0xXNrJE2NQc+HAJzVGtip8ji9bK9d0H2VVr6kMyDUS5I7EDOfjujAyK5JVow80Cgj
         r42rPKTvg4IP7jjMA3QViNiHal8GCAQN8Jgt+eMZIAIf2oX7O1ef7Xa+PRv0mNbIso9H
         0YLw==
X-Gm-Message-State: APjAAAUDtmGt294Zaxg4R6gKkPi5C5ot0K03Layj2iTHEwuu6pVja23y
        vxDvtr6ZPU6y4fCQKPPyHzc=
X-Google-Smtp-Source: APXvYqybSXA7T+gpi+MTMOnIybYL2T+wb8VcdrgB2FxBWfu5eA1iF+Ql0c2tn5gYjDBhBtlCv84WVQ==
X-Received: by 2002:a05:6402:794:: with SMTP id d20mr20597492edy.20.1569861054716;
        Mon, 30 Sep 2019 09:30:54 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:4080:1900:7167:7859:9bcf:1ec4])
        by smtp.gmail.com with ESMTPSA id h7sm2529227edn.73.2019.09.30.09.30.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Sep 2019 09:30:53 -0700 (PDT)
Date:   Mon, 30 Sep 2019 18:30:52 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Steve French <smfrench@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: checkpatch warnings in sched.h
Message-ID: <20190930163051.x5q3schjsitmnc4j@ltop.local>
References: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mu1+muust_HA8oOWjYSmH6cLZA-d7pRzGJJsHauoDdJdQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2019 at 02:34:46AM -0500, Steve French wrote:
> Any hints to get rid of the noisy warnings in sched.h that make it
> hard to spot real warnings:
> 
> /include/linux/sched.h:609:43: error: bad integer constant expression
> /include/linux/sched.h:609:73: error: invalid named zero-width bitfield `value'
> 
> I noticed mention of this on lkml but didn't see any suggested
> solution to this distracting warning

Hi,

This is now fixed in sparse's upstream.

Best regards,
-- Luc
