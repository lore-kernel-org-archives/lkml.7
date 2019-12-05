Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0A3C2D0BF
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8C02466E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 23:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="QMwk2s8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfLEXRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 18:17:02 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37945 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbfLEXRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 18:17:01 -0500
Received: by mail-qt1-f193.google.com with SMTP id 14so5265515qtf.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 15:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=I3RTGY6vLoKZQaf8k+i6VV46bgDUyZoMR04eSUnqJf0=;
        b=QMwk2s8tLZKS8OI9lKFCtGA1Z1mb6Ixu7TaH2nsww7Lj0gh8lINdDdlSzcHZAWEInW
         2KHOV9F3S5b+/8KO7htuWlGq2589aUsBKHXl+siySmyqT43otw5mtaebqS6RQJEswuOf
         Wm1v7ZdD2ynX24lCpTt8zvdihVdqodAt4imdnB05SO6kdz/mBmuM/irBoFLMm5OE6Dlb
         4SGQ7uk+nb6R94v4xN5l8oRC3qNAM/ObPCn8OdDcl46UZzLR5I4wU13HBhi6tNR53+AR
         iFu1Riilb1NS0ajglxhMpYgNlbPnGdPUuMUoUmSN4qdWVO+hK9ADEWS253c1N3QDWMmb
         JuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=I3RTGY6vLoKZQaf8k+i6VV46bgDUyZoMR04eSUnqJf0=;
        b=iSJwRV3WtbsQzbdx5Whf8g0jPVU0etgf0jGspjV9Sh20PiNTjK/ZwWGzbhzCKtYvi+
         IY8DTidSKQP0Nchc00+/Sk5AxHQRmL9oCQ4qfJxihCdunbSopksRIjRIjpuDvJi5VQbm
         iR1UdGhfxJ0hMe6AjKRMXl4YovQH5ika/AEJ5w0i7mUrGyn6jf7DFofRl3OWU2ZBHRvA
         xII3fUffa+ShPxD8s2JaZJAXSKlBA8hdVgw9tWuAPjub96qZaxvMmdaCH2ZBNrepxZ4v
         lf2+HtcbgyUHrAx5jqO7vgqEewFD6I5Hh9TIkD9Nbk83Piozi+HBXBgQL2Y4GhfIMegs
         GHNQ==
X-Gm-Message-State: APjAAAUtWqyQT7twphUgMjRB3zpLnHP9pRTYy4jEYs8iSqIcI6G20vTw
        /UUMbG9uza4fLxPIqgZFmbb1SA==
X-Google-Smtp-Source: APXvYqzMNgSvzkY3NFpm0uElw07fgY3Oc+zNdS7EukDtvaMDWAC/GHg5qCYP6d3VQTnEZEFY8DGvDQ==
X-Received: by 2002:ac8:1410:: with SMTP id k16mr9890823qtj.27.1575587820355;
        Thu, 05 Dec 2019 15:17:00 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j12sm5343442qkk.36.2019.12.05.15.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2019 15:16:59 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [v3 PATCH] mm: move_pages: return valid node id in status if the page is already on the target node
Date:   Thu, 5 Dec 2019 18:16:58 -0500
Message-Id: <4C589824-CA40-41A3-8F2B-C2AA2A924510@lca.pw>
References: <bd3f2ee5-9cbd-ed4f-9863-8859866da810@nvidia.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>, fabecassis@nvidia.com,
        mhocko@suse.com, cl@linux.com, vbabka@suse.cz,
        mgorman@techsingularity.net, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
In-Reply-To: <bd3f2ee5-9cbd-ed4f-9863-8859866da810@nvidia.com>
To:     John Hubbard <jhubbard@nvidia.com>
X-Mailer: iPhone Mail (17B111)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 5, 2019, at 5:41 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>=20
> Please recall how this started: it was due to a report from a real end use=
r, who was=20
> seeing a real problem. After a few emails, it was clear that there's not a=
 good
> work around available for cases like this:
>=20
> * User space calls move_pages(), gets 0 (success) returned, and based on t=
hat,
> proceeds to iterate through the status array.
>=20
> * The status array remains untouched by the move_pages() call, so confusio=
n and
> wrong behavior ensues.
>=20
> After some further discussion, we decided that the current behavior really=
 is=20
> incorrect, and that it needs fixing in the kernel. Which this patch does.

Well, that test code itself  does not really tell any real world use case.  A=
lso, thanks to the discussion, it brought to me it is more obvious and criti=
cal  that the return code is wrong according to the spec. Then, if that part=
 is taking care of, it would kill two-bird with one stone because there is n=
o need to return status array anymore. Make sense?=
