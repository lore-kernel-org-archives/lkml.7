Return-Path: <SRS0=vISB=2T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC6FC2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 01:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5115C20838
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Dec 2019 01:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfL2BUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Dec 2019 20:20:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:39098 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726187AbfL2BUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Dec 2019 20:20:06 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 25958FD4288C79342CE4;
        Sun, 29 Dec 2019 09:20:04 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Sun, 29 Dec 2019
 09:19:56 +0800
Subject: Re: [PATCH] drm/v3d: remove duplicated kfree in v3d_submit_cl_ioctl
To:     Markus Elfring <Markus.Elfring@web.de>,
        <dri-devel@lists.freedesktop.org>
CC:     <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>, Eric Anholt <eric@anholt.net>,
        Yi Zhang <yi.zhang@huawei.com>,
        zhengbin <zhengbin13@huawei.com>
References: <20191225131715.3527-1-yukuai3@huawei.com>
 <0db93c30-2c87-9824-31be-a15c0d141ab5@web.de>
From:   "yukuai (C)" <yukuai3@huawei.com>
Message-ID: <23c5fdc5-b5ee-fd61-4c33-5e4442cdf305@huawei.com>
Date:   Sun, 29 Dec 2019 09:19:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <0db93c30-2c87-9824-31be-a15c0d141ab5@web.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.220.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2019/12/29 4:45, Markus Elfring wrote:
>> v3d_submit_cl_ioctl call kfree() with variable 'bin' twice.
> 
> I would prefer a wording like “kfree() was called for the same variable twice
> within an if branch.”.
> 
> 
>> Fix it by removing the latter one.
> 
> I find the wording “Delete a duplicate function call.” more appropriate.
> 
Thank you for your advise, I'll make changes in V2 patch.

> Please add the tag “Fixes” to your change description.

I got the results from "git blame":
git blame -L 570,575 drivers/gpu/drm/v3d/v3d_gem.c
a783a09ee76d6 (Eric Anholt        2019-04-16 15:58:53 -0700 570) 
        if (ret) {
0d352a3a8a1f2 (Iago Toral Quiroga 2019-09-16 09:11:25 +0200 571) 
                kfree(bin);
a783a09ee76d6 (Eric Anholt        2019-04-16 15:58:53 -0700 572) 
                v3d_job_put(&render->base);
29cd13cfd7624 (Navid Emamdoost    2019-10-21 13:52:49 -0500 573) 
                kfree(bin);
a783a09ee76d6 (Eric Anholt        2019-04-16 15:58:53 -0700 574) 
                return ret;
a783a09ee76d6 (Eric Anholt        2019-04-16 15:58:53 -0700 575) 
        }

The first kfree belong to the patch 0d352a3a8a1f2 :
commit 0d352a3a8a1f26168d09f7073e61bb4b328e3bb9
Author: Iago Toral Quiroga <itoral@igalia.com>
Date:   Mon Sep 16 09:11:25 2019 +0200

     drm/v3d: don't leak bin job if v3d_job_init fails.

     If the initialization of the job fails we need to kfree() it
     before returning.

     Signed-off-by: Iago Toral Quiroga <itoral@igalia.com>
     Signed-off-by: Eric Anholt <eric@anholt.net>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20190916071125.5255-1-itoral@igalia.com
     Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
     Reviewed-by: Eric Anholt <eric@anholt.net>

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 5d80507b539b..fb32cda18ffe 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -563,6 +563,7 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void *data,
                 ret = v3d_job_init(v3d, file_priv, &bin->base,
                                    v3d_job_free, args->in_sync_bcl);
                 if (ret) {
+                       kfree(bin);
                         v3d_job_put(&render->base);
                         return ret;
                 }

And the second belong to 29cd13cfd7624:
commit 29cd13cfd7624726d9e6becbae9aa419ef35af7f
Author: Navid Emamdoost <navid.emamdoost@gmail.com>
Date:   Mon Oct 21 13:52:49 2019 -0500

     drm/v3d: Fix memory leak in v3d_submit_cl_ioctl

     In the impelementation of v3d_submit_cl_ioctl() there are two memory
     leaks. One is when allocation for bin fails, and the other is when bin
     initialization fails. If kcalloc fails to allocate memory for bin then
     render->base should be put. Also, if v3d_job_init() fails to initialize
     bin->base then allocated memory for bin should be released.

     Fixes: a783a09ee76d ("drm/v3d: Refactor job management.")
     Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
     Reviewed-by: Eric Anholt <eric@anholt.net>
     Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
     Link: 
https://patchwork.freedesktop.org/patch/msgid/20191021185250.26130-1-navid.emamdoost@gmail.com

diff --git a/drivers/gpu/drm/v3d/v3d_gem.c b/drivers/gpu/drm/v3d/v3d_gem.c
index 5d80507b539b..19c092d75266 100644
--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -557,13 +557,16 @@ v3d_submit_cl_ioctl(struct drm_device *dev, void 
*data,

         if (args->bcl_start != args->bcl_end) {
                 bin = kcalloc(1, sizeof(*bin), GFP_KERNEL);
-               if (!bin)
+               if (!bin) {
+                       v3d_job_put(&render->base);
                         return -ENOMEM;
+               }

                 ret = v3d_job_init(v3d, file_priv, &bin->base,
                                    v3d_job_free, args->in_sync_bcl);
                 if (ret) {
                         v3d_job_put(&render->base);
+                       kfree(bin);
                         return ret;
                 }

It seems the two patches fix the same memory leak, but I have no idea 
how thet get together without conflict.

Thanks
Yu Kuai

