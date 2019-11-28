Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26F0C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A608121739
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 17:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kjL/81M3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbfK1RbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 12:31:14 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34676 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfK1RbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 12:31:14 -0500
Received: by mail-qt1-f195.google.com with SMTP id i17so29805339qtq.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2019 09:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ksUJyR23ciW3YG/LyeFtvdri6r4LqALi+fp3wFZeG2U=;
        b=kjL/81M3FuzK8zlJdpBvDPETew4SZ2wJJgF4GbaSWQtBlcqnJzBwEBEa3+QibxyAx0
         ilcnHtr9hkC0w5CCwaq+LBCr+dISmle8jMPxidZQ6cJQBGs7+fQXwN5YPNwXoOaaxsyJ
         rlq0FqHV0pVZXF+ndZ8KOI1MpIoVWlk5nbA8uUGoRvrOZTvWHdRQwaTWz6RhYJ1Dxq3a
         B2EYs0IeBIeJ2CKvwBQiNV/X3sW590f3ryO6lJpiI9GLY4rkDInEtrDZrVjSNIHD29gt
         bLQYTqLMrJjYY6m7v/JwWeDH0tO7EBSClY/KDmegOVwdCO9Svwzcg3/FB1z9r039nW5o
         5FSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ksUJyR23ciW3YG/LyeFtvdri6r4LqALi+fp3wFZeG2U=;
        b=Ok5PQKe4t+zSV/fuepyvNQlqk5Aw2DOukcYCh9uqMOC6unfwDqybI091cdqgfn1n8a
         CPJUWh1eBeZ29dutNaGJJalYzO5UCTNsajtuAgUTWu0YoLEe/3+Rp23w0vTVO3bZUbtZ
         hPzM7HoeoffhsFgPLIy+IQaQBhNhUQrgpCk77aor1GzmS9C0NQfDjeAQMR2txX1cCODc
         M4gtl5Fq+8sMONuwawDbLC2HJxj2dw1/rF1QZKg0YkCfYJP3lT6/PimhHPhWECfnVvk3
         JtJT2qNbDpG7GShFO7bKU2wRq5AbO2lPnyF/cxu/4JpdQ/aYoRY9DFHcbi3EhKBUYyi1
         joIg==
X-Gm-Message-State: APjAAAWBom5ZDJWUqcokVxaqUASf474HFPPu0/61zG9m4AytkqbQqO9Z
        jWrJxzJ6MnryrOJKKt5ZhzJ4IQ==
X-Google-Smtp-Source: APXvYqzbzGAm1r83BfTU7L56y8WzqjvdMyFvT8GM4pajMRb0g0rm/QdR6WiQZxS/Nl/jHHFiYi8XLg==
X-Received: by 2002:ac8:c4f:: with SMTP id l15mr6461181qti.177.1574962273070;
        Thu, 28 Nov 2019 09:31:13 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 62sm2384133qkm.121.2019.11.28.09.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2019 09:31:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Thu, 28 Nov 2019 12:31:11 -0500
Message-Id: <01CF30A6-062D-422A-A817-C732968FACC3@lca.pw>
References: <7e357dc7-1ad7-45cd-d8ba-0fe849d4fefd@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <7e357dc7-1ad7-45cd-d8ba-0fe849d4fefd@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 28, 2019, at 10:31 AM, David Hildenbrand <david@redhat.com> wrote:
>=20
> I said all I had to say about this topic, especially also why cleanups
> and refactorings are important. No, you won't change the way I (and most
> other people here) work, sorry.

Yes, I don=E2=80=99t think I am going to change anybody. Also, it is useless=
 to only improve the mindset of a few subsystems like MM because other subsy=
stems will affect the whole greatly. The good news is that I probably never b=
e out of the job.=
