Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D20FC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:52:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB71206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=shipmail.org header.i=@shipmail.org header.b="Fmm8HafN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbfDZPw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:52:27 -0400
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:47500 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:52:26 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Apr 2019 11:52:25 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 945BE4391E;
        Fri, 26 Apr 2019 17:42:30 +0200 (CEST)
Authentication-Results: pio-pvt-msa3.bahnhof.se;
        dkim=pass (1024-bit key; unprotected) header.d=shipmail.org header.i=@shipmail.org header.b=Fmm8HafN;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VuvOqvhRsIjG; Fri, 26 Apr 2019 17:42:25 +0200 (CEST)
Received: from mail1.shipmail.org (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        (Authenticated sender: mb878879)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 65A473F2EF;
        Fri, 26 Apr 2019 17:42:24 +0200 (CEST)
Received: from localhost.localdomain (h-205-35.A357.priv.bahnhof.se [155.4.205.35])
        by mail1.shipmail.org (Postfix) with ESMTPSA id C746036030C;
        Fri, 26 Apr 2019 17:42:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=shipmail.org; s=mail;
        t=1556293343; bh=mJTS0CQsweYfMQdGyho/lewnbiCcAlZeP2iIfxcMNyM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Fmm8HafNbU9b2pNnz/IT3Otk/LE5bt0Z0vyZerlU+W/EcOoSLYSsoltEqI8+HUr9z
         RYzI4Z5W3rs4woZXdEQmDeSAnNiBvCGF4gzRy+M5wTSdfj2HsJlkV+wn3sTfSaNJYT
         P2pZ93DOKTFgJmFzLiMAuqR6azUqrNPGml1i3aZU=
Subject: Re: [PATCH] Revert "drm/qxl: drop prime import/export callbacks"
To:     Daniel Vetter <daniel@ffwll.ch>, Gerd Hoffmann <kraxel@redhat.com>
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        David Airlie <airlied@redhat.com>
References: <20190426053324.26443-1-kraxel@redhat.com>
 <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
From:   Thomas Hellstrom <thomas@shipmail.org>
Message-ID: <8ae152fe-7811-4de3-e26f-350650a8f992@shipmail.org>
Date:   Fri, 26 Apr 2019 17:42:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKMK7uG+vMU0hqqiKAswu=LqpkcXtLPqbYLRWgoAPpsQQV4qzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/19 4:21 PM, Daniel Vetter wrote:
> On Fri, Apr 26, 2019 at 7:33 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>> This reverts commit f4c34b1e2a37d5676180901fa6ff188bcb6371f8.
>>
>> Simliar to commit a0cecc23cfcb Revert "drm/virtio: drop prime
>> import/export callbacks".  We have to do the same with qxl,
>> for the same reasons (it breaks DRI3).
>>
>> Drop the WARN_ON_ONCE().
>>
>> Fixes: f4c34b1e2a37d5676180901fa6ff188bcb6371f8
>> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Maybe we need some helpers for virtual drivers which only allow
> self-reimport and nothing else at all? I think there's qxl, virgl,
> vmwgfx and maybe also vbox one who could use this ... Just a quick
> idea.
> -Daniel

I think vmwgfx could, in theory, support the full range of operations,
at least for reasonably recent device versions. However, it wouldn't be 
terribly efficient since the exported dma-buf sglist would basically be 
a bounce-buffer.

/Thomas


>> ---
>>   drivers/gpu/drm/qxl/qxl_drv.c   |  4 ++++
>>   drivers/gpu/drm/qxl/qxl_prime.c | 12 ++++++++++++
>>   2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/qxl/qxl_drv.c b/drivers/gpu/drm/qxl/qxl_drv.c
>> index 578d867a81d5..f33e349c4ec5 100644
>> --- a/drivers/gpu/drm/qxl/qxl_drv.c
>> +++ b/drivers/gpu/drm/qxl/qxl_drv.c
>> @@ -255,10 +255,14 @@ static struct drm_driver qxl_driver = {
>>   #if defined(CONFIG_DEBUG_FS)
>>          .debugfs_init = qxl_debugfs_init,
>>   #endif
>> +       .prime_handle_to_fd = drm_gem_prime_handle_to_fd,
>> +       .prime_fd_to_handle = drm_gem_prime_fd_to_handle,
>>          .gem_prime_export = drm_gem_prime_export,
>>          .gem_prime_import = drm_gem_prime_import,
>>          .gem_prime_pin = qxl_gem_prime_pin,
>>          .gem_prime_unpin = qxl_gem_prime_unpin,
>> +       .gem_prime_get_sg_table = qxl_gem_prime_get_sg_table,
>> +       .gem_prime_import_sg_table = qxl_gem_prime_import_sg_table,
>>          .gem_prime_vmap = qxl_gem_prime_vmap,
>>          .gem_prime_vunmap = qxl_gem_prime_vunmap,
>>          .gem_prime_mmap = qxl_gem_prime_mmap,
>> diff --git a/drivers/gpu/drm/qxl/qxl_prime.c b/drivers/gpu/drm/qxl/qxl_prime.c
>> index 8b448eca1cd9..114653b471c6 100644
>> --- a/drivers/gpu/drm/qxl/qxl_prime.c
>> +++ b/drivers/gpu/drm/qxl/qxl_prime.c
>> @@ -42,6 +42,18 @@ void qxl_gem_prime_unpin(struct drm_gem_object *obj)
>>          qxl_bo_unpin(bo);
>>   }
>>
>> +struct sg_table *qxl_gem_prime_get_sg_table(struct drm_gem_object *obj)
>> +{
>> +       return ERR_PTR(-ENOSYS);
>> +}
>> +
>> +struct drm_gem_object *qxl_gem_prime_import_sg_table(
>> +       struct drm_device *dev, struct dma_buf_attachment *attach,
>> +       struct sg_table *table)
>> +{
>> +       return ERR_PTR(-ENOSYS);
>> +}
>> +
>>   void *qxl_gem_prime_vmap(struct drm_gem_object *obj)
>>   {
>>          struct qxl_bo *bo = gem_to_qxl_bo(obj);
>> --
>> 2.18.1
>>
>

