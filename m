Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3288C43141
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:41:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB4E20740
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 23:41:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ayClCS5X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfKYXlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 18:41:09 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12903 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfKYXlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 18:41:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ddc66950000>; Mon, 25 Nov 2019 15:41:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 25 Nov 2019 15:41:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 25 Nov 2019 15:41:07 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 25 Nov
 2019 23:41:07 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 25 Nov 2019 23:41:06 +0000
Received: from blueforge.nvidia.com (Not Verified[10.110.48.28]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ddc66920000>; Mon, 25 Nov 2019 15:41:06 -0800
From:   John Hubbard <jhubbard@nvidia.com>
To:     Andrii Nakryiko <andriin@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        <bpf@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 0/1] bpf: fix a no-mmu build failure by providing a stub allocator
Date:   Mon, 25 Nov 2019 15:41:02 -0800
Message-ID: <20191125234103.1699950-1-jhubbard@nvidia.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574725269; bh=+UikYwGL8PF/KNnxAPIPj9xjsgDE5Jat9ThGUVvv3jE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:X-NVConfidentiality:Content-Transfer-Encoding:
         Content-Type;
        b=ayClCS5XxvUorhhDTYQ4QhBFhXsd7dXYeRTt2bTcsLG6cI8TYwG6vHL2QHNDcFXg5
         CQvT2tWLejsMmf5QWEhBiP203s4Cv1kx+7yUhBIPz3wYUu/Bfgzlf6bi0OTek6lHJl
         89HXGoftD8P88UnN8HrjILy9Fe8aLqmcpDcWYRob42uYBRtqlNjSiIPzzDxw88rNrX
         XVaeY5eTNDZiJv0hpck5BgVJlUOHWezEs9iKH96x97uvn6KxidFAxJ5kDpNupoDG1t
         f8rqgGDwfIUZuqEBBG1vVPGZ21OKhw+TLNfdZyneoXgaRC3tVGJh4fvvkL01p3EPQj
         QnWUBfewNoKVg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I ran into this on today's linux-next: commit c165016bac27 ("Add
linux-next specific files for 20191125"). The kbuild robot reported a
build failure on my larger (unrelated) patchset, but there were actually
two build failures, and this patch here fixes the second failure.

John Hubbard (1):
  bpf: fix a no-mmu build failure by providing a stub allocator

 kernel/bpf/syscall.c | 7 +++++++
 1 file changed, 7 insertions(+)

--=20
2.24.0

