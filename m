Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B9A9C432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3D2082E
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 06:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itp6mkD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfK3GD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 01:03:59 -0500
Received: from mail-pl1-f170.google.com ([209.85.214.170]:36296 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbfK3GD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 01:03:58 -0500
Received: by mail-pl1-f170.google.com with SMTP id k20so1355207pls.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2019 22:03:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ec0nFTYvaYnyk/8sDq3u071ZfoJJIOH3vX8mQ8EjYTU=;
        b=itp6mkD1SRHUUM3dzkGUrTGZzeeghUrRVdwLIS+sv8ByFdjtSolJb+2ptNl3ZpxOaa
         qQ9F5atiSWznAvMIl3Hw3JceCA1xSO1eu6s403schCBBQ0CT5cNxiDdUmnQDgTFGWUVs
         M578TrlCLWiNC5vIDgGZ/1cG6hw02MAiNfAufnYJIO556KE5x4xNLf14iyBNqlB5wNF7
         PgGRDhnPLaWul1v9YnWxVL7RuflGc3f1raBaQZjRScfzFGB5GnlbFjJYLNpf2ZrNdx2l
         +2fJgWEXIjPDkLB151Y3BMALbCdyeqfadyCZXQ/UdJe8ShKGjCdOyyucDqwtFFkIgx2C
         fx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ec0nFTYvaYnyk/8sDq3u071ZfoJJIOH3vX8mQ8EjYTU=;
        b=RgovCVtZoLMrJ1C1LuVSTJftsmSUuVkNs+WxYiMy1NmPWV8l1bBsGWbvlpGGiOUj6H
         cH4RAnE7b/tZ1Qc+mKFXJg+zjjAZ0+Q0756QHNVOyYHzbTWTmUHQ4p/m0LeesPw8Il/C
         OJ4dDKvCnZffwbt0n2fVgY9yLpetdNbF2p1LEuGY3A9+ySeGdE1V9wtw88gktikMwIbW
         Altz1cgdF0K8dZwMRFGs84SYCVTdVqc+80AC++h+/as5+C560M7p0R8GaTn2sM0dFPdH
         iIfXs1ZoZsVFJBRfWhTwSt/LG5oN7BBouDDCj2RptpzOopXw7gk1zvRIFni8ChBjPMnW
         I34A==
X-Gm-Message-State: APjAAAWSQMCU7wP2v560X87/Gn6QFWtI7uGw7EZ2npyszC+w7/0D7LGM
        1vkpTG4rSum9jEgWGSBEOe1Pb6pDVmpR/HwqEFI=
X-Google-Smtp-Source: APXvYqx2nNvpp3u1ft6zY2DBl10NREssYrBkm84da2QSyHGCXrj7U45ZHl6Wj4R2eUiIL9Vykmwj2WerfPtLQkzMYao=
X-Received: by 2002:a17:902:9a03:: with SMTP id v3mr17750785plp.61.1575093836764;
 Fri, 29 Nov 2019 22:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20191129004855.18506-1-xiyou.wangcong@gmail.com>
 <20191129004855.18506-4-xiyou.wangcong@gmail.com> <dea0de02-cedc-7817-5b04-3888e0e86812@huawei.com>
In-Reply-To: <dea0de02-cedc-7817-5b04-3888e0e86812@huawei.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Fri, 29 Nov 2019 22:03:45 -0800
Message-ID: <CAM_iQpXznBnh+bVMu4Ad-doPfr7en9CnWiG8C8mEXmYu6yTgxg@mail.gmail.com>
Subject: Re: [Patch v2 3/3] iommu: avoid taking iova_rbtree_lock twice
To:     John Garry <john.garry@huawei.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2019 at 5:34 AM John Garry <john.garry@huawei.com> wrote:
>
> On 29/11/2019 00:48, Cong Wang wrote:
> > Both find_iova() and __free_iova() take iova_rbtree_lock,
> > there is no reason to take and release it twice inside
> > free_iova().
> >
> > Fold them into the critical section by calling the unlock
> > versions instead.
>
> Since generally the iova would be non-NULL, this seems a reasonable
> change (which could be mentioned in the commit log)

I think it is too obvious to mention it. There are many things we can
mention but we should only mention what's necessary, right?

Thanks.
