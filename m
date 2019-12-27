Return-Path: <SRS0=GVTe=2R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AADC2D0C6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C1A620882
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="pVibluFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfL0NqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:46:07 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:44454 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfL0NqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Dec 2019 08:46:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id w127so21518811qkb.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Dec 2019 05:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=6etHYhtSl6+gXzRLDDVOeZLed1tEXttA1I2y9xptx5o=;
        b=pVibluFELp7k4SND3Z5PjkskuFcDEeleMyhu5q8UEudXaNsljge7lU3JQfwHJJ1TX7
         F6s8BebrG3hXu1iJcapwKjPQ9/C5GEB+LZkoThO+FUeysWg5mVzBLhV4Amv+/ZgFst1l
         znnBHcKy1vu01qdHze6Ng4uc/YW22LUXyF9VPGd34q718iUKq/qdM2lbalyjVMQetBNb
         cOSkZo8XEtcUAQAGI4P6ciyVfjl+IauE7KBXn0ovpan7wcCxY4N2NC3wVt2aI7wNBk8o
         rmd7NzBk+lsuym0EqZQ6T2uxOnhUG/PTR6rUMmmMIbhDZpc+GQPWIKk/IFEAmfdH5Zbe
         Tlrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=6etHYhtSl6+gXzRLDDVOeZLed1tEXttA1I2y9xptx5o=;
        b=hrkvSJLRyqy/sbAltgXm/Xx7BomlOIcTO0iw+i+4bWwBBSuc6glSiM8uxnq1IMmjMZ
         TuTm9hdfDhTOvrILVn1YXzUq+JSvEN18CnOv8qqqcm4tGcLInE5YhyAkovoRBq8u+0W2
         ePxbDnpXjMbZnUx31ES/wWg7/hAV0uqQwahHN88ofg1FUjcO0BwEKR1KmV4yNuzbyMAS
         GJSPXFl0Yi3n/MMJBFMNVjuMiyCWpeDCwq6bJwI5Yq5V2CRLPw61izINUMbZGhD2bEhr
         tZ0TfpYLrZYnSMGQ4NvsJDuGP1UkWbVH9dysNXQQv47UAidmYKl3kPC55HgtGhq8PEgS
         fV6w==
X-Gm-Message-State: APjAAAVIC3sPDW1BlEL6Qu1TTkE3e3Y5R/+OgOsSg7+6zS9KOcfoekgc
        uDBf6WlWLNsh3IKniNONN35PoBe5yYM=
X-Google-Smtp-Source: APXvYqx1ipKxuo/brS6sZTb08L0kWqRCscwQVwKNLbEb/EyIXR5uBSfMmlxGFWE48SR7iT9V4rKUYQ==
X-Received: by 2002:ae9:c317:: with SMTP id n23mr34496883qkg.356.1577454365616;
        Fri, 27 Dec 2019 05:46:05 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 16sm9787242qkj.77.2019.12.27.05.46.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2019 05:46:05 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_owner: print largest memory consumer when OOM panic occurs
Date:   Fri, 27 Dec 2019 08:46:03 -0500
Message-Id: <2EA70B54-A7E1-4C5A-A447-844A3FEA7E93@lca.pw>
References: <1577432670.4248.3.camel@mtkswgap22>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
In-Reply-To: <1577432670.4248.3.camel@mtkswgap22>
To:     Miles Chen <miles.chen@mediatek.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 27, 2019, at 2:44 AM, Miles Chen <miles.chen@mediatek.com> wrote:
>=20
> It's not complete situation.
>=20
> I've listed different OOM panic situations in previous email [1]
> and what we can do about them with current information.
>=20
> There are some cases which cannot be covered by current information
> easily.
> For example: a memory leakage caused by alloc_pages() or vmalloc() with
> a large size.
> I keep seeing these issues for years and that's why I built this patch.=20=

> It's like a missing piece of the puzzle.
>=20
> To prove that the approach is practical and useful, I have collected
> real test cases
> under real devices and posted the test result in the commit message.
> These are real cases, not my imagination.

Of course this may help debug *your* problems in the past, but if that is th=
e only requirement to merge the debugging patch like this, we would end up w=
ith endless of those. If your goal is to stop developers from reproducing is=
sues unnecessarily again using page_owner to debug, then your patch does not=
 help much for the majority of other developers=E2=80=99 issues.

The page_owner is designed to give information about the top candidates that=
 might cause issues, so it make somewhat sense if it dumps the top 10 greate=
st memory consumer for example, but that also clutter the OOM report so much=
, so it is no-go.=
