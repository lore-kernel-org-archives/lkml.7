Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B2CC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990532064A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCZtbd8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391689AbfDRSX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:23:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:41735 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390479AbfDRSXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:23:24 -0400
Received: by mail-lf1-f67.google.com with SMTP id t30so2328247lfd.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2019 11:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vC2agpd/yeTIjkC+tv6Q0HWjOpOqDC0mbvCHm0eBf4Y=;
        b=oCZtbd8wbvAsIKhSYoUJZQVeVFzI9LhVk5xw5A9aYv70oTCxPDa6CUjfhq+7Ko97Yw
         5EBuW7fdsXGgA4duhAS6WpIwtYcQqgAk9n2TFWUG9A7Guuq6Wjh96ylkUMKabdIy43a6
         8DlL8MSTSorKUkzsLvIHVbj17K+BG/zixxqBZhZOCrrzOYOTMKXRFKWY3xzHa5FX0FnE
         N6PJsM8S5vsd0FFiKD5cO1kUvacWe5/8AigkrFKVHcH1e2gmueli4YEM7P5c4pgH8ojH
         IXmHDGo8zSl1fe/FBh+n8Fy+4L+B3KeT+Qf9JY48R+SfJhpOvzSGNTMAIWBWK6bhaoHX
         t7lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vC2agpd/yeTIjkC+tv6Q0HWjOpOqDC0mbvCHm0eBf4Y=;
        b=VgH6eNXtgng+J9tSr3StlyQdvN+gqTpdO+/SwT/ceiQTcZpBWN460dBXeMfR+BII0t
         kfMw2LC0FcomSzG1BfeKFZ5on7DS+3UHfznMHDttBlRhdXr1L3hDGi7OwqW5C7uYljOB
         hUExL7cS6jZZUZoZQwLs3NCS9ccZFgWKkKyZ2QJMb+nhgze3JyHzZGgmGo3t3iEKX7ru
         oepYEtpYUPOHwU3/juMtM8e53zhlXny4HmKofFmmBomQYW5iAMTmfEFmH6hJloKJH4ka
         DezBadSQhKQpL37AsxpPrZH8Ard0Pdb1urxAR27xaZJ6pnaceaq+k6bRJejglFjmV40k
         mQhQ==
X-Gm-Message-State: APjAAAXpI30dMc8EGMN/OZei4Lo8pJX02XxdrT7ZClliZyCIZPddnYzk
        WrrMcBgdsB9FhwlW3iGiuh0=
X-Google-Smtp-Source: APXvYqyBjDf0Lb5iqi1H4sy3SWYyTORWzsqfNAlBTaJ1dtcbk6DdNBZyJ36/uSTPPp/2Mrwa4eR7NA==
X-Received: by 2002:a19:c51a:: with SMTP id w26mr50367270lfe.59.1555611802703;
        Thu, 18 Apr 2019 11:23:22 -0700 (PDT)
Received: from uranus.localdomain ([5.18.103.226])
        by smtp.gmail.com with ESMTPSA id n28sm90162lfi.79.2019.04.18.11.23.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Apr 2019 11:23:22 -0700 (PDT)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id B8D49460E21; Thu, 18 Apr 2019 21:23:21 +0300 (MSK)
Date:   Thu, 18 Apr 2019 21:23:21 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     mhocko@kernel.org, akpm@linux-foundation.org,
        arunks@codeaurora.org, brgl@bgdev.pl, geert+renesas@glider.be,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        mguzik@redhat.com, rppt@linux.ibm.com, vbabka@suse.cz,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: Re: [PATCH] prctl_set_mm: downgrade mmap_sem to read lock
Message-ID: <20190418182321.GJ3040@uranus.lan>
References: <20190417145548.GN5878@dhcp22.suse.cz>
 <20190418135039.19987-1-mkoutny@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418135039.19987-1-mkoutny@suse.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 03:50:39PM +0200, Michal Koutný wrote:
> I learnt, it's, alas, too late to drop the non PRCTL_SET_MM_MAP calls
> [1], so at least downgrade the write acquisition of mmap_sem as in the
> patch below (that should be stacked on the previous one or squashed).
> 
> Cyrill, you mentioned lock changes in [1] but the link seems empty. Is
> it supposed to be [2]? That could be an alternative to this patch after
> some refreshments and clarifications.
> 
> 
> [1] https://lore.kernel.org/lkml/20190417165632.GC3040@uranus.lan/
> [2] https://lore.kernel.org/lkml/20180507075606.870903028@gmail.com/
> 
> ========
> 
> Since commit 88aa7cc688d4 ("mm: introduce arg_lock to protect
> arg_start|end and env_start|end in mm_struct") we use arg_lock for
> boundaries modifications. Synchronize prctl_set_mm with this lock and
> keep mmap_sem for reading only (analogous to what we already do in
> prctl_set_mm_map).
> 
> Also, save few cycles by looking up VMA only after performing basic
> arguments validation.
> 
> Signed-off-by: Michal Koutný <mkoutny@suse.com>
Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

As Laurent mentioned we might move vma lookup before the spinlock,
but this might be done on top of the series.
