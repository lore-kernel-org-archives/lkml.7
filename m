Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E061C3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E6C23431
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="RAfZLisj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfH3W2j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 18:28:39 -0400
Received: from mx4.ucr.edu ([138.23.248.66]:7952 "EHLO mx4.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbfH3W2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 18:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1567204118; x=1598740118;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=wgVygESRDZ4+rg/c5sOJBi+QyyM3UkHfyRMFo8KoCxI=;
  b=RAfZLisjzOUh7Cl2P/SoSGgX729miO4NgJDkxPlcrmKnLEB4pyzRIEpq
   TSS8UBMdPt5f0tdcgMIZL43olTbxqhVforFl8AP0PRPPXEUXOPrg9qHsr
   LOpL6rNwONiYay1Zcj0Xq5bqXGtRpgDlYuSzmSZV0xKbgTWMgr1jIIZmc
   Wx1DLhRRO95ohg1Sw107MTb5oa54StQnCEmt19R5rDKkj0/rUCWeB/alG
   Xx+MWfZHF1FIYWIvZ/0S1SxTsQUJZkIKxBjz5NC29fhuti/EDu+xXwpsA
   G23aLjQZkmBmFffB1eHpyQyemk4ggSBEk0EWYKSa/oVKVEkPV8RoYHD9H
   A==;
IronPort-SDR: kr0Q9TL0/kFdncT9926ysFvpQAaMqrp2mUz2jFwkWhZ64JBHoNi9WdmR0AIRfFseROYXFwTv8G
 CXW8JpfyleoIQmG0eRz6Pl9dr6+L1vBgAW8MsW0biZepJVxB3XZm+cPYi+3ivks2sW5yAdZ/v0
 1ZdXwA60Ru5FSRfLBFN37IfJOZ8IFRiMpAc/3lqmGVG2ZR8bmypbv/zBUU3pfI3eoaVduxPhhh
 ECLcgrQsFnterhoGvfL+rvqTrdKE1kZH5CddHclWbNHbOwfpZZsgdllVtrW6gVdyngKcH7Auxo
 e5Y=
IronPort-PHdr: =?us-ascii?q?9a23=3AXoLW3B9YxSDOgv9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B41OwcTK2v8tzYMVDF4r011RmVBN+dsqwZwLOP+4nbGkU4qa6bt34DdJEeHz?=
 =?us-ascii?q?Qksu4x2zIaPcieFEfgJ+TrZSFpVO5LVVti4m3peRMNQJW2aFLduGC94iAPER?=
 =?us-ascii?q?vjKwV1Ov71GonPhMiryuy+4ZLebxhWiDanfL9/LRW7oQrMusULnIBvNrs/xh?=
 =?us-ascii?q?zVr3VSZu9Y33loJVWdnxb94se/4ptu+DlOtvwi6sBNT7z0c7w3QrJEAjsmNX?=
 =?us-ascii?q?s15NDwuhnYUQSP/HocXX4InRdOHgPI8Qv1Xpb1siv9q+p9xCyXNtD4QLwoRT?=
 =?us-ascii?q?iv6bpgRQT2gykbKTE27GDXitRxjK1FphKhuwd/yJPQbI2MKfZyYr/RcdYcSG?=
 =?us-ascii?q?FcXMheSjZBD5uzYIsBDeUPPehWoYrgqVUQsRSzHhWsCP/1xzNUmnP6wa833u?=
 =?us-ascii?q?I8Gg/GxgwgGNcOvWzWo9X0NaYSUf21zK7VxjrAb/NZwzb945XPfxEhoPCMXa?=
 =?us-ascii?q?h/ccvNxUUzGQ7IlUiQppD/Pz+PyOsCrnWb4vNmWOmyiGAnsxl8riazysookI?=
 =?us-ascii?q?XEhYIYxkrZ+Sh4wos5P9+1RFJ9bNW5CpVfrTuaOJFzQs46RmFovzs1xaMetJ?=
 =?us-ascii?q?6geSgK1IwnxxnCa/yba4SI4gzsVOKWITpggXJqYrO/hxKr/UikxO3wS9C40F?=
 =?us-ascii?q?hIoyZZiNXMuXcN1xvc6siDVPRx5Fuu2TGK1wzL6+FEJ147lbbDJpI/3rI9ko?=
 =?us-ascii?q?AfvEfDEyPshUn7ja2bel8m9+S08+jnZ6/ppp6YN496kAH+NaEul9S/AOU5Mg?=
 =?us-ascii?q?gBRWmb9fig2LDt5kD5XalFjucsnqbHrZ/aONwXprSlDA9NzoYj9xG/Ai+i0N?=
 =?us-ascii?q?QZm3kHMV1EdAuEj4f3IVHOJu73DfOkjlSynzdk2erGMqfiAprTNHjDlqnufb?=
 =?us-ascii?q?Jn505b0gozwoMX25UBJrgfIf67f071sNHCRks1OhK5xs7rActw04cZV37JBK?=
 =?us-ascii?q?KFZvD8q1iNs9MuMemRY8cnuD/8Y6w09f7njCdhwncAdrPv0JcKPiPrVs96Kl?=
 =?us-ascii?q?mUNCK/yuwKFn0H609nFLTn?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2EPAACxomldf0anVdFmHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUwcBAQsBg1YzKoQhiByGb4IPk3aFJIF7AQgBAQEOLwEBhD8CgmEjNAk?=
 =?us-ascii?q?OAgMIAQEFAQEBAQEGBAEBAhABAQkLCwgnhUOCOikBgmcBAQEBAxIRVhALCwM?=
 =?us-ascii?q?GAQMCAh8HAgIiEgEFARwGEyKFCwWhY4EDPIskgTKIbgEIDIFJEnooAYt3ghe?=
 =?us-ascii?q?DbjU+h0+CWASBLgEBAY1AhxSWCQEGAoINFIwriCwbmGItpiIPIYEvghEzGiV?=
 =?us-ascii?q?/BmeBToJ6ji0iMI84AQE?=
X-IPAS-Result: =?us-ascii?q?A2EPAACxomldf0anVdFmHAEBAQQBAQcEAQGBUwcBAQsBg?=
 =?us-ascii?q?1YzKoQhiByGb4IPk3aFJIF7AQgBAQEOLwEBhD8CgmEjNAkOAgMIAQEFAQEBA?=
 =?us-ascii?q?QEGBAEBAhABAQkLCwgnhUOCOikBgmcBAQEBAxIRVhALCwMGAQMCAh8HAgIiE?=
 =?us-ascii?q?gEFARwGEyKFCwWhY4EDPIskgTKIbgEIDIFJEnooAYt3gheDbjU+h0+CWASBL?=
 =?us-ascii?q?gEBAY1AhxSWCQEGAoINFIwriCwbmGItpiIPIYEvghEzGiV/BmeBToJ6ji0iM?=
 =?us-ascii?q?I84AQE?=
X-IronPort-AV: E=Sophos;i="5.64,447,1559545200"; 
   d="scan'208";a="73993447"
Received: from mail-lf1-f70.google.com ([209.85.167.70])
  by smtpmx4.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2019 15:28:37 -0700
Received: by mail-lf1-f70.google.com with SMTP id b30so1860355lfq.6
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2019 15:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/OqUmnBUo2TwngZckoAVX/16b3P4Ti0vmh5QbNPt/qI=;
        b=Ha+/QoMDWGIzxLFFkhLjdMT/DcINnuktvBQdUPNVVQbcXHvmCYvTHvbYxuOsWhgUr3
         S3yEBO3+xEH/RR0SQ/fD2ea3/w4cJEhywr8i+xbx4WCGY6kZg3Lx/Hkj04Gc8gbRfLbF
         kW6uUWfucaTbfC9J42VZ2StV2ild/B44EadHZfMsMoAMge+AtMbuou/7XzhwTrC+/qU9
         ffQd5wLeozn9tZfbTOpglGTNXiPhVv3BtHq7+BNIc/7uAOBswW18NvkT5aRxZ7Zi7cO2
         OfClZ0Vskv1HxkMqSN738Kb6vWhRUHT4Y4EBr35+v6+ZL6r2eZiI6PdfOa5KCuMtVwss
         FfKg==
X-Gm-Message-State: APjAAAVNX38ooxkpM35AojGBX8b+aFO4cl6P1sTaoeuAF3DYgVXe5SDe
        kgg7XCpD0+g7RLr1ytvklIzzwcwRqBggoWI0NlsRfc9TtP0CSgex6Xbazpd7xFF+56cZ6Je8xUF
        zkrT56cpBr1SovecCV5XAne+0CjmVwxKi4UL7IHqwNw==
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr11134405lfp.15.1567204115690;
        Fri, 30 Aug 2019 15:28:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwa33Y9Bu9hA8LxhW9Vg/wJim85Pk0no7AsHr9XFg9pLsGspx5AJcu+yjlmeSKNUIJl9tL56jCgdsQd0GJsEII=
X-Received: by 2002:a05:6512:304:: with SMTP id t4mr11134392lfp.15.1567204115524;
 Fri, 30 Aug 2019 15:28:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190207174623.16712-1-yzhai003@ucr.edu> <20190208.230117.1867217574108955553.davem@davemloft.net>
In-Reply-To: <20190208.230117.1867217574108955553.davem@davemloft.net>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 30 Aug 2019 15:29:07 -0700
Message-ID: <CABvMjLRzuUVh7FxVQj2O40Sbr+VygwSG8spMv0fW2RZVvaJ8rQ@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: Variable "val" in function
 sun8i_dwmac_set_syscon() could be uninitialized
To:     David Miller <davem@davemloft.net>
Cc:     Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David:

Thanks for your feedback, this patch should work for v4.14.


On Fri, Feb 8, 2019 at 11:01 PM David Miller <davem@davemloft.net> wrote:
>
> From: Yizhuo <yzhai003@ucr.edu>
> Date: Thu,  7 Feb 2019 09:46:23 -0800
>
> > In function sun8i_dwmac_set_syscon(), local variable "val" could
> > be uninitialized if function regmap_read() returns -EINVAL.
> > However, it will be used directly in the if statement, which
> > is potentially unsafe.
> >
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
>
> This doesn't apply to any of my trees.



--
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
