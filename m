Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C585C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D45F02071F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 14:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Flvc2zOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbfK1Oab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 09:30:31 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46570 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfK1Oab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 09:30:31 -0500
Received: by mail-qk1-f193.google.com with SMTP id f5so4516967qkm.13
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 06:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=jYscQgO3B2aZoecEj2KE4EY+YiL/cnMaPDA5RlnwFLg=;
        b=Flvc2zOaQTV13CEkOqjvW0TMJphIYyAkdWE2tT83veu2X0ERztNsQJcMztofB/ZN7l
         MNFiYkNDzuFxliVxQlY9fUffjcmiawFNyhCWadPMqmpxzfTLcISszz0fDNTcDzZ+dC01
         lIZl2jp8ZqCu6raKHn+219SSke74iMA3gJX3Hs7v3F4p/6J7SnmSCYg8LoyhIDkzy2Gk
         gAxvQf3pq7JskO7K8YXiW10GRbIT6oIkY/iETkP3EQ0wPRDbuVHqx2qZqOzD4HdmTYbm
         24LmdYGPoG5lUR/2FbvwSdihM5BesyomafPgmFtXxFvCU3kbFcW1feiBuZnLFMj/FzWW
         Q3pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=jYscQgO3B2aZoecEj2KE4EY+YiL/cnMaPDA5RlnwFLg=;
        b=EvZvxsH1MXwu4Vdl0NPEu8cyHZF9g5qpELhFEuWNojxxoL7VBg/kEgWmZf8Xxngene
         q4sc392AOR5f61q87PFE4wvJ4wGN1wkl9XzgWpdDZKrJi5In6e3w7I+l5tHqGIN1xopn
         qHtFtNFfJ32i+GQmIGc7/8G1MuV6MA+VcU03S45RXmAyE9S9ejUp4rXX1LO1m+cIDYJE
         fw5MppOM9h64dGEwfB7MymAp72miRPvldwhu09ukpEzr6pd7ZuK5+mcua4D1mgQZ20iA
         HrfTQIM5k0j1vQ8uJkOsCTRz5YpyGIgto45C1fyVHZIuFK3Nsd4V7NbvSGKObG6wegfM
         diyw==
X-Gm-Message-State: APjAAAXZObLIrDFuZ+LnVNycUm2kkvnlF7mHhzC8Z+usBGKLHtwjlWkK
        94N9Z2xBNRknZbeW1pXiwmeymg==
X-Google-Smtp-Source: APXvYqyxjiPVBCqwpds4kxAvWyJeLoZVUi5Ie7C1ODzakCJWKx3kUUce4170/DFkgo9C+sTyOcG63g==
X-Received: by 2002:ae9:eb53:: with SMTP id b80mr5848666qkg.430.1574951430457;
        Thu, 28 Nov 2019 06:30:30 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id j3sm8354143qkk.133.2019.11.28.06.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 06:30:29 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Thu, 28 Nov 2019 09:30:29 -0500
Message-Id: <270C2A1D-25B0-4BC5-A521-9EEADF3A6B75@lca.pw>
References: <657e4a9d-767d-5140-a4f4-d963794cdf0c@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <657e4a9d-767d-5140-a4f4-d963794cdf0c@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 9:03 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> That's why we have linux-next and plenty of people playing with it
> (including you and me for example).

As mentioned, it is an expensive development practice. Once a patch was merg=
ed into linux-next, it becomes someone else=E2=80=99s problems because if no=
body flags it as problematic, all it needs is a good eye review and some tim=
e before it gets merged into mainline eventually.=
