Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E51B1C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A38B72077B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 11:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="HhmulKFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbfIDLBB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 07:01:01 -0400
Received: from mout.web.de ([212.227.17.11]:44533 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729656AbfIDLBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 07:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1567594831;
        bh=d2gGjS7PRxCIit8Dvk46MfNkL3iMHMesvVMVXfzHwcg=;
        h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
        b=HhmulKFbz7GVxKm7IhOrHuQgnkmyPLl3wluJiJTv1CEl+QfmypnkFwWFw0ywxapa+
         TJpj921Tmf6rCegXar86fBVkKiEmpzh0xFkyMWBoRz1crF4e5JQnVzk/1RgY6Prwpd
         MjgRt2PRuqKGmdBzJVoRcC8qodtmZwzGa8RBkENM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.100.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3T5g-1iMzuR0CR6-00qzjE; Wed, 04
 Sep 2019 13:00:31 +0200
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Chunming Zhou <David1.Zhou@amd.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kevin Wang <Kevin1.Wang@amd.com>,
        Tom St Denis <tom.stdenis@amd.com>,
        Wang Xiayang <xywang.sjtu@sjtu.edu.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] drm/amdgpu: Delete an unnecessary check before two function
 calls
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-ID: <a3739125-5fa8-cadb-d2b8-8a9f12e9bacd@web.de>
Date:   Wed, 4 Sep 2019 13:00:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MIsHaIZ6eLfpFc4bcLNCrwSAP97Mi/2ouEZOELKUUf/77agSNX2
 rxro93ebz5BdPi6BId9/zy0ZFUFlcX+UOVFCVtbXDKZq6XUuQED9I7fuqpo3e+pQu1SSR0y
 G2r2DRO1y+ipxHYaI1SUnxPYtlOrM0ujCkbnDq7QdOlfnfBar3/zlbHnyJ9NPkfGDdS81yQ
 rQSSYPRUlU5TkpHIf3uHw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mUBOHhkNnbs=:OnB6NPulqGPRilTlNu/wxi
 sumoVQLjrTbnHBGfZZNrUZ6uFDb4Me7pdXkEZGt3X7Lm5pEupQeCgvN/gnKKcfKjuJTmOdWQT
 QZq7LscXlxQ55PtkLaTcRzzquShVajURelUQnROqNBRmLXjprpctWSkj4jIQs/KYr2AlPRVMO
 3D1dcNia7GVoISpIJRabaGEViUchUAPD9l5JDUmmbH6MKQz/4w8D4VeCXXnktOmtE8TKum3mI
 r9QsIucs/EOmpTpYSb3W/ntxYJbrpbikr3b0veVNJcLc7E8sf84Xebs4BVYzfDFyFgxpGJkAh
 a5T0Xqt+iyLiBqaB2nSviqA5NMYLC5br0bxRAs/ntfACwOIWO/FSWrEVlseSa460c4mtr75au
 ZLkEpqGl4p8UZBGYHz9uF86VUKB7pDITCXigANUzcVUxLczmbtmFqV9vsx9c1ug6vEpmdz9xd
 VB5xYvRYIjnDMdnN/hjBjIvJVbh4AiCLCnakmwZo0QnoSQN2Lv1KZMbV3uWb1XmOFhQm9Icy8
 +tf1G9BDqAO5RbgJxo888YVFFWqRIFHI/v3Im6+5H6pZPtHwuaSu0zdZmentXuwdnD/Rwq2zy
 3t2QbkH/pryhfDzjGToniO8cCcmQbTJBziH/weIN9Y7gSBmVoaWnbqr7v2/jtHKbaZJFRYurN
 NnD9AewYUJWwn2Cta8U9pj0ekRsfC51mIrKiUC2uUs4umftsJNjJTX9uPbL2Gmze33lCbUPzY
 r8Yu96ckGkPhh1Te7coPoBU98exqkIVfT2AM1GOh4nyiEC0nxUpWJ30lg1Nb1FU09ipYGjrZB
 UCvyJPQlODek3mT7PWw9LaEo4gryvNmhw/DX/8EhSlceAhHU5B4S4NVzZ8fMCuCbnB6a+avWQ
 LpYafeiwGwb3mpsNYUwZ03hQAonvViMnWjMTYknJzNsn/DJj+tt6whmHUmmS6ou9qwb2f5fEf
 s/OT5F7Bw3vEhy3vWWhOZaSPRr1KfI3AuOkXfBmi3yX3hnXqSJqXYZHocIePEpIQjx0B/zKOb
 uWOsrvugbyf4tJNeofo2Ed5B7QD4o0o4+nx2JN7U+NXv0/i+ci27Ae5yxlCQ5VWBGoBIb+0Ti
 MCWQg/C8qu7KRrMTXyf4KbgBlS1vY7AQNi+Xu1O2e5Z71rPUBuuCds+thp4DfaIKQr1tQ2p3S
 Uri1pEhTrYuTRoieWDOLp+WT7/CAgql/9AGwOYVyl5i8GpuvJt+84i/ilzg6Av2QGRrt1FVaT
 L16NvU42wyp5KHveP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 4 Sep 2019 12:30:23 +0200

The functions =E2=80=9Cdebugfs_remove=E2=80=9D and =E2=80=9Ckfree=E2=80=9D=
 test whether their argument
is NULL and then return immediately.
Thus the tests around the shown calls are not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_debugfs.c
index 5652cc72ed3a..d321c72d63d1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1076,10 +1076,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u6=
4 val)
 	kthread_unpark(ring->sched.thread);

 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
-
-	if (fences)
-		kfree(fences);
-
+	kfree(fences);
 	return 0;
 }

@@ -1103,8 +1100,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)

 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }

 #else
=2D-
2.23.0

