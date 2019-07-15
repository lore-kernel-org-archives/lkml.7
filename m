Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAA4C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA73620868
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 11:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVAJvThD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729943AbfGOLCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 07:02:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38354 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729922AbfGOLCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 07:02:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id g17so16597034wrr.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2019 04:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hukSDBvejCeRA/4yqIF2pUsY8MeiMorK9iH41/yECWE=;
        b=WVAJvThDlrUR1PjmbcoQBsJgIoTLsiFGlMMJBhFmzAqQ4fz7gq23nw8IsmAL4OLRvB
         rGZ33j+7jr/gAXiShpPdenl2kOWKzf4bkQVOYcvLLsaRD5+kONM6zp4VekvriKYw4mh0
         GJYv9/nOo4Nf5LyGib1GZQRqbpMfjwJLdBPG6oLSU1pJkNAgnt+6PvGpm9oj21LUUM3x
         z3SvHGe4lccKkwNUuioSOITAFgwRG4un6LY04ufhxs/0muhucWhucj3ojNMEVpCxH3lY
         8pQmmjbmAABsnw4BFSSf7uS83iy0IF71yahblNeP3ZGpnpduf4zjrGmv1KUyAkkFyCQj
         Uu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hukSDBvejCeRA/4yqIF2pUsY8MeiMorK9iH41/yECWE=;
        b=TrygItSags4dkUBvO67mQlxgujN0PdSBHbzfsAvS7NkDbju24DyFKnBq2LbyGwDMj8
         JQbfAJYJFAj3xhILQACa3vQwJBGWNo5bWyGDthlh1He+m2grWfnJ0ryQzdl6qGGIveWL
         Dq+wyHKlrfET7jYvjcUXu8C8uF8osW44RdPHfT0PcuMF+pjK9/Rhan5GethHYydJb9Ld
         xxma/YqantS36Z0+oSN0ZufheKqY2EsNgdr07UTCJndN6L3k/36T7AKFoF4IdrLGMnOC
         ltBt/m9ykeRj0CxTx/f+EH0pgLQhSrB9cZtHN681Sa0t3ni2iZt0KNO6tDZJCkh0+qZu
         mpXA==
X-Gm-Message-State: APjAAAVWU0LEEOZO2IT3mKh4iMt6OwDEW3XpQ4VCSV8l73IXoC7EvtOd
        rcWWeEMja0IkUS5o+FI2K6s=
X-Google-Smtp-Source: APXvYqyDpmRiJ4rUoNj4baDQxpZ5k4SeUDsKZbZ5q6B2B2SNT0sa1BsSAQXMsvyv0I1v3koYaRYD6Q==
X-Received: by 2002:a5d:52c5:: with SMTP id r5mr9964536wrv.146.1563188550205;
        Mon, 15 Jul 2019 04:02:30 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id y18sm16255024wmi.23.2019.07.15.04.02.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 15 Jul 2019 04:02:29 -0700 (PDT)
Date:   Mon, 15 Jul 2019 12:02:28 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, corbet@lwn.net, airlied@linux.ie,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rfontana@redhat.com,
        gregkh@linuxfoundation.org, joe@perches.com,
        linux-spdx@archiver.kernel.org, tglx@linutronix.de, sean@poorly.run
Subject: Re: [PATCH v3] gpu/drm_memory: fix a few warnings
Message-ID: <20190715110228.GD20839@arch-x1c3>
References: <1562685190-1353-1-git-send-email-cai@lca.pw>
 <1562960735.8510.30.camel@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562960735.8510.30.camel@lca.pw>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On 2019/07/12, Qian Cai wrote:
> Maybe one of the non-DRM maintainers (Andrew, Thomas or Greg) who cares a bit
> about SPDX can pick this up. It occurs to me none of DRM maintainers cares about
> this as there is no feedback from any of them for months since v1.
> 
AFAICT there are a couple of reasons why this has gone unnoticed:
 - summary is the pretty ambiguous
 - commit does two thigs

Another thing to consider is that this patch touches a single file,
while the exact same issue is also present in many other files.

Quick look at the following lists:
head -n2 drivers/gpu/drm/drm_*[ch]  | less

drm_agpsupport.c
drm_dma.c
drm_legacy_misc.c
drm_lock.c
drm_memory.c
drm_scatter.c
drm_vm.c

If you can fixup the s|/**|/*| in the above, I'd gladly merge the patch.

On the topic of SPDX - no objection on my end, but it should be a
separate patch, which replaces the explicit verbose license text with
the tag.

Thanks
Emil
