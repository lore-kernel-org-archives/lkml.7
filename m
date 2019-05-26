Return-Path: <SRS0=Y9JJ=T2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5A6C282E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2535820863
	for <linux-kernel@archiver.kernel.org>; Sun, 26 May 2019 19:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUCoCeqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbfEZTe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 May 2019 15:34:58 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:41844 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbfEZTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 May 2019 15:34:58 -0400
Received: by mail-oi1-f169.google.com with SMTP id y10so10493586oia.8
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2019 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=zz6oW0M34IrJmrCEu87CLaQUtguqorOfV3mnBJbhr78=;
        b=lUCoCeqp7QRrLpU8YyRo89Gm0FVHGn0/8ZrO2LMywOjNZRkSpsfPphN+hN/1gDGjuU
         nGyfFV546BSL3L4KR8lcE+Iv2PfHCYhxQWwzedPsi4B+jrFV+PxH1iR855395lcdJ9Bc
         lkJkxxjTGnKcDJwbl8Fvs1iiW5INBIbahypfIo8eLphV/m/3YAFRXbHsQZv+jJtkmCtp
         KFNYC9oKSVwif3kycSGtcfhPDpfjxRDSoDj31m/KY6FB6ZSb1s2vt3QAmM6hcbMHsWSh
         DI+YxjweklVmN20Rh45zJlAiKLVRGnq7FAM9IFGdS4m9nV03m66v0YdYmWXg30BVm/CK
         lU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=zz6oW0M34IrJmrCEu87CLaQUtguqorOfV3mnBJbhr78=;
        b=WtbWswP6BmtnWRhioAUw1kyukS25wq32Fef07e2yrRga4NgAmJ5WODzTb4fzJBnJMI
         NoQ9sbbF8TwRRdThLUxnjLnUGi6hvURthIC43d3/CZoITS37TiYshwjg47few92ThaxH
         1amgIHD+8utvJeBmAboJ/n0Ez1TjVLWyb3Jvtf6wIFXVFU3WMpdZ2J9Uk+sqJRtKLs0K
         7dxC5o/uFl2vipGySJUk5dYERLc/B3WFG2SQ+4eEV7zKB3jGfANWShZS8+hQO6uw3eF+
         kz4aST9GeWOtoqRHA2lRoNkKk9ExUcAqbuaZ3aHnG3o8xzlqDv25PHe1K2SEJqQXxjwB
         eO0Q==
X-Gm-Message-State: APjAAAW1btx0zUAQyygHB4ajqeNrlltEo/TLDDqN0AehFHK1P9A5Kba9
        1Rh9ZPD6FyMspRkRHZaujx+vSA==
X-Google-Smtp-Source: APXvYqwVP3Ws9a+oMaQNYN17Gkbi/3LZ0QAaW+uMG++o/zO7IyEv4aGTRx4EqzsRtcWp6vaTrZnHew==
X-Received: by 2002:aca:f089:: with SMTP id o131mr13449731oih.103.1558899297122;
        Sun, 26 May 2019 12:34:57 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id k99sm3311040otk.12.2019.05.26.12.34.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 May 2019 12:34:56 -0700 (PDT)
Date:   Sun, 26 May 2019 12:34:54 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Pavel Machek <pavel@ucw.cz>
cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>, hughd@google.com,
        linux-leds@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: leds: avoid flush_work in atomic context
In-Reply-To: <20190526173700.GD1282@xo-6d-61-c0.localdomain>
Message-ID: <alpine.LSU.2.11.1905261226040.2004@eggly.anvils>
References: <20190526073854.GA13681@amd> <5a741b3c-cf45-3577-9b6c-653f083ca96b@gmail.com> <20190526173700.GD1282@xo-6d-61-c0.localdomain>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 May 2019, Pavel Machek wrote:
> Hi!
> 
> > Thank you for the patch.
> > 
> > I've applied it however I'm not sure if it is an official
> > submission, since it doesn't look like (no [PATCH] tag
> > in the subject).
> 
> It was official submission :-).
> 
> > Beside that 'Fixes' tag is somewhat incomplete - it should be
> > generated using following git command:
> > 
> > git log -1 0db37915d912 --format='Fixes: %h ("%s")'
> > 
> > Fixed that and applied to the for-next branch and will push
> > it upstream after a bit of testing for rc3 or rc4.
> 
> Ok. Note that this did not crash Hugh's machine but it may crash
> someone else's, and probably crashed mine already.

Where "this" is commit 0db37915d912, I hope: right, it did not
actually crash my machine, but the splurge of warning messages
forced me to reboot quickly, and go look for the culprit.

Your fix certainly did not crash my machine either,
but I hope we don't expect your fix to crash someone else's!

> 
> So... it makes sense to push it to Linus "soon".

Agreed.

Hugh
